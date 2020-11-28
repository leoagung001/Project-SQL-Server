--CASES--

--1
SELECT MovieID, [Total Revenue] = 'IDR ' + CONVERT(VARCHAR,(SUM(StudioPrice*Seats)))
FROM ScheduleTransaction st JOIN DetailMovieTransaction dmt
ON st.ScheduleTransactionID = dmt.ScheduleTransactionID JOIN Studio s
ON s.StudioID = st.StudioID
WHERE StudioPrice > 50000 AND DAY(DateandTime) < 20
GROUP BY MovieID

--2 x
SELECT StaffName, [Total Sold Seats] = SUM(Seats)
FROM Staff s JOIN HeaderMovieTransaction hmt
ON s.StaffID = hmt.StaffID JOIN DetailMovieTransaction dmt
ON hmt.MovieTransactionID = dmt.MovieTransactionID JOIN ScheduleTransaction st
ON dmt.ScheduleTransactionID = st.ScheduleTransactionID
WHERE StaffGender = 'Male' AND DAY(DateandTime) < 28
GROUP BY StaffName
ORDER BY [Total Sold Seats] DESC

--3
SELECT [Average Refreshment Revenue per Day] = 'IDR ' + 
CONVERT(VARCHAR,AVG(drt.Quantity * r.RefreshmentPrice)),
[Transaction Days] = CONVERT(VARCHAR,COUNT(DISTINCT hrt.TransactionDate)) + ' days',
[Female Staff Count] = CONVERT(VARCHAR,COUNT(DISTINCT s.StaffID)) + ' people'
FROM Staff s JOIN HeaderRefreshmentTransaction hrt
ON s.StaffID = hrt.StaffID JOIN DetailRefreshmentTransaction drt
ON hrt.RefreshmentSaleID = drt.RefreshmentSaleID JOIN Refreshment r
ON drt.RefreshmentID = r.RefreshmentID
WHERE StaffGender = 'Female' AND hrt.TransactionDate < CONVERT(DATE,'2020-02-10')

--4
SELECT [Staff First Name] = 'Mr. ' + SUBSTRING(s.StaffName,0,CHARINDEX(' ',s.StaffName)),
[Total of Refreshment] = COUNT(RefreshmentID),
[Total of Quantity Sold] = SUM(Quantity)
FROM Staff s JOIN HeaderRefreshmentTransaction hrt ON s.StaffID = hrt.StaffID
JOIN DetailRefreshmentTransaction drt ON hrt.RefreshmentSaleID = drt.RefreshmentSaleID
WHERE StaffGender = 'Male'
GROUP BY s.StaffName
UNION
SELECT [Staff First Name] = 'Ms. ' + SUBSTRING(s.StaffName,0,CHARINDEX(' ',s.StaffName)),
[Total of Refreshment] = COUNT(RefreshmentID),
[Total of Quantity Sold] = SUM(Quantity)
FROM Staff s JOIN HeaderRefreshmentTransaction hrt ON s.StaffID = hrt.StaffID
JOIN DetailRefreshmentTransaction drt ON hrt.RefreshmentSaleID = drt.RefreshmentSaleID
WHERE StaffGender = 'Female'
GROUP BY s.StaffName

--5
SELECT [Refreshment Transaction ID] = RIGHT(hrt.RefreshmentSaleID,3),
[Refreshment Transaction Date] = CONVERT(DATE,hrt.TransactionDate,107)
FROM DetailRefreshmentTransaction drt JOIN Refreshment r
ON drt.RefreshmentID = r.RefreshmentID JOIN RefreshmentType rt
ON r.RefreshmentTypeID = rt.RefreshmentTypeID JOIN HeaderRefreshmentTransaction hrt
ON hrt.RefreshmentSaleID = drt.RefreshmentSaleID,
(
	SELECT Transaksi = AVG(Quantity*RefreshmentPrice)
	FROM DetailRefreshmentTransaction drt JOIN Refreshment r
	ON drt.RefreshmentID = r.RefreshmentID
) AS Average
WHERE Quantity * RefreshmentPrice > Average.Transaksi AND rt.RefreshmentTypeID IN ('RT006', 'RT007', 'RT008', 'RT009', 'RT010')

