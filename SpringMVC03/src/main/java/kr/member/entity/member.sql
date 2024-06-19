CREATE TABLE mem_tbl(
	memIdx int AUTO_INCREMENT,
	memID varchar(20) NOT NULL,
	memPassword varchar(20) NOT NULL,
	memName varchar(20)NOT NULL,
	memAge int,
	memGender varchar(20),
	memEmail varchar(50),
	memProfile varchar(50),
	primary key(memIdx)
);

DESCRIBE mem_tbl;
SELECT * FROM mem_tbl;


INSERT INTO mem_tbl(memID, memPassWord, memName, memAge, memGender, memEmail, memProfile)
VALUES('raphael', '4260', '신민기', 33, '남자', 'shinmingi0621@gmail.com', null);

commit;
SELECT * FROM mem_tbl WHERE memID = 'raphael' AND memPassWord = 'XX' OR 1=1 --' AND memName = '신민기';

