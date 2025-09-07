# Automobile Service Appointment Management System  

## Overview  
The **Automobile Service Appointment Management System** is a database-driven application designed to streamline vehicle service scheduling and management. 

<p> &nbsp; </p>

The project integrates **Microsoft Access** as the front-end interface and **Oracle SQL** as the back-end database, providing both customers and mechanics with a user-friendly and reliable platform for managing appointments, vehicle details, and service history.  

<p> &nbsp; </p>

For more details, please check the project repository on [GitHub](https://github.com/kang-tian/Automobile-Service-Appointment-Management-System).

<p> &nbsp;</p>  

## Skills & Technologies  
- **Microsoft Access:** Forms, reports, VBA programming, user interface design.  
- **Oracle SQL & PL/SQL:** Schema design, triggers, stored procedures, packages, and functions.  
- **Database Design:** Normalization, multi-valued relationships, temporal data management.  
- **Integration:** Access front-end linked with Oracle database via ODBC connection.
<p> &nbsp; </p>
  
## Key Features  

### 1. Front-End (Microsoft Access)  
- **Navigation Page**  
  - Entry point allows users to choose between **“Login as Customer”** or **“Login as Mechanic.”**  
<p align="center">
  <img src="/projects/Automobile-Service-Appointment-Management-System/images/Picture1.png" alt="Reviews per Page" width="50%"/>
</p>
<p> &nbsp; </p>

- **Customer Portal**  
  - Customers can enter and update their **personal information**, **vehicle details**, and **appointment requests.**  
  - A customer can manage **multiple vehicles**, and each vehicle can have **multiple appointments.**
<p align="center">
  <img src="/projects/Automobile-Service-Appointment-Management-System/images/Picture2.png" alt="Reviews per Page" width="70%"/>
</p>
<p align="center">
  <img src="/projects/Automobile-Service-Appointment-Management-System/images/Picture3.png" alt="Reviews per Page" width="70%"/>
</p>
<p> &nbsp; </p>

- **Service Type Selection**  
  - When booking an appointment, selecting a **service type** (e.g., tire, engine, battery, others) automatically opens a detailed form tailored to that service.  
  - Ensures accurate and structured data entry for specialized services.
<p align="center">
  <img src="/projects/Automobile-Service-Appointment-Management-System/images/Picture4.png" alt="Reviews per Page" width="70%"/>
</p>
<p> &nbsp; </p>

- **Mechanic Portal**  
  - Mechanics can log in to view a list of their assigned appointments.  
  - For each appointment, mechanics can see **customer details, vehicle information, and requested services.**   
  - Mechanics can fillin the **appointment status** and their **mechanic ID**, while other customer data remains read-only.  
<p align="center">
  <img src="/projects/Automobile-Service-Appointment-Management-System/images/Picture5.png" alt="Reviews per Page" width="100%"/>
</p>

<p> &nbsp; </p>

### 2. Back-End (Oracle SQL Database)  

#### 2.1 Core Schema  
- Designed relational schema with **customers, vehicles, appointments, mechanics, and service tables.**  
- Enforced **referential integrity** with primary and foreign keys.  
<p align="center">
  <img src="/projects/Automobile-Service-Appointment-Management-System/images/Picture6.png" alt="Reviews per Page" width="100%"/>
</p>
<p> &nbsp; </p>

#### 2.2 Association & History Tracking  
- Implemented **association tables** and **history table** for handling **multi-valued relationships** (e.g., customer-appointment, vehicle-service) and recording the changes made by users.  
- Each association table includes **StartDate** and **EndDate** columns to enable **temporal history tracking.**
- Example: Customer with `CustomerID = 100` changed their phone number from `555-1234` to `111-111-1111`; both values are recorded with timestamps in the **history table.**
<p align="center">
  <img src="/projects/Automobile-Service-Appointment-Management-System/images/Picture7.png" alt="Reviews per Page" width="70%"/>
</p>
<p align="center">
  <img src="/projects/Automobile-Service-Appointment-Management-System/images/Picture8.png" alt="Reviews per Page" width="40%"/>
</p>
<p> &nbsp; </p>

#### 2.3 Historical Data Management  
- Developed **14 sets of association and history tables** to capture changes in customer, vehicle, and service records.  
- Ensures full auditability of modifications made by both customers and mechanics.  
<p align="center">
  <img src="/projects/Automobile-Service-Appointment-Management-System/images/Picture9.png" alt="Reviews per Page" width="70%"/>
</p>
<p> &nbsp; </p>

#### 2.4 PL/SQL Automation  
- Created **packages, procedures, functions, and triggers** in Oracle SQL to handle:  
  - **Insertions, updates, and deletions** with cascading rules.  
  - Automatic logging of changes into history tables.  
  - Enforcement of data consistency across front-end (Access) and back-end (Oracle).  
<p align="center">
  <img src="/projects/Automobile-Service-Appointment-Management-System/images/Picture10.png" alt="Reviews per Page" width="70%"/>
</p>
<p align="center">
  <img src="/projects/Automobile-Service-Appointment-Management-System/images/Picture11.png" alt="Reviews per Page" width="70%"/>
</p>
<p> &nbsp; </p>


## Skills & Technologies  
- **Microsoft Access:** Forms, reports, VBA programming, user interface design.  
- **Oracle SQL & PL/SQL:** Schema design, triggers, stored procedures, packages, and functions.  
- **Database Design:** Normalization, multi-valued relationships, temporal data management.  
- **Integration:** Access front-end linked with Oracle database via ODBC connection.  

<p> &nbsp; </p>

## Impact  
This project demonstrates expertise in **database application development**, combining user-friendly **front-end interfaces** with **robust back-end data management.** The system ensures both **ease of use for customers and mechanics** and **data integrity with historical tracking**, making it a practical solution for real-world automobile service management.  
