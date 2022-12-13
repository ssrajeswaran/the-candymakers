-- This file is to bootstrap a database for the CS3200 project. 

-- Create a new database.  You can change the name later.  You'll
-- need this name in the FLASK API file(s),  the AppSmith 
-- data source creation.
create database candyland;

-- Via the Docker Compose file, a special user called webapp will 
-- be created in MySQL. We are going to grant that user 
-- all privilages to the new database we just created. 
-- TODO: If you changed the name of the database above, you need 
-- to change it here too.
grant all privileges on candyland.* to 'webapp'@'%';
flush privileges;

-- Move into the database we just created.
-- TODO: If you changed the name of the database above, you need to
-- change it here too. 
use candyland;


CREATE TABLE manufacturers (
    manufacturer_id INT NOT NULL,
    name VARCHAR(50),
    address VARCHAR(1000),
    PRIMARY KEY (manufacturer_id)
);


CREATE TABLE categories (
    category_id INT NOT NULL,
    category_name VARCHAR(50),
    PRIMARY KEY (category_id)
);


CREATE TABLE ingredients (
    ingredient_id INT NOT NULL,
    name VARCHAR(50),
    PRIMARY KEY (ingredient_id)
);


CREATE TABLE candies (
    candy_id INT NOT NULL,
    manufacturer_id INT NOT NULL,
    candy_name VARCHAR(50),
    unit_price DECIMAL(10,2),
    qty_in_stock INT,
    expiry_date DATE,
    calories INT,
    sugars INT,
    fats INT,
    carbs INT,
    currently_sold BOOL,
    PRIMARY KEY (candy_id),
    CONSTRAINT fk_candy_manuf
        FOREIGN KEY (manufacturer_id) REFERENCES manufacturers (manufacturer_id)
        ON UPDATE cascade ON DELETE restrict
);


CREATE TABLE discounts (
    discount_id INT NOT NULL,
    candy_id INT NOT NULL,
    discount_pct INT,
    start_date DATE,
    end_date DATE,
    PRIMARY KEY (discount_id),
    CONSTRAINT fk_disc_candy
        FOREIGN KEY (candy_id) REFERENCES candies(candy_id)
        ON UPDATE cascade ON DELETE restrict
);


CREATE TABLE store_mgrs (
    store_mgr_id INT NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone VARCHAR(20),
    email VARCHAR(50),
    PRIMARY KEY (store_mgr_id)
);

CREATE TABLE marketing_mgrs (
    mktg_mgr_id INT NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone VARCHAR(20),
    email VARCHAR(50),
    PRIMARY KEY (mktg_mgr_id)
);


CREATE TABLE customers (
    cust_id INT NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone VARCHAR(20),
    email VARCHAR(50),
    address VARCHAR(1000),
    PRIMARY KEY (cust_id)
);

CREATE TABLE shippers (
    shipper_id INT NOT NULL,
    name VARCHAR(50),
    address VARCHAR(1000),
    email VARCHAR(50),
    PRIMARY KEY (shipper_id)
);


CREATE TABLE advertisements (
    advertisement_id INT NOT NULL,
    candy_id INT NOT NULL,
    mktg_mgr_id INT NOT NULL,
    location VARCHAR(50),
    cost DECIMAL(10,2),
    PRIMARY KEY (advertisement_id),
    CONSTRAINT fk_ad_candy
        FOREIGN KEY (candy_id) REFERENCES candies (candy_id)
        ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT fk_ad_mktg
        FOREIGN KEY (mktg_mgr_id) REFERENCES marketing_mgrs (mktg_mgr_id)
        ON UPDATE cascade ON DELETE restrict
);



CREATE TABLE invoices (
    invoice_id INT NOT NULL,
    store_mgr_id INT NOT NULL,
    cust_id INT NOT NULL,
    shipper_id INT NOT NULL,
    billing_address VARCHAR(1000),
    invoice_date DATE,
    PRIMARY KEY (invoice_id),
    CONSTRAINT fk_inv_storemgr
        FOREIGN KEY (store_mgr_id) REFERENCES store_mgrs (store_mgr_id)
        ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT fk_inv_cust
        FOREIGN KEY (cust_id) REFERENCES customers (cust_id)
        ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT fk_inv_shipper
        FOREIGN KEY (shipper_id) REFERENCES shippers (shipper_id)
        ON UPDATE cascade ON DELETE restrict
);

CREATE TABLE candies_categories (
    candy_id INT NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (candy_id, category_id),
    CONSTRAINT fk_candy_cat
        FOREIGN KEY (category_id) REFERENCES categories (category_id)
        ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT fk_cat_candy
        FOREIGN KEY (candy_id) REFERENCES candies (candy_id)
        ON UPDATE cascade ON DELETE restrict
);

CREATE TABLE candies_ingredients (
    candy_id INT NOT NULL,
    ingredient_id INT NOT NULL,
    PRIMARY KEY (candy_id, ingredient_id),
    CONSTRAINT fk_candy_ing
        FOREIGN KEY (ingredient_id) REFERENCES ingredients (ingredient_id)
        ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT fk_ing_candy
        FOREIGN KEY (candy_id) REFERENCES candies (candy_id)
        ON UPDATE cascade ON DELETE restrict
);

CREATE TABLE invoice_line (
    candy_id INT NOT NULL,
    invoice_id INT NOT NULL,
    qty INT NOT NULL,
    PRIMARY KEY (candy_id, invoice_id),
    CONSTRAINT fk_candy_inv
        FOREIGN KEY (invoice_id) REFERENCES invoices (invoice_id)
        ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT fk_inv_candy
        FOREIGN KEY (candy_id) REFERENCES candies (candy_id)
        ON UPDATE cascade ON DELETE restrict
);



-- customers
INSERT INTO customers (cust_id, first_name, last_name, phone, email, address) VALUES (89219, 'Britteny', 'Shemilt', '820-987-4026', 'bshemilt0@csmonitor.com', '601 Luster Place');
INSERT INTO customers (cust_id, first_name, last_name, phone, email, address) VALUES (10866, 'Danita', 'Cuncliffe', '378-466-5108', 'dcuncliffe1@hao123.com', '6 Evergreen Way');
INSERT INTO customers (cust_id, first_name, last_name, phone, email, address) VALUES (59332, 'Selena', 'Tender', '667-301-3365', 'stender2@devhub.com', '35000 5th Lane');
INSERT INTO customers (cust_id, first_name, last_name, phone, email, address) VALUES (62620, 'Herschel', 'Comfort', '603-448-0215', 'hcomfort3@edublogs.org', '95995 Hovde Center');
INSERT INTO customers (cust_id, first_name, last_name, phone, email, address) VALUES (24282, 'Valery', 'Tilburn', '276-640-3147', 'vtilburn4@spotify.com', '9528 Aberg Center');
INSERT INTO customers (cust_id, first_name, last_name, phone, email, address) VALUES (91818, 'Neill', 'Mixter', '914-214-9524', 'nmixter5@msu.edu', '485 Namekagon Drive');
INSERT INTO customers (cust_id, first_name, last_name, phone, email, address) VALUES (97700, 'Farris', 'Castan', '219-691-0476', 'fcastan6@army.mil', '0 Continental Road');
INSERT INTO customers (cust_id, first_name, last_name, phone, email, address) VALUES (90679, 'Celisse', 'Adamovich', '544-651-3807', 'cadamovich7@zdnet.com', '2 Harbort Road');
INSERT INTO customers (cust_id, first_name, last_name, phone, email, address) VALUES (20634, 'Bat', 'Hedylstone', '263-894-9525', 'bhedylstone8@woothemes.com', '9 Claremont Circle');
INSERT INTO customers (cust_id, first_name, last_name, phone, email, address) VALUES (36534, 'Nero', 'Dowman', '687-229-2486', 'ndowman9@forbes.com', '14541 Springview Drive');
INSERT INTO customers (cust_id, first_name, last_name, phone, email, address) VALUES (84328, 'Judi', 'Blackett', '804-796-3166', 'jblacketta@twitpic.com', '31502 Schlimgen Terrace');
INSERT INTO customers (cust_id, first_name, last_name, phone, email, address) VALUES (87569, 'Joscelin', 'Eveque', '900-840-9086', 'jevequeb@typepad.com', '45 Laurel Alley');
INSERT INTO customers (cust_id, first_name, last_name, phone, email, address) VALUES (53321, 'Chadd', 'Carlesi', '569-420-1961', 'ccarlesic@naver.com', '85 Tennessee Alley');
INSERT INTO customers (cust_id, first_name, last_name, phone, email, address) VALUES (27226, 'Christian', 'Perigeaux', '817-412-4461', 'cperigeauxd@prnewswire.com', '5692 Miller Point');
INSERT INTO customers (cust_id, first_name, last_name, phone, email, address) VALUES (90965, 'Melessa', 'Meegin', '196-610-9343', 'mmeegine@eventbrite.com', '183 Eagle Crest Avenue');
INSERT INTO customers (cust_id, first_name, last_name, phone, email, address) VALUES (26239, 'Tremaine', 'Bacop', '624-267-3130', 'tbacopf@netvibes.com', '1 Boyd Way');
INSERT INTO customers (cust_id, first_name, last_name, phone, email, address) VALUES (55410, 'Arlan', 'Dossettor', '579-569-7028', 'adossettorg@blogs.com', '8676 Menomonie Way');
INSERT INTO customers (cust_id, first_name, last_name, phone, email, address) VALUES (22528, 'Eziechiele', 'Labadini', '636-138-0566', 'elabadinih@foxnews.com', '19 Oak Valley Court');
INSERT INTO customers (cust_id, first_name, last_name, phone, email, address) VALUES (73022, 'Bridgette', 'Donke', '611-619-8159', 'bdonkei@latimes.com', '512 Mifflin Crossing');
INSERT INTO customers (cust_id, first_name, last_name, phone, email, address) VALUES (20382, 'Lindon', 'Woodham', '464-577-0606', 'lwoodhamj@amazon.co.uk', '22662 Sutteridge Trail');
INSERT INTO customers (cust_id, first_name, last_name, phone, email, address) VALUES (99728, 'Jolene', 'Teggin', '971-952-9238', 'jteggink@google.ru', '93 Lighthouse Bay Court');
INSERT INTO customers (cust_id, first_name, last_name, phone, email, address) VALUES (75970, 'Bee', 'Haseley', '622-440-7951', 'bhaseleyl@1688.com', '7852 Fieldstone Drive');
INSERT INTO customers (cust_id, first_name, last_name, phone, email, address) VALUES (36183, 'Analise', 'Mc Coughan', '545-344-7427', 'amccoughanm@artisteer.com', '58944 Lakewood Gardens Park');
INSERT INTO customers (cust_id, first_name, last_name, phone, email, address) VALUES (90025, 'Florri', 'Aldie', '726-891-2949', 'faldien@google.com.hk', '5233 Sundown Court');
INSERT INTO customers (cust_id, first_name, last_name, phone, email, address) VALUES (67266, 'Daune', 'Peppett', '454-308-0734', 'dpeppetto@fotki.com', '11 Doe Crossing Parkway');
INSERT INTO customers (cust_id, first_name, last_name, phone, email, address) VALUES (11055, 'Aldous', 'Jahns', '221-702-8519', 'ajahnsp@oracle.com', '64123 Reinke Court');
INSERT INTO customers (cust_id, first_name, last_name, phone, email, address) VALUES (48105, 'Buckie', 'Grzelczyk', '599-201-5489', 'bgrzelczykq@indiatimes.com', '93 Mendota Pass');
INSERT INTO customers (cust_id, first_name, last_name, phone, email, address) VALUES (67690, 'Britt', 'Aksell', '614-714-2785', 'baksellr@mail.ru', '5 Darwin Drive');
INSERT INTO customers (cust_id, first_name, last_name, phone, email, address) VALUES (69748, 'Drucill', 'Ryles', '864-874-5789', 'dryless@si.edu', '10712 Carberry Court');
INSERT INTO customers (cust_id, first_name, last_name, phone, email, address) VALUES (42401, 'Dominik', 'Levis', '102-351-1617', 'dlevist@gravatar.com', '3 Claremont Park');

