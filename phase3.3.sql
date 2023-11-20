REM   Script: Phase3.3
REM   Phase3.3

INSERT INTO CUSTOMER (CustomerId, Password, CustomerName, Language, MobilePhone, Email) 
VALUES (1, 'pwd', 'Olivia', 'English', '5756757657', 'olga@mail.ru');

INSERT INTO CART (CartId, CustomerId) 
VALUES (1, 1);

INSERT INTO CATEGORIES (RUBERID, CategoryName) 
VALUES (12345, 'Main');

INSERT INTO MENU (MenuId, MenuName, MenuDescription, RUBERID, CategoryName) 
VALUES (1, 'Main Menu', 'fhfhfhgfh', 12345, 'Main');

INSERT INTO MENUITEMS (MenuItemName, MenuId, Description, Price) 
VALUES ('Pizza', 1, 'hgjdfgjhgfhjdf', 17.99);

INSERT INTO SELECTS (CartId, MenuItemName, MenuId) 
VALUES (1, 'Pizza', 1);

CREATE OR REPLACE PROCEDURE get_ordered_menu_items(p_customer_id IN CUSTOMER.CustomerId%TYPE) 
AS 
BEGIN 
  FOR menu_item IN ( 
    SELECT MENUITEMS.MenuItemName, MENUITEMS.Description, MENUITEMS.Price 
    FROM CUSTOMER  
    JOIN CART ON CUSTOMER.CustomerId = CART.CustomerId 
    JOIN SELECTS ON CART.CartId = SELECTS.CartId 
    JOIN MENUITEMS ON SELECTS.MenuItemName = MENUITEMS.MenuItemName AND SELECTS.MenuId = MENUITEMS.MenuId 
    WHERE CUSTOMER.CustomerId = p_customer_id 
  ) 
  LOOP 
     DBMS_OUTPUT.PUT_LINE('ORDERED ITEMS'); 
    DBMS_OUTPUT.PUT_LINE('Menu Item: ' || menu_item.MenuItemName); 
    DBMS_OUTPUT.PUT_LINE('Description: ' || menu_item.Description); 
    DBMS_OUTPUT.PUT_LINE('Price: ' || menu_item.Price); 
    
  END LOOP; 
END; 
/

SET SERVEROUTPUT ON


EXECUTE get_ordered_menu_items(1)


INSERT INTO AVAILABILITY (DayofWeek) VALUES (1);

INSERT INTO AVAILABILITY (DayofWeek) VALUES (2);

INSERT INTO STATUS (Statusid, Statusname) VALUES (1, 'Pending');

INSERT INTO STATUS (Statusid, Statusname) VALUES (2, 'In Progress');

INSERT INTO RESTAURANT (RUberID, RestaurantEmail, Password, Mobilenumber, Name, Address, numlocations, ContractStatus) 
VALUES (1, 'rest@mail.ru', 'pwd', '4354543', 'Italian', 'romilly street', 1, 'Active');

INSERT INTO DELIVERYPERSON (DPId, DPName, DPEmail, DPPhone, DPAdress, IDDetails, IDProofType, DPCheck, AccountStatus) 
VALUES (1, 'Alex', 'alex@mail.ru', '434334', 'Elizabeth Street', '454354', 'Driver License', 1, 'Active');

INSERT INTO PAYMENTOPTION (POId, POType, Pay_details, ExpirationDate, IsPrimary, CustomerId) 
VALUES (1, 'Credit Card', 'gfjghjgjgj', TO_DATE('2024-12-31', 'YYYY-MM-DD'), 1, 1);

INSERT INTO DELIVERYADDRESS (AddressId, Address, CustomerId) 
VALUES (1, 'fghfhg', 1);

INSERT INTO PROMOCODE (PromoCodeId, Status, DiscountDetails, CustomerId) 
VALUES (1, 'Active', 'ghjgjh', 1);

