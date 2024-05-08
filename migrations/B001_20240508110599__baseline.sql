SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Creating [dbo].[CUSTOMER]'
GO
CREATE TABLE [dbo].[CUSTOMER]
(
[customer_id] [varchar] (10) NOT NULL,
[customer_firstname] [varchar] (60) NULL,
[customer_lastname] [varchar] (60) NULL,
[customer_gender] [varchar] (1) NULL,
[customer_company_name] [varchar] (60) NULL,
[customer_street_address] [varchar] (60) NULL,
[customer_region] [varchar] (60) NULL,
[customer_country] [varchar] (60) NULL,
[customer_email] [varchar] (60) NULL,
[customer_telephone] [varchar] (60) NULL,
[customer_zipcode] [varchar] (60) NULL,
[credit_card_type_id] [varchar] (2) NULL,
[customer_credit_card_number] [varchar] (60) NULL
)
GO
PRINT N'Creating primary key [PK__CUSTOMER__CD65CB85EBFD3C84] on [dbo].[CUSTOMER]'
GO
ALTER TABLE [dbo].[CUSTOMER] ADD CONSTRAINT [PK__CUSTOMER__CD65CB85EBFD3C84] PRIMARY KEY CLUSTERED ([customer_id])
GO
PRINT N'Creating [dbo].[INVOICE]'
GO
CREATE TABLE [dbo].[INVOICE]
(
[invoice_number] [varchar] (10) NOT NULL,
[invoice_date] [datetime] NULL,
[customer_ID] [varchar] (10) NULL
)
GO
PRINT N'Creating primary key [PK__INVOI__8081A63BC39394DD] on [dbo].[INVOICE]'
GO
ALTER TABLE [dbo].[INVOICE] ADD CONSTRAINT [PK__INVOI__8081A63BC39394DD] PRIMARY KEY CLUSTERED ([invoice_number])
GO
PRINT N'Adding foreign keys to [dbo].[INVOICE]'
GO
ALTER TABLE [dbo].[INVOICE] ADD CONSTRAINT [in_cust_fk] FOREIGN KEY ([customer_ID]) REFERENCES [dbo].[CUSTOMER] ([customer_id])
GO

