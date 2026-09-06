USE [Nicole]
GO

/****** Object:  Table [dbo].[Company]    Script Date: 19/6/2026 11:27:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Company](
	[CompanyId] [uniqueidentifier] NOT NULL,
	[Identification] [nvarchar](20) NOT NULL,
	[TradeName] [nvarchar](150) NULL,
	[BusinessName] [nvarchar](200) NOT NULL,
	[Email] [nvarchar](150) NULL,
	[IsAccountingRequired] [bit] NOT NULL,
	[SpecialTaxpayer] [nvarchar](50) NULL,
	[Status] [char](1) NOT NULL,
	[RepresentativeId] [uniqueidentifier] NULL,
	[ParentCompanyId] [uniqueidentifier] NULL,
	[TaxpayerType] [nvarchar](50) NULL,
	[ArtisanQualification] [nvarchar](10) NULL,
	[Environment] [varchar](30) NULL,
	[Currency] [varchar](3) NULL,
	[Timezone] [varchar](60) NULL,
	[LanguageCode] [varchar](3) NULL,
	[CreatedBy] [nvarchar](80) NOT NULL,
	[CreatedAt] [datetime2](0) NOT NULL,
	[UpdatedBy] [nvarchar](80) NULL,
	[UpdatedAt] [datetime2](0) NULL,
 CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED
(
	[CompanyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Company_Identification] UNIQUE NONCLUSTERED
(
	[Identification] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Company] ADD  CONSTRAINT [DF_Company_CompanyId]  DEFAULT (newsequentialid()) FOR [CompanyId]
GO

ALTER TABLE [dbo].[Company] ADD  CONSTRAINT [DF_Company_IsAccountingRequired]  DEFAULT ((0)) FOR [IsAccountingRequired]
GO

ALTER TABLE [dbo].[Company] ADD  CONSTRAINT [DF_Company_Status]  DEFAULT ('A') FOR [Status]
GO

ALTER TABLE [dbo].[Company] ADD  CONSTRAINT [DF_Company_CreatedAt]  DEFAULT (sysdatetime()) FOR [CreatedAt]
GO

ALTER TABLE [dbo].[Company]  WITH CHECK ADD  CONSTRAINT [FK_Company_Parent] FOREIGN KEY([ParentCompanyId])
REFERENCES [dbo].[Company] ([CompanyId])
GO

ALTER TABLE [dbo].[Company] CHECK CONSTRAINT [FK_Company_Parent]
GO

ALTER TABLE [dbo].[Company]  WITH CHECK ADD  CONSTRAINT [FK_Company_Representative] FOREIGN KEY([RepresentativeId])
REFERENCES [dbo].[Person] ([PersonId])
GO

ALTER TABLE [dbo].[Company] CHECK CONSTRAINT [FK_Company_Representative]
GO

ALTER TABLE [dbo].[Company]  WITH CHECK ADD  CONSTRAINT [FK_Company_Status] FOREIGN KEY([Status])
REFERENCES [dbo].[EntityStatus] ([StatusCode])
GO

ALTER TABLE [dbo].[Company] CHECK CONSTRAINT [FK_Company_Status]
GO

ALTER TABLE [dbo].[Company]  WITH CHECK ADD  CONSTRAINT [CK_Company_Currency] CHECK  (([Currency] IS NULL OR len(ltrim(rtrim([Currency])))=(3)))
GO

ALTER TABLE [dbo].[Company] CHECK CONSTRAINT [CK_Company_Currency]
GO

ALTER TABLE [dbo].[Company]  WITH CHECK ADD  CONSTRAINT [CK_Company_LanguageCode] CHECK  (([LanguageCode] IS NULL OR len(ltrim(rtrim([LanguageCode])))>=(2) AND len(ltrim(rtrim([LanguageCode])))<=(3)))
GO

ALTER TABLE [dbo].[Company] CHECK CONSTRAINT [CK_Company_LanguageCode]
GO

ALTER TABLE [dbo].[Company]  WITH CHECK ADD  CONSTRAINT [CK_Company_ParentCompany] CHECK  (([ParentCompanyId] IS NULL OR [ParentCompanyId]<>[CompanyId]))
GO

ALTER TABLE [dbo].[Company] CHECK CONSTRAINT [CK_Company_ParentCompany]
GO
