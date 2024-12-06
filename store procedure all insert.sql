IF (OBJECT_ID('InsertUser') IS NOT NULL)
  DROP PROCEDURE InsertUser;
GO

CREATE PROCEDURE InsertUser
    @usrt_id INT,
    @usr_name VARCHAR(150),
    @usr_username VARCHAR(15),
    @usr_password VARCHAR(15),
    @usr_birthdate DATE,
    @usr_address VARCHAR(50) = NULL,
    @usr_city VARCHAR(50) = NULL,
    @usr_zipcode INT = NULL,
    @usr_email VARCHAR(150) = NULL,
    @usr_phone BIGINT = NULL,
    @usr_status BIT
AS
BEGIN
    -- Insert the values into the table
    INSERT INTO Users (
        usrt_id, usr_name, usr_username, usr_password, usr_birthdate, 
        usr_address, usr_city, usr_zipcode, usr_email, usr_phone, usr_status
    )
    VALUES (
        @usrt_id, @usr_name, @usr_username, @usr_password, @usr_birthdate, 
        @usr_address, @usr_city, @usr_zipcode, @usr_email, @usr_phone, @usr_status
    );
END;
GO

IF (OBJECT_ID('InsertUserType') IS NOT NULL)
  DROP PROCEDURE InsertUserType;
GO

;CREATE PROCEDURE InsertUserType
	@usrt_name VARCHAR(150),
    @usrt_description VARCHAR(250),
    @usrt_customer BIT,
    @usrt_admin BIT,
    @usrt_status BIT
AS
BEGIN
    ---- Declare variables for input
    --DECLARE @usrt_name VARCHAR(150),
    --        @usrt_description VARCHAR(250),
    --        @usrt_customer BIT,
    --        @usrt_admin BIT,
    --        @usrt_status BIT;

    ---- Set values for the variables
    --SET @usrt_name = 'Example Name'; -- Replace with actual value
    --SET @usrt_description = 'Example Description'; -- Replace with actual value
    --SET @usrt_customer = 1; -- Replace with 1 or 0
    --SET @usrt_admin = 0; -- Replace with 1 or 0
    --SET @usrt_status = 1; -- Replace with 1 or 0

    -- Insert into the table
    INSERT INTO UserTypes (usrt_name, usrt_description, usrt_customer, usrt_admin, usrt_status)
    VALUES (@usrt_name, @usrt_description, @usrt_customer, @usrt_admin, @usrt_status);
END; 
GO

IF (OBJECT_ID('InsertShipping') IS NOT NULL)
  DROP PROCEDURE InsertShipping;
GO

CREATE PROCEDURE InsertShipping
    @ord_id INT,
    @shp_name VARCHAR(150),
    @shp_address VARCHAR(50),
    @shp_city VARCHAR(50),
    @shp_state VARCHAR(2),
    @shp_zipcode int,
    @shp_phone bigint,
    @shp_tracking VARCHAR(50) = NULL,
    @shp_last_date DATETIME,
    @shp_date DATETIME
AS
BEGIN
    INSERT INTO Shipping (
        ord_id, 
        shp_name, 
        shp_address, 
        shp_city, 
        shp_state, 
        shp_zipcode, 
        shp_phone, 
        shp_tracking, 
        shp_last_date, 
        shp_date
    )
    VALUES (
        @ord_id, 
        @shp_name, 
        @shp_address, 
        @shp_city, 
        @shp_state, 
        @shp_zipcode, 
        @shp_phone, 
        @shp_tracking, 
        @shp_last_date, 
        @shp_date
    );
END;
GO

IF (OBJECT_ID('InsertSales') IS NOT NULL)
  DROP PROCEDURE InsertSales;
GO

CREATE PROCEDURE InsertSales
    @ord_id INT,
    @prod_id INT,
    @sls_price MONEY
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Sales (ord_id, prod_id, sls_price)
    VALUES (@ord_id, @prod_id, @sls_price);
END;
GO

IF (OBJECT_ID('InsertReview') IS NOT NULL)
  DROP PROCEDURE InsertReview;
GO

CREATE PROCEDURE InsertReview
    @prod_id INT,
    @rvw_stars NUMERIC(2,1),
    @rvw_comment VARCHAR(250),
    @rvw_status BIT,
    @rvw_date DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Reviews (prod_id, rvw_stars, rvw_comment, rvw_status, rvw_date)
    VALUES (@prod_id, @rvw_stars, @rvw_comment, @rvw_status, @rvw_date);
END;
GO

IF (OBJECT_ID('InsertProductType') IS NOT NULL)
  DROP PROCEDURE InsertProductType;
GO

CREATE PROCEDURE InsertProductType
    @prodt_name VARCHAR(150),
    @prodt_description VARCHAR(250),
    @prodt_status BIT
AS
BEGIN
    INSERT INTO ProductsTypes
        (prodt_name, prodt_description, prodt_status)
    VALUES
        (@prodt_name, @prodt_description, @prodt_status);
END; 
GO

IF (OBJECT_ID('InsertProduct') IS NOT NULL)
  DROP PROCEDURE InsertProduct;
GO

CREATE PROCEDURE InsertProduct
    @prodt_id INT,
    @prod_name VARCHAR(150),
    @prod_price MONEY,
    @prod_condition VARCHAR(15),
    @prod_description VARCHAR(250),
    @prod_brand VARCHAR(150),
    @prod_status BIT
