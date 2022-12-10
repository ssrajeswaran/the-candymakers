-- create a candyland database
CREATE DATABASE candyland;

-- create user and grant all privileges
CREATE USER 'webapp'@'%' IDENTIFIED BY 'Butterfly55';
GRANT ALL PRIVILEGES ON candyland.* TO 'webapp'@'%';
FLUSH PRIVILEGES;

-- create all tables and attributes w/in db
USE candyland;

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



-- add sample data (around 10-20 rows / table)

-- customers
insert into customers (cust_id, first_name, last_name, phone, email, address) values (17994, 'Jerry', 'Sells', '391-799-6851', 'jsells0@mapy.cz', '617 Westridge Pass');
insert into customers (cust_id, first_name, last_name, phone, email, address) values (53562, 'Levy', 'Christie', '543-836-4705', 'lchristie1@goodreads.com', '82299 Sachtjen Place');
insert into customers (cust_id, first_name, last_name, phone, email, address) values (35952, 'Gusty', 'Daughtry', '968-386-1832', 'gdaughtry2@ifeng.com', '9 Cherokee Plaza');
insert into customers (cust_id, first_name, last_name, phone, email, address) values (35452, 'Hamel', 'Learned', '804-642-9517', 'hlearned3@studiopress.com', '45 Grayhawk Drive');
insert into customers (cust_id, first_name, last_name, phone, email, address) values (45842, 'Marlena', 'Vynarde', '333-899-5928', 'mvynarde4@hostgator.com', '4 Montana Court');
insert into customers (cust_id, first_name, last_name, phone, email, address) values (56912, 'Igor', 'Astlet', '862-168-5793', 'iastlet5@sohu.com', '6 Tomscot Parkway');
insert into customers (cust_id, first_name, last_name, phone, email, address) values (09548, 'Joanie', 'Dowyer', '342-875-4007', 'jdowyer6@1und1.de', '2012 Coolidge Circle');
insert into customers (cust_id, first_name, last_name, phone, email, address) values (29626, 'Gay', 'Bontine', '676-443-8727', 'gbontine7@independent.co.uk', '0589 Weeping Birch Road');
insert into customers (cust_id, first_name, last_name, phone, email, address) values (32831, 'Jeanelle', 'Bicheno', '632-787-7513', 'jbicheno8@ft.com', '7267 Rowland Circle');
insert into customers (cust_id, first_name, last_name, phone, email, address) values (72785, 'Olwen', 'Imason', '633-961-3397', 'oimason9@ucla.edu', '9 Boyd Court');
insert into customers (cust_id, first_name, last_name, phone, email, address) values (61509, 'Anderson', 'Deverell', '840-350-5736', 'adeverella@wix.com', '2 Stone Corner Avenue');
insert into customers (cust_id, first_name, last_name, phone, email, address) values (53868, 'Billi', 'Wheelhouse', '257-833-3248', 'bwheelhouseb@prnewswire.com', '36595 Kropf Point');
insert into customers (cust_id, first_name, last_name, phone, email, address) values (93990, 'Rici', 'Wabb', '977-912-2066', 'rwabbc@yahoo.com', '24235 Sachtjen Terrace');
insert into customers (cust_id, first_name, last_name, phone, email, address) values (96901, 'Julina', 'Roeby', '709-474-2695', 'jroebyd@rediff.com', '69 Wayridge Place');
insert into customers (cust_id, first_name, last_name, phone, email, address) values (76025, 'Sheffy', 'Gopsell', '108-269-4692', 'sgopselle@opensource.org', '9008 Ramsey Alley');
insert into customers (cust_id, first_name, last_name, phone, email, address) values (43085, 'Britt', 'Reasce', '498-474-1699', 'breascef@netscape.com', '39207 Havey Lane');
insert into customers (cust_id, first_name, last_name, phone, email, address) values (95661, 'Jenilee', 'Whittle', '195-655-0138', 'jwhittleg@biblegateway.com', '4 Thackeray Point');
insert into customers (cust_id, first_name, last_name, phone, email, address) values (95341, 'Janaya', 'Richardin', '137-802-5887', 'jrichardinh@slate.com', '3 Boyd Parkway');
insert into customers (cust_id, first_name, last_name, phone, email, address) values (41868, 'Cristabel', 'Darragh', '126-401-2929', 'cdarraghi@japanpost.jp', '9 Fordem Trail');
insert into customers (cust_id, first_name, last_name, phone, email, address) values (59608, 'Trina', 'Guiel', '996-151-7916', 'tguielj@mapy.cz', '92571 East Street');

