REM   Script: Project Phase 3 
REM   Project Phase 3 

CREATE TABLE AVAILABILITY ( 
 
DayofWeek INT, 
 
Constraint availability_pk PRIMARY KEY (DayofWeek) 
 
);

CREATE TABLE STATUS ( 
 
Statusid INT NOT NULL, 
 
Statusname VARCHAR(255) UNIQUE, 
 
Constraint status_pk PRIMARY KEY (Statusid) 
 
);

CREATE TABLE CUSTOMER ( 
 
CustomerId INT NOT NULL, 
 
Password VARCHAR(255) NOT NULL, 
 
CustomerName VARCHAR(255), 
 
Language VARCHAR(255), 
 
MobilePhone VARCHAR(255) UNIQUE, 
 
Email VARCHAR(255) UNIQUE, 
 
Constraint customer_pk PRIMARY KEY (CustomerId) 
 
);

CREATE TABLE RESTAURANT ( 
 
RUberID INT, 
 
RestaurantEmail VARCHAR(255) NOT NULL UNIQUE, 
 
Password VARCHAR(255), 
 
Mobilenumber VARCHAR(255) UNIQUE, 
 
Name VARCHAR(255) UNIQUE, 
 
Address VARCHAR(255), 
 
numlocations INT, 
 
ContractStatus VARCHAR(255), 
 
Constraint restaurant_pk PRIMARY KEY (RUberID) 
 
);

CREATE TABLE DELIVERYPERSON ( 
 
DPId INT NOT NULL, 
 
DPName VARCHAR(255), 
 
DPEmail VARCHAR(255) UNIQUE, 
 
DPPhone VARCHAR(255) UNIQUE, 
 
DPAdress VARCHAR(255), 
 
IDDetails VARCHAR(255), 
 
IDProofType VARCHAR(255), 
 
DPCheck NUMBER(1) CHECK (DPCheck IN (0, 1)), 
 
AccountStatus VARCHAR(255), 
 
Constraint dp_pk PRIMARY KEY (DPId) 
 
);

CREATE TABLE CUSTOMISATION ( 
 
CustomisationId INT, 
 
Limit INT, 
 
Details VARCHAR(255), 
 
Constraint customisation_pk PRIMARY KEY (CustomisationId) 
 
);

CREATE TABLE RECEIPT ( 
 
ReceiptId INT NOT NULL, 
 
MenuCost DECIMAL(10, 2), 
 
DelFee DECIMAL(10, 2), 
 
SerFee DECIMAL(10, 2), 
 
OtherFees DECIMAL(10, 2), 
 
Discount DECIMAL(10, 2), 
 
Constraint receipt_pk PRIMARY KEY (ReceiptId) 
 
);

CREATE TABLE CATEGORIES ( 
 
RUBERID INT, 
 
CategoryName VARCHAR(255), 
 
Constraint categories_pk PRIMARY KEY (RUBERID, CategoryName) 
 
);

CREATE TABLE MENU ( 
 
  MenuId INT NOT NULL, 
 
  MenuName VARCHAR(255) NOT NULL UNIQUE, 
 
  MenuDescription VARCHAR(255), 
 
  MenuHours VARCHAR(255), 
 
  RUBERID INT, 
 
  CategoryName VARCHAR(255), 
 
  RUberID2 INT, 
 
  Constraint menu_pk PRIMARY KEY (MenuId), 
 
  Constraint RUBerID2_fk FOREIGN KEY (RUBerID2) REFERENCES RESTAURANT(RUberID), 
 
  Constraint CategoryName_fk FOREIGN KEY (RUBERID, CategoryName) REFERENCES CATEGORIES(RUBERID, CategoryName) 
 
);

CREATE TABLE MENUITEMS ( 
 
  MenuItemName VARCHAR(255) NOT NULL UNIQUE, 
 
  MenuId INT, 
 
  Description VARCHAR(255), 
 
  Price DECIMAL(10, 2), 
 
  Taxrate DECIMAL(5, 2), 
 
  DietaryPref VARCHAR(255), 
 
  AvStatus VARCHAR(255), 
 
  Image BLOB, 
 
  
 
  CustomisationId INT, 
 
  Constraint menuitems_pk PRIMARY KEY (MenuItemName, MenuId), 
 
  Constraint MenuID_fk FOREIGN KEY (MenuId) REFERENCES MENU(MenuId), 
 
  Constraint CustomisationId_fk FOREIGN KEY (CustomisationId) REFERENCES CUSTOMISATION(CustomisationId) 
 
);

