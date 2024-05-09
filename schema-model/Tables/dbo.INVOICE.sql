CREATE TABLE [dbo].[INVOICE]
(
[invoice_number] [varchar] (10) NOT NULL,
[invoice_date] [datetime] NULL,
[invoice_customer_id] [varchar] (10) NULL
)
GO
ALTER TABLE [dbo].[INVOICE] ADD CONSTRAINT [PK__INVOI__8081A63BC39394DD] PRIMARY KEY CLUSTERED ([invoice_number])
GO
ALTER TABLE [dbo].[INVOICE] ADD CONSTRAINT [in_cust_fk] FOREIGN KEY ([invoice_customer_id]) REFERENCES [dbo].[CUSTOMER] ([customer_id])
GO