-- manufacturers
insert into manufacturers (manufacturer_id, name, address) values (0559, 'Blick-Gottlieb', '0 Bunker Hill Park');
insert into manufacturers (manufacturer_id, name, address) values (7177, 'Kovacek Inc', '56866 Arrowood Center');
insert into manufacturers (manufacturer_id, name, address) values (3135, 'Heidenreich and Sons', '8 Loomis Point');
insert into manufacturers (manufacturer_id, name, address) values (1427, 'Quitzon, Fay and Reinger', '4 Sugar Drive');
insert into manufacturers (manufacturer_id, name, address) values (0270, 'Oberbrunner and Sons', '37 Aberg Terrace');
insert into manufacturers (manufacturer_id, name, address) values (6093, 'Swift, Ward and Kessler', '32 Dennis Lane');
insert into manufacturers (manufacturer_id, name, address) values (0537, 'Feest-Reinger', '0 Brentwood Road');
insert into manufacturers (manufacturer_id, name, address) values (9190, 'Wuckert Group', '1972 Lawn Alley');
insert into manufacturers (manufacturer_id, name, address) values (9821, 'Goyette Inc', '114 Forest Dale Pass');
insert into manufacturers (manufacturer_id, name, address) values (8192, 'Wolf-Skiles', '83 Hovde Trail');
insert into manufacturers (manufacturer_id, name, address) values (7880, 'Zemlak, Hettinger and Carter', '17 Maywood Road');
insert into manufacturers (manufacturer_id, name, address) values (7225, 'Wolf-Mayert', '0 Acker Lane');
insert into manufacturers (manufacturer_id, name, address) values (3588, 'Daniel, Jacobs and Becker', '7275 Dryden Road');
insert into manufacturers (manufacturer_id, name, address) values (2574, 'Langworth, Gusikowski and Gaylord', '7 Miller Crossing');
insert into manufacturers (manufacturer_id, name, address) values (3268, 'Jacobson Inc', '910 Elka Junction');
insert into manufacturers (manufacturer_id, name, address) values (6598, 'Feeney LLC', '8 Bobwhite Pass');
insert into manufacturers (manufacturer_id, name, address) values (7625, 'Williamson Group', '87892 Shopko Alley');
insert into manufacturers (manufacturer_id, name, address) values (6173, 'Kirlin Group', '8 Ramsey Drive');
insert into manufacturers (manufacturer_id, name, address) values (2067, 'Kuvalis-Heathcote', '04 Bowman Alley');
insert into manufacturers (manufacturer_id, name, address) values (2506, 'Goodwin, Jerde and Hintz', '6 Nelson Circle');

-- ingredients

insert into ingredients (ingredient_id, name) values (020, 'Eggs');
insert into ingredients (ingredient_id, name) values (332, 'Flour');
insert into ingredients (ingredient_id, name) values (712, 'Cocoa Powder');
insert into ingredients (ingredient_id, name) values (341, 'Baking Powder');
insert into ingredients (ingredient_id, name) values (226, 'Powdered Sugar');
insert into ingredients (ingredient_id, name) values (438, 'Baking Soda');
insert into ingredients (ingredient_id, name) values (611, 'Milk');
insert into ingredients (ingredient_id, name) values (690, 'Water');
insert into ingredients (ingredient_id, name) values (997, 'Salt');
insert into ingredients (ingredient_id, name) values (705, 'Brown Sugar');
insert into ingredients (ingredient_id, name) values (745, 'Dark Brown Sugar');
insert into ingredients (ingredient_id, name) values (370, 'Cornstarch');
insert into ingredients (ingredient_id, name) values (873, 'Nutmeg');
insert into ingredients (ingredient_id, name) values (508, 'Oil');
insert into ingredients (ingredient_id, name) values (816, 'Walnuts');
insert into ingredients (ingredient_id, name) values (128, 'Peanuts');
insert into ingredients (ingredient_id, name) values (956, 'Chocolate Chips');
insert into ingredients (ingredient_id, name) values (921, 'Almonds');
insert into ingredients (ingredient_id, name) values (071, 'Coconut');
insert into ingredients (ingredient_id, name) values (460, 'White Chocolate Chips');