CREATE TABLE PROMOCODE ( 
 
  PromoCodeId INT NOT NULL, 
 
  Status VARCHAR(255) NOT NULL, 
 
  DiscountDetails VARCHAR(255), 
 
  CustomerId INT, 
 
  Constraint PromoCodeId_pk PRIMARY KEY (PromoCodeId), 
 
  Constraint CustomerId_fk FOREIGN KEY (CustomerId) REFERENCES CUSTOMER(CustomerId) 
 
);

CREATE TABLE DELIVERYADDRESS ( 
 
AddressId INT NOT NULL, 
 
Address VARCHAR(255), 
 
CustomerId INT, 
 
Constraint deliveryaddress_pk PRIMARY KEY (AddressId), 
 
Constraint CustomerIddel_fk FOREIGN KEY (CustomerId) REFERENCES CUSTOMER(CustomerId) 
 
);

CREATE TABLE PAYMENTOPTION ( 
 
POId INT NOT NULL, 
 
POType VARCHAR(255) NOT NULL, 
 
Pay_details VARCHAR(255), 
 
ExpirationDate DATE, 
 
IsPrimary NUMBER(1) CHECK (IsPrimary IN (0, 1)) NOT NULL, 
 
CustomerId INT, 
 
Constraint paymentoption_pk PRIMARY KEY (POId), 
 
Constraint CustomerIdpo_fk FOREIGN KEY (CustomerId) REFERENCES CUSTOMER(CustomerId) 
 
);

CREATE TABLE CART ( 
 
CartId INT NOT NULL, 
 
CustomerId INT, 
 
Constraint cart_pk PRIMARY KEY (CartId), 
 
Constraint CustomerIdcart_fk FOREIGN KEY (CustomerId) REFERENCES CUSTOMER(CustomerId) 
 
);

CREATE TABLE CUSTOMATISATIONOPTION ( 
 
CustName VARCHAR(255) NOT NULL UNIQUE, 
 
CustomisationId INT NOT NULL UNIQUE, 
 
Cost DECIMAL(10, 2) NOT NULL, 
 
Constraint custopt_pk PRIMARY KEY (CustName, CustomisationId), 
 
Constraint CustomisationIdcop_fk FOREIGN KEY (CustomisationId) REFERENCES CUSTOMISATION(CustomisationId) 
 
  
 
);

CREATE TABLE ORDERS ( 
 
  OrderId INT NOT NULL, 
 
  DeliveryOption VARCHAR(255) NOT NULL, 
 
  PaymentMethod VARCHAR(255) NOT NULL, 
 
  Instructions VARCHAR(255), 
 
  DateOrder DATE NOT NULL, 
 
  EstimatedDelTime TIMESTAMP, 
 
  EstimatedPickupTime TIMESTAMP, 
 
  Statusid INT NOT NULL, 
 
  DeliveryAddress INT NOT NULL, 
 
  PromoCodeId INT, 
 
  IsCancelled NUMBER(1) CHECK (IsCancelled IN (0, 1)), 
 
  PickupAddress INT, 
 
  POId INT, 
 
  RUberID INT, 
 
  CartId INT, 
 
  Constraint order_pk PRIMARY KEY (OrderId), 
 
  Constraint AddressId_fk FOREIGN KEY (DeliveryAddress) REFERENCES DELIVERYADDRESS (AddressId), 
 
  Constraint PromoCodeId_fk FOREIGN KEY (PromoCodeId) REFERENCES PROMOCODE(PromoCodeId), 
 
  Constraint Statusid_fk FOREIGN KEY (Statusid) REFERENCES STATUS(Statusid), 
 
  Constraint POId_fk FOREIGN KEY (POId) REFERENCES PAYMENTOPTION(POId), 
 
  Constraint RUberID_fk FOREIGN KEY (RUberID) REFERENCES RESTAURANT(RUberID), 
 
  Constraint CartId_fk FOREIGN KEY (CartId) REFERENCES CART(CartId) 
 
);

