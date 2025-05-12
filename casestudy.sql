create database asset_management;

use asset_management;

create table employees (
    employee_id int primary key auto_increment,
    employee_name varchar (50) not null,
    department varchar(25),
    email varchar(50) unique not null,
    pswd varchar(50) not null
);

create table assets (
    asset_id int auto_increment primary key unique,
    name varchar(100),
    type varchar(100),
    serial_number varchar(100),
    purchase_date date,
    location varchar(100),
    status varchar(50),
    owner_id int
);

create table asset_allocations (
    allocation_id int auto_increment primary key unique,
    asset_id int,
    employee_id int,
    allocation_date date,
    return_date date,
    foreign key (asset_id) references assets(asset_id), 
    foreign key (employee_id) references employees(employee_id)
);

create table maintenance_records (
    maintenance_id int auto_increment primary key unique,
    asset_id int,
    maintenance_date date,
    description text,
    cost double,
    foreign key (asset_id) references assets(asset_id)
);

create table reservations (
    reservation_id int auto_increment primary key unique,
    asset_id int,
    employee_id int,
    reservation_date date,
    start_date date,
    end_date date,
    status varchar(50),
    foreign key (asset_id) references assets(asset_id),
    foreign key (employee_id) references employees(employee_id)
);
select*from assets;
insert into employees(applicantsapplicants