-- manufacturers
INSERT INTO manufacturers (manufacturer_id, name, address) VALUES (9421, 'Towne, Medhurst and Renner', '29 Maywood Hill');
INSERT INTO manufacturers (manufacturer_id, name, address) VALUES (9021, 'Buckridge Group', '03 Ronald Regan Park');
INSERT INTO manufacturers (manufacturer_id, name, address) VALUES (6082, 'Cole, Graham and Greenholt', '92 Chive Terrace');
INSERT INTO manufacturers (manufacturer_id, name, address) VALUES (9545, 'Satterfield-Parker', '6882 Eagan Point');
INSERT INTO manufacturers (manufacturer_id, name, address) VALUES (7279, 'Marks-Bashirian', '3 Chinook Street');
INSERT INTO manufacturers (manufacturer_id, name, address) VALUES (5920, 'Blick-Ziemann', '0 Alpine Parkway');
INSERT INTO manufacturers (manufacturer_id, name, address) VALUES (6668, 'Schroeder and Sons', '600 Kingsford Parkway');
INSERT INTO manufacturers (manufacturer_id, name, address) VALUES (2233, 'Hills-MacGyver', '5931 Badeau Drive');
INSERT INTO manufacturers (manufacturer_id, name, address) VALUES (3285, 'Johnson-Sipes', '34108 Florence Crossing');
INSERT INTO manufacturers (manufacturer_id, name, address) VALUES (1630, 'O-Reilly, Gleason and Wunsch', '30065 Straubel Court');
INSERT INTO manufacturers (manufacturer_id, name, address) VALUES (5515, 'Sanford Group', '3276 Armistice Court');
INSERT INTO manufacturers (manufacturer_id, name, address) VALUES (6339, 'Dooley Inc', '4 Wayridge Road');
INSERT INTO manufacturers (manufacturer_id, name, address) VALUES (4343, 'Stroman LLC', '09 Nova Alley');
INSERT INTO manufacturers (manufacturer_id, name, address) VALUES (1288, 'Pacocha Group', '07852 John Wall Street');
INSERT INTO manufacturers (manufacturer_id, name, address) VALUES (4079, 'Collier-Adams', '9471 Kennedy Hill');
INSERT INTO manufacturers (manufacturer_id, name, address) VALUES (7519, 'Hickle-Senger', '167 Dakota Road');
INSERT INTO manufacturers (manufacturer_id, name, address) VALUES (3264, 'Mertz Group', '67841 Corben Circle');
INSERT INTO manufacturers (manufacturer_id, name, address) VALUES (2855, 'Lesch, Stehr and Nolan', '28927 Cambridge Terrace');
INSERT INTO manufacturers (manufacturer_id, name, address) VALUES (1904, 'Medhurst and Sons', '4323 Grayhawk Way');
INSERT INTO manufacturers (manufacturer_id, name, address) VALUES (4166, 'Hackett, Osinski and Nitzsche', '94129 Division Lane');
INSERT INTO manufacturers (manufacturer_id, name, address) VALUES (5552, 'Keeling and Sons', '609 Stoughton Street');
INSERT INTO manufacturers (manufacturer_id, name, address) VALUES (7793, 'Mueller LLC', '6296 Rockefeller Place');
INSERT INTO manufacturers (manufacturer_id, name, address) VALUES (2679, 'Satterfield, Will and Borer', '7 Mayer Hill');
INSERT INTO manufacturers (manufacturer_id, name, address) VALUES (7425, 'Bruen-Breitenberg', '50432 Reindahl Lane');
INSERT INTO manufacturers (manufacturer_id, name, address) VALUES (2563, 'Rempel Group', '4 Reinke Place');
INSERT INTO manufacturers (manufacturer_id, name, address) VALUES (2731, 'Kunze-Fisher', '5633 Anzinger Terrace');
INSERT INTO manufacturers (manufacturer_id, name, address) VALUES (8488, 'Senger LLC', '4386 Fair Oaks Hill');
INSERT INTO manufacturers (manufacturer_id, name, address) VALUES (1919, 'Ledner-Hirthe', '656 Aberg Crossing');
INSERT INTO manufacturers (manufacturer_id, name, address) VALUES (6989, 'Wehner-Bartell', '27 Dapin Way');
INSERT INTO manufacturers (manufacturer_id, name, address) VALUES (5476, 'Carter-Kunde', '266 Bluestem Way');

-- ingredients
INSERT INTO ingredients (ingredient_id, name) VALUES (317, 'Eggs');
INSERT INTO ingredients (ingredient_id, name) VALUES (490, 'Flour');
INSERT INTO ingredients (ingredient_id, name) VALUES (744, 'Cocoa Powder');
INSERT INTO ingredients (ingredient_id, name) VALUES (235, 'Baking Powder');
INSERT INTO ingredients (ingredient_id, name) VALUES (265, 'Powdered Sugar');
INSERT INTO ingredients (ingredient_id, name) VALUES (689, 'Baking Soda');
INSERT INTO ingredients (ingredient_id, name) VALUES (441, 'Milk');
INSERT INTO ingredients (ingredient_id, name) VALUES (288, 'Water');
INSERT INTO ingredients (ingredient_id, name) VALUES (381, 'Salt');
INSERT INTO ingredients (ingredient_id, name) VALUES (217, 'Brown Sugar');
INSERT INTO ingredients (ingredient_id, name) VALUES (670, 'Dark Brown Sugar');
INSERT INTO ingredients (ingredient_id, name) VALUES (895, 'Cornstarch');
INSERT INTO ingredients (ingredient_id, name) VALUES (935, 'Nutmeg');
INSERT INTO ingredients (ingredient_id, name) VALUES (132, 'Oil');
INSERT INTO ingredients (ingredient_id, name) VALUES (109, 'Walnuts');
INSERT INTO ingredients (ingredient_id, name) VALUES (769, 'Peanuts');
INSERT INTO ingredients (ingredient_id, name) VALUES (891, 'Chocolate Chips');
INSERT INTO ingredients (ingredient_id, name) VALUES (812, 'Almonds');
INSERT INTO ingredients (ingredient_id, name) VALUES (594, 'Coconut');
INSERT INTO ingredients (ingredient_id, name) VALUES (536, 'White Chocolate Chips');
INSERT INTO ingredients (ingredient_id, name) VALUES (997, 'High Fructose Corn Syrup');
INSERT INTO ingredients (ingredient_id, name) VALUES (480, 'Maple Syrup');
INSERT INTO ingredients (ingredient_id, name) VALUES (619, 'Apples');
INSERT INTO ingredients (ingredient_id, name) VALUES (117, 'Heavy Cream');
INSERT INTO ingredients (ingredient_id, name) VALUES (113, 'Oranges');
INSERT INTO ingredients (ingredient_id, name) VALUES (378, 'Raspberry');
INSERT INTO ingredients (ingredient_id, name) VALUES (704, 'Strawberry');
INSERT INTO ingredients (ingredient_id, name) VALUES (687, 'Lemon');
INSERT INTO ingredients (ingredient_id, name) VALUES (751, 'Banana');
INSERT INTO ingredients (ingredient_id, name) VALUES (728, 'Food Coloring');

-- shippers
INSERT INTO shippers (shipper_id, name, address, email) VALUES (77, 'Otcom', '16796 Morningstar Parkway', 'ajayme0@upenn.edu');
INSERT INTO shippers (shipper_id, name, address, email) VALUES (21, 'Flexidy', '94 Nova Court', 'swatterson1@cam.ac.uk');
INSERT INTO shippers (shipper_id, name, address, email) VALUES (56, 'It', '7 Sheridan Street', 'dfforde2@youtube.com');
INSERT INTO shippers (shipper_id, name, address, email) VALUES (15, 'Veribet', '01442 Bunting Point', 'gcartwright3@scientificamerican.com');
INSERT INTO shippers (shipper_id, name, address, email) VALUES (50, 'Tempsoft', '85726 North Plaza', 'tgallop4@elpais.com');
INSERT INTO shippers (shipper_id, name, address, email) VALUES (23, 'Kanlam', '6 Bartelt Park', 'fewart5@lycos.com');
INSERT INTO shippers (shipper_id, name, address, email) VALUES (72, 'Stronghold', '13417 Hansons Hill', 'rdate6@archive.org');
INSERT INTO shippers (shipper_id, name, address, email) VALUES (89, 'Bytecard', '41 Ridge Oak Place', 'kstokell7@goo.gl');
INSERT INTO shippers (shipper_id, name, address, email) VALUES (95, 'Ventosanzap', '5 Grayhawk Street', 'tnorvill8@smh.com.au');
INSERT INTO shippers (shipper_id, name, address, email) VALUES (27, 'Alpha', '05 American Ash Lane', 'lhutchison9@alexa.com');
INSERT INTO shippers (shipper_id, name, address, email) VALUES (22, 'Fintone', '43307 Twin Pines Court', 'spercifera@sbwire.com');
INSERT INTO shippers (shipper_id, name, address, email) VALUES (97, 'Bamity', '92218 Marcy Point', 'rweavillb@ted.com');
INSERT INTO shippers (shipper_id, name, address, email) VALUES (78, 'Cardguard', '47 Macpherson Terrace', 'tromanc@freewebs.com');
INSERT INTO shippers (shipper_id, name, address, email) VALUES (92, 'Bigtax', '27439 Blue Bill Park Parkway', 'tobeyd@naver.com');
INSERT INTO shippers (shipper_id, name, address, email) VALUES (40, 'Zaam-Dox', '24583 Mallard Terrace', 'eglindee@1688.com');
INSERT INTO shippers (shipper_id, name, address, email) VALUES (98, 'Namfix', '389 Thierer Road', 'dparkinsf@sfgate.com');
INSERT INTO shippers (shipper_id, name, address, email) VALUES (45, 'Latlux', '84681 Cascade Court', 'lasherg@csmonitor.com');
INSERT INTO shippers (shipper_id, name, address, email) VALUES (25, 'Kanlam', '48832 Arizona Point', 'tgraffinh@washingtonpost.com');
INSERT INTO shippers (shipper_id, name, address, email) VALUES (66, 'Hatity', '824 Meadow Ridge Road', 'llangthornei@cmu.edu');
INSERT INTO shippers (shipper_id, name, address, email) VALUES (46, 'Keylex', '53604 Grover Circle', 'amephamj@jugem.jp');
INSERT INTO shippers (shipper_id, name, address, email) VALUES (87, 'Matsoft', '31 Mcbride Terrace', 'fgiovanazzik@godaddy.com');
INSERT INTO shippers (shipper_id, name, address, email) VALUES (34, 'Latlux', '531 Summerview Trail', 'hspoursl@pinterest.com');
INSERT INTO shippers (shipper_id, name, address, email) VALUES (67, 'Overhold', '2 Mandrake Hill', 'hgockem@mlb.com');
INSERT INTO shippers (shipper_id, name, address, email) VALUES (71, 'Fix San', '6888 Knutson Terrace', 'bbarteln@google.com');
INSERT INTO shippers (shipper_id, name, address, email) VALUES (11, 'Viva', '924 Hayes Point', 'tcockingo@usatoday.com');
INSERT INTO shippers (shipper_id, name, address, email) VALUES (37, 'Subin', '577 5th Plaza', 'gdrysdallp@oracle.com');
INSERT INTO shippers (shipper_id, name, address, email) VALUES (63, 'Viva', '36 Center Junction', 'slavrickq@shinystat.com');
INSERT INTO shippers (shipper_id, name, address, email) VALUES (13, 'Subin', '087 Transport Avenue', 'darchibaldr@economist.com');
INSERT INTO shippers (shipper_id, name, address, email) VALUES (41, 'Temp', '17 Scofield Point', 'dfortuns@youtu.be');
INSERT INTO shippers (shipper_id, name, address, email) VALUES (81, 'Sonsing', '59541 Delladonna Center', 'ltonnert@istockphoto.com');

