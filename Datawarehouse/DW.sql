CREATE DATABASE IF6201_DW_STORE_B82444
GO

CREATE SCHEMA DW
GO

USE IF6201_DW_STORE_B82444
CREATE TABLE DW.DIM_CUSTOMER
(
	ID_CUSTOMER INT PRIMARY KEY,
	FULLNAME varchar(150),
	AGE int,
	COUNTRY VARCHAR(120),
	EMAIL VARCHAR(150)
);

CREATE TABLE DW.DIM_PRODUCT
(
	ID_PRODUCT INT PRIMARY KEY,
	NAME_PRODUCT varchar(150),
	PRICE int
);

CREATE TABLE DW.DIM_TIME
(
	ID_TIME INT PRIMARY KEY,
	BILL_DATE DATETIME,
	ANNO_SALE INT,
	MONTH_SALE INT,
	DAY_SALE INT
);


CREATE TABLE DW.DIM_HECHOS_STORE
(
	DIM_ID_CUSTOMER INT,
	DIM_ID_PRODUCT INT,
	DIM_ID_TIME INT,
	TOTAL_PRODUCTS INT,
	TOTAL_SALE INT,
	CONSTRAINT PK_HECHOS_STORE PRIMARY KEY(DIM_ID_CUSTOMER, DIM_ID_PRODUCT, DIM_ID_TIME),
	CONSTRAINT FK_CUSTOMER FOREIGN KEY (DIM_ID_CUSTOMER) REFERENCES DW.DIM_CUSTOMER (ID_CUSTOMER),
	CONSTRAINT FK_PRODUCT FOREIGN KEY (DIM_ID_PRODUCT) REFERENCES DW.DIM_PRODUCT(ID_PRODUCT),
	CONSTRAINT FK_TIME FOREIGN KEY (DIM_ID_TIME) REFERENCES DW.DIM_TIME(ID_TIME)
);


USE IF6201_EX2_Aplicada_B82444
SELECT DISTINCT
	CUST.ID_CUSTOMER,
	PROD.ID_PRODUCT,
	SL.ID_SALE,
	COUNT(SALD.TOTAL_SALE) AS TOTAL_SALE,
	SUM(SALD.AMOUNT) AS AMOUNT
FROM SALE_DETAIL SALD
	JOIN SALE SL
		ON SL.ID_SALE = SALD.ID_SALE
			JOIN PRODUCT PROD 
				ON PROD.ID_PRODUCT = SALD.ID_PRODUCT
					JOIN CUSTOMER CUST
						ON CUST.ID_CUSTOMER = SL.ID_CUSTOMER
GROUP BY CUST.ID_CUSTOMER, PROD.ID_PRODUCT, SL.ID_SALE