CREATE TABLE SCHEDULEDDELIVERY ( 
 
  Id INT NOT NULL, 
 
  DeliveryDate DATE NOT NULL, 
 
  DeliveryTime TIMESTAMP NOT NULL, 
 
  OrderId INT NOT NULL, 
 
  Constraint sd_pk PRIMARY KEY (Id), 
 
  Constraint order_idsd_fk FOREIGN KEY (OrderId) REFERENCES  ORDERS (OrderId) 
 
);

CREATE TABLE R_WPAYMENT ( 
 
  RPayID INT NOT NULL, 
 
  PayDate DATE NOT NULL, 
 
  Pay DECIMAL(10, 2), 
 
  Uberfees DECIMAL(10, 2), 
 
  RUberID INT, 
 
  Constraint rwpayment_pk PRIMARY KEY (RPayID), 
 
  Constraint RUberIDrw_fk FOREIGN KEY (RUberID) REFERENCES RESTAURANT(RUberID) 
 
);

CREATE TABLE D_WPAYMENT ( 
 
  DPayID INT NOT NULL, 
 
  PayDate DATE NOT NULL, 
 
  Pay DECIMAL(10, 2), 
 
  DPid INT, 
 
  Constraint dqpayment_pk PRIMARY KEY (DPayID), 
 
  Constraint DPid_fk FOREIGN KEY (DPid) REFERENCES DELIVERYPERSON(DPId) 
 
);

CREATE TABLE MARKETINGCOMM ( 
 
Commid INT NOT NULL, 
 
MC_details VARCHAR(255) NOT NULL, 
 
CustomerId INT, 
 
Constraint marketingcomm_pk PRIMARY KEY (Commid), 
 
Constraint CustomerIdmk_fk FOREIGN KEY (CustomerId) REFERENCES CUSTOMER(CustomerId) 
 
);

CREATE TABLE FEEDBACKS ( 
 
FeedbackId INT NOT NULL, 
 
Rating INT NOT NULL, 
 
Comments VARCHAR(255), 
 
ForWhom VARCHAR(255), 
 
ByWhom VARCHAR(255), 
 
OrderId INT, 
 
Constraint feedback_pk PRIMARY KEY (FeedbackId), 
 
Constraint OrderIdfb_fk FOREIGN KEY (OrderId) REFERENCES ORDERS(OrderId) 
 
);

CREATE TABLE INCLUDETB ( 
 
OrderId INT, 
 
ReceiptId INT, 
 
Constraint include_pk PRIMARY KEY (OrderId, ReceiptId), 
 
Constraint OrderIdinc_fk FOREIGN KEY (OrderId) REFERENCES ORDERS(OrderId), 
 
Constraint ReceiptIdinc_fk FOREIGN KEY (ReceiptId) REFERENCES RECEIPT(ReceiptId) 
 
);

CREATE TABLE GIVES_PROMO ( 
 
OrderId INT, 
 
PromoCodeId INT, 
 
Constraint givespromo_pk PRIMARY KEY (OrderId, PromoCodeId), 
 
Constraint OrderIdgp_fk FOREIGN KEY (OrderId) REFERENCES ORDERS(OrderId), 
 
Constraint PromoCodeIdgp_fk FOREIGN KEY (PromoCodeId) REFERENCES PROMOCODE(PromoCodeId) 
 
);

CREATE TABLE GETSORDER ( 
 
OrderId INT, 
 
DPayID INT, 
 
Constraint getsorder_pk PRIMARY KEY (OrderId, DPayID), 
 
Constraint OrderIdgo_fk FOREIGN KEY (OrderId) REFERENCES ORDERS(OrderId), 
 
Constraint DPayIDgo_fk FOREIGN KEY (DPayID) REFERENCES D_WPAYMENT(DPayID) 
 
);

CREATE TABLE HAS ( 
 
OrderId INT, 
 
Statusid INT, 
 
DateHas DATE, 
 
ByWhom VARCHAR(255), 
 
CommentHas VARCHAR(255),   
 
Constraint has_pk PRIMARY KEY (OrderId, Statusid), 
 
Constraint OrderIdhas_fk FOREIGN KEY (OrderId) REFERENCES ORDERS (OrderId), 
 
Constraint Statusidhas_fk FOREIGN KEY (Statusid) REFERENCES STATUS(Statusid) 
 
);