-- store managers
INSERT INTO store_mgrs (store_mgr_id, first_name, last_name, phone, email) VALUES (783124, 'Aarika', 'Matcham', '473-790-5135', 'amatcham0@geocities.jp');
INSERT INTO store_mgrs (store_mgr_id, first_name, last_name, phone, email) VALUES (586885, 'Trudie', 'Cowpland', '353-358-9669', 'tcowpland1@bandcamp.com');
INSERT INTO store_mgrs (store_mgr_id, first_name, last_name, phone, email) VALUES (587532, 'Simona', 'Hampton', '488-611-1255', 'shampton2@geocities.com');
INSERT INTO store_mgrs (store_mgr_id, first_name, last_name, phone, email) VALUES (528003, 'Jehu', 'Tibbotts', '564-845-0000', 'jtibbotts3@phpbb.com');
INSERT INTO store_mgrs (store_mgr_id, first_name, last_name, phone, email) VALUES (848252, 'Rey', 'Luipold', '269-964-3405', 'rluipold4@macromedia.com');
INSERT INTO store_mgrs (store_mgr_id, first_name, last_name, phone, email) VALUES (366519, 'Aubrey', 'Gilks', '932-111-0017', 'agilks5@google.cn');
INSERT INTO store_mgrs (store_mgr_id, first_name, last_name, phone, email) VALUES (343104, 'Zeke', 'Pitt', '745-382-4146', 'zpitt6@wordpress.com');
INSERT INTO store_mgrs (store_mgr_id, first_name, last_name, phone, email) VALUES (941011, 'Thedric', 'Bingle', '970-392-0101', 'tbingle7@free.fr');
INSERT INTO store_mgrs (store_mgr_id, first_name, last_name, phone, email) VALUES (591008, 'Crawford', 'Berns', '570-627-7360', 'cberns8@jugem.jp');
INSERT INTO store_mgrs (store_mgr_id, first_name, last_name, phone, email) VALUES (377763, 'Raynor', 'MacMeanma', '404-134-1185', 'rmacmeanma9@tinyurl.com');
INSERT INTO store_mgrs (store_mgr_id, first_name, last_name, phone, email) VALUES (718861, 'Viviana', 'Margrem', '727-453-5073', 'vmargrema@reference.com');
INSERT INTO store_mgrs (store_mgr_id, first_name, last_name, phone, email) VALUES (100374, 'Mikaela', 'Sadlier', '271-116-1243', 'msadlierb@unicef.org');
INSERT INTO store_mgrs (store_mgr_id, first_name, last_name, phone, email) VALUES (335616, 'Linnea', 'Danzey', '188-251-5590', 'ldanzeyc@youtu.be');
INSERT INTO store_mgrs (store_mgr_id, first_name, last_name, phone, email) VALUES (875793, 'Eddy', 'Whopples', '594-640-5073', 'ewhopplesd@npr.org');
INSERT INTO store_mgrs (store_mgr_id, first_name, last_name, phone, email) VALUES (173540, 'Celene', 'Spurrier', '861-108-5322', 'cspurriere@sun.com');
INSERT INTO store_mgrs (store_mgr_id, first_name, last_name, phone, email) VALUES (601271, 'Gaby', 'Roxburch', '828-791-2909', 'groxburchf@google.it');
INSERT INTO store_mgrs (store_mgr_id, first_name, last_name, phone, email) VALUES (156962, 'Odella', 'Mullen', '445-710-1137', 'omulleng@e-recht24.de');
INSERT INTO store_mgrs (store_mgr_id, first_name, last_name, phone, email) VALUES (769981, 'Donni', 'Hammett', '463-798-9428', 'dhammetth@soundcloud.com');
INSERT INTO store_mgrs (store_mgr_id, first_name, last_name, phone, email) VALUES (527983, 'Udall', 'Cavnor', '450-421-7049', 'ucavnori@examiner.com');
INSERT INTO store_mgrs (store_mgr_id, first_name, last_name, phone, email) VALUES (354762, 'Griffie', 'Shields', '320-910-8186', 'gshieldsj@so-net.ne.jp');
INSERT INTO store_mgrs (store_mgr_id, first_name, last_name, phone, email) VALUES (741709, 'King', 'Trasler', '133-807-7165', 'ktraslerk@springer.com');
INSERT INTO store_mgrs (store_mgr_id, first_name, last_name, phone, email) VALUES (794617, 'Burke', 'Darrach', '658-451-5431', 'bdarrachl@goo.ne.jp');
INSERT INTO store_mgrs (store_mgr_id, first_name, last_name, phone, email) VALUES (432141, 'Vaughn', 'Waind', '514-582-4265', 'vwaindm@narod.ru');
INSERT INTO store_mgrs (store_mgr_id, first_name, last_name, phone, email) VALUES (133084, 'Stefanie', 'Petkens', '916-468-8360', 'spetkensn@tinyurl.com');
INSERT INTO store_mgrs (store_mgr_id, first_name, last_name, phone, email) VALUES (459141, 'Levon', 'Joincey', '165-768-7105', 'ljoinceyo@blogger.com');
INSERT INTO store_mgrs (store_mgr_id, first_name, last_name, phone, email) VALUES (709298, 'Anthe', 'Duberry', '341-200-5829', 'aduberryp@amazon.co.jp');
INSERT INTO store_mgrs (store_mgr_id, first_name, last_name, phone, email) VALUES (756531, 'Marsha', 'Ghent', '473-945-1160', 'mghentq@google.pl');
INSERT INTO store_mgrs (store_mgr_id, first_name, last_name, phone, email) VALUES (407977, 'Rey', 'Ofer', '297-888-3190', 'roferr@tamu.edu');
INSERT INTO store_mgrs (store_mgr_id, first_name, last_name, phone, email) VALUES (397857, 'Norine', 'Broggetti', '449-638-9236', 'nbroggettis@boston.com');
INSERT INTO store_mgrs (store_mgr_id, first_name, last_name, phone, email) VALUES (448916, 'Retha', 'Hasker', '210-307-9847', 'rhaskert@pagesperso-orange.fr');

-- mktg mgrs
INSERT INTO marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) VALUES (393518, 'Cordy', 'Beels', '227-619-6357', 'cbeels0@omniture.com');
INSERT INTO marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) VALUES (814966, 'Brandea', 'Beeden', '247-834-5770', 'bbeeden1@berkeley.edu');
INSERT INTO marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) VALUES (428815, 'Ely', 'MacLaverty', '381-734-9909', 'emaclaverty2@google.it');
INSERT INTO marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) VALUES (789343, 'Zane', 'Antic', '613-411-5706', 'zantic3@pinterest.com');
INSERT INTO marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) VALUES (444853, 'Dick', 'McClurg', '819-785-1482', 'dmcclurg4@stumbleupon.com');
INSERT INTO marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) VALUES (249410, 'Shela', 'Sallnow', '697-875-4686', 'ssallnow5@diigo.com');
INSERT INTO marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) VALUES (444866, 'Chelsy', 'Bessom', '144-428-8468', 'cbessom6@irs.gov');
INSERT INTO marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) VALUES (311355, 'Opal', 'Bicksteth', '982-120-8700', 'obicksteth7@google.com');
INSERT INTO marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) VALUES (684368, 'Kerry', 'Waymont', '838-627-6477', 'kwaymont8@w3.org');
INSERT INTO marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) VALUES (357132, 'Callida', 'Allibon', '946-767-8152', 'callibon9@patch.com');
INSERT INTO marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) VALUES (444840, 'Eberhard', 'Rignall', '657-292-1915', 'erignalla@qq.com');
INSERT INTO marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) VALUES (389567, 'Rhys', 'Hallewell', '665-375-3557', 'rhallewellb@cbslocal.com');
INSERT INTO marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) VALUES (465722, 'Peder', 'Elington', '113-745-9972', 'pelingtonc@apple.com');
INSERT INTO marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) VALUES (976810, 'Casey', 'Lukehurst', '966-846-3860', 'clukehurstd@hostgator.com');
INSERT INTO marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) VALUES (262889, 'Abey', 'Foxley', '563-797-7802', 'afoxleye@cyberchimps.com');
INSERT INTO marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) VALUES (732764, 'Letti', 'Faas', '774-430-6107', 'lfaasf@fotki.com');
INSERT INTO marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) VALUES (980312, 'Valeda', 'Younger', '561-320-1306', 'vyoungerg@plala.or.jp');
INSERT INTO marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) VALUES (937581, 'Nels', 'Blofield', '836-582-0786', 'nblofieldh@myspace.com');
INSERT INTO marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) VALUES (859126, 'Shannan', 'Alfonzo', '139-433-3056', 'salfonzoi@fda.gov');
INSERT INTO marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) VALUES (572611, 'Michaelina', 'Buttner', '664-232-2926', 'mbuttnerj@facebook.com');
INSERT INTO marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) VALUES (200198, 'Bradney', 'Hanny', '354-677-1639', 'bhannyk@cargocollective.com');
INSERT INTO marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) VALUES (225064, 'Cinderella', 'Godsafe', '907-546-5618', 'cgodsafel@skyrock.com');
INSERT INTO marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) VALUES (412383, 'Jelene', 'Botwood', '911-983-5419', 'jbotwoodm@yelp.com');
INSERT INTO marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) VALUES (384707, 'Patrice', 'Middler', '979-952-8281', 'pmiddlern@fotki.com');
INSERT INTO marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) VALUES (209084, 'Monica', 'Leel', '630-272-8036', 'mleelo@imdb.com');
INSERT INTO marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) VALUES (782687, 'Shirline', 'Cobello', '124-376-8736', 'scobellop@guardian.co.uk');
INSERT INTO marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) VALUES (865237, 'Egan', 'Wash', '582-907-7264', 'ewashq@timesonline.co.uk');
INSERT INTO marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) VALUES (938992, 'Berty', 'Gergely', '103-910-2987', 'bgergelyr@msn.com');
INSERT INTO marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) VALUES (248760, 'Winni', 'O-Duilleain', '990-241-0525', 'woduilleains@washingtonpost.com');
INSERT INTO marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) VALUES (895610, 'Carlie', 'Petracek', '119-116-8583', 'cpetracekt@google.com.hk');

