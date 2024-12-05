CREATE DATABASE SportsComplex2;
USE SportsComplex2;

CREATE TABLE PERSON (
    cnic char(12),
    firstName varchar(100),
    lastName varchar(100),
    dob date,
    gender enum('M', 'F'),
    contact char(10),
    emerContact char(10),
    email varchar(100),
    bloodGroup enum ('A+','A-','B+','B-','AB+','AB-','O+','O-'),
    address text,
    constraint person_pk PRIMARY KEY (cnic),
    CONSTRAINT check_cnic_length CHECK (LENGTH(cnic) = 12)
);

CREATE TABLE MEMBER(
member_id int(5) auto_increment,
    cnic char(12),
    
    constraint member_pk PRIMARY KEY (member_id),
    constraint member_fk fOREIGN KEY (cnic) REFERENCES person (cnic) ON DELETE cascade
);

ALTER TABLE member AUTO_INCREMENT=10000;

CREATE TABLE GUEST(
    cnic char(12),
    member_id int(5),
    firstName varchar(100),
    lastName varchar(100),
	
    constraint guest_pk PRIMARY KEY (cnic),
    constraint guest_fk fOREIGN KEY (member_id) REFERENCES MEMBER(member_id)   ON DELETE cascade,
	CONSTRAINT check_cnicLength CHECK (length(cnic)=12)
);

CREATE TABLE  DEPARTMENT
(dept_id int(5) AUTO_INCREMENT,
 deptName varchar(100), 
 supervisor_id int(5),
salary float,
 constraint department_pk PRIMARY KEY (dept_id),
CONSTRAINT check_salary_positive CHECK (salary >= 0)
);

CREATE TABLE EMPLOYEE (
    emp_id int AUTO_INCREMENT,
    cnic char(12),
    dept_id int(5),
    constraint emp_fk1 FOREIGN KEY (cnic) REFERENCES PERSON(cnic) ON DELETE CASCADE,
    constraint emp_pk PRIMARY KEY (emp_id)
);

ALTER TABLE EMPLOYEE AUTO_INCREMENT = 10000;


CREATE TABLE SPORT(
	sport_id int (5) auto_increment,
    sportName varchar(100),
    teamMember int(3) DEFAULT NULL,
    constraint sport_pk PRIMARY KEY (sport_id)
);

CREATE TABLE  COACH
(coach_id int(5),
sport_id int(5),
constraint coach_fk1 fOREIGN KEY (coach_id) REFERENCES EMPLOYEE(emp_id)  ON DELETE cascade,
constraint coach_fk2 fOREIGN KEY (sport_id) REFERENCES sport(sport_id)  ON DELETE cascade,
constraint coach_pk PRIMARY KEY (coach_id)
);

CREATE TABLE   CLASS
(class_id int(5)  AUTO_INCREMENT,
day enum('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'), 
startTime time,
endTime time,
coach_id int(5),
constraint class_fk fOREIGN KEY (coach_id) REFERENCES COACH(coach_id) ON DELETE cascade,
constraint class_pk PRIMARY KEY (class_id)
);

CREATE TABLE   Trainee
(class_id int(5),
member_id int (5),
 constraint trainee_fk1 fOREIGN KEY (class_id) REFERENCES CLASS(class_id) ON DELETE cascade,
 constraint trainee_fk2 fOREIGN KEY (member_id)  REFERENCES MEMBER(member_id) ON DELETE cascade,
 constraint trainee_Pk PRIMARY KEY (class_id,member_id)
);

CREATE TABLE  ALLERGIES
(cnic char(12), 
allergy varchar(100),
constraint allergies_fk fOREIGN KEY (cnic) REFERENCES PERSON(cnic) ON DELETE cascade, 
constraint allergies_pk PRIMARY KEY (cnic, allergy)
);

CREATE TABLE  security_qs
(ques_id int(5) AUTO_INCREMENT,
 ques text,
 constraint department_pk PRIMARY KEY (ques_id)
);

