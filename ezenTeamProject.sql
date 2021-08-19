/**
 *  MEMBER
 */
CREATE TABLE member (
userId VARCHAR2(30) PRIMARY KEY,
userPw CHAR(60) NOT NULL,
userName VARCHAR2(25) NOT NULL,
userEmail VARCHAR2(60) NOT NULL,
userBirthday VARCHAR2(10) NOT NULL,
userAddress VARCHAR2(600) NOT NULL,
userRegdate DATE DEFAULT SYSDATE,
userUpdatedate DATE DEFAULT SYSDATE,
userGrade NUMBER DEFAULT 1
)

/**
 * PRODUCT
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

/**
 *  PRODUCT STOCK
 */
CREATE TABLE prod_stock (
prodName VARCHAR2(500),
prodStockSSize NUMBER DEFAULT 0,
prodStockMSize NUMBER DEFAULT 0,
prodStockLSize NUMBER DEFAULT 0,
CONSTRAINT fk_prodStock_prodStockName FOREIGN KEY(prodName) REFERENCES product(prodName)
ON DELETE CASCADE
)

/**
 *  ATTACH FILE
 */
CREATE TABLE prod_attach (
prodAttProdImg VARCHAR2(500),
prodAttBno NUMBER,
prodAttPreBno NUMBER,
prodAttRegdate DATE DEFAULT SYSDATE,
CONSTRAINT fk_prod_attach_prodAttBno FOREIGN KEY(prodAttBno) REFERENCES product(prodBno)
ON DELETE CASCADE
)


/**
 *  CART
 */
CREATE TABLE cart(
    cartNo NUMBER primary key,
    userId VARCHAR2(30) not null,
    prodName VARCHAR2(500) not null,
    prodSize VARCHAR2(10),
    amount NUMBER default 0,
    constraint fk_cart_userid FOREIGN KEY(userId) REFERENCES member(userId) ON DELETE CASCADE,
    FOREIGN KEY(prodName) REFERENCES product(prodName)
    ON DELETE CASCADE
)

/**
 *  ORDER
 */
CREATE TABLE prod_order (
orderNum NUMBER PRIMARY KEY,
orderProdName VARCHAR2(100) NOT NULL,
orderProdPrice NUMBER NOT NULL,
orderProdQuantity NUMBER NOT NULL,
orderProdSize varchar2(20),
orderUserId VARCHAR2 (30) NOT NULL,
orderUserAddress VARCHAR2 (600) NOT NULL,
orderProdStatus NUMBER,
orderTrackingNum NUMBER,
CONSTRAINT fk_order_oderUserId FOREIGN KEY(orderUserId) REFERENCES member(userId)
)

/**
 * PAYMENT
 */
CREATE TABLE kpay(
tid VARCHAR2(200),
onum NUMBER,
orderId VARCHAR2(50),
tno NUMBER
)

/**
 *  QNA
 */
CREATE TABLE qna (

qQno NUMBER PRIMARY KEY,
qBno NUMBER NOT NULL,
qTitle VARCHAR2(50) NOT NULL,
qWriter VARCHAR2(30) NOT NULL,
qContent VARCHAR2(300) NOT NULL,
qPassword VARCHAR2(60) NOT NULL,
qRegdate DATE DEFAULT SYSDATE,
qUpdatedate DATE DEFAULT SYSDATE,
qReproot NUMBER DEFAULT 0,
qRepstep NUMBER DEFAULT 0,
qRepindent NUMBER DEFAULT 0,
qUserId VARCHAR2(30),

CONSTRAINT fk_qna_qBno FOREIGN KEY(qBno) REFERENCES product(prodBno)
ON DELETE CASCADE
)

/**
 *  REVIEW
 */
CREATE TABLE review (
reRno NUMBER PRIMARY KEY,
reBno NUMBER NOT NULL ,
reWriter VARCHAR2(30) NOT NULL ,
reContent VARCHAR2(2000) NOT NULL ,
reRegdate DATE DEFAULT SYSDATE ,
reUpdatedate DATE DEFAULT SYSDATE ,
reStar NUMBER NOT NULL,
CONSTRAINT review_fk_reBno FOREIGN KEY(reBno) REFERENCES product(prodBno)
ON DELETE CASCADE
)
