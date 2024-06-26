SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE   PROC [dbo].[spGetTopCustomers] AS
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
