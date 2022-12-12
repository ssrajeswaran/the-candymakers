from flask import Blueprint, request, jsonify, make_response
import json
from src import db

# make a blueprint
mktg_mgr = Blueprint('mktg_mgr', __name__)

@mktg_mgr.route("/mktgmgrs")
def get_mktg_mgrs():
    cursor = db.get_db().cursor()
    cursor.execute('select m.mktg_mgr_id as value from marketing_mgrs m')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

@mktg_mgr.route("/adupdateform")
def get_ad_form():
    return """
        <h2>HTML Forms</h2>
        <form action="/mktgmgr/adupdate" method="POST">
        <label for="location">Ad location:</label><br>
        <input type="text" id="location" name="location"><br>
        <label for="cost">Cost of Ad:</label><br>
        <input type="integer" id="cost" name="cost"><br><br>
        <input type="submit" value="Submit">
        </form>
    """

@mktg_mgr.route('/adupdate', methods = ['POST'])
def post_ad_form():
    # current_app.logger.info(request.form)
    # cursor = db.get_db().cursor()
    location = request.form['location']
    cost = request.form['cost']
    query = f'INSERT INTO advertisement(location, cost, mktg_mgr_id) VALUES(\"{location}\", {cost}, {mktg_mgr_id})'
    # db.get_db().commit()
    return f'success {query}'