--6
SELECT [Transaction Date] = DATENAME(WEEKDAY,TransactionDate) + ', ' +
CONVERT(VARCHAR,CONVERT(DATE,TransactionDate,106)),
[Total Movie Revenue] = 'IDR ' + CONVERT(VARCHAR,Seats * StudioPrice)
FROM HeaderMovieTransaction hmt JOIN DetailMovieTransaction dmt
ON hmt.MovieTransactionID = dmt.MovieTransactionID JOIN ScheduleTransaction st
ON st.ScheduleTransactionID = dmt.ScheduleTransactionID JOIN Studio s
ON s.StudioID = st.StudioID,(
	SELECT Average = AVG(Seats * StudioPrice)
	FROM DetailMovieTransaction dmt JOIN ScheduleTransaction st
	ON dmt.ScheduleTransactionID = st.ScheduleTransactionID JOIN Studio s
	ON s.StudioID = st.StudioID
)AS Average
WHERE Seats*StudioPrice > Average.Average AND
DATEDIFF(DAY,TransactionDate,28-02-2020) < 30

--7
SELECT [Staff Last Name] = RIGHT(s.StaffName,CHARINDEX(' ',REVERSE(StaffName),0)),
RefreshmentTransactionID = drt.RefreshmentSaleID,RefreshmentName,
Price = 'IDR ' + CONVERT(VARCHAR,r.RefreshmentPrice)
FROM Staff s JOIN HeaderRefreshmentTransaction hrt
ON s.StaffID = hrt.StaffID JOIN DetailRefreshmentTransaction drt
ON hrt.RefreshmentSaleID = drt.RefreshmentSaleID JOIN Refreshment r
ON drt.RefreshmentID = r.RefreshmentID,(
	SELECT Minimum = MIN(RefreshmentPrice)
	FROM Refreshment
)AS Minimum,(
	SELECT Maximum = MAX(RefreshmentPrice)
	FROM Refreshment
)AS Maximum
WHERE RefreshmentPrice > Minimum.Minimum AND RefreshmentPrice < Maximum.Maximum

--8
SELECT [Movie Transaction ID] = SUBSTRING(hmt.MovieTransactionID,2,2) + ' ' +
RIGHT(hmt.MovieTransactionID,3),StudioName,
[Studio Price] = 'IDR ' + CONVERT(VARCHAR,StudioPrice)
FROM HeaderMovieTransaction hmt JOIN DetailMovieTransaction dmt
ON hmt.MovieTransactionID = dmt.MovieTransactionID JOIN ScheduleTransaction st
ON dmt.ScheduleTransactionID = st.ScheduleTransactionID JOIN Studio s
ON s.StudioID = st.StudioID,(
	SELECT Seats = AVG(Seats)
	FROM DetailMovieTransaction
)AS AverageSeats,(
	SELECT Seats = MAX(Seats)
	FROM DetailMovieTransaction
)AS MaxSeats,(
	SELECT Price = AVG(StudioPrice)
	FROM Studio
)AS AveragePrice,(
	SELECT Price = MAX(StudioPrice)
	FROM Studio
)AS MaxPrice
WHERE dmt.Seats BETWEEN AverageSeats.Seats AND MaxSeats.Seats AND
StudioPrice BETWEEN AveragePrice.Price AND MaxPrice.Price

--9
CREATE VIEW [Movie Schedule Viewer]
AS
SELECT [Studio ID] = 'Studio ' + RIGHT(s.StudioID,3),StudioName,[Total Play Schedule] = COUNT(ScheduleTransactionID),
[Movie Duration Total] = SUM(MovieDuration)
FROM ScheduleTransaction st JOIN Movie m ON st.MovieID = m.MovieID JOIN Studio s
ON st.StudioID = s.StudioID
WHERE LEFT(StudioName,5) = 'Satin' AND MovieDuration > 120
GROUP BY s.StudioID, StudioName

DROP VIEW [Movie Schedule Viewer]

--10
GO
CREATE VIEW [Refreshment Transaction Summary Viewer]
AS
SELECT [Transaction Count] = CONVERT(VARCHAR,COUNT(hrt.RefreshmentSaleID)) + ' transactions',
[Quantity Sold] = CONVERT(VARCHAR,SUM(Quantity)) + ' products'
FROM HeaderRefreshmentTransaction hrt JOIN DetailRefreshmentTransaction drt
ON hrt.RefreshmentSaleID = drt.RefreshmentSaleID JOIN Refreshment r
ON drt.RefreshmentID = r.RefreshmentID
WHERE DATENAME(WEEKDAY,hrt.TransactionDate) IN ('Saturday','Sunday') AND Quantity > 5
