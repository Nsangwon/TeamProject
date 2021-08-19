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

SELECT cartNo, c.userId, p.prodName, p.prodPrice, p.prodThumbnail, prodSize, amount, 
		s.prodStockSSize, s.prodStockMSize, s.prodStockLSize
		FROM member m, product p, cart c, prod_stock s
		WHERE c.userId = 'dudwls4020' AND m.userId = c.userId AND c.prodName = s.prodName AND p.prodName = c.prodName
		ORDER BY cartNo DESC 

ALTER TABLE cart ADD Column prodSize
drop table prod_attach
drop table prod_stock
select * from cart

INSERT INTO product (prodName, prodBno, prodCategory, prodTitle, prodContent, prodPrice, prodThumbnail) 
VALUES ('test1', 1, 'food', 'asd', 'asd', '24500', 'abc.png')


INSERT INTO cart (cartNo, userId, prodName, prodSize, amount)
VALUES (1, 'm001', 'test1', 'S', 1)
