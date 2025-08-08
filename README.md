Pahana Edu Bookshop Management System

Project Overview
The Pahana Edu Bookshop Management System is a web-based billing and customer management application designed for Pahana Edu Bookshop in Colombo. It streamlines operations such as customer registration, inventory management, billing and payment report generation. The system ensures efficient tracking of bookshop activities, reduces manual work, and improves overall productivity.

Technologies Used
Frontend: HTML, JSP, Tailwind CSS

Backend: Java (Servlets, JSP)

Database: MySQL

Tools: Apache NetBeans, WampServer

Features
User Authentication: Secure login/logout system with session handling.

Customer Management: Add, edit, delete, and view customers.

Inventory Management: Manage items/books including add, edit, and list.

Billing System: Generate bills with multiple items and auto-calculated totals.

Payment Tracking: View and update payment status.

Admin Dashboard: Summary of key metrics with restricted admin-only views.

Report Generation: View detailed payment report.

Help & Support: Help page with guidance for users.

Getting Started
Prerequisites
Java Development Kit (JDK 21)

Apache NetBeans IDE

MySQL Server

Apache Tomcat (configured in NetBeans)

Installation Steps
Clone the repository:
git clone https://github.com/Akeeban-06/PahanaEdubookshopSystem.git
Import the database: o Use the provided pahana_edu_bookshop.sql file to set up your database.
Open the project in NetBeans and configure your database connection (dbURL, dbUser, dbPassword).
Run the application using your Apache Tomcat server configured in NetBeans.

Admin Dashboard Login
Username: admin

Password: admin123 (or as set in your DB)

GitHub Repository and Version Control
This project uses Git for version control with the repository hosted publicly on GitHub.

Version Control Workflow
Create features and test locally

Commit changes with clear and descriptive messages

Push updates to GitHub daily

Maintain structured folder and naming conventions

Use branches for major changes (if needed)

Database Schema
The database contains the following tables:

users – Admin and staff login credentials

customers – Customer details

items – Inventory and book records

bills – Bill header details

bill_items – Bill line items (many-to-one with bills)

payments – Payment records

Contributions
You are welcome to contribute to this project by:

Reporting bugs or issues

Suggesting new features

Submitting pull requests

Contact
Developer: Logeesan Akeeban

Email: logeesanakeeban2002@gmail.com
