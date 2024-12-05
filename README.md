
# Sports-Complex-Management-System

A Java based desktop application made for Sports Complex Management. 
The objective is to make a system that can manage the records, data and servicing activities of different sports, players, coach, management all at a time through a single platform.    

## Project Description
- JavaFX (FXML) for front-end, CSS for styling
- JDBC for connection of database with system
- MySQL for Database

### ERD
![alt text]https://github.com/tchawla827/Sports-Tournament-Management-System

<br/>
This project is a new self-contained product offering following:
<br/>

### Registration:
The registration department has the access to register and remove employees, members, teams, trainees, participants of the tournaments, and guests. New user gets default password of 'Employee@123'.
![image](https://user-images.githubusercontent.com/77397009/186241298-32de9947-8c1a-4e4f-a37e-ec86b173ac27.png)

### Finance:
Finance department is responsible for all kind of transactions. It can generate payrolls, credit memberships, allocate funds for the extras and tournaments, and pay monthly bills of the Sports Complex.
![image](https://user-images.githubusercontent.com/77397009/186241428-b5eafa62-c341-47c2-a7de-394cf1b4a690.png)

### Maintenance and Repairs:
They ensure regular maintenance check-ups and can request for repair funds.
<p align="center">
  <img src="https://user-images.githubusercontent.com/77397009/186241544-43cad98a-ff6b-419c-8147-cfed751f5015.png">
</p>

### Inventory:	
The inventory department maintains the records of items associated with the Complex. This includes the regular borrow and return of objects and request of funds for the new items when required. 
![image](https://user-images.githubusercontent.com/77397009/186241655-5dd98c9d-abeb-4510-8f50-b8623f852361.png)

### Emergency:
This department maintains records of all the emergencies occurring in the Complex. 
<p align="center">
  <img src="https://user-images.githubusercontent.com/77397009/186242151-f9f244dd-8985-46ba-bc3d-781700ac3c98.png">
</p>

### Manager:
Manager will have access to complaints and suggestions, repairs, emergencies, and attendance of the employees. Manager can further issue notices that will be accessible to all users.
![image](https://user-images.githubusercontent.com/77397009/186242265-93d7c49e-7977-416c-aaa0-67270aa1cca7.png)

### Coach
Coach can view his/her daily schedule and trainees registered with him/her.
<p align="center">
  <img src="https://user-images.githubusercontent.com/77397009/186242930-7957a4c4-6ac9-4ebb-a8d3-657a8c7bbb2d.png">
</p>


### Attendant 
Attendant can mark daily attedance of employees which is then visible to manager.
<p align="center">
  <img src="https://user-images.githubusercontent.com/77397009/186243124-d1f297dd-d811-4cf8-88a7-f5e4b3bf0052.png">
</p>


<br/> <br/>
For further details please refer to Software Requirements Specification (SRS) and Software Design Specification (SDS)

## How to Run
    1- Execute SportsComplex.sql in MySQL.
    2- Open project in NetBeans IDE.
    3- In DbQuery.java, update the username and password attributes of class with your MySQL username and password at line 29 and 30 respectively.
    4- Run the project and Enjoy!

### Login details:
<p align="center">
  <img src="https://user-images.githubusercontent.com/77397009/186240805-554e4081-9d39-4b86-89f7-71ef0a42d89a.png">
</p>

	
### Use This Info to Login
users
+------------+--------+-----------+----------------+-------------+
| username   | emp_id | password  | security_qs_id | securityAns |
+------------+--------+-----------+----------------+-------------+
| A.Kumar98  |  10006 | Tavish123 |              2 | brown       | registration
| A.Mishra00 |  10005 | Tavish123 |              4 | farzana     | inventory
| A.Sharma02 |  10001 | Tavish123 |              2 | black       | maintenance
| I.Gupta99  |  10002 | Tavish123 |              3 | cat         | healthcentre
| K.Singh03  |  10003 | Tavish123 |              2 | blue        | transaction
| N.Roy03    |  10009 | Tavish123 |              2 | white       | manager
| R.Verma01  |  10004 | Tavish123 |              4 | abaida      |
| S.Chopra04 |  10007 | Tavish123 |              3 | fish        | coach
| T.Chawla04 |  10000 | Tavish123 |              1 | bunny       | coach
| Y.Patel02  |  10008 | Tavish123 |              3 | fish        | 
+------------+--------+-----------+----------------+-------------+
employee
+--------+--------------+---------+
| emp_id | cnic         | dept_id |
+--------+--------------+---------+
|  10000 | 374052080001 |       7 |
|  10001 | 374052080002 |       6 |
|  10002 | 374052080003 |       5 |
|  10003 | 374052080004 |       4 |
|  10004 | 374052080005 |       3 |
|  10005 | 374052080006 |       2 |
|  10006 | 374052080007 |       1 |
|  10007 | 374052080008 |       7 |
|  10008 | 374052080009 |       8 |
|  10009 | 374052080010 |       9 |
+--------+--------------+---------+
department
+---------+--------------+---------------+--------+
| dept_id | deptName     | supervisor_id | salary |
+---------+--------------+---------------+--------+
|       1 | registration |         10000 |  45000 |
|       2 | inventory    |         10001 |  25000 |
|       3 | medical      |         10003 |  25000 |
|       4 | finance      |         10004 |  50000 |
|       5 | emergency    |         10005 |  25000 |
|       6 | maintenance  |         10006 |  25000 |
|       7 | coach        |         10007 |  40000 |
|       8 | attendant    |         10008 |  25000 |
|       9 | manager      |         10009 |  50000 |
+---------+--------------+---------------+--------+



## Project By Tavish Chawla