AS
BEGIN
    INSERT INTO Products (
        prodt_id,
        prod_name,
        prod_price,
        prod_condition,
        prod_description,
        prod_brand,
        prod_status
    )
    VALUES (
        @prodt_id,
        @prod_name,
        @prod_price,
        @prod_condition,
        @prod_description,
        @prod_brand,
        @prod_status
    );
END; 
GO

IF (OBJECT_ID('InsertPayment') IS NOT NULL)
  DROP PROCEDURE InsertPayment;
GO

CREATE PROCEDURE InsertPayment
    @paym_name VARCHAR(50),
    @paym_method VARCHAR(150),
    @paym_number VARCHAR(50),
    @paym_expdate VARCHAR(5)
AS
BEGIN
    INSERT INTO Payment (paym_name, paym_method, paym_number, paym_expdate)
    VALUES (@paym_name, @paym_method, @paym_number, @paym_expdate);
END; 
GO

IF (OBJECT_ID('InsertOrder') IS NOT NULL)
  DROP PROCEDURE InsertOrder;
GO

CREATE PROCEDURE InsertOrder
    @ord_content VARCHAR(150),
    @shp_id INT,
    @ord_date DATETIME
AS
BEGIN
    INSERT INTO Orders
        (ord_content, shp_id, ord_date)
    VALUES
        (@ord_content, @shp_id, @ord_date);
END; 
GO

IF (OBJECT_ID('InsertMisteryBagDetailed') IS NOT NULL)
  DROP PROCEDURE InsertMisteryBagDetailed;
GO

CREATE PROCEDURE InsertMisteryBagDetailed
    @mysb_id INT,               -- Mystery Bag ID (Foreign Key)
    @mysbd_content VARCHAR(50),  -- Content of the mystery bag
    @mysbd_total_value MONEY,    -- Total value of the items in the bag
    @mysbd_status BIT           -- Status of the detailed bag (active or inactive)
AS
BEGIN
    INSERT INTO MisteryBagsDetailed (
        mysb_id, 
        mysbd_content, 
        mysbd_total_value, 
        mysbd_status
    )
    VALUES (
        @mysb_id, 
        @mysbd_content, 
        @mysbd_total_value, 
        @mysbd_status
    );
END;
GO

IF (OBJECT_ID('InsertMysteryBag') IS NOT NULL)
  DROP PROCEDURE InsertMysteryBag;
GO

CREATE PROCEDURE InsertMysteryBag
    @mysb_name VARCHAR(150),
    @mysb_description VARCHAR(250),
    @mysb_items TINYINT,
    @mysb_status BIT
AS
BEGIN
    INSERT INTO MysteryBags (mysb_name, mysb_description, mysb_items, mysb_status)
    VALUES (@mysb_name, @mysb_description, @mysb_items, @mysb_status);
END; 
GO

IF (OBJECT_ID('InsertInvoice') IS NOT NULL)
  DROP PROCEDURE InsertInvoice;
GO

CREATE PROCEDURE InsertInvoice
    @paym_id INT,
    @usr_id INT,
    @invc_orders VARCHAR(250),
    @invc_subtotal MONEY,
    @invc_discount MONEY,
    @invc_total MONEY,
    @invc_date DATETIME,
    @invc_status BIT
AS
BEGIN
    INSERT INTO Invoice 
        (paym_id, usr_id, invc_orders, invc_subtotal, invc_discount, invc_total, invc_date, invc_status)
    VALUES 
        (@paym_id, @usr_id, @invc_orders, @invc_subtotal, @invc_discount, @invc_total, @invc_date, @invc_status);
END; 
GO

IF (OBJECT_ID('InsertInventory') IS NOT NULL)
  DROP PROCEDURE InsertInventory;
GO

CREATE PROCEDURE InsertInventory
    @prod_id INT,
    @inv_quantity TINYINT,
    @usr_id INT,
    @inv_mod_date DATETIME,
    @inv_state BIT
AS
BEGIN
    INSERT INTO Inventory (
        prod_id, 
        inv_quantity, 
		usr_id,
        inv_mod_date, 
        inv_state
    )
    VALUES (
        @prod_id, 
        @inv_quantity, 
		@usr_id,
        @inv_mod_date, 
        @inv_state
    );
END; 
GO

IF (OBJECT_ID('InsertExpenseType') IS NOT NULL)
  DROP PROCEDURE InsertExpenseType;
GO

CREATE PROCEDURE InsertExpenseType 
    @expt_name VARCHAR(150),
    @expt_description VARCHAR(250),
    @expt_frequency TINYINT,
    @expt_priority TINYINT
AS
BEGIN
    INSERT INTO ExpensesTypes 
    (
        expt_name,
        expt_description,
        expt_frequency,
        expt_priority
    )
    VALUES 
    (
        @expt_name,
        @expt_description,
        @expt_frequency,
        @expt_priority
    );
END; 
GO

IF (OBJECT_ID('InsertExpense') IS NOT NULL)
  DROP PROCEDURE InsertExpense;
GO

CREATE PROCEDURE InsertExpense 
    @expt_id INT,
    @exp_description VARCHAR(250),
    @exp_amount MONEY,
    @exp_method VARCHAR(15),
    @exp_date DATE
AS
BEGIN
    INSERT INTO Expenses (
        expt_id, 
        exp_description, 
        exp_amount, 
        exp_method, 
        exp_date
    )
    VALUES (
        @expt_id, 
        @exp_description, 
        @exp_amount, 
        @exp_method, 
        @exp_date
    );
END; 
GO