-- shippers
insert into shippers (shipper_id, name, address, email) values (08, 'Zava', '27 Twin Pines Way', 'vklimushev0@flickr.com');
insert into shippers (shipper_id, name, address, email) values (72, 'Aimbo', '62671 Graceland Place', 'jparell1@cargocollective.com');
insert into shippers (shipper_id, name, address, email) values (69, 'Topiczoom', '24692 Brown Trail', 'mjeavon2@so-net.ne.jp');
insert into shippers (shipper_id, name, address, email) values (37, 'Flashset', '32931 Towne Court', 'ajackson3@infoseek.co.jp');
insert into shippers (shipper_id, name, address, email) values (93, 'BlogXS', '88 Hazelcrest Parkway', 'ttayspell4@chicagotribune.com');
insert into shippers (shipper_id, name, address, email) values (53, 'Tanoodle', '19 Ronald Regan Junction', 'fbetty5@parallels.com');
insert into shippers (shipper_id, name, address, email) values (00, 'Fivespan', '509 Walton Alley', 'sbloomfield6@baidu.com');
insert into shippers (shipper_id, name, address, email) values (33, 'Zazio', '9 Chive Alley', 'dpennicott7@studiopress.com');
insert into shippers (shipper_id, name, address, email) values (87, 'Zava', '54873 Birchwood Way', 'pgahagan8@state.tx.us');
insert into shippers (shipper_id, name, address, email) values (39, 'Snaptags', '69258 Warrior Drive', 'callberry9@tinyurl.com');


-- store managers
insert into store_mgrs (store_mgr_id, first_name, last_name, phone, email) values (834794, 'Frasier', 'Aspland', '866-676-5135', 'faspland0@geocities.com');
insert into store_mgrs (store_mgr_id, first_name, last_name, phone, email) values (962240, 'Harper', 'Goodacre', '134-719-0007', 'hgoodacre1@free.fr');
insert into store_mgrs (store_mgr_id, first_name, last_name, phone, email) values (188583, 'Alvan', 'Oag', '190-777-1281', 'aoag2@redcross.org');
insert into store_mgrs (store_mgr_id, first_name, last_name, phone, email) values (158471, 'Maison', 'Litherland', '526-152-9357', 'mlitherland3@youku.com');
insert into store_mgrs (store_mgr_id, first_name, last_name, phone, email) values (093342, 'Mariele', 'Coghill', '766-640-9777', 'mcoghill4@addtoany.com');
insert into store_mgrs (store_mgr_id, first_name, last_name, phone, email) values (659220, 'Serena', 'Franzen', '470-447-0643', 'sfranzen5@ameblo.jp');
insert into store_mgrs (store_mgr_id, first_name, last_name, phone, email) values (965511, 'Gawain', 'Reynalds', '576-894-8048', 'greynalds6@msu.edu');
insert into store_mgrs (store_mgr_id, first_name, last_name, phone, email) values (824123, 'Gaylord', 'Mundwell', '457-435-1711', 'gmundwell7@wiley.com');
insert into store_mgrs (store_mgr_id, first_name, last_name, phone, email) values (097308, 'Hilary', 'Craig', '581-295-1193', 'hcraig8@mail.ru');
insert into store_mgrs (store_mgr_id, first_name, last_name, phone, email) values (708185, 'Ellis', 'Grose', '839-854-1681', 'egrose9@irs.gov');
insert into store_mgrs (store_mgr_id, first_name, last_name, phone, email) values (906249, 'Bobbette', 'Hicken', '146-887-8459', 'bhickena@prnewswire.com');
insert into store_mgrs (store_mgr_id, first_name, last_name, phone, email) values (328119, 'Shaina', 'Denisot', '154-875-4473', 'sdenisotb@usgs.gov');
insert into store_mgrs (store_mgr_id, first_name, last_name, phone, email) values (280333, 'Aleece', 'Brosel', '304-813-6907', 'abroselc@homestead.com');
insert into store_mgrs (store_mgr_id, first_name, last_name, phone, email) values (880805, 'Danielle', 'Mitrikhin', '262-124-9451', 'dmitrikhind@angelfire.com');
insert into store_mgrs (store_mgr_id, first_name, last_name, phone, email) values (214920, 'Eba', 'Walch', '123-468-2357', 'ewalche@storify.com');
insert into store_mgrs (store_mgr_id, first_name, last_name, phone, email) values (219763, 'Jerrylee', 'Meikle', '178-969-2331', 'jmeiklef@ucoz.ru');
insert into store_mgrs (store_mgr_id, first_name, last_name, phone, email) values (301264, 'Jozef', 'Jost', '841-389-6271', 'jjostg@statcounter.com');
insert into store_mgrs (store_mgr_id, first_name, last_name, phone, email) values (466004, 'Gabriel', 'Longman', '179-290-0870', 'glongmanh@statcounter.com');
insert into store_mgrs (store_mgr_id, first_name, last_name, phone, email) values (135486, 'Wilhelmina', 'Klossek', '950-785-0985', 'wklosseki@csmonitor.com');
insert into store_mgrs (store_mgr_id, first_name, last_name, phone, email) values (613953, 'Michel', 'Phin', '723-570-9630', 'mphinj@domainmarket.com');


