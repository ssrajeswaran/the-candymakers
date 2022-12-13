# Some set up for the application

from flask import Flask
from flaskext.mysql import MySQL

# create a MySQL object that we will use in other parts of the API
db = MySQL()

def create_app():
    app = Flask(__name__)
    
    # secret key that will be used for securely signing the session 
    # cookie and can be used for any other security related needs by 
    # extensions or your application
    app.config['SECRET_KEY'] = 'someCrazyS3cR3T!Key.!'

    # allow DB object to be able to connect to MySQL.
    app.config['MYSQL_DATABASE_USER'] = 'webapp'
    app.config['MYSQL_DATABASE_PASSWORD'] = open('/secrets/db_password.txt').readline()
    app.config['MYSQL_DATABASE_HOST'] = 'db'
    app.config['MYSQL_DATABASE_PORT'] = 3306
    app.config['MYSQL_DATABASE_DB'] = 'candyland'  # Change this to your DB name

    # Initialize the database object with the settings above. 
    db.init_app(app)

    # import routes
    from src.store_mgr.store_mgr import store_mgr
    from src.customers.customers import customers
    from src.mktg_mgr.mktg_mgr import mktg_mgr

    # register routes we just imported
    app.register_blueprint(store_mgr, url_prefix='/storemgr')
    app.register_blueprint(customers, url_prefix='/cust')
    app.register_blueprint(mktg_mgr, url_prefix='/mktgmgr')


    return app