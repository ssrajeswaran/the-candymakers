from flask import Blueprint, request, jsonify, make_response
import json
from src import db


customers = Blueprint('customers', __name__)

@customers.route('/candies')
def get_cust_candies():
    cursor = db.get_db().cursor()

    query = '''
        SELECT c.candy_name AS Candy, c.unit_price AS Price,
           c.calories AS Calories, c.sugars AS Sugars, c.fats AS Fats, c.carbs AS Carbs
        FROM candies c
        WHERE currently_sold = 1;
    '''
    cursor.execute(query)
       # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers.
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


@customers.route("/ingredients")
def get_ingredients():
    cursor = db.get_db().cursor()
    cursor.execute('select i.name from ingredients i')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

@customers.route('/allergies')
def get_allergies(ingredient):
    cursor = db.get_db().cursor()

    query = f'SELECT c.candy_name AS Candy, c.unit_price AS Price, \
            c.calories AS Calories, c.sugars AS Sugars, c.fats AS Fats, c.carbs AS Carbs \
            FROM candies c JOIN ingredients i on \
            WHERE currently_sold = 1 AND i.name != {ingredient};'

    cursor.execute(query)
       # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers.
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)




# View available candies


# # Get all customers from the DB
# @customers.route('/customers', methods=['GET'])
# def get_customers():
#     cursor = db.get_db().cursor()
#     cursor.execute('select customerNumber, customerName,\
#         creditLimit from customers')
#     row_headers = [x[0] for x in cursor.description]
#     json_data = []
#     theData = cursor.fetchall()
#     for row in theData:
#         json_data.append(dict(zip(row_headers, row)))
#     the_response = make_response(jsonify(json_data))
#     the_response.status_code = 200
#     the_response.mimetype = 'application/json'
#     return the_response
#
# # Get customer detail for customer with particular userID
# @customers.route('/customers/<userID>', methods=['GET'])
# def get_customer(userID):
#     cursor = db.get_db().cursor()
#     cursor.execute('select * from customers where customerNumber = {0}'.format(userID))
#     row_headers = [x[0] for x in cursor.description]
#     json_data = []
#     theData = cursor.fetchall()
#     for row in theData:
#         json_data.append(dict(zip(row_headers, row)))
#     the_response = make_response(jsonify(json_data))
#     the_response.status_code = 200
#     the_response.mimetype = 'application/json'
#     return the_response