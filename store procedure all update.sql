IF (OBJECT_ID('UpdateUser') IS NOT NULL)
  DROP PROCEDURE UpdateUser;
GO

CREATE PROCEDURE UpdateUser
    @usr_id INT,
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
    -- UPDATE the WHERE the table
    UPDATE Users SET usrt_id = @usrt_id, usr_name = @usr_name, usr_username = @usr_username, usr_password = @usr_password, usr_birthdate = @usr_birthdate, 
        usr_address = @usr_address, usr_city = @usr_city, usr_zipcode = @usr_zipcode, usr_email = @usr_email, 
		usr_phone = @usr_phone, usr_status = @usr_status
    WHERE usr_id = @usr_id
END;
GO

IF (OBJECT_ID('UpdateUserType') IS NOT NULL)
  DROP PROCEDURE UpdateUserType;
GO

;CREATE PROCEDURE UpdateUserType
    @usrt_id INT,
	@usrt_name VARCHAR(150),
    @usrt_description VARCHAR(250),
    @usrt_customer BIT,
    @usrt_admin BIT,
    @usrt_status BIT
AS
BEGIN
    -- UPDATE the table
    UPDATE UserTypes SET usrt_name = @usrt_name, usrt_description = @usrt_description, usrt_customer = @usrt_customer, usrt_admin = @usrt_admin, usrt_status = @usrt_status
    WHERE usrt_id = @usrt_id
END; 
GO

IF (OBJECT_ID('UpdateShipping') IS NOT NULL)
  DROP PROCEDURE UpdateShipping;
GO

CREATE PROCEDURE UpdateShipping
    @shp_id INT,
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
    UPDATE Shipping SET
        ord_id = @ord_id, 
        shp_name = @shp_name, 
        shp_address = @shp_address, 
        shp_city = @shp_city, 
        shp_state = @shp_state, 
        shp_zipcode = @shp_zipcode, 
        shp_phone = @shp_phone, 
        shp_tracking = @shp_tracking, 
        shp_last_date = @shp_last_date, 
        shp_date = @shp_date
    WHERE shp_id = @shp_id
END;
GO

IF (OBJECT_ID('UpdateSales') IS NOT NULL)
  DROP PROCEDURE UpdateSales;
GO

CREATE PROCEDURE UpdateSales
    @sls_id INT,
	@ord_id INT,
    @prod_id INT,
    @sls_price MONEY
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Sales SET ord_id = @ord_id, prod_id = @prod_id, sls_price = @sls_price
    WHERE sls_id = @sls_id
END;
GO

IF (OBJECT_ID('UpdateReview') IS NOT NULL)
  DROP PROCEDURE UpdateReview;
GO

CREATE PROCEDURE UpdateReview
    @rvw_id INT,
	@prod_id INT,
    @rvw_stars NUMERIC(2,1),
    @rvw_comment VARCHAR(250),
    @rvw_status BIT,
    @rvw_date DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Reviews SET prod_id = @prod_id, rvw_stars = @rvw_stars, rvw_comment = @rvw_comment, rvw_status = @rvw_status, rvw_date = @rvw_date
    WHERE rvw_id = @rvw_id
END;
GO

IF (OBJECT_ID('UpdateProductType') IS NOT NULL)
  DROP PROCEDURE UpdateProductType;
GO

CREATE PROCEDURE UpdateProductType
	@prodt_id INT,
    @prodt_name VARCHAR(150),
    @prodt_description VARCHAR(250),
    @prodt_status BIT
AS
BEGIN
    UPDATE ProductsTypes set
        prodt_name = @prodt_name, 
		prodt_description = @prodt_description, 
		prodt_status = @prodt_status
    WHERE prodt_id = @prodt_id
END; 
GO

IF (OBJECT_ID('UpdateProduct') IS NOT NULL)
  DROP PROCEDURE UpdateProduct;
GO

CREATE PROCEDURE UpdateProduct
    @prod_id INT,
    @prodt_id INT,
    @prod_name VARCHAR(150),
    @prod_price MONEY,
    @prod_condition VARCHAR(15),
    @prod_description VARCHAR(250),
    @prod_brand VARCHAR(150),
    @prod_status BIT
AS
BEGIN
    UPDATE Products set
        prodt_id = @prodt_id,
        prod_name = @prod_name,
        prod_price = @prod_price,
        prod_condition = @prod_condition,
        prod_description = @prod_description,
        prod_brand = @prod_brand,
        prod_status = @prod_status
	where prod_id = @prod_id
END; 
GO

IF (OBJECT_ID('UpdatePayment') IS NOT NULL)
  DROP PROCEDURE UpdatePayment;
GO