INSERT INTO ORDERS (OrderId, DeliveryOption, PaymentMethod, Instructions, DateOrder, EstimatedDelTime, EstimatedPickupTime, Statusid, DeliveryAddress, PromoCodeId, IsCancelled, PickupAddress, POId, RUberID, CartId) 
VALUES (1, 'Delivery', 'Credit Card', 'bjhgjgj', SYSDATE, TO_TIMESTAMP('2023-06-01 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-06-01 13:30:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 1, 1, 0, 1, 1, 1, 1);

INSERT INTO D_WPAYMENT (DPayID, PayDate, Pay, DPid) 
VALUES (1, TO_DATE('2023-05-31', 'YYYY-MM-DD'), 17.99, 1);

INSERT INTO GETSORDER (DPayID, OrderId) VALUES (1, 1);

COMMIT;

CREATE OR REPLACE PROCEDURE get_delivery_person_details( 
  p_OrderId IN ORDERS.OrderId%TYPE, 
  p_DeliveryPersonId OUT DELIVERYPERSON.DPId%TYPE, 
  p_DeliveryPersonName OUT DELIVERYPERSON.DPName%TYPE, 
  p_DeliveryPersonEmail OUT DELIVERYPERSON.DPEmail%TYPE, 
  p_DeliveryPersonPhone OUT DELIVERYPERSON.DPPhone%TYPE 
) AS 
BEGIN 
  SELECT DPId, DPName, DPEmail, DPPhone 
  INTO p_DeliveryPersonId, p_DeliveryPersonName, p_DeliveryPersonEmail, p_DeliveryPersonPhone 
  FROM DELIVERYPERSON 
  WHERE DPId = ( 
    SELECT DPayID 
    FROM GETSORDER 
    WHERE OrderId = p_OrderId 
  ); 
END; 
/

DECLARE 
  v_DeliveryPersonId DELIVERYPERSON.DPId%TYPE; 
  v_DeliveryPersonName DELIVERYPERSON.DPName%TYPE; 
  v_DeliveryPersonEmail DELIVERYPERSON.DPEmail%TYPE; 
  v_DeliveryPersonPhone DELIVERYPERSON.DPPhone%TYPE; 
 
BEGIN 
get_delivery_person_details(p_OrderId => 1, p_DeliveryPersonId => v_DeliveryPersonId, p_DeliveryPersonName => v_DeliveryPersonName, p_DeliveryPersonEmail => v_DeliveryPersonEmail, p_DeliveryPersonPhone => v_DeliveryPersonPhone); 
 
DBMS_OUTPUT.PUT_LINE('Delivery Person Details:'); 
DBMS_OUTPUT.PUT_LINE('ID: ' || v_DeliveryPersonId); 
DBMS_OUTPUT.PUT_LINE('Name: ' || v_DeliveryPersonName); 
DBMS_OUTPUT.PUT_LINE('Email: ' || v_DeliveryPersonEmail); 
DBMS_OUTPUT.PUT_LINE('Phone: ' || v_DeliveryPersonPhone); 
END; 
/

CREATE OR REPLACE FUNCTION get_customer_details(p_CustomerId IN CUSTOMER.CustomerId%TYPE) 
RETURN CUSTOMER%ROWTYPE 
AS 
  v_Customer CUSTOMER%ROWTYPE; 
BEGIN 
  SELECT * 
  INTO v_Customer 
  FROM CUSTOMER 
  WHERE CustomerId = p_CustomerId; 
   
  RETURN v_Customer; 
END; 
/

DECLARE 
  v_Customer CUSTOMER%ROWTYPE; 
BEGIN 
  v_Customer := get_customer_details(1); 
   
  DBMS_OUTPUT.PUT_LINE('Customer Details:'); 
  DBMS_OUTPUT.PUT_LINE('Customer ID: ' || v_Customer.CustomerId); 
  DBMS_OUTPUT.PUT_LINE('Customer Name: ' || v_Customer.CustomerName); 
  DBMS_OUTPUT.PUT_LINE('Language: ' || v_Customer.Language); 
  DBMS_OUTPUT.PUT_LINE('Mobile Phone: ' || v_Customer.MobilePhone); 
  DBMS_OUTPUT.PUT_LINE('Email: ' || v_Customer.Email); 
END; 
/