CREATE TABLE  USERS
(username varchar(30), 
emp_id int(5),
password varchar(100) default "Employee@123",
security_qs_id int(5),
securityAns varchar(100),

constraint user_pk PRIMARY KEY (username),
constraint user_fk1 fOREIGN KEY (emp_id) REFERENCES EMPLOYEE(emp_id) ON DELETE cascade, 
constraint user_fk2 fOREIGN KEY (security_qs_id) REFERENCES security_qs(ques_id) ,
CONSTRAINT check_username_Length CHECK(length(username)>=6  AND length(username)<=30),
CONSTRAINT check_password_Length CHECK(length(password)>=8 )

);

CREATE TABLE TEAM(
	team_id int(5)  auto_increment,
    sport_id int(5),
    package enum('training', 'non-training'),
    
    constraint team_pk PRIMARY KEY (team_id),
	constraint team_fk FOREIGN KEY (sport_id) references SPORT(sport_id) ON DELETE cascade
);

CREATE TABLE TEAM_SCHEDULE(
team_id int(5) ,
    class_id int(5),
    constraint teamSchedule_fk1 FOREIGN KEY (team_id) references TEAM(team_id) ON DELETE cascade,
    constraint teamSchedule_fk2 FOREIGN KEY (class_id) references CLASS(class_id) ON DELETE cascade,
    constraint teamSchedule_pk PRIMARY KEY (team_id,class_id)	
);

CREATE TABLE ATTENDANCE(
	emp_id int(5) ,
    date date,
    status enum('P','A') default 'A',
    constraint attendance_fk FOREIGN KEY (emp_id) references EMPLOYEE(emp_id) ON DELETE cascade,
    constraint attendance_pk PRIMARY KEY (emp_id,date)	
);

CREATE TABLE Schedule (
    event_id int(5) NOT NULL AUTO_INCREMENT,
    eventName text,
    date date,
    time time,
    venue varchar(250),
    constraint schedule_pk PRIMARY KEY (event_id)
);

CREATE TABLE EMERGENCY(
	emer_id int(5) auto_increment,
    patient_id int(5),
    problem text,
    date date,
    time time,
    status enum('resolved', 'unresolved'),
    
    constraint emergency_pk PRIMARY KEY (emer_id),
    constraint emergency_fk FOREIGN KEY (patient_id) references MEMBER (member_id) 	ON DELETE cascade
);

CREATE TABLE INVENTORY(
	item_id int(5) auto_increment,
    sport_id int(5),
    itemName varchar(200),
    quantity int,
    
    constraint inventory_pk PRIMARY KEY (item_id),
    constraint inventory_fk FOREIGN KEY (sport_id) REFERENCES SPORT(sport_id) ON DELETE cascade
    	
);

CREATE TABLE ISSUED_ITEMS(
	issue_id int(5) auto_increment,
    member_id int(5),
    item_id int(5),
    time time,
    quantity int,
    
    constraint issue_pk PRIMARY KEY (issue_id),
    constraint issue_member_fk FOREIGN KEY (member_id) REFERENCES MEMBER (member_id),
     constraint issue_item_fk FOREIGN KEY (item_id) REFERENCES INVENTORY (item_id) ON DELETE cascade
);

CREATE TABLE INVENTORY_LOG(
    member_id int(5),
    item_id int(5),
    date date,
    borrowedTime time,
    returnedTime time,
    quantity int,
    damaged bool default false,
    
    constraint inventory_log_pk PRIMARY KEY (member_id,item_id,date,borrowedTime),
    constraint inventory_log_fk1 FOREIGN KEY (member_id) REFERENCES MEMBER (member_id),
     constraint inventory_log__fk2 FOREIGN KEY (item_id) REFERENCES INVENTORY (item_id) ON DELETE cascade

);

CREATE TABLE MAINTENANCE(
	maintenance_id int(5) auto_increment,
    sport_id int(5),
    date date,
    activity varchar(200),
    level enum('Partial', 'Compelete', 'Not Started') default 'Not Started',
    
    constraint maintenance_pk PRIMARY KEY (maintenance_id),
    constraint maintenance_fk FOREIGN KEY (sport_id) REFERENCES sport (sport_id) ON DELETE cascade

);

