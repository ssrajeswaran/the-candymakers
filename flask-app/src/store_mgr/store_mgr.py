from flask import Blueprint, request, jsonify, make_response
import json
from src import db

# make a blueprint
store_mgr = Blueprint('store_mgr', __name__)

@store_mgr.route('/hi')
def test():
    return 'hello'

@store_mgr.route('/restockinfo', methods=['GET'])
def get_candies():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute('select * from candies')

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