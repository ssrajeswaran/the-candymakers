# Candyland: CS3200 Final Project
### Made By: Shreya Rajeswaran (The Candymakers)

Database creation:
- This project involved creating a database to support a fictional candy company called
Candyland which wanted a better way to keep track of the candies it is selling, customers who order from it,
invoices that are made, employees of the company, etc. This database was first designed with entity-relationship
diagrams and then created using MySQL.

Web development:
- After the database was created, Python Flask was used as a tool to write routes for different user-personas
to view or update different aspects of the data. 
- Flask was then connected to Appsmith through a secure Ngrok connection. Appsmith allowed for the 
creation of different user interfaces that could be linked back to the Flask routes to cleanly display get and post
requests.

Docker:
- To facilitate the project, Docker was used to generate containers. This repo spins up 2 Docker containers: 
  1. A MySQL 8 container
  1. A Python Flask container to implement a REST API

In order to create the REST API, the flask-app folder contains three different blueprints for different 
user-personas to access different aspects of the database. Each blueprint includes get and post routes that
are relevant for that specific user-persona. The personas include:
1. **Customer**: a user who is interested in buying candies from Candyland and who wants to know 
price, nutritional info, and ingredient list of different candies
2. **Marketing manager**: a user who is involved in advertising and promoting Candyland, who needs to be able to
insert information about a new ad that they have created
3. **Store manager**: a user who is heavily involved in restocking candies in the company, managing invoices, and 
keeping track of shippers who are sending invoices/orders to customers

For a brief video overview of this project (including the user interface on Appsmith), visit:
https://drive.google.com/file/d/155xowfbroNRg4D8jHUwp1jHRBZ-SBReS/view?usp=share_link


