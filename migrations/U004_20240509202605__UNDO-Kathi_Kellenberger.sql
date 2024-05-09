SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Dropping foreign keys from [dbo].[INVOICE]'
GO
ALTER TABLE [dbo].[INVOICE] DROP CONSTRAINT [in_cust_fk]
GO
PRINT N'Altering [dbo].[INVOICE]'
GO
ALTER TABLE [dbo].[INVOICE] ADD
[customer_ID] [varchar] (10) NULL
GO
ALTER TABLE [dbo].[INVOICE] DROP
COLUMN [invoice_customer_id]
GO
PRINT N'Altering [dbo].[spGetTopCustomers]'
GO
ALTER   PROC [dbo].[spGetTopCustomers] AS
;
    --Use window function to rank customers sorted by most invoices
    --Return their ids and invoice count
-- The original query is modified for performance improvement by leveraging existing indexes
-- and minimizing the overhead in the CTE definition.

WITH InvoiceRankings
AS (SELECT i.customer_id,
           COUNT(*) AS invoices_count
    FROM dbo.INVOICE i
    GROUP BY i.customer_id)
SELECT TOP (100)
       c.customer_id,
       ir.invoices_count
FROM dbo.CUSTOMER c
    INNER JOIN InvoiceRankings ir
        ON c.customer_id = ir.customer_id
ORDER BY ir.invoices_count DESC,
         c.customer_id;

-- Changes made:
-- 1. Removed the 'ranking' column as it was not used in the final SELECT.
-- 2. Altered the order of sorting to directly use 'invoices_count' descending, which eliminates the need for ranking computation.
-- This should enhance performance by reducing computation and leveraging direct counts.
-- 3. Ensured that column references and table names are accurate per the given database schema.
GO
PRINT N'Adding foreign keys to [dbo].[INVOICE]'
GO
ALTER TABLE [dbo].[INVOICE] ADD CONSTRAINT [in_cust_fk] FOREIGN KEY ([customer_ID]) REFERENCES [dbo].[CUSTOMER] ([customer_id])
GO

