from flask import Blueprint, request, jsonify, make_response
import json
from src import db

# make a blueprint
mktg_mgr = Blueprint('mktg_mgr', __name__)

# route to get mktg_mgr_id and mgr last name
# will be used in a drop down widget
@mktg_mgr.route("/mktgmgrs")
def get_mktg_mgrs():
    cursor = db.get_db().cursor()
    cursor.execute('select m.mktg_mgr_id as value, m.last_name as label from marketing_mgrs m')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# route to get candy_id and candy name
# will be used in a drop down widget
@mktg_mgr.route("/candies")
def get_candy_name_id():
    cursor = db.get_db().cursor()
    cursor.execute('select c.candy_id as value, c.candy_name as label from candies c')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# route for mktg mgr to insert info into the db about a new ad they just created
@mktg_mgr.route('/adupdate', methods = ['POST'])
def post_ad_form():
    cursor = db.get_db().cursor()
    location = request.form['location']
    cost = request.form['cost']
    mktg_mgr_id = request.form['mktg_mgr_id']
    candy_id = request.form['candy_id']
    advertisement_id = request.form['advertisement_id']
    query = f'INSERT INTO advertisements (location, cost, mktg_mgr_id, candy_id, advertisement_id) VALUES(\"{location}\", {cost}, {mktg_mgr_id}, {candy_id}, {advertisement_id})'
    cursor.execute(query)
    db.get_db().commit()
    return f'success {query}'