-- marketing mgrs

insert into marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) values (400939, 'Ralf', 'Rydzynski', '822-913-8670', 'rrydzynski0@theglobeandmail.com');
insert into marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) values (689949, 'Fae', 'Wolford', '185-932-5854', 'fwolford1@prweb.com');
insert into marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) values (517205, 'Alexa', 'Gonthier', '422-286-1350', 'agonthier2@digg.com');
insert into marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) values (444559, 'Haven', 'Offill', '300-265-3661', 'hoffill3@hp.com');
insert into marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) values (717423, 'Bibi', 'Hartless', '552-117-2341', 'bhartless4@clickbank.net');
insert into marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) values (696069, 'George', 'Sear', '910-263-2806', 'gsear5@virginia.edu');
insert into marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) values (556458, 'Michale', 'Goding', '247-678-1176', 'mgoding6@foxnews.com');
insert into marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) values (491568, 'Rennie', 'Killimister', '489-418-7879', 'rkillimister7@phpbb.com');
insert into marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) values (912853, 'Inger', 'Soares', '879-207-1759', 'isoares8@aol.com');
insert into marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) values (766749, 'Clemmie', 'Hawker', '202-715-5761', 'chawker9@taobao.com');
insert into marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) values (373120, 'Aryn', 'Bengle', '733-366-9266', 'abenglea@oakley.com');
insert into marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) values (706017, 'Chico', 'Costall', '115-212-9229', 'ccostallb@wsj.com');
insert into marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) values (363382, 'Clem', 'Gallyon', '385-847-1460', 'cgallyonc@163.com');
insert into marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) values (220582, 'Davita', 'Etienne', '419-772-4852', 'detienned@ted.com');
insert into marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) values (506441, 'Rob', 'Southern', '781-148-7447', 'rsoutherne@pagesperso-orange.fr');
insert into marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) values (048361, 'Jedediah', 'Emor', '783-565-1933', 'jemorf@stanford.edu');
insert into marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) values (563420, 'Devon', 'Raybould', '734-778-3084', 'draybouldg@cisco.com');
insert into marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) values (880578, 'Pattin', 'Begin', '482-680-9824', 'pbeginh@dagondesign.com');
insert into marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) values (268944, 'Kaitlin', 'Haster', '762-987-0706', 'khasteri@mysql.com');
insert into marketing_mgrs (mktg_mgr_id, first_name, last_name, phone, email) values (277169, 'Therine', 'Lonergan', '764-117-8877', 'tlonerganj@sun.com');


-- categories
insert into categories (category_id, category_name) values ('1466948', 'Caramel');
insert into categories (category_id, category_name) values ('1266113', 'Chocolate');
insert into categories (category_id, category_name) values ('0825185', 'Mint');
insert into categories (category_id, category_name) values ('6984329', 'Coconut');
insert into categories (category_id, category_name) values ('8513447', 'Peanut');
insert into categories (category_id, category_name) values ('4853133', 'Almond');
insert into categories (category_id, category_name) values ('7759091', 'Orange');
insert into categories (category_id, category_name) values ('6429594', 'Strawberry');
insert into categories (category_id, category_name) values ('4567412', 'Raisin');
insert into categories (category_id, category_name) values ('9634865', 'White Chocolate');

-- candies