-- categories
INSERT INTO categories (category_id, category_name) VALUES (3232686, 'Caramel');
INSERT INTO categories (category_id, category_name) VALUES (7109473, 'Chocolate');
INSERT INTO categories (category_id, category_name) VALUES (6695810, 'Mint');
INSERT INTO categories (category_id, category_name) VALUES (6655748, 'Coconut');
INSERT INTO categories (category_id, category_name) VALUES (3435943, 'Peanut');
INSERT INTO categories (category_id, category_name) VALUES (5754426, 'Almond');
INSERT INTO categories (category_id, category_name) VALUES (9557056, 'Orange');
INSERT INTO categories (category_id, category_name) VALUES (2311196, 'Strawberry');
INSERT INTO categories (category_id, category_name) VALUES (2852764, 'Raisin');
INSERT INTO categories (category_id, category_name) VALUES (3492998, 'White Chocolate');
INSERT INTO categories (category_id, category_name) VALUES (5839939, 'Taffy');
INSERT INTO categories (category_id, category_name) VALUES (4783237, 'Licorice');
INSERT INTO categories (category_id, category_name) VALUES (6751706, 'Jelly Beans');
INSERT INTO categories (category_id, category_name) VALUES (7217658, 'Lollipop');
INSERT INTO categories (category_id, category_name) VALUES (8576905, 'Rock Candy');
INSERT INTO categories (category_id, category_name) VALUES (9615887, 'Christmas');
INSERT INTO categories (category_id, category_name) VALUES (6961131, 'Gummy');
INSERT INTO categories (category_id, category_name) VALUES (3275785, 'Honey');
INSERT INTO categories (category_id, category_name) VALUES (9650576, 'Sour');
INSERT INTO categories (category_id, category_name) VALUES (9866792, 'Hard Candy');
INSERT INTO categories (category_id, category_name) VALUES (4312709, 'Halloween');
INSERT INTO categories (category_id, category_name) VALUES (8027776, 'Chewy');
INSERT INTO categories (category_id, category_name) VALUES (8997144, 'Fruity');
INSERT INTO categories (category_id, category_name) VALUES (6580906, 'Nutty');
INSERT INTO categories (category_id, category_name) VALUES (4516665, 'Nougat');
INSERT INTO categories (category_id, category_name) VALUES (7758372, 'Fondant');
INSERT INTO categories (category_id, category_name) VALUES (9373749, 'Fudge');
INSERT INTO categories (category_id, category_name) VALUES (1267141, 'European');
INSERT INTO categories (category_id, category_name) VALUES (4756185, 'French');
INSERT INTO categories (category_id, category_name) VALUES (7914790, 'Gum');

-- candies
INSERT INTO candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) VALUES (39313758, 2855, 'Kitkat', 6.59, 70, '2022-06-27', 23, 78, 12, 41, TRUE);
INSERT INTO candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) VALUES (61752835, 9021, 'Jolly Rancher', 3.88, 26, '2022-10-17', 49, 33, 17, 78, TRUE);
INSERT INTO candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) VALUES (75469899, 4079, 'Hersheys', 9.63, 28, '2022-09-17', 20, 91, 41, 8, TRUE);
INSERT INTO candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) VALUES (22480259, 7425, 'Pop Rocks', 1.28, 72, '2022-09-20', 54, 58, 93, 42, FALSE);
INSERT INTO candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) VALUES (71085921, 1904, 'Twix', 3.53, 54, '2022-09-28', 43, 65, 6, 80, FALSE);
INSERT INTO candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) VALUES (43486512, 2731, 'Twizzlers', 9.37, 96, '2022-01-27', 62, 20, 41, 70, TRUE);
INSERT INTO candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) VALUES (81188160, 9021, 'Butterfingers', 0.71, 19, '2022-06-11', 25, 84, 26, 35, TRUE);
INSERT INTO candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) VALUES (70685586, 1904, 'Reeses', 7.79, 24, '2022-10-01', 1, 99, 83, 86, TRUE);
INSERT INTO candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) VALUES (45525516, 8488, 'Reeses Pieces', 9.22, 37, '2022-02-16', 54, 64, 12, 17, TRUE);
INSERT INTO candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) VALUES (25586201, 7519, 'Skittles', 1.46, 66, '2022-06-04', 12, 95, 16, 18, TRUE);
INSERT INTO candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) VALUES (72302293, 8488, 'Starburst', 4.96, 61, '2022-09-10', 2, 58, 47, 16, TRUE);
INSERT INTO candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) VALUES (52255752, 4166, 'Milk Duds', 5.01, 78, '2022-02-10', 27, 77, 3, 32, TRUE);
INSERT INTO candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) VALUES (38416212, 6082, 'Almond Joy', 1.11, 15, '2022-04-20', 97, 71, 66, 32, TRUE);
INSERT INTO candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) VALUES (90112395, 2233, 'M&Ms', 5.72, 38, '2022-06-25', 65, 18, 71, 63, TRUE);
INSERT INTO candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) VALUES (94022635, 9021, 'Crunch', 5.38, 90, '2022-05-27', 100, 8, 32, 34, TRUE);
INSERT INTO candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) VALUES (12302565, 2731, 'Raisinets', 1.4, 53, '2022-06-26', 86, 11, 84, 73, FALSE);
INSERT INTO candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) VALUES (19395793, 5920, 'Whoppers', 2.49, 94, '2022-09-19', 62, 92, 16, 100, TRUE);
INSERT INTO candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) VALUES (78338525, 3285, '3 Musketeers', 9.68, 16, '2021-12-23', 37, 5, 79, 32, TRUE);
INSERT INTO candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) VALUES (69632483, 5920, 'Mike and Ike', 5.4, 1, '2022-10-29', 53, 68, 28, 91, TRUE);
INSERT INTO candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) VALUES (72076152, 2855, 'Dots', 3.79, 27, '2022-06-11', 19, 3, 74, 45, TRUE);
INSERT INTO candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) VALUES (46334925, 3285, 'Baby Ruth', 7.48, 32, '2022-02-26', 13, 23, 5, 83, TRUE);
INSERT INTO candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) VALUES (60596910, 6668, 'Sweet Tarts', 4.15, 23, '2022-05-21', 23, 78, 50, 76, TRUE);
INSERT INTO candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) VALUES (40475062, 6668, 'Snickers', 4.9, 15, '2022-06-01', 92, 58, 59, 82, TRUE);
INSERT INTO candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) VALUES (53103777, 2233, 'Sour Patch Kids', 6.38, 85, '2022-04-25', 61, 55, 13, 30, FALSE);
INSERT INTO candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) VALUES (29569692, 2679, 'Kisses', 4.07, 51, '2021-12-22', 26, 27, 7, 63, TRUE);
INSERT INTO candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) VALUES (90809602, 2731, 'Trolli', 1.57, 7, '2022-01-15', 9, 36, 25, 38, TRUE);
INSERT INTO candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) VALUES (36577199, 5920, 'Krackle', 5.15, 81, '2022-01-01', 57, 35, 5, 89, TRUE);
INSERT INTO candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) VALUES (21879745, 1904, 'Nerds', 9.71, 63, '2022-02-22', 52, 75, 35, 5, TRUE);
INSERT INTO candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) VALUES (88458076, 4079, 'Airheads', 0.03, 99, '2022-10-30', 78, 34, 38, 25, TRUE);
INSERT INTO candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) VALUES (49093250, 7425, 'Gobstoppers', 0.05, 28, '2022-05-09', 98, 17, 87, 23, TRUE);


-- discounts
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (70420, 22480259, 39, '2022-11-20', '2023-08-25');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (33377, 70685586, 24, '2022-04-18', '2023-10-15');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (25787, 78338525, 49, '2022-09-08', '2023-11-09');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (22653, 81188160, 38, '2022-02-25', '2023-10-24');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (60405, 75469899, 39, '2022-01-12', '2022-11-29');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (64358, 43486512, 43, '2022-05-08', '2023-08-30');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (61871, 72076152, 35, '2022-03-26', '2023-02-10');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (30140, 19395793, 28, '2022-01-15', '2022-12-06');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (49302, 38416212, 46, '2022-08-04', '2023-10-02');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (31707, 94022635, 30, '2022-04-15', '2023-10-13');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (79400, 78338525, 33, '2022-01-03', '2023-07-19');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (78085, 71085921, 42, '2022-06-27', '2023-04-11');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (49364, 90112395, 30, '2022-06-17', '2023-10-01');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (26232, 21879745, 39, '2022-07-07', '2023-07-30');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (67032, 46334925, 49, '2022-09-24', '2023-07-25');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (43416, 53103777, 37, '2022-01-07', '2023-08-07');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (52262, 94022635, 28, '2022-06-06', '2022-12-05');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (76246, 90809602, 47, '2022-05-17', '2023-10-31');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (73180, 39313758, 35, '2021-12-03', '2022-12-14');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (12425, 40475062, 29, '2022-07-19', '2023-08-16');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (13325, 90112395, 34, '2022-07-04', '2023-08-20');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (65172, 53103777, 43, '2022-08-14', '2023-06-19');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (89304, 71085921, 50, '2022-09-23', '2022-12-17');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (55233, 49093250, 28, '2022-09-15', '2023-09-02');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (27339, 12302565, 40, '2021-12-17', '2023-07-17');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (20242, 21879745, 32, '2022-08-14', '2023-05-09');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (60958, 12302565, 44, '2022-04-28', '2023-07-01');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (33115, 78338525, 25, '2022-11-21', '2023-03-09');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (84662, 88458076, 50, '2022-02-01', '2023-11-01');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (28173, 94022635, 22, '2022-09-14', '2023-04-10');

-- advertisements
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (5373, 29569692, 200198, '7 Loomis Road', 91.13);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (4084, 71085921, 444840, '5 Brentwood Crossing', 94.36);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (1336, 53103777, 389567, '67269 Hoard Point', 60.91);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (2606, 21879745, 357132, '697 Emmet Plaza', 55.94);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (2931, 22480259, 895610, '2 Bunker Hill Center', 30.7);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (5680, 21879745, 444840, '177 Fair Oaks Lane', 31.19);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (8154, 38416212, 444853, '775 Maple Junction', 81.63);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (4890, 78338525, 393518, '54753 Randy Parkway', 79.06);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (3355, 22480259, 465722, '65 Valley Edge Park', 69.25);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (4852, 90112395, 789343, '25 Thompson Park', 52.15);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (7224, 12302565, 782687, '5276 Golden Leaf Circle', 54.97);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (1397, 46334925, 865237, '06 Arrowood Park', 28.09);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (1038, 88458076, 782687, '483 Gulseth Lane', 74.87);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (2122, 75469899, 465722, '56 Mariners Cove Pass', 76.33);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (2018, 21879745, 782687, '4732 Evergreen Park', 96.44);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (9305, 72076152, 976810, '8 Emmet Hill', 81.64);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (7121, 61752835, 444840, '659 Katie Way', 95.41);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (2715, 90112395, 732764, '80 Crownhardt Trail', 61.06);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (3794, 72302293, 937581, '93743 Larry Plaza', 69.86);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (2115, 90809602, 814966, '18 Talmadge Hill', 88.56);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (9146, 71085921, 444866, '287 Di Loreto Road', 42.55);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (8112, 71085921, 393518, '5 Birchwood Drive', 66.43);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (2137, 61752835, 465722, '0 Nova Park', 29.96);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (4676, 61752835, 412383, '60754 Cherokee Alley', 95.89);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (4655, 19395793, 200198, '554 Northfield Park', 51.18);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (4818, 90112395, 384707, '6832 Pawling Court', 31.67);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (4028, 29569692, 572611, '42 Talmadge Trail', 48.34);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (7006, 36577199, 684368, '64677 Columbus Crossing', 83.2);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (6761, 88458076, 209084, '245 Karstens Park', 82.87);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (2865, 90809602, 895610, '77781 Prentice Alley', 83.38);

