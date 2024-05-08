SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE   PROC [dbo].[spGetTopCustomers] AS;
    --Use window function to rank customers sorted by most invoices
    --Return their ids and invoice count

    WITH                                                  rankings
                                                          AS ( SELECT   i.customer_id ,
                                                                        COUNT (
                                                                            *)
                                                                        AS
                                                                        invoices_count ,
                                                                        ranking = ROW_NUMBER () OVER ( ORDER BY COUNT (
                                                                                                                    *) DESC )
                                                               FROM     dbo.INVOICE i
                                                               GROUP BY i.customer_id )
    SELECT   TOP ( 100 ) C.customer_id, r.invoices_count 
    FROM     dbo.CUSTOMER c
             LEFT JOIN rankings r ON c.customer_id = r.customer_id
    WHERE r.ranking is not null
    ORDER BY r.ranking ASC ,
             c.customer_id;

GO