CREATE TABLE CALL ( 
 
CustomerId INT, 
 
DPayID INT, 
 
DurationCall INT, 
 
DateCall DATE, 
 
Constraint call_pk PRIMARY KEY (CustomerId, DPayID), 
 
Constraint CustomerIdcall_fk FOREIGN KEY (CustomerId) REFERENCES CUSTOMER(CustomerId), 
 
Constraint DPayID_fk FOREIGN KEY (DPayID) REFERENCES DELIVERYPERSON(DPId) 
 
);

CREATE TABLE SELECTS ( 
 
CartId INT, 
 
MenuItemName VARCHAR(255), 
 
MenuId INT, 
 
Constraint selects_pk PRIMARY KEY (CartId, MenuItemName, MenuId), 
 
Constraint CartIdselects_fk FOREIGN KEY (CartId) REFERENCES CART(CartId), 
 
Constraint menuitemsselects_fk FOREIGN KEY (MenuItemName, MenuId) REFERENCES MENUITEMS(MenuItemName, MenuId) 
 
      
 
);

CREATE TABLE SELECTED ( 
 
CartId INT, 
 
CustName VARCHAR(255), 
 
CustomisationId INT, 
 
MenuItemName VARCHAR(255), 
 
MenuId INT, 
 
Constraint selected_pk PRIMARY KEY (CartId, CustName, CustomisationId), 
 
Constraint CartIdsel_fk FOREIGN KEY (CartId) REFERENCES CART(CartId), 
 
Constraint custoptsel_fk FOREIGN KEY (CustName, CustomisationId) REFERENCES CUSTOMATISATIONOPTION(CustName, CustomisationId), 
 
Constraint menuitemssel_fk FOREIGN KEY (MenuItemName, MenuId) REFERENCES MENUITEMS(MenuItemName, MenuId) 
 
);

CREATE TABLE AVAILABLE ( 
 
MenuId INT, 
 
DayofWeek INT, 
 
Constraint available_pk PRIMARY KEY (MenuId, DayofWeek), 
 
Constraint menu_fk FOREIGN KEY (MenuId) REFERENCES MENU(MenuId), 
 
Constraint DayofWeek_fk FOREIGN KEY (DayofWeek) REFERENCES AVAILABILITY(DayofWeek) 
 
);

--TRIGGERS
--Adding a new user receipt/order cost in receipt table when order is delivered.
CREATE OR REPLACE TRIGGER add_new_user_receipt_cost_trg
AFTER UPDATE ON ORDERS
FOR EACH ROW
WHEN (NEW.Statusid = 3) -- Assuming 3 represents status "delivered"
DECLARE
    menuCost NUMBER(10, 2);
    delFee NUMBER(10, 2) := 5.00;
    serFee NUMBER(10, 2) := 2.00;
    otherFees NUMBER(10, 2) := 3.00;
    discount NUMBER(10, 2) := 10.00;
BEGIN
    SELECT SUM(Price) INTO menuCost FROM MENUITEMS WHERE MenuId = :NEW.OrderId;
    
    INSERT INTO RECEIPT (MenuCost, DelFee, SerFee, OtherFees, Discount)
    VALUES (menuCost, delFee, serFee, otherFees, discount);
END;
/

--Not allowing deletion of primary payment option.
CREATE OR REPLACE TRIGGER prevent_deletion_ppo_trg
BEFORE DELETE ON PAYMENTOPTION
FOR EACH ROW
WHEN (OLD.isPrimary = 1)
BEGIN
    RAISE_APPLICATION_ERROR(-20150, 'Deletion of primary payment option is not allowed.');
END;



--updating the promotion code status to redeemed once order is delivered.
CREATE OR REPLACE TRIGGER update_promocode_status_trg
AFTER UPDATE ON ORDERS
FOR EACH ROW
WHEN (NEW.Statusid = 3) 

DECLARE
  v_PromoCodeId INT;

BEGIN
  IF (:NEW.PromoCodeId IS NOT NULL) THEN
    SELECT PromoCodeId
    INTO v_PromoCodeId
    FROM ORDERS
    WHERE OrderId = :NEW.OrderId;

    UPDATE PROMOCODE
    SET Status = 'redeemed'
    WHERE PromoCodeId = v_PromoCodeId;
  END IF;
END;
/