CREATE PROCEDURE UpdatePayment
    @paym_id INT,
	@paym_name VARCHAR(50),
    @paym_method VARCHAR(150),
    @paym_number VARCHAR(50),
    @paym_expdate VARCHAR(5)
AS
BEGIN
    UPDATE Payment SET paym_name = @paym_name, paym_method = @paym_method, paym_number = @paym_number, paym_expdate = @paym_expdate
    WHERE paym_id = @paym_id 
END; 
GO

IF (OBJECT_ID('UpdateOrder') IS NOT NULL)
  DROP PROCEDURE UpdateOrder;
GO

CREATE PROCEDURE UpdateOrder
    @ord_id INT,
	@ord_content VARCHAR(150),
    @shp_id INT,
    @ord_date DATETIME
AS
BEGIN
    UPDATE Orders SET
        ord_content = @ord_content, shp_id = @shp_id, ord_date = @ord_date
    WHERE ord_id = @ord_id
END; 
GO

IF (OBJECT_ID('UpdateMisteryBagDetailed') IS NOT NULL)
  DROP PROCEDURE UpdateMisteryBagDetailed;
GO

CREATE PROCEDURE UpdateMisteryBagDetailed
    @mysbd_id INT,
	@mysb_id INT,               
    @mysbd_content VARCHAR(50), 
    @mysbd_total_value MONEY,   
    @mysbd_status BIT           
AS
BEGIN
    UPDATE MisteryBagsDetailed SET
        mysb_id = @mysb_id, 
        mysbd_content = @mysbd_content, 
        mysbd_total_value = @mysbd_total_value, 
        mysbd_status = @mysbd_status
    WHERE mysbd_id = @mysbd_id
END;
GO

IF (OBJECT_ID('UpdateMysteryBag') IS NOT NULL)
  DROP PROCEDURE UpdateMysteryBag;
GO

CREATE PROCEDURE UpdateMysteryBag
    @mysb_id INT,
	@mysb_name VARCHAR(150),
    @mysb_description VARCHAR(250),
    @mysb_items TINYINT,
    @mysb_status BIT
AS
BEGIN
    UPDATE MysteryBags SET mysb_name = @mysb_name, mysb_description = @mysb_description, mysb_items = @mysb_items, mysb_status = @mysb_status
    WHERE mysb_id = @mysb_id  
END; 
GO

IF (OBJECT_ID('UpdateInvoice') IS NOT NULL)
  DROP PROCEDURE UpdateInvoice;
GO

CREATE PROCEDURE UpdateInvoice
    @invc_id INT,
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
    UPDATE Invoice SET
        paym_id = @paym_id, usr_id = @usr_id, invc_orders = @invc_orders, invc_subtotal = @invc_subtotal, invc_discount = @invc_discount, invc_total = @invc_total, invc_date = @invc_date, invc_status = @invc_status
    WHERE invc_id = @invc_id
END; 
GO

IF (OBJECT_ID('UpdateInventory') IS NOT NULL)
  DROP PROCEDURE UpdateInventory;
GO

CREATE PROCEDURE UpdateInventory
    @inv_id INT,
	@prod_id INT,
    @inv_quantity TINYINT,
    @usr_id INT,
    @inv_mod_date DATETIME,
    @inv_state BIT
AS
BEGIN
    UPDATE Inventory SET
        prod_id = @prod_id, 
        inv_quantity = @inv_quantity, 
		usr_id = @usr_id,
        inv_mod_date = @inv_mod_date, 
        inv_state = @inv_state
    WHERE inv_id = @inv_id
END; 
GO

IF (OBJECT_ID('UpdateExpenseType') IS NOT NULL)
  DROP PROCEDURE UpdateExpenseType;
GO

CREATE PROCEDURE UpdateExpenseType 
    @expt_id INT,
	@expt_name VARCHAR(150),
    @expt_description VARCHAR(250),
    @expt_frequency TINYINT,
    @expt_priority TINYINT
AS
BEGIN
    UPDATE ExpensesTypes SET
        expt_name = @expt_name,
        expt_description = @expt_description,
        expt_frequency = @expt_frequency,
        expt_priority = @expt_priority
    WHERE expt_id = @expt_id
END; 
GO

IF (OBJECT_ID('UpdateExpense') IS NOT NULL)
  DROP PROCEDURE UpdateExpense;
GO

CREATE PROCEDURE UpdateExpense 
    @exp_id INT,
    @expt_id INT,
    @exp_description VARCHAR(250),
    @exp_amount MONEY,
    @exp_method VARCHAR(15),
    @exp_date DATE
AS
BEGIN
    UPDATE Expenses SET
        expt_id = @expt_id, 
        exp_description = @exp_description, 
        exp_amount = @exp_amount, 
        exp_method = @exp_method, 
        exp_date = @exp_date
    WHERE exp_id = @exp_id
END; 
GO