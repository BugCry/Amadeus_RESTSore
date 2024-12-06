DROP TABLE UserTypes

CREATE TABLE UserTypes (
    usrt_id INT IDENTITY(1,1) PRIMARY KEY,
    usrt_name VARCHAR(150) NOT NULL,
    usrt_description VARCHAR(250) NOT NULL,
    usrt_customer bit,
    usrt_admin bit,
    usrt_status bit
);

DROP TABLE Users

CREATE TABLE Users (
    usr_id INT IDENTITY(1,1) PRIMARY KEY,
    usrt_id INT NOT NULL,
    usr_name VARCHAR(150) MASKED WITH (FUNCTION = 'partial(0, "$#@*(", 2)') NOT NULL,
    usr_username VARCHAR(15) MASKED WITH (FUNCTION = 'partial(0, "$#@*(", 2)') UNIQUE NOT NULL,
    usr_password varchar(15) MASKED WITH (FUNCTION = 'partial(0, "$#@*(", 2)') NOT NULL,
    usr_birthdate DATE MASKED WITH (FUNCTION = 'default()') NOT NULL,
    usr_address VARCHAR(50) NULL,
    usr_city VARCHAR(50) NULL,
    usr_zipcode int NULL,
    usr_email VARCHAR(150) MASKED WITH (FUNCTION = 'email()') NULL ,
    usr_phone bigint MASKED WITH (FUNCTION = 'random(1, 5000)') NULL,
    usr_status bit
);

DROP TABLE Payment

CREATE TABLE Payment (
    paym_id INT IDENTITY(1,1) PRIMARY KEY,
    paym_name VARCHAR(50) MASKED WITH (FUNCTION = 'partial(0,"###-", 4)') NOT NULL,
    paym_method VARCHAR(150) MASKED WITH (FUNCTION = 'partial(0,"###-", 4)') NOT NULL,
	paym_number VARCHAR(50) MASKED WITH (FUNCTION = 'partial(0,"###-", 4)') NOT NULL,
	paym_expdate VARCHAR(5) MASKED WITH (FUNCTION = 'default()') NOT NULL
);

DROP TABLE Invoice

CREATE TABLE Invoice (
    invc_id INT IDENTITY(1,1) PRIMARY KEY,
    paym_id INT MASKED WITH (FUNCTION = 'random(1, 5000)') NOT NULL,
    usr_id INT MASKED WITH (FUNCTION = 'random(1, 5000)') NOT NULL,
    invc_orders VARCHAR(250) NULL,
    invc_subtotal MONEY,
    invc_discount MONEY,
    invc_total MONEY,
    invc_date DATETIME MASKED WITH (FUNCTION = 'default()') NOT NULL,
    invc_status bit
);

DROP TABLE Inventory

CREATE TABLE Inventory (
    inv_id INT IDENTITY(1,1) PRIMARY KEY,
    prod_id INT UNIQUE NOT NULL,
    inv_quantity tinyint NOT NULL,
	usr_id INT MASKED WITH (FUNCTION = 'random(1, 5000)') NOT NULL,
    inv_mod_date DATETIME MASKED WITH (FUNCTION = 'default()') NOT NULL,
    inv_state bit
);

DROP TABLE Products

CREATE TABLE Products (
    prod_id INT IDENTITY(1,1) PRIMARY KEY,
    prodt_id INT NOT NULL,
    prod_name VARCHAR(150) NOT NULL,
    prod_price MONEY,
    prod_condition VARCHAR(15) NOT NULL,
    prod_description VARCHAR(250) NULL,
    prod_brand VARCHAR(150) NOT NULL,
    prod_status bit
);

DROP TABLE ProductsTypes

CREATE TABLE ProductsTypes (
    prodt_id INT IDENTITY(1,1) PRIMARY KEY,
    prodt_name VARCHAR(150) NOT NULL,
    prodt_description VARCHAR(250) NOT NULL,
    prodt_status bit
);

DROP TABLE Orders

CREATE TABLE Orders (
    ord_id INT IDENTITY(1,1) PRIMARY KEY,
    ord_content VARCHAR(150) NOT NULL,
    shp_id INT NULL,
	ord_date DATETIME MASKED WITH (FUNCTION = 'default()') NOT NULL
);

DROP TABLE Shipping

CREATE TABLE Shipping (
    shp_id INT IDENTITY(1,1) PRIMARY KEY,
    ord_id INT NOT NULL,
    shp_name VARCHAR(150) NOT NULL,
    shp_address VARCHAR(50) NOT NULL,
    shp_city VARCHAR(50) NOT NULL,
    shp_state VARCHAR(2) NOT NULL,
    shp_zipcode int NOT NULL,
    shp_phone bigint MASKED WITH (FUNCTION = 'random(1, 5000)') NOT NULL,
    shp_tracking VARCHAR(50) NULL,
	shp_last_date DATETIME MASKED WITH (FUNCTION = 'default()') NOT NULL,
	shp_date DATETIME MASKED WITH (FUNCTION = 'default()') NOT NULL
);

DROP TABLE Sales

CREATE TABLE Sales (
    sls_id INT IDENTITY(1,1) PRIMARY KEY,
    ord_id INT NOT NULL,
    prod_id INT NOT NULL,
    sls_price MONEY
);

DROP TABLE Reviews

CREATE TABLE Reviews (
    rvw_id INT IDENTITY(1,1) PRIMARY KEY,
    prod_id INT NOT NULL,
    rvw_stars NUMERIC(2,1) NOT NULL,
    rvw_comment VARCHAR(250) NOT NULL,
    rvw_status bit,
	rvw_date DATETIME MASKED WITH (FUNCTION = 'default()') NOT NULL
);

DROP TABLE MysteryBags

CREATE TABLE MysteryBags (
    mysb_id INT IDENTITY(1,1) PRIMARY KEY,
    mysb_name VARCHAR(150) NOT NULL,
    mysb_description VARCHAR(250) NOT NULL,
    mysb_items tinyint NOT NULL,
    mysb_status bit
);

DROP TABLE MisteryBagsDetailed

CREATE TABLE MisteryBagsDetailed (
    mysbd_id INT IDENTITY(1,1) PRIMARY KEY,
    mysb_id INT NOT NULL,
    mysbd_content VARCHAR(50) NOT NULL,
    mysbd_total_value MONEY,
    mysbd_status bit
);

DROP TABLE Expenses

CREATE TABLE Expenses (
    exp_id INT IDENTITY(1,1) PRIMARY KEY,
    expt_id INT NOT NULL,
    exp_description VARCHAR(250) NOT NULL,
    exp_amount MONEY,
    exp_method VARCHAR(15) NOT NULL,
	exp_date DATE MASKED WITH (FUNCTION = 'default()') NOT NULL
);

DROP TABLE ExpensesTypes

CREATE TABLE ExpensesTypes (
    expt_id INT IDENTITY(1,1) PRIMARY KEY,
    expt_name VARCHAR(150) NOT NULL,
    expt_description VARCHAR(250) NOT NULL,
    expt_frequency tinyint NOT NULL,
    expt_priority tinyint NOT NULL
);