-- invoices
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (545742985, 407977, 97700, 89, '28 5th Road', '2022-05-27');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (806832105, 407977, 26239, 45, '821 Cordelia Center', '2022-06-01');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (702393961, 343104, 27226, 41, '4 Del Mar Plaza', '2022-05-15');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (911933353, 741709, 89219, 97, '1904 Rutledge Circle', '2022-01-02');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (526410316, 459141, 69748, 34, '66262 Garrison Place', '2021-12-10');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (722420475, 335616, 69748, 63, '6 Donald Terrace', '2022-01-19');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (710294142, 133084, 84328, 45, '6 Brickson Park Trail', '2022-04-02');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (143696470, 718861, 69748, 98, '6619 Canary Plaza', '2021-12-18');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (748213325, 783124, 42401, 56, '448 Bartelt Crossing', '2022-04-29');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (931238345, 343104, 90025, 89, '68450 Grayhawk Drive', '2022-07-10');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (335974277, 100374, 53321, 81, '18602 Basil Trail', '2022-01-07');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (270776475, 432141, 75970, 22, '0 Magdeline Drive', '2022-07-09');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (559163884, 601271, 67266, 22, '242 Sunnyside Way', '2022-02-22');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (976913027, 769981, 69748, 97, '958 Everett Court', '2022-03-03');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (597005766, 709298, 91818, 34, '967 Loftsgordon Hill', '2022-08-18');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (293318218, 528003, 36534, 81, '7042 Sycamore Hill', '2022-05-24');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (717126547, 718861, 87569, 92, '755 Fremont Center', '2022-11-21');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (782995222, 591008, 27226, 40, '45923 Elmside Junction', '2022-03-13');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (598862587, 343104, 91818, 89, '7949 6th Crossing', '2021-12-01');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (734441723, 156962, 87569, 97, '25556 Merchant Place', '2022-05-21');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (132699034, 407977, 36534, 45, '0986 Browning Lane', '2022-10-15');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (860186782, 848252, 69748, 81, '2 Petterle Drive', '2022-02-06');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (119051133, 377763, 42401, 45, '17147 Pennsylvania Lane', '2022-06-05');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (727488818, 156962, 73022, 11, '83 Schlimgen Junction', '2022-07-10');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (103492292, 591008, 91818, 77, '78 Shelley Street', '2021-12-31');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (600862907, 794617, 55410, 81, '39508 Luster Way', '2022-08-09');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (648546251, 527983, 20382, 22, '74 Claremont Point', '2022-01-07');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (952486490, 407977, 99728, 22, '40 Butternut Terrace', '2021-12-07');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (996012935, 591008, 87569, 63, '6 Hoffman Hill', '2022-03-30');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (381793182, 432141, 26239, 15, '2 Tony Street', '2022-08-13');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (652410031, 601271, 69748, 95, '790 Pennsylvania Court', '2022-05-01');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (720373815, 448916, 24282, 97, '66 Stephen Place', '2022-10-28');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (692728272, 875793, 53321, 45, '1563 Ridgeview Crossing', '2022-05-01');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (928846278, 591008, 36183, 45, '3294 Twin Pines Lane', '2021-12-02');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (921385411, 709298, 10866, 10, '67 Lindbergh Point', '2022-04-04');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (644724728, 432141, 20634, 11, '6 Caliangt Point', '2022-06-02');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (943091983, 173540, 55410, 71, '14 Trailsway Hill', '2022-02-05');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (725755216, 794617, 90679, 15, '7377 Raven Avenue', '2022-07-13');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (279558496, 133084, 87569, 10, '434 Dapin Circle', '2022-09-27');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (720445452, 354762, 11055, 72, '86 Prairie Rose Court', '2022-05-04');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (382041711, 591008, 90679, 45, '0017 Fordem Center', '2022-11-03');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (492904963, 528003, 27226, 50, '1 Clarendon Road', '2022-08-01');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (913927527, 407977, 84328, 45, '9 Fair Oaks Crossing', '2021-12-21');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (808874353, 377763, 22528, 40, '2 Stoughton Avenue', '2022-10-30');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (815809655, 397857, 53321, 25, '8709 Sheridan Junction', '2022-03-31');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (505577051, 587532, 69748, 23, '4080 Buhler Place', '2022-05-15');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (399145888, 528003, 27226, 10, '77025 Rieder Circle', '2022-10-04');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (418782208, 397857, 48105, 21, '11 International Center', '2022-10-27');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (938408607, 587532, 53321, 11, '12999 Moose Parkway', '2022-04-08');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (535815293, 527983, 10866, 81, '2 Reinke Trail', '2022-03-05');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (902178589, 718861, 62620, 34, '87313 Westridge Road', '2022-08-02');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (596927713, 709298, 89219, 95, '10355 Delaware Way', '2022-09-21');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (325203296, 527983, 67690, 40, '8978 Charing Cross Trail', '2022-05-23');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (300829602, 587532, 69748, 15, '0 Mcbride Court', '2022-09-19');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (776209779, 601271, 48105, 98, '001 Dayton Terrace', '2022-04-09');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (763532248, 354762, 67690, 89, '259 Hintze Crossing', '2022-10-07');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (455732945, 591008, 53321, 56, '89 Shasta Center', '2022-02-03');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (500262362, 366519, 90025, 89, '7352 Forest Street', '2022-07-25');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (638800757, 794617, 55410, 37, '78301 Declaration Drive', '2022-01-05');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (349636249, 756531, 90965, 81, '576 Starling Crossing', '2022-11-02');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (135535148, 459141, 55410, 25, '2 Milwaukee Lane', '2022-07-17');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (990251276, 100374, 69748, 98, '0329 Drewry Court', '2022-01-03');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (934637673, 527983, 42401, 77, '29784 Mayfield Street', '2022-06-08');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (320349635, 783124, 27226, 50, '9534 Scoville Alley', '2022-11-05');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (152248292, 377763, 90679, 34, '417 Northland Road', '2022-02-26');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (875405294, 354762, 24282, 50, '87826 Sutteridge Point', '2022-05-13');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (156191429, 527983, 36534, 34, '52 Schlimgen Place', '2022-03-24');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (976551412, 848252, 22528, 98, '3635 Vera Alley', '2021-12-05');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (704590917, 741709, 99728, 27, '71698 Manley Street', '2022-07-16');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (562773355, 335616, 90025, 67, '49 Sutteridge Terrace', '2022-04-07');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (454010052, 527983, 62620, 95, '0 Comanche Road', '2022-09-29');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (620841273, 527983, 55410, 97, '0034 Clove Lane', '2022-09-13');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (525060855, 459141, 67690, 11, '81293 Crest Line Alley', '2022-09-05');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (318719518, 601271, 55410, 98, '7 Spaight Parkway', '2022-03-10');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (635203160, 366519, 75970, 22, '5 Sunbrook Way', '2022-03-13');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (770994424, 366519, 36534, 10, '6 Heffernan Avenue', '2022-06-08');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (340408905, 769981, 24282, 37, '6933 Main Park', '2022-10-17');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (117815505, 875793, 90965, 45, '13 Scoville Park', '2022-08-02');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (884440828, 100374, 10866, 87, '302 Colorado Avenue', '2022-10-04');
INSERT INTO invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) VALUES (331184662, 718861, 75970, 22, '50 Shoshone Hill', '2022-10-13');