insert into candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) values (51496868, 0537, 'Kitkat', 0.53, 15, '2022-04-08', 70, 35, 14, 77, true);
insert into candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) values (70300879, 0559, 'Jolly Rancher', 2.46, 97, '2022-06-28', 50, 1, 31, 57, false);
insert into candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) values (22268619, 7880, 'Hersheys', 5.98, 21, '2022-10-15', 28, 18, 91, 29, true);
insert into candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) values (05130609, 3268, 'Pop Rocks', 1.72, 43, '2022-05-16', 61, 46, 3, 51, false);
insert into candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) values (88545788, 7177, 'Twix', 5.97, 61, '2022-09-11', 20, 38, 9, 75, true);
insert into candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) values (67477127, 8192, 'Twizzlers', 6.41, 83, '2022-03-08', 44, 42, 67, 87, false);
insert into candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) values (76789346, 6093, 'Butterfingers', 5.94, 100, '2022-09-13', 38, 15, 55, 59, false);
insert into candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) values (74680753, 6093, 'Skittles', 3.37, 67, '2022-09-16', 8, 19, 97, 72, false);
insert into candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) values (72285533, 2574, 'Starburst', 2.89, 35, '2022-06-15', 1, 54, 27, 87, true);
insert into candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) values (93056299, 9190, 'Milk Duds', 4.49, 56, '2022-07-18', 52, 91, 80, 7, false);
insert into candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) values (04463365, 3588, 'Almond Joy', 1.03, 34, '2022-10-07', 10, 35, 96, 38, false);
insert into candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) values (59035043, 0537, 'M&Ms', 5.09, 85, '2022-08-24', 98, 67, 68, 97, true);
insert into candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) values (31966041, 0559, 'Crunch', 5.21, 41, '2021-11-27', 73, 87, 6, 75, true);
insert into candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) values (85795562, 0559, 'Reeses', 4.60, 20, '2022-06-11', 65, 81, 69, 26, false);
insert into candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) values (58337447, 0559, 'Raisinets', 0.25, 71, '2022-02-27', 61, 78, 11, 24, false);
insert into candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) values (70807063, 9190, '3 Musketeers', 8.89, 76, '2022-09-23', 11, 38, 99, 5, true);
insert into candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) values (02504833, 2067, 'Mike and Ike', 3.50, 1, '2022-04-23', 3, 10, 49, 19, false);
insert into candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) values (61796052, 2574, 'Baby Ruth', 6.77, 6, '2022-11-03', 62, 62, 25, 95, false);
insert into candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) values (29646073, 9190, 'Sweet Tarts', 2.19, 39, '2022-11-20', 94, 34, 81, 66, true);
insert into candies (candy_id, manufacturer_id, candy_name, unit_price, qty_in_stock, expiry_date, calories, sugars, fats, carbs, currently_sold) values (24514311, 3268, 'Snickers', 7.06, 63, '2022-08-27', 13, 22, 52, 98, false);

-- discounts

insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (21978, 04463365, 26, '2022-07-25', '2023-08-05');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (13148, 70807063, 23, '2021-11-27', '2023-01-22');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (65715, 85795562, 48, '2022-01-13', '2023-08-17');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (74480, 72285533, 45, '2021-12-21', '2023-09-06');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (86162, 67477127, 42, '2022-08-03', '2022-11-29');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (39093, 58337447, 33, '2022-08-19', '2023-01-08');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (26131, 51496868, 32, '2022-09-09', '2023-09-14');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (70862, 74680753, 46, '2022-02-25', '2023-10-30');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (57754, 61796052, 28, '2021-12-02', '2023-02-01');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (49505, 05130609, 36, '2022-08-02', '2023-03-19');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (28590, 51496868, 35, '2022-03-11', '2023-04-22');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (51552, 88545788, 23, '2022-04-13', '2022-12-09');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (08179, 70300879, 49, '2022-11-20', '2023-08-13');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (56156, 70300879, 25, '2022-10-03', '2022-12-01');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (79671, 74680753, 34, '2022-02-14', '2023-10-10');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (13278, 93056299, 40, '2022-01-19', '2023-10-18');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (39306, 67477127, 38, '2022-07-23', '2022-12-24');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (22328, 02504833, 37, '2022-04-28', '2023-08-19');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (48778, 88545788, 49, '2022-09-23', '2023-10-11');
insert into discounts (discount_id, candy_id, discount_pct, start_date, end_date) values (59513, 70807063, 46, '2022-03-30', '2023-06-28');