CREATE TABLE MEDICAL_LOG(
	emer_id int(5),
    item_id int(5),
    quantity int,
    
    constraint medical_pk PRIMARY KEY (emer_id, item_id),
    constraint medical_emer_fk FOREIGN KEY (emer_id) references EMERGENCY (emer_id) ON DELETE cascade,
    constraint medical_item_fk FOREIGN KEY (item_id) references INVENTORY (item_id) ON DELETE cascade

);

create table REPAIRS(
	repair_id int(5) auto_increment,
    sport_id int(5),
    purpose text,
    amount float,
    status enum('Allocated', 'Refused', 'Pending'),
    
    constraint repairs_pk primary key (repair_id),
    constraint repairs_fk foreign key (sport_id) references sport (sport_id) ON DELETE cascade,
    CONSTRAINT check_amounts_positive CHECK (amount >= 0)

);

CREATE TABLE Report (
    report_id int(5) NOT NULL AUTO_INCREMENT,
    details varchar(500) NOT NULL,
    type ENUM ('complaint', 'suggestion'),
    status ENUM('addressed', 'unaddressed') default 'unaddressed',
    constraint report_pk PRIMARY KEY (report_id)
);

CREATE TABLE Notice (
    notice_id int(5) NOT NULL AUTO_INCREMENT,
    title varchar(100),
    text text,
    date date,
    constraint notice_pk PRIMARY KEY (notice_id)
);

CREATE TABLE Transactions (
    transaction_id int(10) NOT NULL AUTO_INCREMENT,
    type varchar(100),
    amount double,
    constraint transactions_pk PRIMARY KEY (transaction_id),
    CONSTRAINT check_amount_positive CHECK (amount >= 0)
);

CREATE TABLE credit_membership (
    member_id int(5) ,
    date date,
    amount float,
    status enum('paid', 'unpaid') default 'unpaid',
    constraint credit_Membership_fk FOREIGN KEY (member_id) REFERENCES MEMBER (member_id) ON DELETE cascade
);



# table for storing history of employee deleted
CREATE TABLE  employee_deleted
(emp_id int  , 
cnic char(12) , 
dept_id int(5) ,
time timestamp,
constraint emp_del_pk PRIMARY KEY (emp_id)
);

# table for storing history of employee inserted
CREATE TABLE  employee_inserted
(emp_id int  , 
cnic char(12) , 
dept_id int(5) ,
time timestamp,
constraint emp_insert_pk PRIMARY KEY (emp_id)
);

#-------stored procedures-------------
# SP that will return the coach_id of given sport_id
DELIMITER //
CREATE PROCEDURE getCoachOfSport(IN sportID int(5), out coachId int(5))
BEGIN
   SET coachId = (SELECT coach_id FROM Coach WHERE sport_id = sportID)  ;
   
END //

# SP that will return the cnic of the employee with the given emp_id
DELIMITER //
CREATE PROCEDURE GetEmployeeCnic(IN ID int(5), out emp_cnic varchar(12))
BEGIN
   SET emp_cnic = (select cnic from employee  where emp_id =ID) ;
   
END //

# SP that will return the autogenerated username of the user
DELIMITER //
CREATE PROCEDURE setUsername(IN ID int(5), out uname varchar(30))
BEGIN
   CALL GetEmployeeCnic(ID,@emp_cnic);
   SET uname = (
   select concat(concat_ws('.',substring(person.firstName,1,1),person.lastname),substring(person.dob,3,2))
   from person
   where cnic = @emp_cnic
   );
   
END //
DELIMITER ;

#--------------triggers-----------------

# trigger that will insert the employee details that is deleted into employee_deleted tbl
delimiter #
create trigger deleteEmployeeTrigger
before delete on employee for each row
begin
insert into employee_deleted values (old.emp_id, old.cnic,old.dept_id, now()) ;
end #

