import psycopg2


db_params = {
    "database": "DB_HW1",
    "user": "postgres",
    "password": "postgres",
    "client_encoding": "utf8",
}
conn = psycopg2.connect(**db_params)


def create_table(create_sql):
    with conn.cursor() as cur:
        cur.execute(create_sql)
        conn.commit()
        cur.close()
    print("Таблица создана")


create_table_clients = "CREATE TABLE Clients (client_id SERIAL PRIMARY KEY, name VARCHAR(100) NOT NULL, surname VARCHAR(100) NOT NULL,email VARCHAR(255) NOT NULL UNIQUE);"

create_table_numbers = "CREATE TABLE TelephoneNumber (number_id SERIAL PRIMARY KEY, number VARCHAR(50) NOT NULL, client_id INTEGER NOT NULL REFERENCES Clients(client_id));"

# create_table(create_table_clients)
# create_table(create_table_numbers)
def insert_info(insert_sql):
    with conn.cursor() as cur:
        cur.execute(insert_sql)
        conn.commit()
        cur.close()
    print("Информация добавлена")

insert_client = "INSERT INTO Clients (name, surname, email) VALUES ('Иван', 'Петров', 'ivan.petrov@ya.com');"
insert_tel = "INSERT INTO TelephoneNumber (number, client_id) VALUES ('+7 (916) 123-45-67', 1);"
# insert_info(insert_client)
# insert_info(insert_tel)
def update_info(update_sql, client_id):
    with conn.cursor() as cur:
        cur.execute(update_sql, (client_id,))
        conn.commit()
        cur.close()
    print("Информация обновлена")

update_client = "UPDATE Clients SET email = 'new.ivan.petrov@example.com' WHERE client_id = %s;"
# update_info(update_client, 1)

def find_client(sql):
    with conn.cursor() as cur:
        print(cur.execute(sql))
        conn.commit()
        print(cur.fetchall())
        cur.close()

select_find = "SELECT c.name, c.surname, t.number FROM Clients AS c JOIN TelephoneNumber AS t ON c.client_id = t.client_id;"

find_client(select_find)