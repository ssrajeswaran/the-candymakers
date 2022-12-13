from flask import Blueprint, request, jsonify, make_response
import json
from src import db


customers = Blueprint('customers', __name__)

# route that will allow customer to see all candies currently being sold
# and nutritional info, price
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


# route to get only the candy id and name of all candies currently being sold
# will be used in a drop down widget
@customers.route("/candyallergy")
def get_available_candy():
    cursor = db.get_db().cursor()
    query = 'select c.candy_id as value, c.candy_name as label from candies c WHERE c.currently_sold = 1'
    cursor.execute(query)
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# route to get all the ingredients of a candy, given its candy_id
@customers.route('/ingredients/<candy_id>')
def get_ingredients(candy_id):
    cursor = db.get_db().cursor()

    query = f'SELECT i.name AS Ingredient \
            FROM candies_ingredients ci JOIN ingredients i on ci.ingredient_id = i.ingredient_id \
            WHERE ci.candy_id = {candy_id};'

    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)
