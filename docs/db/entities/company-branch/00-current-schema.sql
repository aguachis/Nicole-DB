USE [Nicole]
GO

/****** Object:  Table [dbo].[CompanyBranch]    Script Date: 19/6/2026 11:29:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CompanyBranch](
	[CompanyBranchId] [uniqueidentifier] NOT NULL,
	[CompanyId] [uniqueidentifier] NOT NULL,
	[EstablishmentCode] [varchar](10) NOT NULL,
	[BranchName] [nvarchar](150) NULL,
	[Address] [nvarchar](300) NULL,
	[Phone] [nvarchar](50) NULL,
	[Email] [nvarchar](150) NULL,
	[City] [int] NULL,
	[Province] [char](3) NULL,
	[Status] [char](1) NOT NULL,
	[CreatedBy] [nvarchar](80) NOT NULL,
	[CreatedAt] [datetime2](0) NOT NULL,
	[UpdatedBy] [nvarchar](80) NULL,
	[UpdatedAt] [datetime2](0) NULL,
 CONSTRAINT [PK_CompanyBranch] PRIMARY KEY CLUSTERED 
(
	[CompanyBranchId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_CompanyBranch_Company_EstablishmentCode] UNIQUE NONCLUSTERED 
(
	[CompanyId] ASC,
	[EstablishmentCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[CompanyBranch] ADD  CONSTRAINT [DF_CompanyBranch_CompanyBranchId]  DEFAULT (newsequentialid()) FOR [CompanyBranchId]
GO

ALTER TABLE [dbo].[CompanyBranch] ADD  CONSTRAINT [DF_CompanyBranch_Status]  DEFAULT ('A') FOR [Status]
GO

ALTER TABLE [dbo].[CompanyBranch] ADD  CONSTRAINT [DF_CompanyBranch_CreatedAt]  DEFAULT (sysdatetime()) FOR [CreatedAt]
GO

ALTER TABLE [dbo].[CompanyBranch]  WITH CHECK ADD  CONSTRAINT [FK_CompanyBranch_Company] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[Company] ([CompanyId])
GO

ALTER TABLE [dbo].[CompanyBranch] CHECK CONSTRAINT [FK_CompanyBranch_Company]
GO

ALTER TABLE [dbo].[CompanyBranch]  WITH CHECK ADD  CONSTRAINT [FK_CompanyBranch_Status] FOREIGN KEY([Status])
REFERENCES [dbo].[EntityStatus] ([StatusCode])
GO

ALTER TABLE [dbo].[CompanyBranch] CHECK CONSTRAINT [FK_CompanyBranch_Status]
GO

ALTER TABLE [dbo].[CompanyBranch]  WITH CHECK ADD  CONSTRAINT [CK_CompanyBranch_EstablishmentCode_NotBlank] CHECK  ((len(ltrim(rtrim([EstablishmentCode])))>(0)))
GO

ALTER TABLE [dbo].[CompanyBranch] CHECK CONSTRAINT [CK_CompanyBranch_EstablishmentCode_NotBlank]
GO
