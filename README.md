Pahana Edu Bookshop Management System

Project Overview
The Pahana Edu Bookshop Management System is a web-based billing and customer management application designed for Pahana Edu Bookshop in Colombo. It streamlines operations such as customer registration, inventory management, billing, payments, and report generation. The system ensures efficient tracking of bookshop activities, reduces manual work, and improves overall productivity.
Technologies Used
•	Frontend: HTML, CSS, Tailwind CSS, JavaScript
•	Backend: Java (Servlets, JSP)
•	Database: MySQL
•	Tools: Apache NetBeans, WampServer

Features
•	User Authentication: Secure login/logout system with session handling.
•	Customer Management: Add, edit, delete, and view customers.
•	Inventory Management: Manage items/books including add, edit, and list.
•	Billing System: Generate bills with multiple items and auto-calculated totals.
•	Payment Tracking: View and update payment status.
•	Report Generation: View detailed payment report, admin-only views.
•	Help & Support: Help page with guidance for users.

Getting Started
Prerequisites
•	Java Development Kit (JDK)
•	Apache NetBeans
•	MySQL Server
•	Apache Tomcat (configured in NetBeans)

Installation Steps
1.	Clone the repository:
2.	git clone https://github.com/Akeeban-06/PahanaEdubookshopSystem.git
3.	Import the database:
o	Use the provided pahana_edu_bookshop.sql file to set up your database.
4.	Open the project in NetBeans and configure your database connection (dbURL, dbUser, dbPassword).
5.	Run the application using your Apache Tomcat server configured in NetBeans.

Admin Dashboard Login
•	Username - admin
•	Password - admin123 (or as set in your DB)

GitHub Repository and Version Control
This project uses Git for version control with the repository hosted publicly on GitHub.
Version Control Workflow
•	Develop features and test locally.
•	Commit regularly with descriptive messages.
•	Push daily updates to GitHub.
•	Maintain a structured folder and naming conventions

Database Schema
•	pahana_edu_bookshop.sql file provided includes: 
o	users – Admin and staff login credentials
o	customers – Customer details
o	items – Inventory and book records
o	bills – Bill details
o	bill_items – Bill line items (many-to-one with bills)
o	payments – Payment records

Contributions
You are welcome to contribute to this project by:
•	Reporting bugs or issues
•	Suggesting new features
•	Making pull requests

Contact
•	Email: logeesanakeeban2002@gmail.com

This repository and documentation clearly showcase version control practices, project workflow, and easy collaboration for managing the PahanaEdu Bookshop Management System effectively.
