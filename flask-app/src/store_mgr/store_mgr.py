from flask import Blueprint, request, jsonify, make_response
import json
from src import db

# make a blueprint
store_mgr = Blueprint('store_mgr', __name__)

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

# When the store mgr partners with a new shipper, they need to add the shipper's info into the db
# below is a route for an html form (127.0.0.1:8001/newshipperform)
# note: this was not implemented in the Appsmith wireframes
@store_mgr.route("/newshipperform")
def get_shipper_form():
    return """
        <h2>HTML Forms</h2>
        <form action="/storemgr/newshipper" method="POST">
        <label for="name">Shipper Name:</label><br>
        <input type="text" id="name" name="name"><br>
        <label for="address">Shipper Location:</label><br>
        <input type="text" id="address" name="address"><br><br>
        <label for="email">Shipper Email:</label><br>
        <input type="text" id="email" name="email"><br><br>
        <label for="shipper_id">Shipper ID:</label><br>
        <input type="integer" id="shipper_id" name="shipper_id"><br><br>
        <input type="submit" value="Submit">
        </form>
    """

# post route to update the db with new shipper's info
@store_mgr.route('/newshipper', methods = ['POST'])
def post_shipper_form():
    cursor = db.get_db().cursor()
    name = request.form['name']
    address = request.form['address']
    email = request.form['email']
    shipper_id = request.form['shipper_id']
    query = f'INSERT INTO shippers (name, address, email, shipper_id) \
            VALUES (\"{name}\", \"{address}\", \"{email}\", {shipper_id})'
    cursor.execute(query)
    db.get_db().commit()
    return f'Success! Your query was: {query}'


# get route for store mgr to see how many invoices different shippers are handling
@store_mgr.route('/shipperinvoicecount')
def get_shipper_invoice_count():
    cursor = db.get_db().cursor()

    query = '''
        SELECT s.name AS Shipper, COUNT(*) AS NumInvoices
        FROM shippers s JOIN invoices i on s.shipper_id = i.shipper_id
        GROUP BY Shipper;
    '''
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


