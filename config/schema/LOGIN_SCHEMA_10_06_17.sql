DROP TABLE IF EXISTS address;
DROP TABLE IF EXISTS role;
DROP TABLE IF EXISTS member_list;
DROP TABLE IF EXISTS user_email_list;
DROP TABLE IF EXISTS retailer_seq;
DROP TABLE IF EXISTS retailer_details;
DROP TABLE IF EXISTS wholeseller_seq;
DROP TABLE IF EXISTS wholeseller_details;
DROP TABLE IF EXISTS supplier_seq;
DROP TABLE IF EXISTS supplier_details;
DROP TABLE IF EXISTS admin_seq;
DROP TABLE IF EXISTS admin_details;
DROP TABLE IF EXISTS login;
DROP TABLE IF EXISTS footwear_inventory;

CREATE TABLE member_list
(
member_id VARCHAR(10) NOT NULL PRIMARY KEY
);

CREATE TABLE user_email_list
(
email_id VARCHAR(30) NOT NULL PRIMARY KEY
);

CREATE TABLE address
(
address_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
line1 VARCHAR(100),
line2 VARCHAR(100),
line3 VARCHAR(100),
city VARCHAR(30) NOT NULL,
state VARCHAR(30) NOT NULL,
country VARCHAR(30) NOT NULL
);

CREATE TABLE role
(
role_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
role_name VARCHAR(30) NOT NULL,
home_link VARCHAR(50) NOT NULL,
table_name VARCHAR(30) NOT NULL
);