# trigger that will insert the employee details that is inserted into employee_inserted tbl
delimiter #
create trigger insertEmployeeTrigger
after insert on employee for each row
begin
insert into employee_inserted values (new.emp_id, new.cnic,new.dept_id, now()) ;
end #


# trigger that will set the autogenerated username of user when record is inserted
delimiter #
create trigger autogenerated_username
before insert on users for each row
begin
CALL setUsername(NEW.emp_id,@uname);
set new.username= @uname;
end #
DELIMITER ;




#----------views------------------
CREATE  VIEW viewTransEmp AS
SELECT emp_id, firstname, lastname, deptName, salary 
FROM employee
join person using (cnic) join department using (dept_id)
order by emp_id
WITH CHECK OPTION;


CREATE  VIEW viewTransExtras AS
select repair_id, purpose, amount 
from repairs 
where status = "Allocated"
order by repair_id
WITH CHECK OPTION;

CREATE  VIEW viewTransFunds AS
select * 
from transactions 
where type like '%fund%'
WITH CHECK OPTION;


CREATE  VIEW viewTransBills AS
select * from transactions 
where type like "%bill%"
WITH CHECK OPTION;


CREATE  VIEW displayEmployeeList AS
SELECT Employee.emp_id, Person.firstName, Person.lastName, Person.cnic, 
Person.gender, Person.dob, Person.contact, Person.email, Department.deptName 
FROM ((Employee INNER JOIN Person ON Employee.cnic = Person.cnic) 
INNER JOIN Department On Department.dept_id = Employee.dept_id)
WITH CHECK OPTION;

CREATE  VIEW displayMembers AS
SELECT Person.cnic, Person.firstName, Person.lastName, Person.dob,
                Person.gender, Person.contact, Person.email, Member.member_id
FROM Person INNER JOIN Member ON Member.cnic = Person.cnic
order by member.member_id
WITH CHECK OPTION;

CREATE  VIEW displayComplaints AS
SELECT details, status FROM report WHERE type = "complaint"
WITH CHECK OPTION;

CREATE  VIEW displaySuggestions AS
SELECT details, status FROM report WHERE type = "suggestion"
WITH CHECK OPTION;


  
INSERT INTO person (cnic, firstName, lastName, dob, gender, contact, emerContact, email, bloodGroup, address) VALUES
('374052080001', 'Tavish', 'Chawla', '2004-10-12', 'M', '8950425060', '9355084882', 'tchawla827@gmail.com', 'B+', 'IIIT Allahabad');

INSERT INTO person (cnic, firstName, lastName, dob, gender, contact, emerContact, email, bloodGroup, address) VALUES
('374052080002', 'Aarav', 'Sharma', '2002-07-15', 'M', '8945012345', '9345098765', 'aarav.sharma@gmail.com', 'O+', 'Bangalore, Karnataka'),
('374052080003', 'Isha', 'Gupta', '1999-11-20', 'F', '8976543210', '9345678910', 'isha.gupta@yahoo.com', 'A-', 'Lucknow, Uttar Pradesh'),
('374052080004', 'Kavya', 'Singh', '2003-03-05', 'F', '8987654321', '9345789012', 'kavya.singh@outlook.com', 'AB+', 'Jaipur, Rajasthan'),
('374052080005', 'Rohan', 'Verma', '2001-01-25', 'M', '8998765432', '9356890123', 'rohan.verma@gmail.com', 'B-', 'Mumbai, Maharashtra'),
('374052080006', 'Ananya', 'Mishra', '2000-05-10', 'F', '8009876543', '9367901234', 'ananya.mishra@hotmail.com', 'O-', 'Pune, Maharashtra'),
('374052080007', 'Aditya', 'Kumar', '1998-02-18', 'M', '8018765432', '9378012345', 'aditya.kumar@gmail.com', 'A+', 'Delhi, NCR'),
('374052080008', 'Sanya', 'Chopra', '2004-09-10', 'F', '8027654321', '9389123456', 'sanya.chopra@gmail.com', 'B+', 'Chennai, Tamil Nadu'),
('374052080009', 'Yash', 'Patel', '2002-08-30', 'M', '8036543210', '9390234567', 'yash.patel@yahoo.com', 'AB-', 'Ahmedabad, Gujarat'),
('374052080010', 'Nisha', 'Roy', '2003-12-22', 'F', '8045432109', '9401345678', 'nisha.roy@rediffmail.com', 'O+', 'Kolkata, West Bengal');


