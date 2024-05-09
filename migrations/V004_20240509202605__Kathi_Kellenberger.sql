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
[invoice_customer_id] [varchar] (10) NULL
GO
ALTER TABLE [dbo].[INVOICE] DROP
COLUMN [customer_ID]
GO
PRINT N'Altering [dbo].[spGetTopCustomers]'
GO
ALTER   PROC [dbo].[spGetTopCustomers]  AS;
    --Use window function to rank customers sorted by most invoices
    --Return their ids and invoice count

    WITH                                                  rankings
                                                          AS ( SELECT   i.invoice_customer_id ,
                                                                        COUNT (
                                                                            *)
                                                                        AS
                                                                        invoices_count ,
                                                                        ranking = ROW_NUMBER () OVER ( ORDER BY COUNT (
                                                                                                                    *) DESC )
                                                               FROM     dbo.INVOICE i
                                                               GROUP BY i.invoice_customer_id )
    SELECT   TOP (100 ) C.customer_id, r.invoices_count 
    FROM     dbo.CUSTOMER c
             LEFT JOIN rankings r ON c.customer_id = r.invoice_customer_id
    WHERE r.ranking is not null
    ORDER BY r.ranking ASC ,
             c.customer_id;

GO
PRINT N'Adding foreign keys to [dbo].[INVOICE]'
GO
ALTER TABLE [dbo].[INVOICE] ADD CONSTRAINT [in_cust_fk] FOREIGN KEY ([invoice_customer_id]) REFERENCES [dbo].[CUSTOMER] ([customer_id])
GO

