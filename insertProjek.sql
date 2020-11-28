
INSERT INTO Staff VALUES 
('SF001','Michael Russel','MichaelRussel@gmail.com','2000-05-05','Male','082113011703','JL.Budi Raya'),
('SF002','Mika Sello','MikaSello@gmail.com','2000-03-09','Female','082113078904','JL.Bina Raya'),
('SF003','Cael Maskul','CaelMaskul@gmail.com','1996-11-07','Male','083218911703','JL.Nusantara Merdeka'),
('SF004','Long Lesso','LongLesso@gmail.com','2000-04-17','Male','082109846703','JL.Ahmad Muli'),
('SF005','Jonathan Lolo','JonathanLolo@gmail.com','1999-02-12','Male','082213451703','JL.Nusantara Kita'),
('SF006','Russel Misa','RusselMisa@gmail.com','2000-04-05','Female','082110987503','JL.Bina Bidil'),
('SF007','Kevin Prima','KevinPrima@gmail.com','2000-06-01','Male','082113214503','JL.Bina Binasakan'),
('SF008','Cecil Windri','CecilWindri@gmail.com','1988-04-07','Male','081123011307','JL.Nusantara Sejahtra'),
('SF009','Sisil Ruri','SisilRuri@gmail.com','2000-04-15','Female','082301211723','JL.Bina Kuliah'),
('SF010','Michele Angeline','MicheleAngeline@gmail.com','1999-05-07','Female','082114011703','JL.Bina Bahasa')

INSERT INTO Movie Values
('MV001','Into The Unkown','International',120),
('MV002','Into The Deep','International',120),
('MV003','Wanita Jalang','National',130),
('MV004','Into The Ocean','International',99),
('MV005','Unkown Guest','National',120),
('MV006','Dilan','International',120),
('MV007','Xmas Life','National',120),
('MV008','Campus Trouble','International',100),
('MV009','Double Job','International',90),
('MV010','Fear in Dream','International',150)

INSERT INTO Studio Values
('ST001','Gold',60000),
('ST002','Gold',60000),
('ST003','Satin',50000),
('ST004','Satin',50000),
('ST005','Gold',60000),
('ST006','Gold',60000),
('ST007','Gold',60000),
('ST008','Red',45000),
('ST009','Red',45000),
('ST010','Gold',60000)

INSERT INTO ScheduleTransaction VALUES
('MS001','ST001','MV001','2019-12-12 15:05:20'),
('MS002','ST002','MV002','2019-12-12 15:03:20'),
('MS003','ST003','MV003','2019-12-12 15:32:20'),
('MS004','ST004','MV004','2019-12-12 15:12:20'),
('MS005','ST005','MV005','2019-12-12 16:05:20'),
('MS006','ST006','MV006','2019-12-12 15:05:20'),
('MS007','ST007','MV007','2019-12-12 14:05:20'),
('MS008','ST008','MV008','2019-12-12 13:05:20'),
('MS009','ST009','MV009','2019-12-12 12:05:20'),
('MS010','ST010','MV010','2019-12-12 15:05:20')

INSERT INTO HeaderMovieTransaction Values
('MTr001','SF001','2019-12-12'),
('MTr002','SF002','2019-12-12'),
('MTr003','SF003','2019-12-12'),
('MTr004','SF004','2019-12-12'),
('MTr005','SF005','2019-12-06'),
('MTr006','SF006','2019-12-03'),
('MTr007','SF007','2019-12-12'),
('MTr008','SF008','2019-12-13'),
('MTr009','SF009','2019-12-02'),
('MTr010','SF010','2019-12-09')


INSERT INTO DetailMovieTransaction Values
('MTr001','MS001','1'),
('MTr002','MS002','10'),
('MTr003','MS003','3'),
('MTr004','MS004','5'),
('MTr005','MS005','4'),
('MTr006','MS006','52'),
('MTr007','MS007','20'),
('MTr008','MS008','9'),
('MTr009','MS009','12'),
('MTr010','MS010','35')


INSERT INTO HeaderRefreshmentTransaction Values
('RTr001','SF001','2019-12-12'),
('RTr002','SF002','2019-12-12'),
('RTr003','SF003','2019-12-12'),
('RTr004','SF004','2019-12-12'),
('RTr005','SF005','2019-12-06'),
('RTr006','SF006','2019-12-03'),
('RTr007','SF007','2019-12-12'),
('RTr008','SF008','2019-12-13'),
('RTr009','SF009','2019-12-02'),
('RTr010','SF010','2019-12-09')


INSERT INTO RefreshmentType VALUES
('RT001','Cold Drink'),
('RT002','Hot Drink'),
('RT003','Regular Drink'),
('RT004','Cold Food'),
('RT005','Hot Food'),
('RT006','Regular Food'),
('RT007','Sweet Drink'),
('RT008','Sour Drink'),
('RT009','Coffee'),
('RT010','Tea')


INSERT INTO Refreshment VALUES
('RE001','RT001',52,12000,'Lemonade'),
('RE002','RT008',80,24000,'Orange'),
('RE003','RT001',52,12000,'Lemon Tea'),
('RE004','RT001',52,12000,'Lychee Tea'),
('RE005','RT008',80,24000,'Orange Tea'),
('RE006','RT001',52,12000,'Mango Tea'),
('RE007','RT001',52,12000,'Milk Tea'),
('RE008','RT007',70,25000,'Boba Tea'),
('RE009','RT007',70,25000,'Java Tea'),
('RE010','RT001',60,30000,'Regular Tea')

INSERT INTO DetailRefreshmentTransaction Values
('RTr001','RE001',52),
('RTr002','RE002',60),
('RTr003','RE003',60),
('RTr004','RE004',58),
('RTr005','RE005',52),
('RTr006','RE006',52),
('RTr007','RE007',52),
('RTr008','RE008',70),
('RTr009','RE009',78),
('RTr010','RE010',56)

DELETE FROM Staff
DELETE FROM Movie
DELETE FROM Studio
DELETE FROM ScheduleTransaction
DELETE FROM HeaderMovieTransaction
DELETE FROM DetailMovieTransaction
DELETE FROM Refreshment
DELETE FROM RefreshmentType
DELETE FROM HeaderRefreshmentTransaction
DELETE FROM DetailRefreshmentTransaction