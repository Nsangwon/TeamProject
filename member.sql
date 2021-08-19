DROP TABLE member
SELECT * FROM member

DELETE FROM member WHERE userId = 'dudwls4020'

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

CREATE TABLE product (

prodName VARCHAR2(500) PRIMARY KEY,
prodBno NUMBER UNIQUE,
prodCategory NUMBER NOT NULL,
prodTitle VARCHAR2(500) NOT NULL,
prodReadCnt NUMBER DEFAULT 0,
prodRegdate DATE DEFAULT SYSDATE,
prodUpdatedate DATE DEFAULT SYSDATE,
prodPrice NUMBER NOT NULL,
prodSalesCount NUMBER DEFAULT 0

)

CREATE TABLE prodStock (
prodStockName VARCHAR2(500),
prodStockSSzie NUMBER DEFAULT 0,
prodStockMSize NUMBER DEFAULT 0,
prodStockLSize NUMBER DEFAULT 0,
CONSTRAINT fk_prodStock_prodStockName FOREIGN KEY(prodStockName) REFERENCES product(prodName)
ON DELETE CASCADE
)


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


CREATE TABLE qna (

qQno NUMBER PRIMARY KEY,
qBno NUMBER NOT NULL,
qTitle VARCHAR2(50) NOT NULL,
qWriter VARCHAR2(30) NOT NULL,
qContent VARCHAR2(1000) NOT NULL,
qPassword VARCHAR2(60) NOT NULL,
qRegdate DATE DEFAULT SYSDATE,
qUpdatedate DATE DEFAULT SYSDATE,
qReproot NUMBER,
qRepstep NUMBER,
qRepindent NUMBER,
CONSTRAINT fk_qna_qBno FOREIGN KEY(qBno) REFERENCES product(prodBno)
ON DELETE CASCADE

)



CREATE TABLE attach (

attachFilename VARCHAR2(200) NOT NULL,
attachBno NUMBER,
attachRno NUMBER,
attachRegdate DATE DEFAULT SYSDATE

)

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
ALTER TABLE prod_order ADD orderProdStatus NUMBER;
ALTER TABLE prod_order ADD orderTrackingNum NUMBER;
drop table prod_order
x
INSERT INTO prod_order (orderNum, orderProdName, orderProdPrice, orderProdQuantity, orderProdSize, orderUserId, orderUserAddress, orderProdStatus, orderTrackingNum)
 values (1, 'bitcoin', 39800, 10, 0, 'm001', '��� ���̽� ������ �����ⱳ�� 16/�����Ѽ���',0,0)
delete from PROD_ORDER WHERE orderNum = 1
SELECT * from  prod_order