-- candies_categories
insert into candies_categories (candy_id, category_id) values (36577199, 7109473);
insert into candies_categories (candy_id, category_id) values (21879745, 7109473);
insert into candies_categories (candy_id, category_id) values (22480259, 6695810);
insert into candies_categories (candy_id, category_id) values (94022635, 6655748);
insert into candies_categories (candy_id, category_id) values (12302565, 3435943);
insert into candies_categories (candy_id, category_id) values (71085921, 5754426);
insert into candies_categories (candy_id, category_id) values (21879745, 9557056);
insert into candies_categories (candy_id, category_id) values (70685586, 2311196);
insert into candies_categories (candy_id, category_id) values (29569692, 2852764);
insert into candies_categories (candy_id, category_id) values (25586201, 3492998);
insert into candies_categories (candy_id, category_id) values (61752835, 5839939);
insert into candies_categories (candy_id, category_id) values (22480259, 4783237);
insert into candies_categories (candy_id, category_id) values (36577199, 6751706);
insert into candies_categories (candy_id, category_id) values (75469899, 7217658);
insert into candies_categories (candy_id, category_id) values (49093250, 8576905);
insert into candies_categories (candy_id, category_id) values (49093250, 9615887);
insert into candies_categories (candy_id, category_id) values (52255752, 6961131);
insert into candies_categories (candy_id, category_id) values (46334925, 3275785);
insert into candies_categories (candy_id, category_id) values (90112395, 9650576);
insert into candies_categories (candy_id, category_id) values (72076152, 9866792);
insert into candies_categories (candy_id, category_id) values (12302565, 4312709);
insert into candies_categories (candy_id, category_id) values (75469899, 8027776);
insert into candies_categories (candy_id, category_id) values (70685586, 8997144);
insert into candies_categories (candy_id, category_id) values (60596910, 6580906);
insert into candies_categories (candy_id, category_id) values (53103777, 4516665);
insert into candies_categories (candy_id, category_id) values (70685586, 7758372);
insert into candies_categories (candy_id, category_id) values (45525516, 9373749);
insert into candies_categories (candy_id, category_id) values (72302293, 1267141);
insert into candies_categories (candy_id, category_id) values (22480259, 4756185);
insert into candies_categories (candy_id, category_id) values (38416212, 7914790);
insert into candies_categories (candy_id, category_id) values (61752835, 3232686);
insert into candies_categories (candy_id, category_id) values (69632483, 7109473);
insert into candies_categories (candy_id, category_id) values (71085921, 6695810);
insert into candies_categories (candy_id, category_id) values (46334925, 6655748);
insert into candies_categories (candy_id, category_id) values (40475062, 3435943);
insert into candies_categories (candy_id, category_id) values (53103777, 5754426);
insert into candies_categories (candy_id, category_id) values (81188160, 9557056);
insert into candies_categories (candy_id, category_id) values (90809602, 2311196);
insert into candies_categories (candy_id, category_id) values (61752835, 2852764);
insert into candies_categories (candy_id, category_id) values (90809602, 3492998);
insert into candies_categories (candy_id, category_id) values (53103777, 5839939);
insert into candies_categories (candy_id, category_id) values (38416212, 4783237);
insert into candies_categories (candy_id, category_id) values (69632483, 6751706);
insert into candies_categories (candy_id, category_id) values (43486512, 7217658);
insert into candies_categories (candy_id, category_id) values (43486512, 8576905);
insert into candies_categories (candy_id, category_id) values (90809602, 9615887);
insert into candies_categories (candy_id, category_id) values (69632483, 6961131);
insert into candies_categories (candy_id, category_id) values (94022635, 3275785);
insert into candies_categories (candy_id, category_id) values (36577199, 9650576);
insert into candies_categories (candy_id, category_id) values (72076152, 9650576);
insert into candies_categories (candy_id, category_id) values (69632483, 4312709);
insert into candies_categories (candy_id, category_id) values (75469899, 8997144);
insert into candies_categories (candy_id, category_id) values (52255752, 8997144);
insert into candies_categories (candy_id, category_id) values (21879745, 6580906);
insert into candies_categories (candy_id, category_id) values (39313758, 4516665);
insert into candies_categories (candy_id, category_id) values (29569692, 7758372);
insert into candies_categories (candy_id, category_id) values (53103777, 9373749);
insert into candies_categories (candy_id, category_id) values (19395793, 1267141);
insert into candies_categories (candy_id, category_id) values (21879745, 4756185);
insert into candies_categories (candy_id, category_id) values (90809602, 7914790);
insert into candies_categories (candy_id, category_id) values (78338525, 3232686);
insert into candies_categories (candy_id, category_id) values (53103777, 7109473);
insert into candies_categories (candy_id, category_id) values (53103777, 6695810);
insert into candies_categories (candy_id, category_id) values (39313758, 1267141);
insert into candies_categories (candy_id, category_id) values (72076152, 3435943);
insert into candies_categories (candy_id, category_id) values (22480259, 5754426);
insert into candies_categories (candy_id, category_id) values (38416212, 9557056);
insert into candies_categories (candy_id, category_id) values (49093250, 5839939);
insert into candies_categories (candy_id, category_id) values (78338525, 2852764);
insert into candies_categories (candy_id, category_id) values (49093250, 3492998);
insert into candies_categories (candy_id, category_id) values (45525516, 5839939);
insert into candies_categories (candy_id, category_id) values (70685586, 4783237);
insert into candies_categories (candy_id, category_id) values (94022635, 6751706);
insert into candies_categories (candy_id, category_id) values (72302293, 7217658);
insert into candies_categories (candy_id, category_id) values (61752835, 8576905);
insert into candies_categories (candy_id, category_id) values (38416212, 9615887);
insert into candies_categories (candy_id, category_id) values (90112395, 6961131);
insert into candies_categories (candy_id, category_id) values (90809602, 3275785);
insert into candies_categories (candy_id, category_id) values (43486512, 9650576);
insert into candies_categories (candy_id, category_id) values (71085921, 9866792);
insert into candies_categories (candy_id, category_id) values (46334925, 7758372);
insert into candies_categories (candy_id, category_id) values (61752835, 8027776);
insert into candies_categories (candy_id, category_id) values (19395793, 8997144);
insert into candies_categories (candy_id, category_id) values (88458076, 6580906);
insert into candies_categories (candy_id, category_id) values (61752835, 4516665);
insert into candies_categories (candy_id, category_id) values (53103777, 7758372);
insert into candies_categories (candy_id, category_id) values (90809602, 9373749);
insert into candies_categories (candy_id, category_id) values (45525516, 7109473);
insert into candies_categories (candy_id, category_id) values (25586201, 4756185);
insert into candies_categories (candy_id, category_id) values (40475062, 7914790);
insert into candies_categories (candy_id, category_id) values (70685586, 3232686);
insert into candies_categories (candy_id, category_id) values (70685586, 7109473);
insert into candies_categories (candy_id, category_id) values (22480259, 7109473);
insert into candies_categories (candy_id, category_id) values (88458076, 6655748);
insert into candies_categories (candy_id, category_id) values (38416212, 3435943);
insert into candies_categories (candy_id, category_id) values (75469899, 5754426);
insert into candies_categories (candy_id, category_id) values (52255752, 9557056);
insert into candies_categories (candy_id, category_id) values (52255752, 2311196);
insert into candies_categories (candy_id, category_id) values (52255752, 2852764);
insert into candies_categories (candy_id, category_id) values (39313758, 3492998);
insert into candies_categories (candy_id, category_id) values (12302565, 5839939);
insert into candies_categories (candy_id, category_id) values (88458076, 4783237);
insert into candies_categories (candy_id, category_id) values (88458076, 2311196);
insert into candies_categories (candy_id, category_id) values (60596910, 8576905);
insert into candies_categories (candy_id, category_id) values (60596910, 9615887);
insert into candies_categories (candy_id, category_id) values (19395793, 9615887);
insert into candies_categories (candy_id, category_id) values (69632483, 3275785);
insert into candies_categories (candy_id, category_id) values (19395793, 3275785);
insert into candies_categories (candy_id, category_id) values (78338525, 9650576);
insert into candies_categories (candy_id, category_id) values (70685586, 9866792);
insert into candies_categories (candy_id, category_id) values (45525516, 4312709);
insert into candies_categories (candy_id, category_id) values (36577199, 8027776);
insert into candies_categories (candy_id, category_id) values (52255752, 6580906);
insert into candies_categories (candy_id, category_id) values (60596910, 4516665);
insert into candies_categories (candy_id, category_id) values (49093250, 4516665);
insert into candies_categories (candy_id, category_id) values (40475062, 7758372);
insert into candies_categories (candy_id, category_id) values (60596910, 9373749);
insert into candies_categories (candy_id, category_id) values (72076152, 1267141);
insert into candies_categories (candy_id, category_id) values (72076152, 4756185);
insert into candies_categories (candy_id, category_id) values (19395793, 7914790);
insert into candies_categories (candy_id, category_id) values (39313758, 3232686);
insert into candies_categories (candy_id, category_id) values (90809602, 7109473);
insert into candies_categories (candy_id, category_id) values (72302293, 6695810);
insert into candies_categories (candy_id, category_id) values (60596910, 6655748);
insert into candies_categories (candy_id, category_id) values (70685586, 3435943);
insert into candies_categories (candy_id, category_id) values (61752835, 5754426);
insert into candies_categories (candy_id, category_id) values (72302293, 9557056);
insert into candies_categories (candy_id, category_id) values (19395793, 2311196);
insert into candies_categories (candy_id, category_id) values (49093250, 2852764);
insert into candies_categories (candy_id, category_id) values (70685586, 3492998);
insert into candies_categories (candy_id, category_id) values (52255752, 5839939);
insert into candies_categories (candy_id, category_id) values (52255752, 4783237);
insert into candies_categories (candy_id, category_id) values (52255752, 6751706);
insert into candies_categories (candy_id, category_id) values (70685586, 7217658);
insert into candies_categories (candy_id, category_id) values (22480259, 8576905);
insert into candies_categories (candy_id, category_id) values (46334925, 9615887);
insert into candies_categories (candy_id, category_id) values (43486512, 6961131);
insert into candies_categories (candy_id, category_id) values (22480259, 3275785);
insert into candies_categories (candy_id, category_id) values (39313758, 9650576);
insert into candies_categories (candy_id, category_id) values (36577199, 9866792);
insert into candies_categories (candy_id, category_id) values (70685586, 4312709);
insert into candies_categories (candy_id, category_id) values (40475062, 8027776);
insert into candies_categories (candy_id, category_id) values (53103777, 8997144);
insert into candies_categories (candy_id, category_id) values (94022635, 6580906);
insert into candies_categories (candy_id, category_id) values (40475062, 4516665);
insert into candies_categories (candy_id, category_id) values (72302293, 7758372);
insert into candies_categories (candy_id, category_id) values (72302293, 9373749);
insert into candies_categories (candy_id, category_id) values (21879745, 1267141);
insert into candies_categories (candy_id, category_id) values (69632483, 4756185);
insert into candies_categories (candy_id, category_id) values (75469899, 7914790);

