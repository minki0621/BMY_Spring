CREATE TABLE news (
	idx int NOT NULL AUTO_INCREMENT,
	title VARCHAR(100) NOT NULL,
	content VARCHAR(3000) NOT NULL,
	brand VARCHAR(100) NOT NULL,
	indate datetime DEFAULT NOW(),
	count int DEFAULT 0,
	PRIMARY KEY (idx)
);

INSERT INTO news (title, content, brand) 
VALUES ('스프링 어렵다고 소문..', '너무나 어렵다고 소문! 하지만 알고보니 너무나도 쉬운!', '한국 신문 ');
INSERT INTO news (title, content, brand) 
VALUES ('자바스크립트 어렵다고 소문..', '너무나 어렵다고 소문! 하지만 알고보니 너무나도 쉬운!', '프랑스 신문 ');
INSERT INTO news (title, content, brand) 
VALUES ('HTML 어렵다고 소문..', '너무나 어렵다고 소문! 하지만 알고보니 너무나도 쉬운!', '독일 신문 ');
INSERT INTO news (title, content, brand) 
VALUES ('CSS 어렵다고 소문..', '너무나 어렵다고 소문! 하지만 알고보니 너무나도 쉬운!', '미국 신');

COMMIT;

SELECT * FROM news ORDER BY idx DESC;
