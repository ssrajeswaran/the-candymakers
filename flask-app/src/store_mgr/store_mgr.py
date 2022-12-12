from flask import Blueprint, request, jsonify, make_response
import json
from src import db

# make a blueprint
store_mgr = Blueprint('store_mgr', __name__)

@store_mgr.route('/hi')
def test():
    return 'hello'

# route that will allow store mgr to view important candy info
# to help with deciding what to restock
@store_mgr.route('/restockinfo', methods=['GET'])
def get_restock_info():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # grab candy, qty in stock, currently sold, and total sales
    query = '''
        SELECT c.candy_name AS Candy,
               c.qty_in_stock AS QuantityInStock,
               c.currently_sold AS CurrentlySold,
               SUM(il.qty * c.unit_price) AS TotalSales
        FROM candies c JOIN invoice_line il on c.candy_id = il.candy_id
        GROUP BY Candy, QuantityInStock, CurrentlySold;
    '''

    # use cursor to query the database
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