-- advertisements
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (0981, 58337447, 517205, '44005 Golf Course Center', 5.16);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (5049, 31966041, 444559, '59 Muir Place', 9.67);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (0792, 04463365, 506441, '3730 Huxley Trail', 8.58);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (2348, 58337447, 689949, '3 Kropf Junction', 0.99);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (8134, 72285533, 363382, '9192 Mallard Court', 4.65);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (6423, 70300879, 506441, '2 Graceland Court', 1.67);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (6649, 02504833, 363382, '43 Mayfield Parkway', 8.47);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (8553, 04463365, 220582, '10589 Kropf Drive', 1.78);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (1091, 61796052, 277169, '64552 Mcguire Court', 0.13);
insert into advertisements (advertisement_id, candy_id, mktg_mgr_id, location, cost) values (5370, 76789346, 563420, '5010 Mosinee Street', 6.93);


-- invoices
insert into invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) values (024238, 097308, 59608, 69, '30 Emmet Point', '2021-12-05');
insert into invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) values (620092, 466004, 53562, 72, '26 Thackeray Park', '2022-11-06');
insert into invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) values (274018, 093342, 17994, 53, '464 North Pass', '2022-03-30');
insert into invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) values (387943, 466004, 56912, 87, '1079 Fairfield Alley', '2022-04-26');
insert into invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) values (237984, 328119, 95661, 69, '44726 Mccormick Center', '2022-10-15');
insert into invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) values (080660, 188583, 29626, 08, '1 Scofield Road', '2022-03-22');
insert into invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) values (084306, 214920, 96901, 69, '816 Bowman Lane', '2022-11-10');
insert into invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) values (794143, 659220, 35952, 39, '18 Longview Street', '2022-02-26');
insert into invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) values (069917, 965511, 43085, 08, '9360 Hayes Hill', '2021-12-12');
insert into invoices (invoice_id, store_mgr_id, cust_id, shipper_id, billing_address, invoice_date) values (901305, 188583, 41868, 87, '70177 Cordelia Lane', '2022-01-04');

-- candies_categories
insert into candies_categories (candy_id, category_id) values (93056299, 4567412);
insert into candies_categories (candy_id, category_id) values (51496868, 4567412);
insert into candies_categories (candy_id, category_id) values (70807063, 6429594);
insert into candies_categories (candy_id, category_id) values (70300879, 9634865);
insert into candies_categories (candy_id, category_id) values (72285533, 4567412);
insert into candies_categories (candy_id, category_id) values (58337447, 4567412);
insert into candies_categories (candy_id, category_id) values (29646073, 1266113);
insert into candies_categories (candy_id, category_id) values (72285533, 6984329);
insert into candies_categories (candy_id, category_id) values (24514311, 8513447);
insert into candies_categories (candy_id, category_id) values (70807063, 1466948);

-- candies_ingredients
insert into candies_ingredients (candy_id, ingredient_id) values (31966041, 020);
insert into candies_ingredients (candy_id, ingredient_id) values (70807063, 341);
insert into candies_ingredients (candy_id, ingredient_id) values (51496868, 611);
insert into candies_ingredients (candy_id, ingredient_id) values (24514311, 341);
insert into candies_ingredients (candy_id, ingredient_id) values (76789346, 921);
insert into candies_ingredients (candy_id, ingredient_id) values (76789346, 611);
insert into candies_ingredients (candy_id, ingredient_id) values (61796052, 611);
insert into candies_ingredients (candy_id, ingredient_id) values (02504833, 712);
insert into candies_ingredients (candy_id, ingredient_id) values (05130609, 873);
insert into candies_ingredients (candy_id, ingredient_id) values (74680753, 020);

-- invoice_line
insert into invoice_line (candy_id, invoice_id, qty) values (76789346, 274018, 45);
insert into invoice_line (candy_id, invoice_id, qty) values (22268619, 794143, 87);
insert into invoice_line (candy_id, invoice_id, qty) values (22268619, 069917, 43);
insert into invoice_line (candy_id, invoice_id, qty) values (31966041, 387943, 54);
insert into invoice_line (candy_id, invoice_id, qty) values (24514311, 084306, 76);
insert into invoice_line (candy_id, invoice_id, qty) values (61796052, 901305, 9);
insert into invoice_line (candy_id, invoice_id, qty) values (05130609, 084306, 35);
insert into invoice_line (candy_id, invoice_id, qty) values (04463365, 620092, 61);
insert into invoice_line (candy_id, invoice_id, qty) values (93056299, 237984, 74);
insert into invoice_line (candy_id, invoice_id, qty) values (88545788, 387943, 18);