-- candies_ingredients
insert into candies_ingredients (candy_id, ingredient_id) values (21879745, 113);
insert into candies_ingredients (candy_id, ingredient_id) values (78338525, 235);
insert into candies_ingredients (candy_id, ingredient_id) values (43486512, 751);
insert into candies_ingredients (candy_id, ingredient_id) values (38416212, 689);
insert into candies_ingredients (candy_id, ingredient_id) values (71085921, 891);
insert into candies_ingredients (candy_id, ingredient_id) values (36577199, 689);
insert into candies_ingredients (candy_id, ingredient_id) values (69632483, 689);
insert into candies_ingredients (candy_id, ingredient_id) values (45525516, 812);
insert into candies_ingredients (candy_id, ingredient_id) values (94022635, 891);
insert into candies_ingredients (candy_id, ingredient_id) values (71085921, 619);
insert into candies_ingredients (candy_id, ingredient_id) values (49093250, 670);
insert into candies_ingredients (candy_id, ingredient_id) values (60596910, 265);
insert into candies_ingredients (candy_id, ingredient_id) values (78338525, 689);
insert into candies_ingredients (candy_id, ingredient_id) values (90112395, 704);
insert into candies_ingredients (candy_id, ingredient_id) values (90112395, 687);
insert into candies_ingredients (candy_id, ingredient_id) values (38416212, 536);
insert into candies_ingredients (candy_id, ingredient_id) values (25586201, 619);
insert into candies_ingredients (candy_id, ingredient_id) values (52255752, 891);
insert into candies_ingredients (candy_id, ingredient_id) values (21879745, 997);
insert into candies_ingredients (candy_id, ingredient_id) values (69632483, 109);
insert into candies_ingredients (candy_id, ingredient_id) values (21879745, 265);
insert into candies_ingredients (candy_id, ingredient_id) values (12302565, 751);
insert into candies_ingredients (candy_id, ingredient_id) values (78338525, 441);
insert into candies_ingredients (candy_id, ingredient_id) values (49093250, 132);
insert into candies_ingredients (candy_id, ingredient_id) values (46334925, 751);
insert into candies_ingredients (candy_id, ingredient_id) values (78338525, 381);
insert into candies_ingredients (candy_id, ingredient_id) values (78338525, 895);
insert into candies_ingredients (candy_id, ingredient_id) values (45525516, 235);
insert into candies_ingredients (candy_id, ingredient_id) values (78338525, 265);
insert into candies_ingredients (candy_id, ingredient_id) values (19395793, 109);
insert into candies_ingredients (candy_id, ingredient_id) values (22480259, 935);
insert into candies_ingredients (candy_id, ingredient_id) values (19395793, 891);
insert into candies_ingredients (candy_id, ingredient_id) values (45525516, 378);
insert into candies_ingredients (candy_id, ingredient_id) values (19395793, 378);
insert into candies_ingredients (candy_id, ingredient_id) values (88458076, 812);
insert into candies_ingredients (candy_id, ingredient_id) values (81188160, 704);
insert into candies_ingredients (candy_id, ingredient_id) values (90112395, 113);
insert into candies_ingredients (candy_id, ingredient_id) values (90112395, 744);
insert into candies_ingredients (candy_id, ingredient_id) values (40475062, 812);
insert into candies_ingredients (candy_id, ingredient_id) values (70685586, 480);
insert into candies_ingredients (candy_id, ingredient_id) values (39313758, 744);
insert into candies_ingredients (candy_id, ingredient_id) values (78338525, 117);
insert into candies_ingredients (candy_id, ingredient_id) values (72076152, 288);
insert into candies_ingredients (candy_id, ingredient_id) values (36577199, 288);
insert into candies_ingredients (candy_id, ingredient_id) values (75469899, 935);
insert into candies_ingredients (candy_id, ingredient_id) values (71085921, 378);
insert into candies_ingredients (candy_id, ingredient_id) values (39313758, 381);
insert into candies_ingredients (candy_id, ingredient_id) values (60596910, 935);
insert into candies_ingredients (candy_id, ingredient_id) values (90809602, 117);
insert into candies_ingredients (candy_id, ingredient_id) values (90809602, 132);
insert into candies_ingredients (candy_id, ingredient_id) values (69632483, 704);
insert into candies_ingredients (candy_id, ingredient_id) values (69632483, 490);
insert into candies_ingredients (candy_id, ingredient_id) values (75469899, 895);
insert into candies_ingredients (candy_id, ingredient_id) values (12302565, 744);
insert into candies_ingredients (candy_id, ingredient_id) values (88458076, 109);
insert into candies_ingredients (candy_id, ingredient_id) values (40475062, 109);
insert into candies_ingredients (candy_id, ingredient_id) values (36577199, 117);
insert into candies_ingredients (candy_id, ingredient_id) values (21879745, 935);
insert into candies_ingredients (candy_id, ingredient_id) values (21879745, 490);
insert into candies_ingredients (candy_id, ingredient_id) values (75469899, 113);
insert into candies_ingredients (candy_id, ingredient_id) values (19395793, 594);
insert into candies_ingredients (candy_id, ingredient_id) values (46334925, 895);
insert into candies_ingredients (candy_id, ingredient_id) values (88458076, 594);
insert into candies_ingredients (candy_id, ingredient_id) values (39313758, 619);
insert into candies_ingredients (candy_id, ingredient_id) values (90112395, 317);
insert into candies_ingredients (candy_id, ingredient_id) values (69632483, 381);
insert into candies_ingredients (candy_id, ingredient_id) values (36577199, 381);
insert into candies_ingredients (candy_id, ingredient_id) values (38416212, 744);
insert into candies_ingredients (candy_id, ingredient_id) values (12302565, 536);
insert into candies_ingredients (candy_id, ingredient_id) values (90112395, 117);
insert into candies_ingredients (candy_id, ingredient_id) values (43486512, 704);
insert into candies_ingredients (candy_id, ingredient_id) values (29569692, 769);
insert into candies_ingredients (candy_id, ingredient_id) values (25586201, 728);
insert into candies_ingredients (candy_id, ingredient_id) values (25586201, 265);
insert into candies_ingredients (candy_id, ingredient_id) values (90809602, 891);
insert into candies_ingredients (candy_id, ingredient_id) values (81188160, 687);
insert into candies_ingredients (candy_id, ingredient_id) values (69632483, 441);
insert into candies_ingredients (candy_id, ingredient_id) values (78338525, 288);
insert into candies_ingredients (candy_id, ingredient_id) values (40475062, 117);
insert into candies_ingredients (candy_id, ingredient_id) values (12302565, 728);
insert into candies_ingredients (candy_id, ingredient_id) values (43486512, 594);
insert into candies_ingredients (candy_id, ingredient_id) values (94022635, 117);
insert into candies_ingredients (candy_id, ingredient_id) values (45525516, 997);
insert into candies_ingredients (candy_id, ingredient_id) values (40475062, 113);
insert into candies_ingredients (candy_id, ingredient_id) values (90112395, 895);
insert into candies_ingredients (candy_id, ingredient_id) values (29569692, 728);
insert into candies_ingredients (candy_id, ingredient_id) values (43486512, 317);
insert into candies_ingredients (candy_id, ingredient_id) values (90112395, 728);
insert into candies_ingredients (candy_id, ingredient_id) values (88458076, 490);
insert into candies_ingredients (candy_id, ingredient_id) values (36577199, 536);
insert into candies_ingredients (candy_id, ingredient_id) values (88458076, 381);
insert into candies_ingredients (candy_id, ingredient_id) values (94022635, 769);
insert into candies_ingredients (candy_id, ingredient_id) values (90809602, 381);
insert into candies_ingredients (candy_id, ingredient_id) values (19395793, 728);
insert into candies_ingredients (candy_id, ingredient_id) values (94022635, 728);
insert into candies_ingredients (candy_id, ingredient_id) values (81188160, 728);
insert into candies_ingredients (candy_id, ingredient_id) values (90809602, 689);
insert into candies_ingredients (candy_id, ingredient_id) values (81188160, 689);
insert into candies_ingredients (candy_id, ingredient_id) values (90809602, 619);
insert into candies_ingredients (candy_id, ingredient_id) values (52255752, 689);
insert into candies_ingredients (candy_id, ingredient_id) values (43486512, 480);
insert into candies_ingredients (candy_id, ingredient_id) values (61752835, 704);
insert into candies_ingredients (candy_id, ingredient_id) values (71085921, 381);
insert into candies_ingredients (candy_id, ingredient_id) values (39313758, 997);
insert into candies_ingredients (candy_id, ingredient_id) values (72302293, 619);
insert into candies_ingredients (candy_id, ingredient_id) values (40475062, 670);
insert into candies_ingredients (candy_id, ingredient_id) values (70685586, 812);
insert into candies_ingredients (candy_id, ingredient_id) values (25586201, 441);
insert into candies_ingredients (candy_id, ingredient_id) values (75469899, 441);
insert into candies_ingredients (candy_id, ingredient_id) values (38416212, 217);
insert into candies_ingredients (candy_id, ingredient_id) values (25586201, 132);
insert into candies_ingredients (candy_id, ingredient_id) values (45525516, 441);
insert into candies_ingredients (candy_id, ingredient_id) values (53103777, 288);
insert into candies_ingredients (candy_id, ingredient_id) values (29569692, 891);
insert into candies_ingredients (candy_id, ingredient_id) values (12302565, 109);
insert into candies_ingredients (candy_id, ingredient_id) values (75469899, 689);
insert into candies_ingredients (candy_id, ingredient_id) values (75469899, 594);
insert into candies_ingredients (candy_id, ingredient_id) values (25586201, 594);
insert into candies_ingredients (candy_id, ingredient_id) values (90809602, 288);
insert into candies_ingredients (candy_id, ingredient_id) values (70685586, 132);
insert into candies_ingredients (candy_id, ingredient_id) values (90809602, 744);
insert into candies_ingredients (candy_id, ingredient_id) values (25586201, 704);
insert into candies_ingredients (candy_id, ingredient_id) values (46334925, 935);
insert into candies_ingredients (candy_id, ingredient_id) values (52255752, 317);
insert into candies_ingredients (candy_id, ingredient_id) values (72076152, 536);
insert into candies_ingredients (candy_id, ingredient_id) values (49093250, 812);
insert into candies_ingredients (candy_id, ingredient_id) values (70685586, 317);
insert into candies_ingredients (candy_id, ingredient_id) values (39313758, 689);
insert into candies_ingredients (candy_id, ingredient_id) values (25586201, 117);
insert into candies_ingredients (candy_id, ingredient_id) values (75469899, 117);
insert into candies_ingredients (candy_id, ingredient_id) values (72302293, 217);
insert into candies_ingredients (candy_id, ingredient_id) values (29569692, 704);
insert into candies_ingredients (candy_id, ingredient_id) values (52255752, 744);
insert into candies_ingredients (candy_id, ingredient_id) values (12302565, 381);
insert into candies_ingredients (candy_id, ingredient_id) values (40475062, 997);
insert into candies_ingredients (candy_id, ingredient_id) values (72302293, 891);
insert into candies_ingredients (candy_id, ingredient_id) values (75469899, 751);
insert into candies_ingredients (candy_id, ingredient_id) values (45525516, 751);
insert into candies_ingredients (candy_id, ingredient_id) values (90112395, 769);
insert into candies_ingredients (candy_id, ingredient_id) values (71085921, 769);
insert into candies_ingredients (candy_id, ingredient_id) values (53103777, 704);
insert into candies_ingredients (candy_id, ingredient_id) values (71085921, 132);
insert into candies_ingredients (candy_id, ingredient_id) values (40475062, 265);
insert into candies_ingredients (candy_id, ingredient_id) values (19395793, 235);
insert into candies_ingredients (candy_id, ingredient_id) values (19395793, 704);
insert into candies_ingredients (candy_id, ingredient_id) values (25586201, 235);
insert into candies_ingredients (candy_id, ingredient_id) values (94022635, 217);
insert into candies_ingredients (candy_id, ingredient_id) values (94022635, 536);
insert into candies_ingredients (candy_id, ingredient_id) values (72302293, 769);
insert into candies_ingredients (candy_id, ingredient_id) values (72302293, 480);

