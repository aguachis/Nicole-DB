USE [Nicole]
GO

/****** Object:  Table [dbo].[CompanyEmissionPoint]    Script Date: 19/6/2026 11:36:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CompanyEmissionPoint](
	[CompanyEmissionPointId] [uniqueidentifier] NOT NULL,
	[CompanyBranchId] [uniqueidentifier] NOT NULL,
	[EmissionPointCode] [varchar](10) NOT NULL,
	[Name] [nvarchar](150) NULL,
	[Status] [char](1) NOT NULL,
	[CreatedBy] [nvarchar](80) NOT NULL,
	[CreatedAt] [datetime2](0) NOT NULL,
	[UpdatedBy] [nvarchar](80) NULL,
	[UpdatedAt] [datetime2](0) NULL,
 CONSTRAINT [PK_CompanyEmissionPoint] PRIMARY KEY CLUSTERED 
(
	[CompanyEmissionPointId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_CompanyEmissionPoint_Branch_EmissionPointCode] UNIQUE NONCLUSTERED 
(
	[CompanyBranchId] ASC,
	[EmissionPointCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[CompanyEmissionPoint] ADD  CONSTRAINT [DF_CompanyEmissionPoint_Id]  DEFAULT (newsequentialid()) FOR [CompanyEmissionPointId]
GO

ALTER TABLE [dbo].[CompanyEmissionPoint] ADD  CONSTRAINT [DF_CompanyEmissionPoint_Status]  DEFAULT ('A') FOR [Status]
GO

ALTER TABLE [dbo].[CompanyEmissionPoint] ADD  CONSTRAINT [DF_CompanyEmissionPoint_CreatedAt]  DEFAULT (sysdatetime()) FOR [CreatedAt]
GO

ALTER TABLE [dbo].[CompanyEmissionPoint]  WITH CHECK ADD  CONSTRAINT [FK_CompanyEmissionPoint_CompanyBranch] FOREIGN KEY([CompanyBranchId])
REFERENCES [dbo].[CompanyBranch] ([CompanyBranchId])
GO

ALTER TABLE [dbo].[CompanyEmissionPoint] CHECK CONSTRAINT [FK_CompanyEmissionPoint_CompanyBranch]
GO

ALTER TABLE [dbo].[CompanyEmissionPoint]  WITH CHECK ADD  CONSTRAINT [FK_CompanyEmissionPoint_Status] FOREIGN KEY([Status])
REFERENCES [dbo].[EntityStatus] ([StatusCode])
GO

ALTER TABLE [dbo].[CompanyEmissionPoint] CHECK CONSTRAINT [FK_CompanyEmissionPoint_Status]
GO

ALTER TABLE [dbo].[CompanyEmissionPoint]  WITH CHECK ADD  CONSTRAINT [CK_CompanyEmissionPoint_Code_NotBlank] CHECK  ((len(ltrim(rtrim([EmissionPointCode])))>(0)))
GO

ALTER TABLE [dbo].[CompanyEmissionPoint] CHECK CONSTRAINT [CK_CompanyEmissionPoint_Code_NotBlank]
GO
