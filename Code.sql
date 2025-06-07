
-- Create and use the database
CREATE DATABASE IF NOT EXISTS `shkunch_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `shkunch_db`;

-- CUSTOMER Table
CREATE TABLE `CUSTOMER` (
  `CUST_ID` INT(5) NOT NULL,
  `CUST_NAME` VARCHAR(25),
  `CUST_EMAIL` VARCHAR(50),
  `CUST_PHONE` CHAR(12),
  `CUST_DOB` DATE,
  PRIMARY KEY (`CUST_ID`)
);

INSERT INTO `CUSTOMER` VALUES
(1, 'John Doe', 'john@example.com', '123-456-7890', '1990-05-15'),
(2, 'Jane Smith', 'jane@example.com', '987-654-3210', '1985-09-20'),
(3, 'Michael Johnson', 'michael@example.com', '456-789-0123', '1988-03-10'),
(4, 'Emily Brown', 'emily@example.com', '789-012-3456', '1995-11-28'),
(5, 'David Wilson', 'david@example.com', '012-345-6789', '1979-07-04');

-- CUSTOMER_ADDRESS Table
CREATE TABLE `CUSTOMER_ADDRESS` (
  `CUST_ADD_ID` INT(6) NOT NULL,
  `CUST_ID` INT(5),
  `CUST_ADD` VARCHAR(50),
  `CUST_DEFAULT` TINYINT(1),
  PRIMARY KEY (`CUST_ADD_ID`),
  FOREIGN KEY (`CUST_ID`) REFERENCES `CUSTOMER`(`CUST_ID`) ON DELETE CASCADE
);

INSERT INTO `CUSTOMER_ADDRESS` VALUES
(1, 1, '123 Main Street', 1),
(2, 1, '456 Elm Avenue', 0),
(3, 2, '789 Oak Lane', 1),
(4, 3, '101 Maple Road', 1),
(5, 4, '202 Pine Street', 1);

-- CUSTOMERCARE_INTERACTION Table
CREATE TABLE `CUSTOMERCARE_INTERACTION` (
  `INTER_ID` INT(5) NOT NULL,
  `CUST_ID` INT(5),
  `INTER_DATE` DATETIME,
  `INTER_DES` VARCHAR(100),
  `INTER_STATUS` TINYINT(1),
  PRIMARY KEY (`INTER_ID`),
  FOREIGN KEY (`CUST_ID`) REFERENCES `CUSTOMER`(`CUST_ID`) ON DELETE CASCADE
);

INSERT INTO `CUSTOMERCARE_INTERACTION` VALUES
(1, 1, '2024-04-27 10:30:00', 'Issue with order delivery', 0),
(2, 2, '2024-04-28 14:15:00', 'Inquiry about menu items', 1),
(3, 3, '2024-04-29 11:00:00', 'Complaint about food quality', 0),
(4, 4, '2024-04-30 09:45:00', 'Feedback on service', 1),
(5, 5, '2024-05-01 16:20:00', 'Request for refund', 0);

-- RESTAURANT Table
CREATE TABLE `RESTAURANT` (
  `REST_ID` INT(6) NOT NULL,
  `REST_NAME` VARCHAR(35),
  `REST_CUISINE` VARCHAR(35),
  `REST_RATING` DECIMAL(2,1),
  `REST_LOCATION` VARCHAR(50),
  `REST_OPENHRS` TIME,
  `REST_CLOSEHRS` TIME,
  PRIMARY KEY (`REST_ID`)
);

INSERT INTO `RESTAURANT` VALUES
(1, 'The Bistro', 'Italian', 4.5, '123 Main Street', '10:00:00', '22:00:00'),
(2, 'Sushi Palace', 'Japanese', 4.2, '456 Oak Avenue', '11:30:00', '23:00:00'),
(3, 'La Pizzeria', 'Italian', 4.3, '789 Elm Street', '12:00:00', '21:30:00'),
(4, 'Mama Mia Trattoria', 'Italian', 4.7, '567 Maple Avenue', '11:00:00', '22:30:00'),
(5, 'Taste of India', 'Indian', 4.4, '890 Walnut Street', '11:30:00', '23:00:00'),
(6, 'Chopsticks Chinese Cuisine', 'Chinese', 4.0, '234 Pine Street', '11:00:00', '22:00:00'),
(7, 'BBQ Shack', 'American', 4.6, '345 Cedar Avenue', '12:00:00', '20:00:00');

-- ORDER Table
CREATE TABLE `ORDER` (
  `ORDER_ID` INT(5) NOT NULL,
  `CUST_ID` INT(5),
  `REST_ID` INT(6),
  `ORDER_DATE` DATETIME,
  `ORDER_DELIVERY_ADD` VARCHAR(50),
  `ORDER_STATUS` VARCHAR(20),
  PRIMARY KEY (`ORDER_ID`),
  FOREIGN KEY (`CUST_ID`) REFERENCES `CUSTOMER`(`CUST_ID`) ON DELETE CASCADE,
  FOREIGN KEY (`REST_ID`) REFERENCES `RESTAURANT`(`REST_ID`) ON DELETE CASCADE
);

INSERT INTO `ORDER` VALUES
(1, 1, 1, '2024-04-27 12:30:00', '123 Oak Street', 'Delivered'),
(2, 2, 2, '2024-04-27 18:45:00', '456 Maple Avenue', 'In Progress'),
(3, 1, 2, '2024-04-28 11:15:00', '789 Elm Street', 'Pending'),
(4, 3, 3, '2024-04-28 14:00:00', '890 Pine Road', 'Delivered'),
(5, 4, 1, '2024-04-29 20:00:00', '567 Cedar Lane', 'Canceled');

-- Continue in next cell to avoid truncation


-- MENU_ITEM Table
CREATE TABLE `MENU_ITEM` (
  `MENUITEM_ID` INT(6) NOT NULL,
  `ORDER_ID` INT(5),
  `REST_ID` INT(6),
  `MENUITEM_NAME` VARCHAR(30),
  `MENUITEM_DES` VARCHAR(100),
  `MENUITEM_PRICE` DECIMAL(6,2),
  `MENUITEM_CTG` VARCHAR(20),
  PRIMARY KEY (`MENUITEM_ID`),
  FOREIGN KEY (`REST_ID`) REFERENCES `RESTAURANT`(`REST_ID`) ON DELETE CASCADE
);

INSERT INTO `MENU_ITEM` VALUES
(1, NULL, 1, 'Spaghetti Carbonara', 'Pasta with creamy sauce, pancetta, and Parmesan cheese', 12.99, 'Pasta'),
(2, NULL, 1, 'Margherita Pizza', 'Pizza with tomato sauce, mozzarella cheese, and fresh basil', 10.99, 'Pizza'),
(3, NULL, 2, 'Sashimi Platter', 'Assorted slices of raw fish', 24.99, 'Sashimi'),
(4, NULL, 2, 'California Roll', 'Sushi roll filled with avocado, cucumber, and crab meat', 8.99, 'Sushi'),
(5, NULL, 3, 'Chicken Alfredo', 'Pasta with grilled chicken and creamy Alfredo sauce', 14.99, 'Pasta');

-- ORDER_ITEM Table
CREATE TABLE `ORDER_ITEM` (
  `ORDERITEM_ID` INT(4) NOT NULL,
  `ORDER_ID` INT(5),
  `MENUITEM_ID` INT(6),
  `ORDERITEM_QUAN` INT(2),
  `ORDERITEM_PRICE` DECIMAL(6,2),
  PRIMARY KEY (`ORDERITEM_ID`),
  FOREIGN KEY (`ORDER_ID`) REFERENCES `ORDER`(`ORDER_ID`) ON DELETE CASCADE,
  FOREIGN KEY (`MENUITEM_ID`) REFERENCES `MENU_ITEM`(`MENUITEM_ID`) ON DELETE CASCADE
);

INSERT INTO `ORDER_ITEM` VALUES
(1345, 1, 1, 2, 25.98),
(1346, 2, 3, 1, 24.99),
(1362, 4, 5, 2, 29.98),
(1368, 1, 2, 1, 10.99),
(1392, 3, 1, 3, 38.97);

-- ORDER_ITEM_MENU_ITEM_BRIDGE Table
CREATE TABLE `ORDER_ITEM_MENU_ITEM_BRIDGE` (
  `ORDER_ID` INT(5) NOT NULL,
  `MENUITEM_ID` INT(6) NOT NULL,
  PRIMARY KEY (`ORDER_ID`, `MENUITEM_ID`),
  FOREIGN KEY (`ORDER_ID`) REFERENCES `ORDER`(`ORDER_ID`) ON DELETE CASCADE,
  FOREIGN KEY (`MENUITEM_ID`) REFERENCES `MENU_ITEM`(`MENUITEM_ID`) ON DELETE CASCADE
);

INSERT INTO `ORDER_ITEM_MENU_ITEM_BRIDGE` VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4),
(3, 5);

-- PAYMENT Table
CREATE TABLE `PAYMENT` (
  `PAY_ID` INT(5) NOT NULL,
  `ORDER_ID` INT(5),
  `PAY_AMOUNT` DECIMAL(6,2),
  `PAY_DATE` DATETIME,
  `PAY_METHOD` VARCHAR(20),
  PRIMARY KEY (`PAY_ID`),
  FOREIGN KEY (`ORDER_ID`) REFERENCES `ORDER`(`ORDER_ID`) ON DELETE CASCADE
);

INSERT INTO `PAYMENT` VALUES
(1, 1, 50.00, '2024-04-27 12:30:00', 'Credit Card'),
(2, 2, 65.75, '2024-04-28 10:15:00', 'PayPal'),
(3, 3, 40.00, '2024-04-29 14:20:00', 'Cash'),
(4, 4, 20.50, '2024-04-30 18:45:00', 'Debit Card'),
(5, 5, 75.25, '2024-05-01 20:00:00', 'Credit Card');

-- PROMOTION Table
CREATE TABLE `PROMOTION` (
  `PROM_ID` INT(5) NOT NULL,
  `ORDER_ID` INT(5),
  `PROM_CODE` VARCHAR(5),
  `PROM_DES` VARCHAR(25),
  `PROM_DISCOUNT` DECIMAL(4,2),
  `PROM_VALIDFR` DATE,
  `PROM_VALIDTO` DATE,
  PRIMARY KEY (`PROM_ID`),
  FOREIGN KEY (`ORDER_ID`) REFERENCES `ORDER`(`ORDER_ID`) ON DELETE CASCADE
);

INSERT INTO `PROMOTION` VALUES
(1, 1, 'SALE', '10% off', 10.00, '2024-04-27', '2024-05-10'),
(2, 2, 'DELIV', 'Free delivery', 0.00, '2024-04-27', '2024-05-05'),
(3, 3, 'SPRNG', '20% off', 20.00, '2024-04-28', '2024-05-15'),
(4, 4, 'WLCME', '$5 off', 5.00, '2024-04-28', '2024-05-31'),
(5, 5, 'FSIDE', 'Free side dish', 0.00, '2024-04-29', '2024-05-07');

-- REVIEW Table
CREATE TABLE `REVIEW` (
  `REVIEW_ID` INT(4) NOT NULL,
  `CUST_ID` INT(5),
  `REST_ID` INT(6),
  `REVIEW_COMMENT` VARCHAR(100),
  `REVIEW_DATE` DATE,
  PRIMARY KEY (`REVIEW_ID`),
  FOREIGN KEY (`CUST_ID`) REFERENCES `CUSTOMER`(`CUST_ID`) ON DELETE CASCADE,
  FOREIGN KEY (`REST_ID`) REFERENCES `RESTAURANT`(`REST_ID`) ON DELETE CASCADE
);

INSERT INTO `REVIEW` VALUES
(1, 1, 1, 'Great food and service!', '2024-04-27'),
(2, 2, 2, 'The sushi was fresh and delicious.', '2024-04-28'),
(3, 3, 3, 'Excellent ambiance and friendly staff.', '2024-04-29'),
(4, 4, 4, 'The pasta was a bit overcooked.', '2024-04-30'),
(5, 5, 5, 'Best curry I've ever had!', '2024-05-01');

-- DELIVERY_EXECUTIVE Table
CREATE TABLE `DELIVERY_EXECUTIVE` (
  `DELIVERYEXU_ID` INT(5) NOT NULL,
  `ORDER_ID` INT(5),
  `REST_ID` INT(6),
  `DELIVERYEXU_NAME` VARCHAR(20),
  `DELIVERYEXU_PHONE` CHAR(12),
  `DELIVERYEXU_LOCATION` VARCHAR(30),
  `DELIVERYEXU_AVAL` TINYINT(1),
  PRIMARY KEY (`DELIVERYEXU_ID`),
  FOREIGN KEY (`ORDER_ID`) REFERENCES `ORDER`(`ORDER_ID`) ON DELETE CASCADE,
  FOREIGN KEY (`REST_ID`) REFERENCES `RESTAURANT`(`REST_ID`) ON DELETE CASCADE
);

INSERT INTO `DELIVERY_EXECUTIVE` VALUES
(1, 1, 1, 'John Smith', '123-456-7890', '123 Oak Street', 1),
(2, 2, 2, 'Emily Johnson', '987-654-3210', '456 Maple Avenue', 1),
(3, 3, 1, 'Michael Brown', '789-012-3456', '789 Elm Street', 0),
(4, 4, 3, 'Sarah Wilson', '012-345-6789', '890 Pine Road', 1),
(5, 5, 4, 'David Miller', '234-567-8901', '567 Cedar Lane', 1);

-- Finalize
COMMIT;
