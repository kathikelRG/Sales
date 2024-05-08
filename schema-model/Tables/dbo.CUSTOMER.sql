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
ALTER TABLE [dbo].[CUSTOMER] ADD CONSTRAINT [PK__CUSTOMER__CD65CB85EBFD3C84] PRIMARY KEY CLUSTERED ([customer_id])
GO
