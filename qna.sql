CREATE TABLE qna (

qQno NUMBER PRIMARY KEY,
qBno NUMBER NOT NULL,
qTitle VARCHAR2(50) NOT NULL,
qWriter VARCHAR2(30) NOT NULL,
qContent VARCHAR2(1000) NOT NULL,
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
select * from qna
CREATE SEQUENCE qna_seq
INCREMENT BY 1
START WITH 1
MAXVALUE 1000000000
NOCYCLE

DROP SEQUENCE qna_seq

ALTER TABLE qna MODIFY(qRepindent NUMBER DEFAULT 0);

ALTER TABLE qna ADD qUserId VARCHAR2(30);

INSERT INTO qna (qQno, qBno, qTitle, qWriter, qContent, qPassword, qReproot, qRepstep, qRepindent)
VALUES (1, 1, 'asdfasdf', 'BahMir', '내용입니다.내용입니다.내용입니다.내용입니다.내용입니다.내용입니다.내용입니다.내용입니다.내용입니다.내용입니다.내용입니다.', 'asdf1asdf', 0, 0, 0)

UPDATE qna SET qTitle = '[답변] 수정테스트', qContent = '수정 했습니다.', qUpdatedate = SYSDATE
WHERE qQno = 68 AND qWriter = 'admin'

DELETE FROM qna

DROP TABLE qna

SELECT * FROM qna

SELECT qPassword FROM qna WHERE qQno = 6

SELECT * FROM DBA_ROLE_PRIVS
WHERE GRANTEE = 'ezen200'


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