CREATE TABLE retailer_seq
(
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE retailer_details
(
id VARCHAR(10) NOT NULL PRIMARY KEY REFERENCES member_list(member_id),
email_id VARCHAR(50) NOT NULL UNIQUE REFERENCES user_email_list(email_id),
name VARCHAR(30) NOT NULL,
firm_name VARCHAR(30) NOT NULL,
address_id INT NOT NULL REFERENCES address(address_id),
contact_no BIGINT(10) NOT NULL,
tin_no VARCHAR(11) UNIQUE,
cin_no VARCHAR(21) UNIQUE,
gstin_no VARCHAR(20) UNIQUE
);

DELIMITER $$
CREATE TRIGGER tg_retailer_insert
BEFORE INSERT ON retailer_details
FOR EACH ROW
BEGIN
  INSERT INTO retailer_seq VALUES (NULL);
  SET NEW.id = CONCAT('RT', LAST_INSERT_ID());
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER tg_member_list_insert_retailer
AFTER INSERT ON retailer_details
FOR EACH ROW
BEGIN
  INSERT INTO member_list VALUES (New.id);
  INSERT INTO user_email_list VALUES (New.email_id);
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER tg_member_list_delete_retailer
AFTER DELETE ON retailer_details
FOR EACH ROW
BEGIN
  DELETE FROM member_list where member_list.member_id=OLD.id;
  DELETE FROM user_email_list where user_email_list.email_id=OLD.email_id;
END$$
DELIMITER ;

CREATE TABLE wholeseller_seq
(
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE wholeseller_details
(
id VARCHAR(10) NOT NULL PRIMARY KEY REFERENCES member_list(member_id),
email_id VARCHAR(50) NOT NULL UNIQUE REFERENCES user_email_list(email_id),
name VARCHAR(30) NOT NULL,
firm_name VARCHAR(30) NOT NULL,
address_id INT NOT NULL REFERENCES address(address_id),
contact_no BIGINT(10) NOT NULL,
tin_no VARCHAR(11) UNIQUE,
cin_no VARCHAR(21) UNIQUE,
gstin_no VARCHAR(20) UNIQUE
);

DELIMITER $$
CREATE TRIGGER tg_wholeseller_insert
BEFORE INSERT ON wholeseller_details
FOR EACH ROW
BEGIN
  INSERT INTO wholeseller_seq VALUES (NULL);
  SET NEW.id = CONCAT('WH', LAST_INSERT_ID());
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER tg_member_list_insert_wholeseller
AFTER INSERT ON wholeseller_details
FOR EACH ROW
BEGIN
  INSERT INTO member_list VALUES (New.id);
  INSERT INTO user_email_list VALUES (New.email_id);
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER tg_member_list_delete_wholeseller
AFTER DELETE ON wholeseller_details
FOR EACH ROW
BEGIN
  DELETE FROM member_list where member_list.member_id=OLD.id;
  DELETE FROM user_email_list where user_email_list.email_id=OLD.email_id;
END$$
DELIMITER ;

CREATE TABLE supplier_seq
(
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE supplier_details
(
id VARCHAR(10) NOT NULL PRIMARY KEY REFERENCES member_list(member_id),
email_id VARCHAR(50) NOT NULL UNIQUE REFERENCES user_email_list(email_id),
name VARCHAR(30) NOT NULL,
firm_name VARCHAR(30) NOT NULL,
address_id INT NOT NULL REFERENCES address(address_id),
contact_no BIGINT(10) NOT NULL,
tin_no VARCHAR(11) UNIQUE,
cin_no VARCHAR(21) UNIQUE,
gstin_no VARCHAR(20) UNIQUE
);

DELIMITER $$
CREATE TRIGGER tg_supplier_insert
BEFORE INSERT ON supplier_details
FOR EACH ROW
BEGIN
  INSERT INTO supplier_seq VALUES (NULL);
  SET NEW.id = CONCAT('SP', LAST_INSERT_ID());
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER tg_member_list_insert_supplier
AFTER INSERT ON supplier_details
FOR EACH ROW
BEGIN
  INSERT INTO member_list VALUES (New.id);
  INSERT INTO user_email_list VALUES (New.email_id);
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER tg_member_list_delete_supplier
AFTER DELETE ON supplier_details
FOR EACH ROW
BEGIN
  DELETE FROM member_list where member_list.member_id=OLD.id;
  DELETE FROM user_email_list where user_email_list.email_id=OLD.email_id;
END$$
DELIMITER ;

CREATE TABLE admin_seq
(
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE admin_details
(
id VARCHAR(10) NOT NULL PRIMARY KEY REFERENCES member_list(member_id),
email_id VARCHAR(50) NOT NULL UNIQUE REFERENCES user_email_list(email_id),
name VARCHAR(30) NOT NULL,
firm_name VARCHAR(30) NOT NULL,
address_id INT NOT NULL REFERENCES address(address_id),
contact_no BIGINT(10) NOT NULL,
tin_no VARCHAR(11) UNIQUE,
cin_no VARCHAR(21) UNIQUE,
gstin_no VARCHAR(20) UNIQUE
);

DELIMITER $$
CREATE TRIGGER tg_admin_insert
BEFORE INSERT ON admin_details
FOR EACH ROW
BEGIN
  INSERT INTO admin_seq VALUES (NULL);
  SET NEW.id = CONCAT('AD', LAST_INSERT_ID());
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER tg_member_list_insert_admin
AFTER INSERT ON admin_details
FOR EACH ROW
BEGIN
  INSERT INTO member_list VALUES (New.id);
  INSERT INTO user_email_list VALUES (New.email_id);
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER tg_member_list_delete_admin
AFTER DELETE ON admin_details
FOR EACH ROW
BEGIN
  DELETE FROM member_list where member_list.member_id=OLD.id;
  DELETE FROM user_email_list where user_email_list.email_id=OLD.email_id;
END$$
DELIMITER ;

CREATE TABLE login
(
email_id VARCHAR(30) NOT NULL PRIMARY KEY REFERENCES user_email_list(email_id),
password VARCHAR(100) NOT NULL,
role_id INT NOT NULL REFERENCES role(role_id),
fl_flag CHAR(1) NOT NULL,
status CHAR(1) NOT NULL
);

DELIMITER $$
CREATE TRIGGER tg_store_md5_pass_new_user
BEFORE INSERT ON login
FOR EACH ROW
BEGIN
  SET New.password = MD5(New.password);
END$$
DELIMITER ;

CREATE TABLE footwear_inventory
(
barcode BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
prod_id VARCHAR(10) NOT NULL,
owner_id VARCHAR(10) NOT NULL REFERENCES member_list(member_id),
category VARCHAR(2) NOT NULL,
size_no INT NOT NULL,
price INT NOT NULL,
description VARCHAR(100),
color VARCHAR(20) NOT NULL,
in_date DATE NOT NULL
);

INSERT INTO address VALUES(NULL,'J-2/76','Vijay Nagar','Near M. G. School','Kanpur','Uttar Pradesh','India'),(NULL,'112/56','Agra Cannt',NULL,'Agra','Uttar Pradesh','India');

INSERT INTO admin_details VALUES(NULL,'palakmarwah11@gmail.com','Palak Marwah','Palyug Impex',1,8318380664,'09537543927',NULL,NULL);

INSERT INTO supplier_details VALUES(NULL,'mafootwear@gmail.com','Neel Gupta','M. A. Footwear',1,9876543210,'09537543927',NULL,NULL);

INSERT INTO role VALUES(NULL,'Admin','AdminHome.php','admin_details');

INSERT INTO login VALUES('palakmarwah11@gmail.com','yugs8994',1,'F','A');