INSERT INTO member(cnic) VALUES
('374052080002'),
('374052080003'),
('374052080001'),
('374052080005'),
('374052080006');





INSERT INTO guest VALUES 
('374052080007', 10003, 'Ananya', 'Sharma'),
('374052080008', 10000, 'Riya', 'Verma'),
('374052080009', 10002, 'Aditya', 'Kumar'),
('374052080010', 10001, 'Arjun', 'Singh');


INSERT INTO department(deptName, supervisor_id, salary) VALUES 
('registration', 1, 45000),
('inventory', 2, 25000),
('medical', 3, 25000),
('finance', 4, 50000),
('emergency', 5, 25000),
('maintenance', 6, 25000),
('coach', 7, 40000),
('attendant', 8, 25000),
('manager', 9, 50000);





INSERT INTO employee(cnic, dept_id) VALUES 
('374052080001', 7),
('374052080001', 6),
('374052080001', 5),
('374052080001', 4),
('374052080001', 3),
('374052080001', 2),
('374052080001', 1),
('374052080001', 7),
('374052080001', 8),
('374052080001', 9);


ALTER TABLE department
ADD FOREIGN KEY (supervisor_id) REFERENCES Employee(emp_id) ON DELETE SET NULL;

INSERT INTO sport(sportName,teamMember) values 
('bowling',2),
('gym',null),
('swimming',null),
('Basket ball',5);

INSERT INTO coach values 
(10000	,3);





INSERT INTO class (day,startTime,endtime,coach_id) values 
('Monday',	'10:00:00',	'13:00:00',	10000),
('Tuesday',	'10:30:00',	'12:30:00',	10000),
('Wednesday','11:30:00','13:30:00',	10000),
('Thursday','13:30:00',	'16:30:00',	10000),
('Friday',	'9:30:00',	'10:30:00',	10000),
('Saturday','10:30:00',	'11:30:00',	10000),
('Monday',	'9:00:00',	'12:00:00',	10000),
('Thursday','12:00:00',	'15:00:00',	10000);


INSERT INTO trainee  values 
(1,	10000),
(7,	10001),
(3,	10003),
(6,	10002);

INSERT INTO allergies VALUES
('374052080002', 'Pollen'),
('374052080004', 'Dust'),
('374052080007', 'Dust');


INSERT INTO security_qs (ques) values 
('Nick name'),
('Favourite colour'),
('Favourite pet'),
('Mother name');

INSERT INTO users (emp_id, password, security_qs_id, securityAns) VALUES
(10000, 'Tavish123', 1, 'bunny'),
(10001, 'Tavish123', 2, 'black'),
(10002, 'Tavish123', 3, 'cat'),
(10003, 'Tavish123', 2, 'blue'),
(10004, 'Tavish123', 4, 'abaida'),
(10005, 'Tavish123', 4, 'farzana'),
(10006, 'Tavish123', 2, 'brown'),
(10007, 'Tavish123', 3, 'fish'),
(10008, 'Tavish123', 3, 'fish'),
(10009, 'Tavish123', 2, 'white');


INSERT INTO team(sport_id,package)   values 
(4	,'training'),
(1	,'non-training');

INSERT INTO team_schedule  values 
(1,	4);

INSERT INTO attendance values 
(10000,	'2021-12-07',	'P'),
(10001,	'2021-12-07',	'A'),
(10002,	'2021-12-07',	'P'),
(10003,	'2021-12-07',	'P'),
(10004,	'2021-12-07',	'P'),
(10005,	'2021-12-07',	'P'),
(10006,	'2021-12-07',	'P'),
(10007,	'2021-12-07',	'P'),
(10008,	'2021-12-07',	'P'),
(10009,	'2021-12-07',	'P');

