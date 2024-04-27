##Database Creation
create database bus_booking_sys;

use bus_booking_sys;

## Table tbluser creation
CREATE TABLE IF NOT EXISTS tbluser (
    user_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    fullname VARCHAR(25) NOT NULL,
    address VARCHAR(20) NOT NULL,
    contact VARCHAR(15) NOT NULL,
    email VARCHAR(255) UNIQUE,
    username VARCHAR(25) NOT NULL
);
    
## Table Bus creation    
CREATE TABLE IF NOT EXISTS Bus (
    bus_id INT(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    bus_number VARCHAR(20) NOT NULL,
    bus_type VARCHAR(10) NOT NULL,
    seat_capacity INT NOT NULL,
    operator_id INT,
    CONSTRAINT fk_operator_id FOREIGN KEY (operator_id)
        REFERENCES operator (operator_id)
);
    
    
##Table operator creation
CREATE TABLE IF NOT EXISTS operator (
    operator_id INT(10) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    operator_name VARCHAR(25) NOT NULL,
    LicenseNumber VARCHAR(20) UNIQUE NOT NULL,
    contact VARCHAR(15) NOT NULL
);
    
    

    
##Table route creation
CREATE TABLE IF NOT EXISTS route (
    route_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    bus_id INT,
    starting_location VARCHAR(25) NOT NULL,
    destination VARCHAR(25) NOT NULL,
    departure_time TIMESTAMP,
    Schedule_date DATE,
    fare_amount INT NOT NULL,
    CONSTRAINT fk_bus_id FOREIGN KEY (bus_id)
        REFERENCES Bus (bus_id)
);

    
##Table booking creation
CREATE TABLE IF NOT EXISTS booking (
    booking_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    bus_id INT,
    Number_of_seats INT NOT NULL,
    b_status ENUM('succesful', 'canceled', 'pending') DEFAULT 'succesful',
    date_of_booking DATE,
    fare_amount DECIMAL(10 , 2 )
);


##Table payment Creation
CREATE TABLE IF NOT EXISTS payment (
    payment_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    booking_id INT,
    amount_paid DECIMAL(10 , 2 ),
    paied_date DATE
);

 


##Add foreign key on payemnt
alter table payment 
add constraint fk_user_idpay foreign key (user_id) references tbluser(user_id), 
add constraint fk_booking_pay foreign key (booking_id) references booking(booking_id);


##add foreign key on booking
alter table booking 
add constraint fk_user_idbook foreign key (user_id) references tbluser(user_id),
add constraint fk_bus_idbook foreign key (bus_id) references bus(bus_id);

## add new column on booking
alter table booking
add column route_id int,
add constraint fk_route_id foreign key(route_id) references route(route_id);



##Value insertion on tbluser
INSERT INTO tbluser (user_id, fullname, address, contact, email, username)
VALUES
    (1, 'Ram Sharma', 'kathmandu', '+9779812345678', 'ram.sharma@email.com', 'ram_sharma'),
    (2, 'Shyam Prasad', 'lalitpur', '+9779823456789', 'shyam.prasad@email.com', 'shyam_prasad'),
    (3, 'Geeta Rajput', 'kathmandu', '+9779845678901', 'geeta.rajput@email.com', 'geeta_rajput'),
    (4, 'Srijal Kapri', 'kathmandu', '+9779856789012', 'rijalkapri180@email.com', 'srijal_kapri18'),
    (5, 'Pujan Subedi', 'Chitwan', '+9779867890123', 'pujansrk@email.com', 'pujuuuu'),
    (6, 'Michael Brown', 'pokhara', '+9779878901234', 'michael.brown@email.com', 'michael_brown'),
    (7, 'Olivia Miller', 'pokhara', '+9779889012345', 'olivia.miller@email.com', 'olivia_miller'),
    (8, 'Daniel White', 'pokhara', '+9779890123456', 'daniel.white@email.com', 'daniel_white'),
    (9, 'Emma Anderson', 'lalitpur', '+9779811234567', 'emma.anderson@email.com', 'emma_anderson'),
    (10, 'William Jackson', 'dharan', '+9779822345678', 'william.jackson@email.com', 'william_jackson'),
    (11, 'Ava Garcia', 'lalitpur', '+9779833456789', 'ava.garcia@eamil.com', 'ava_garcia'),
    (12, 'Suresh Khadka', 'pokhara', '+9779844567890', 'suresh.khadka@email.com', 'suresh_khadka');


##Value insertion on operator
INSERT INTO operator (operator_id, operator_name, LicenseNumber, contact)
VALUES
    (1, 'ABC Bus Company', "D123", '+9779812345678'),
    (2, 'XYZ Bus Services', '45', '+9779823456789'),
    (3, 'laxmi safari', '789', '+9779834567890'),
    (4, 'LMN Travels', '101', '+9779845678901'),
    (5, 'RST Tours', '202', '+9779856789012'),
    (6,'salina Travels','562',+977985623554);
    
    select *from operator;



##Value insertion on bus
INSERT INTO bus (bus_id, bus_number, bus_type, seat_capacity, operator_id)
VALUES
    (1, 'G AA 306', 'Deluxe', 35, 6),
    (2, 'G DD 5112', 'Deluxe', 32, 2),
    (3, 'G AB 5623', 'Standard', 28, 1),
    (4, 'G DC 1256', 'Standard', 30, 6),
    (5, 'G DE 5555', 'Slepper', 45, 5),
    (6, 'G CC 4441', 'standard', 35, 4),
    (7, 'G BC 2020', 'Deluxe', 55, 3),
    (8, 'G AA 2014', 'Standard', 50, 2),
    (9, 'G AB 1132', 'Luxury', 40, 6),
    (10, 'G CD 010', 'Express', 60, 2);
    
    select *from bus;
    


####Value insertion on route
INSERT INTO route (route_id, bus_id, starting_location, destination, Schedule_date, fare_amount)
VALUES
    (1, 9, 'Kathmandu', 'Pokhara', '2022-02-10', 1000),
    (2, 2, 'Pokhara', 'Chitwan',  '2022-05-21', 800),
    (3, 10, 'Chitwan', 'Kathmandu', '2023-04-10', 800),
    (4, 5, 'Dharan', 'Lalitpur',  '2023-08-16', 2000),
    (5, 8, 'Chitwan', 'Dharan',  '2023-02-10', 400),
    (6, 7, 'Kathmandu', 'Butwal', '2023-02-05', 900),
    (7, 5, 'Pokhara', 'Bhaktapur',  '2023-02-22', 550),
    (8, 4, 'Butwal', 'Kathmandu',  '2023-02-11', 650),
    (9, 3, 'Kathmandu', 'Chitwan',  '2023-02-18', 1000),
    (10, 1, 'Lalitpur', 'Butwal',  '2023-02-03', 750);
    
    select *from route;


##Value insertion on booking
insert into booking(booking_id,user_id,bus_id,Number_of_seats,b_status,date_of_booking,fare_amount,route_id)
value(1,5,2,2,'succesful',2020-04-08,800,3),
(2,5,8,2,'succesful','2022-02-08',1000,1),
(3,4,5,1,'succesful','2023-04-10',800,3),
(4,5,2,4,'pending','2022-02-10',1000,1),
(5,3,2,1,'canceled','2023-02-17',1000,9),
(6,8,2,1,'succesful','2023-02-10',400,5),
(7,6,2,8,'canceled','2023-08-14',2000,4),
(8,2,2,1,'pending','2023-02-10',650,8),
(9,2,2,2,'succesful','2023-08-14',2000,4),
(10,5,2,2,'succesful','2022-05-21',800,2);

SELECT  *FROM bus_booking_sys.booking;



## updating the table booking
UPDATE booking 
SET 
    date_of_booking = '2023-04-08'
WHERE
    booking_id = 1;
    
    

## value insertion on payment
insert into payment(payment_id,user_id,booking_id,amount_paid,paid_date)
value
(1,1,1,'2400.00','2020-04-08'),
(2,5,2,'2000.00','2022-02-08'),
(3,4,3,'2400.00','2023-04-10'),
(4,8,6,'2000.00','2023-02-10'),
(5,2,9,'8000.00','2023-08-14');

SELECT * FROM payment;



#####SELECT QUERY#####
##select all column of table tbluser

SELECT *FROM tbluser;

##select all the users who are from kathmandu
SELECT *FROM tbluser
WHERE 
address = 'kathmandu';


##Inner join on table tbluser and booking: 
select tbluser.username, booking.booking_id
from tbluser
inner join booking on tbluser.user_id = booking.booking_id;



##Left outer join
select tbluser.username,tbluser.contact, booking.booking_id, booking.Number_of_seats
from tbluser
inner join booking on tbluser.user_id = booking.booking_id;



##creation of view
CREATE VIEW paymentinfo AS
    SELECT 
        payment.payment_id,
        tbluser.fullname,
        payment.amount_paid,
        payment.paid_date
    FROM payment LEFT JOIN tbluser 
           ON payment.payment_id = tbluser.user_id;

SELECT *FROM paymentinfo;



##drop view
drop view paymentinfo;
    