-- invoice_line
insert into invoice_line (candy_id, invoice_id, qty) values (38416212, 382041711, 11);
insert into invoice_line (candy_id, invoice_id, qty) values (78338525, 702393961, 61);
insert into invoice_line (candy_id, invoice_id, qty) values (40475062, 335974277, 9);
insert into invoice_line (candy_id, invoice_id, qty) values (19395793, 132699034, 91);
insert into invoice_line (candy_id, invoice_id, qty) values (38416212, 454010052, 21);
insert into invoice_line (candy_id, invoice_id, qty) values (49093250, 720373815, 4);
insert into invoice_line (candy_id, invoice_id, qty) values (94022635, 135535148, 55);
insert into invoice_line (candy_id, invoice_id, qty) values (19395793, 335974277, 39);
insert into invoice_line (candy_id, invoice_id, qty) values (45525516, 648546251, 20);
insert into invoice_line (candy_id, invoice_id, qty) values (78338525, 598862587, 32);
insert into invoice_line (candy_id, invoice_id, qty) values (81188160, 702393961, 41);
insert into invoice_line (candy_id, invoice_id, qty) values (39313758, 382041711, 14);
insert into invoice_line (candy_id, invoice_id, qty) values (38416212, 928846278, 59);
insert into invoice_line (candy_id, invoice_id, qty) values (49093250, 943091983, 67);
insert into invoice_line (candy_id, invoice_id, qty) values (19395793, 381793182, 85);
insert into invoice_line (candy_id, invoice_id, qty) values (45525516, 132699034, 96);
insert into invoice_line (candy_id, invoice_id, qty) values (90809602, 921385411, 29);
insert into invoice_line (candy_id, invoice_id, qty) values (69632483, 717126547, 29);
insert into invoice_line (candy_id, invoice_id, qty) values (52255752, 597005766, 68);
insert into invoice_line (candy_id, invoice_id, qty) values (90112395, 525060855, 40);
insert into invoice_line (candy_id, invoice_id, qty) values (94022635, 505577051, 58);
insert into invoice_line (candy_id, invoice_id, qty) values (52255752, 913927527, 76);
insert into invoice_line (candy_id, invoice_id, qty) values (78338525, 156191429, 79);
insert into invoice_line (candy_id, invoice_id, qty) values (40475062, 943091983, 33);
insert into invoice_line (candy_id, invoice_id, qty) values (22480259, 710294142, 91);
insert into invoice_line (candy_id, invoice_id, qty) values (94022635, 990251276, 38);
insert into invoice_line (candy_id, invoice_id, qty) values (25586201, 117815505, 35);
insert into invoice_line (candy_id, invoice_id, qty) values (72302293, 635203160, 8);
insert into invoice_line (candy_id, invoice_id, qty) values (38416212, 806832105, 13);
insert into invoice_line (candy_id, invoice_id, qty) values (19395793, 911933353, 31);
insert into invoice_line (candy_id, invoice_id, qty) values (53103777, 952486490, 50);
insert into invoice_line (candy_id, invoice_id, qty) values (69632483, 652410031, 49);
insert into invoice_line (candy_id, invoice_id, qty) values (90112395, 598862587, 69);
insert into invoice_line (candy_id, invoice_id, qty) values (40475062, 279558496, 65);
insert into invoice_line (candy_id, invoice_id, qty) values (25586201, 600862907, 35);
insert into invoice_line (candy_id, invoice_id, qty) values (36577199, 545742985, 29);
insert into invoice_line (candy_id, invoice_id, qty) values (49093250, 418782208, 76);
insert into invoice_line (candy_id, invoice_id, qty) values (71085921, 598862587, 37);
insert into invoice_line (candy_id, invoice_id, qty) values (71085921, 340408905, 52);
insert into invoice_line (candy_id, invoice_id, qty) values (88458076, 644724728, 56);
insert into invoice_line (candy_id, invoice_id, qty) values (81188160, 600862907, 84);
insert into invoice_line (candy_id, invoice_id, qty) values (22480259, 782995222, 90);
insert into invoice_line (candy_id, invoice_id, qty) values (61752835, 976551412, 95);
insert into invoice_line (candy_id, invoice_id, qty) values (70685586, 525060855, 2);
insert into invoice_line (candy_id, invoice_id, qty) values (12302565, 702393961, 35);
insert into invoice_line (candy_id, invoice_id, qty) values (72076152, 720373815, 39);
insert into invoice_line (candy_id, invoice_id, qty) values (52255752, 644724728, 57);
insert into invoice_line (candy_id, invoice_id, qty) values (94022635, 702393961, 93);
insert into invoice_line (candy_id, invoice_id, qty) values (43486512, 152248292, 55);
insert into invoice_line (candy_id, invoice_id, qty) values (78338525, 717126547, 99);
insert into invoice_line (candy_id, invoice_id, qty) values (72076152, 638800757, 7);
insert into invoice_line (candy_id, invoice_id, qty) values (81188160, 152248292, 93);
insert into invoice_line (candy_id, invoice_id, qty) values (22480259, 318719518, 10);
insert into invoice_line (candy_id, invoice_id, qty) values (61752835, 293318218, 23);
insert into invoice_line (candy_id, invoice_id, qty) values (81188160, 931238345, 56);
insert into invoice_line (candy_id, invoice_id, qty) values (36577199, 596927713, 60);
insert into invoice_line (candy_id, invoice_id, qty) values (19395793, 320349635, 45);
insert into invoice_line (candy_id, invoice_id, qty) values (61752835, 152248292, 49);
insert into invoice_line (candy_id, invoice_id, qty) values (90809602, 132699034, 89);
insert into invoice_line (candy_id, invoice_id, qty) values (45525516, 620841273, 99);
insert into invoice_line (candy_id, invoice_id, qty) values (21879745, 620841273, 49);
insert into invoice_line (candy_id, invoice_id, qty) values (70685586, 928846278, 63);
insert into invoice_line (candy_id, invoice_id, qty) values (46334925, 279558496, 16);
insert into invoice_line (candy_id, invoice_id, qty) values (43486512, 990251276, 6);
insert into invoice_line (candy_id, invoice_id, qty) values (19395793, 770994424, 2);
insert into invoice_line (candy_id, invoice_id, qty) values (21879745, 596927713, 33);
insert into invoice_line (candy_id, invoice_id, qty) values (38416212, 763532248, 94);
insert into invoice_line (candy_id, invoice_id, qty) values (61752835, 598862587, 34);
insert into invoice_line (candy_id, invoice_id, qty) values (69632483, 931238345, 25);
insert into invoice_line (candy_id, invoice_id, qty) values (39313758, 559163884, 94);
insert into invoice_line (candy_id, invoice_id, qty) values (69632483, 725755216, 13);
insert into invoice_line (candy_id, invoice_id, qty) values (88458076, 600862907, 54);
insert into invoice_line (candy_id, invoice_id, qty) values (53103777, 103492292, 90);
insert into invoice_line (candy_id, invoice_id, qty) values (69632483, 635203160, 24);
insert into invoice_line (candy_id, invoice_id, qty) values (78338525, 638800757, 92);
insert into invoice_line (candy_id, invoice_id, qty) values (22480259, 279558496, 95);
insert into invoice_line (candy_id, invoice_id, qty) values (78338525, 279558496, 12);
insert into invoice_line (candy_id, invoice_id, qty) values (90809602, 875405294, 86);
insert into invoice_line (candy_id, invoice_id, qty) values (40475062, 638800757, 88);
insert into invoice_line (candy_id, invoice_id, qty) values (90809602, 117815505, 65);
insert into invoice_line (candy_id, invoice_id, qty) values (21879745, 702393961, 91);
insert into invoice_line (candy_id, invoice_id, qty) values (43486512, 620841273, 82);
insert into invoice_line (candy_id, invoice_id, qty) values (71085921, 734441723, 40);
insert into invoice_line (candy_id, invoice_id, qty) values (72302293, 722420475, 97);
insert into invoice_line (candy_id, invoice_id, qty) values (90112395, 382041711, 19);
insert into invoice_line (candy_id, invoice_id, qty) values (49093250, 860186782, 62);
insert into invoice_line (candy_id, invoice_id, qty) values (46334925, 119051133, 77);
insert into invoice_line (candy_id, invoice_id, qty) values (75469899, 815809655, 67);
insert into invoice_line (candy_id, invoice_id, qty) values (12302565, 763532248, 41);
insert into invoice_line (candy_id, invoice_id, qty) values (12302565, 117815505, 49);
insert into invoice_line (candy_id, invoice_id, qty) values (19395793, 635203160, 18);
insert into invoice_line (candy_id, invoice_id, qty) values (90809602, 928846278, 13);
insert into invoice_line (candy_id, invoice_id, qty) values (53103777, 635203160, 10);
insert into invoice_line (candy_id, invoice_id, qty) values (22480259, 776209779, 22);
insert into invoice_line (candy_id, invoice_id, qty) values (72076152, 335974277, 98);
insert into invoice_line (candy_id, invoice_id, qty) values (72302293, 492904963, 99);
insert into invoice_line (candy_id, invoice_id, qty) values (69632483, 600862907, 3);
insert into invoice_line (candy_id, invoice_id, qty) values (52255752, 525060855, 78);
insert into invoice_line (candy_id, invoice_id, qty) values (12302565, 928846278, 27);
insert into invoice_line (candy_id, invoice_id, qty) values (29569692, 763532248, 58);
insert into invoice_line (candy_id, invoice_id, qty) values (29569692, 349636249, 91);
insert into invoice_line (candy_id, invoice_id, qty) values (69632483, 692728272, 86);
insert into invoice_line (candy_id, invoice_id, qty) values (72076152, 152248292, 9);
insert into invoice_line (candy_id, invoice_id, qty) values (46334925, 349636249, 80);
insert into invoice_line (candy_id, invoice_id, qty) values (90112395, 884440828, 12);
insert into invoice_line (candy_id, invoice_id, qty) values (38416212, 644724728, 8);
insert into invoice_line (candy_id, invoice_id, qty) values (40475062, 156191429, 4);
insert into invoice_line (candy_id, invoice_id, qty) values (53103777, 559163884, 43);
insert into invoice_line (candy_id, invoice_id, qty) values (52255752, 806832105, 64);
insert into invoice_line (candy_id, invoice_id, qty) values (90112395, 806832105, 38);
insert into invoice_line (candy_id, invoice_id, qty) values (46334925, 938408607, 59);
insert into invoice_line (candy_id, invoice_id, qty) values (12302565, 320349635, 83);
insert into invoice_line (candy_id, invoice_id, qty) values (39313758, 293318218, 4);
insert into invoice_line (candy_id, invoice_id, qty) values (22480259, 562773355, 70);
insert into invoice_line (candy_id, invoice_id, qty) values (43486512, 875405294, 52);
insert into invoice_line (candy_id, invoice_id, qty) values (36577199, 399145888, 62);
insert into invoice_line (candy_id, invoice_id, qty) values (29569692, 884440828, 64);
insert into invoice_line (candy_id, invoice_id, qty) values (22480259, 717126547, 35);
insert into invoice_line (candy_id, invoice_id, qty) values (81188160, 976913027, 61);
insert into invoice_line (candy_id, invoice_id, qty) values (60596910, 875405294, 20);
insert into invoice_line (candy_id, invoice_id, qty) values (49093250, 103492292, 71);
insert into invoice_line (candy_id, invoice_id, qty) values (75469899, 808874353, 97);
insert into invoice_line (candy_id, invoice_id, qty) values (40475062, 913927527, 6);
insert into invoice_line (candy_id, invoice_id, qty) values (43486512, 535815293, 21);
insert into invoice_line (candy_id, invoice_id, qty) values (39313758, 492904963, 10);
insert into invoice_line (candy_id, invoice_id, qty) values (94022635, 117815505, 6);
insert into invoice_line (candy_id, invoice_id, qty) values (75469899, 644724728, 88);
insert into invoice_line (candy_id, invoice_id, qty) values (46334925, 704590917, 26);
insert into invoice_line (candy_id, invoice_id, qty) values (43486512, 931238345, 74);
insert into invoice_line (candy_id, invoice_id, qty) values (49093250, 270776475, 19);
insert into invoice_line (candy_id, invoice_id, qty) values (25586201, 505577051, 85);
insert into invoice_line (candy_id, invoice_id, qty) values (40475062, 710294142, 87);
insert into invoice_line (candy_id, invoice_id, qty) values (70685586, 349636249, 10);
insert into invoice_line (candy_id, invoice_id, qty) values (78338525, 931238345, 56);
insert into invoice_line (candy_id, invoice_id, qty) values (45525516, 913927527, 20);
insert into invoice_line (candy_id, invoice_id, qty) values (81188160, 782995222, 15);
insert into invoice_line (candy_id, invoice_id, qty) values (36577199, 325203296, 48);
insert into invoice_line (candy_id, invoice_id, qty) values (78338525, 782995222, 48);
insert into invoice_line (candy_id, invoice_id, qty) values (38416212, 103492292, 10);
insert into invoice_line (candy_id, invoice_id, qty) values (69632483, 734441723, 25);
insert into invoice_line (candy_id, invoice_id, qty) values (60596910, 860186782, 51);
insert into invoice_line (candy_id, invoice_id, qty) values (88458076, 782995222, 27);
insert into invoice_line (candy_id, invoice_id, qty) values (40475062, 535815293, 28);
insert into invoice_line (candy_id, invoice_id, qty) values (94022635, 725755216, 85);
insert into invoice_line (candy_id, invoice_id, qty) values (38416212, 702393961, 11);
insert into invoice_line (candy_id, invoice_id, qty) values (45525516, 300829602, 20);
insert into invoice_line (candy_id, invoice_id, qty) values (90809602, 152248292, 62);
insert into invoice_line (candy_id, invoice_id, qty) values (39313758, 597005766, 18);
insert into invoice_line (candy_id, invoice_id, qty) values (21879745, 976551412, 29);
insert into invoice_line (candy_id, invoice_id, qty) values (38416212, 559163884, 21);
