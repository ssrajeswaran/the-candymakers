from flask import Blueprint, request, jsonify, make_response
import json
from src import db

# make a blueprint
mktg_mgr = Blueprint('mktg_mgr', __name__)

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
    query = f'INSERT INTO advertisement(location, cost) VALUES(\"{location}\", {cost})'
    # db.get_db().commit()
    return f'success {query}'