////////////////////////////**************************************PROCEDIMIENTOS ALMACENADOS******************************////////////////////////////////////////
USE [IF6201_EX2_Aplicada_B82444]
GO
-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<DIEGO COTO>
-- Create date: <12/11/2021 1:01>
-- Description:	<INSERTA DATOS RANDOM EN LA TABLA SALE>
-- =============================================
ALTER PROCEDURE [dbo].[SP_INSERT_SALE]
AS
BEGIN
	--RANDOM ID DE LOS CLIENTES
	DECLARE @ID_CUSTOMER INT = 
	(SELECT TOP 1 ID_CUSTOMER 
		FROM CUSTOMER 
			ORDER BY NEWID())
	
	--RANDOM FECHA
	DECLARE @FromDate DATETIME2(0)
	DECLARE @ToDate   DATETIME2(0)
	SET @FromDate = '2000-01-01 08:22:13' 
	SET @ToDate = '2021-11-20 17:56:31'
	DECLARE @Seconds INT = DATEDIFF(SECOND, @FromDate, @ToDate)
	DECLARE @Random INT = ROUND(((@Seconds-1) * RAND()), 0)

	-- INSERTO DATOS EN LA TABLA SALE CON VALORES RANDOM
	INSERT INTO SALE(ID_CUSTOMER, BILL_DATE)
		VALUES(@ID_CUSTOMER,DATEADD(SECOND, @Random, @FromDate))
END
GO


*******************************//////////////////////////////////////////////
USE [IF6201_EX2_Aplicada_B82444]
GO
-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<DIEGO COTO>
-- Create date: <12/11/2021 2:02>
-- Description:	<INSERTA DATOS RANDOM EN LA TABLA SALE>
-- =============================================
ALTER PROCEDURE [dbo].[SP_INSERT_SALE_DETAIL]
AS
BEGIN
	
	EXEC [dbo].[SP_INSERT_SALE]

	-- DATOS PARA INSERTAR EN LA TABLA SALE_DETAIL
	DECLARE @PRODUCT INT =
	(SELECT TOP 1 ID_PRODUCT 
		FROM PRODUCT 
			ORDER BY NEWID())

	DECLARE @SALE INT = 
		(SELECT TOP 1 ID_SALE 
			FROM SALE 
				ORDER BY NEWID())

	DECLARE @PRICE INT = 
	(SELECT PRICE 
		FROM PRODUCT 
			WHERE ID_PRODUCT = @PRODUCT)

	DECLARE @QUANTITY INT = 
		(SELECT FLOOR(RAND()*(10-1)+1))

	DECLARE @AMOUNT INT = @PRICE * @QUANTITY

	-- DATOS PARA INSERTAR EN LA TABLA SALE_DETAIL
	INSERT INTO SALE_DETAIL(ID_PRODUCT,ID_SALE, QUANTITY,AMOUNT)
		VALUES(@PRODUCT,@SALE,@QUANTITY,@AMOUNT)

END

exec [SP_INSERT_SALE_DETAIL]

*******************************/////////////////////////////////////////////*****************************