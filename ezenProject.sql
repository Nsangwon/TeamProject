/**
 *  MEMBER TABLE
 */
CREATE TABLE member (
userId VARCHAR2(30) PRIMARY KEY,
userPw VARCHAR2(50) NOT NULL,
userName VARCHAR2(25) NOT NULL,
userEmail VARCHAR2(60) NOT NULL,
userBirthday VARCHAR2(10) NOT NULL,
userAddress VARCHAR2(600) NOT NULL,
userRegdate DATE DEFAULT SYSDATE,
userUpdatedate DATE DEFAULT SYSDATE,
userGrade NUMBER DEFAULT 1
)

/**
 *  PRODUCT TABLE
 */
CREATE TABLE product (
prodName VARCHAR2(500) PRIMARY KEY,
prodBno NUMBER UNIQUE,
prodCategory VARCHAR2(50) NOT NULL,
prodTitle VARCHAR2(500) NOT NULL,
prodContent VARCHAR2(3000) NOT NULL,
prodReadCnt NUMBER DEFAULT 0,
prodRegdate DATE DEFAULT SYSDATE,
prodUpdatedate DATE DEFAULT SYSDATE,
prodPrice NUMBER NOT NULL,
prodSalesCount NUMBER DEFAULT 0,
prodThumbnail VARCHAR2(500) UNIQUE
)

DROP TABLE product

DELETE FROM product WHERE prodBno = 7

SELECT * FROM member

/**
 *  PRODUCT STOCK TABLE
 */
CREATE TABLE prod_stock (
prodName VARCHAR2(500),
prodStockSSize NUMBER DEFAULT 0,
prodStockMSize NUMBER DEFAULT 0,
prodStockLSize NUMBER DEFAULT 0,
CONSTRAINT fk_prodStock_prodStockName FOREIGN KEY(prodName) REFERENCES product(prodName)
ON DELETE CASCADE
)

SELECT * FROM prod_stock

DROP TABLE prod_stock

/**
 *  PRODUCT AND PRODCUTSTOCK 'S VIEW
 */
CREATE OR REPLACE VIEW v_product_s
AS
SELECT * FROM product prod, prodStock prodS

WHERE prod.prodName = prodS.prodName

WITH READ ONLY

DROP VIEW v_product_s

/**
 *  ATTACH FILE TABLE
 */
CREATE TABLE prod_attach (
prodAttProdImg VARCHAR2(500),
prodAttBno NUMBER,
prodAttPreBno NUMBER,
prodAttProdThumb VARCHAR2(500),
prodAttRegdate DATE DEFAULT SYSDATE,
CONSTRAINT fk_prod_attach_prodAttBno FOREIGN KEY(prodAttBno) REFERENCES product(prodBno)
ON DELETE CASCADE
)

SELECT * FROM prod_attach ORDER BY prodAttRegdate ASC
SELECT * FROM kpay
DELETE FROM kpay

UPDATE prod_attach SET prodAttBno = 1 WHERE prodAttPreBno = 1

DROP TABLE prod_attach

DELETE FROM prod_attach WHERE prodAttPreBno = 3

/**
 * THUMBNAIL VIEW
 */
CREATE OR REPLACE VIEW


DROP VIEW v_prod_thumbnail

