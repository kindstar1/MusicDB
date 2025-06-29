import sqlalchemy
import sqlalchemy as sq
from sqlalchemy.orm import declarative_base, relationship, sessionmaker
from sqlalchemy import select
import json
import datetime

Base = declarative_base()

class Publisher(Base):

    __tablename__ = 'publisher'
    
    id = sq.Column(sq.Integer, primary_key=True)
    name = sq.Column(sq.String(length=100), unique=True)

class Book(Base):
    __tablename__ = 'books'

    id = sq.Column(sq.Integer, primary_key=True)
    title = sq.Column(sq.String(length=100), unique=True)
    publisher_id = sq.Column(sq.Integer, sq.ForeignKey("publisher.id"), nullable=False)

    publisher = relationship(Publisher, backref="books")

class Shop(Base):

    __tablename__ = 'shops'
    
    id = sq.Column(sq.Integer, primary_key=True)
    name = sq.Column(sq.String(length=100), unique=True)

class Stock(Base):
    __tablename__ = 'stock'

    id = sq.Column(sq.Integer, primary_key=True)
    count = sq.Column(sq.Integer, nullable=False)
    shop_id = sq.Column(sq.Integer, sq.ForeignKey("shops.id"), nullable=False)
    book_id = sq.Column(sq.Integer, sq.ForeignKey("books.id"), nullable=False)

    shop = relationship(Shop, backref="stock_items")
    book = relationship(Book, backref="stock_items")

class Sale(Base):

    __tablename__= 'sales'

    id = sq.Column(sq.Integer, primary_key=True)
    price = sq.Column(sq.String, nullable=False)
    date_sale = sq.Column(sq.DateTime(timezone=True),nullable=False)
    count = sq.Column(sq.Integer, nullable=False)
    stock_id = sq.Column(sq.Integer, sq.ForeignKey("stock.id"), nullable=False)
    stock = relationship(Stock, backref="stock")

def create_tables(engine):
    Base.metadata.drop_all(engine)
    Base.metadata.create_all(engine)

DSN = "postgresql://postgres:postgres@localhost:5432/Books_DB"
engine = sqlalchemy.create_engine(DSN)

create_tables(engine)

Session = sessionmaker(bind=engine)
ses = Session()

with open('tests_data.json', 'r', encoding='utf-8') as f:
    data = json.load(f)
    for item in data:
        if item['model'] == 'publisher':
            pb = Publisher(id=item['pk'], name=item['fields']['name'])
            ses.add(pb)
            ses.commit()
        elif item['model'] == 'book':
            bk = Book(id=item['pk'], title=item['fields']['title'], publisher_id=item['fields']['id_publisher'])
            ses.add(bk)
            ses.commit()
        elif item['model'] == 'shop':
            sh = Shop(id=item['pk'], name=item['fields']['name'])
            ses.add(sh)
            ses.commit()
        elif item['model'] == 'stock':
            st = Stock(id=item['pk'], shop_id=item['fields']['id_shop'], book_id=item['fields']['id_book'], count=item['fields']['count'])
            ses.add(st)
            ses.commit()
        elif item['model'] == 'sale':
            sl = Sale(id=item['pk'], price=item['fields']['price'], date_sale=item['fields']['date_sale'], count=item['fields']['count'], stock_id=item['fields']['id_stock'])
            ses.add(sl)
            ses.commit()

# id_pub = int(input('Введите идентификатор издателя: '))
id_pub = 1

q = (
    select(
        Book.title, 
        Shop.name, 
        Stock.count, 
        Sale.date_sale
        )
        .select_from(Sale)
        .join(Stock)
        .join(Shop)
        .join(Book)
        .where(Book.publisher_id== id_pub)
    )
res = ses.execute(q).all()

for title, shop, count, date_sale in res:
    sale_date = date_sale.date()
    print(f"{title} | {shop} | {count}| {sale_date}")