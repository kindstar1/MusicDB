create table Employee (
id SERIAL primary key,
full_name varchar(255) not null,
department varchar(255) not null,
chief_flg boolean not null,
chief_id integer references Employee(id)
);