INSERT INTO schedule(eventName,date,time,venue)   values 
('Swimming Tournament',	'2021-12-6',	'12:30:00',	'Main Swimming Pool,floor1'),
('Bowling Competition',	'2021-12-20',	'14:00:00',	'Bowling Court 4,floor2');

INSERT INTO emergency(patient_id,problem,date,time,status)  values 
(10000,'fractured','2021-06-19','10:30:49','resolved'),
(10003,'injured','2021-11-17','15:15:26','resolved'),
(10002,'wrist sprains','2021-03-21','17:18:30','resolved'),
(10003,'Asthma attack','2021-12-04','12:30:49','unresolved');

INSERT INTO inventory(sport_id,itemName,quantity) values 
(1,'Bowling balls',35),
(1,'Bowling pins',60),
(2,'Dumbbells',9),
(4,'Balls',6),
(4,'Med First Aid Kit',4),
(1,'Med First Aid Kit',4),
(3	,'Med Oxygen tank',	3),
(2	,'Med  Hot bags',	7),
(2	,'Med  Drips',	8);


INSERT INTO issued_items(member_id,item_id,time,quantity) values 
(10003 , 3,'10:15:20',4),
(10001 ,1 ,'12:25:30',10),
(10001,2,'12:30:45',12),
(10000 , 4,'9:12:25',2);


INSERT INTO inventory_log values 
(10003,3,'2021-10-15','10:15:20','17:30:49',4,0),
(10001,1,'2021-10-15','12:25:30','15:30:30',10,0),
(10001,2,'2021-10-15','12:30:45','15:34:45',12,1),
(10000,4,'2021-10-25','9:12:25','13:12:25',2,0);

DELETE FROM issued_items WHERE issue_id =1;
DELETE FROM issued_items WHERE issue_id =2;
DELETE FROM issued_items WHERE issue_id =3;
DELETE FROM issued_items WHERE issue_id =4;

INSERT INTO issued_items(member_id,item_id,time,quantity) values 
(10003 , 8,'12:15:20',1),
(10002 ,4 ,'10:25:30',2),
(10001,9,'13:30:45',2),
(10000 , 2,'11:12:25',2);




INSERT INTO maintenance(sport_id,date,activity,level)  values 
(3,'2021-01-21','Checking','Partial'),
(3,'2021-02-07','Cleaning','Compelete'),
(2,'2021-02-16','Checking','Compelete'),
(4,'2021-05-19','Cleaning','Not Started');

INSERT INTO medical_log   values 
(1, 5, 1),
(2, 6, 1),
(3,	6, 1),
(4,	5, 1);

INSERT INTO repairs(sport_id,purpose,amount,status)   values 
(2,	'Repair treadmill' ,	10000 ,	'Pending'),
(3	,'Repair filter pump'	,50000,'Allocated');

INSERT INTO report(details,type,status)   values 
('Treadmill not working',	'complaint',	'addressed'),
('New AC for bowling court',	'suggestion',	'unaddressed'),
('More swimming dresses', 'suggestion', 'unaddressed'),
('Filter pump of swimming pool 3 not working', 'complaint', 'unaddressed');

INSERT INTO notice(title,text,date)   values 
('Swimming tournament','Join us for Swimming tournament on 6 DEC','2021-12-6'),
('Bowling competition','Gear up for Bowling competition on  20 DEC','2021-12-20'),
('Christmas Holiday','Enjoy Christmas & spread happiness','2021-12-25');

INSERT INTO transactions(type,amount) values 
('Electricity_bill',	30000),
('maintenanceFunds',	15000),
('inventoryFunds',	25000),
('repairFunds',	7000);

INSERT INTO credit_membership(member_id,date,amount,status) values 
(10000,	'2020-11-01' ,5000,	'paid'),
(10001,	null,	8000,	'unpaid'),
(10002	,null,	5000,	'unpaid'),
(10003	,'2020-10-06',	10000,	'paid');

