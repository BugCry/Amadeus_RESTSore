IF (OBJECT_ID('DeleteUser') IS NOT NULL)
  DROP PROCEDURE DeleteUser;
GO

CREATE PROCEDURE DeleteUser
    @usr_id INT,
	@usr_status BIT
AS
BEGIN
    -- UPDATE the WHERE the table
    UPDATE Users SET  usr_status = @usr_status
    WHERE usr_id = @usr_id
END;
GO

IF (OBJECT_ID('DeleteUserType') IS NOT NULL)
  DROP PROCEDURE DeleteUserType;
GO

;CREATE PROCEDURE DeleteUserType
    @usrt_id INT,
    @usrt_status BIT
AS
BEGIN
    -- UPDATE the table
    UPDATE UserTypes SET usrt_status = @usrt_status
    WHERE usrt_id = @usrt_id
END; 
GO

IF (OBJECT_ID('DeleteShipping') IS NOT NULL)
  DROP PROCEDURE DeleteShipping;
GO

CREATE PROCEDURE DeleteShipping
    @shp_id INT,
    @shp_last_date DATETIME,
    @shp_date DATETIME
AS
BEGIN
    UPDATE Shipping SET
        shp_last_date = @shp_last_date, 
        shp_date = @shp_date
    WHERE shp_id = @shp_id
END;
GO

IF (OBJECT_ID('DeleteSales') IS NOT NULL)
  DROP PROCEDURE DeleteSales;
GO

CREATE PROCEDURE DeleteSales
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

IF (OBJECT_ID('DeleteReview') IS NOT NULL)
  DROP PROCEDURE DeleteReview;
GO

CREATE PROCEDURE DeleteReview
    @rvw_id INT,
    @rvw_status BIT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Reviews SET rvw_status = @rvw_status
    WHERE rvw_id = @rvw_id
END;
GO

IF (OBJECT_ID('DeleteProductType') IS NOT NULL)
  DROP PROCEDURE DeleteProductType;
GO

CREATE PROCEDURE DeleteProductType
	@prodt_id INT,
    @prodt_status BIT
AS
BEGIN
    UPDATE ProductsTypes set
		prodt_status = @prodt_status
    WHERE prodt_id = @prodt_id
END; 
GO

IF (OBJECT_ID('DeleteProduct') IS NOT NULL)
  DROP PROCEDURE DeleteProduct;
GO

CREATE PROCEDURE DeleteProduct
    @prod_id INT,
    @prod_status BIT
AS
BEGIN
    UPDATE Products set
        prod_status = @prod_status
	where prod_id = @prod_id
END; 
GO

IF (OBJECT_ID('DeletePayment') IS NOT NULL)
  DROP PROCEDURE DeletePayment;
GO

CREATE PROCEDURE DeletePayment
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

IF (OBJECT_ID('DeleteOrder') IS NOT NULL)
  DROP PROCEDURE DeleteOrder;
GO

CREATE PROCEDURE DeleteOrder
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

IF (OBJECT_ID('DeleteMisteryBagDetailed') IS NOT NULL)
  DROP PROCEDURE DeleteMisteryBagDetailed;
GO

CREATE PROCEDURE DeleteMisteryBagDetailed
    @mysbd_id INT,
    @mysbd_status BIT           
AS
BEGIN
    UPDATE MisteryBagsDetailed SET
        mysbd_status = @mysbd_status
    WHERE mysbd_id = @mysbd_id
END;
GO

IF (OBJECT_ID('DeleteMysteryBag') IS NOT NULL)
  DROP PROCEDURE DeleteMysteryBag;
GO

CREATE PROCEDURE DeleteMysteryBag
    @mysb_id INT,
    @mysb_status BIT
AS
BEGIN
    UPDATE MysteryBags SET mysb_status = @mysb_status
    WHERE mysb_id = @mysb_id  
END; 
GO

IF (OBJECT_ID('DeleteInvoice') IS NOT NULL)
  DROP PROCEDURE DeleteInvoice;
GO

CREATE PROCEDURE DeleteInvoice
    @invc_id INT,
    @invc_status BIT
AS
BEGIN
    UPDATE Invoice SET
        invc_status = @invc_status
    WHERE invc_id = @invc_id
END; 
GO

IF (OBJECT_ID('DeleteInventory') IS NOT NULL)
  DROP PROCEDURE DeleteInventory;
GO

CREATE PROCEDURE DeleteInventory
    @inv_id INT,
    @inv_state BIT
AS
BEGIN
    UPDATE Inventory SET inv_state = @inv_state
    WHERE inv_id = @inv_id
END; 
GO

IF (OBJECT_ID('DeleteExpenseType') IS NOT NULL)
  DROP PROCEDURE DeleteExpenseType;
GO

CREATE PROCEDURE DeleteExpenseType 
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

IF (OBJECT_ID('DeleteExpense') IS NOT NULL)
  DROP PROCEDURE DeleteExpense;
GO

CREATE PROCEDURE DeleteExpense 
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