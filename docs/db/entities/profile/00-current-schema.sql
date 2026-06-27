USE [Nicole]
GO

/****** Object:  Table [dbo].[Profile]    Script Date: 19/6/2026 11:50:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Profile](
	[ProfileId] [uniqueidentifier] NOT NULL,
	[CompanyId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](150) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[Status] [char](1) NOT NULL,
	[CreatedBy] [nvarchar](80) NOT NULL,
	[CreatedAt] [datetime2](0) NOT NULL,
	[UpdatedBy] [nvarchar](80) NULL,
	[UpdatedAt] [datetime2](0) NULL,
 CONSTRAINT [PK_Profile] PRIMARY KEY CLUSTERED 
(
	[ProfileId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Profile_Company_Name] UNIQUE NONCLUSTERED 
(
	[CompanyId] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Profile_ProfileId_CompanyId] UNIQUE NONCLUSTERED 
(
	[ProfileId] ASC,
	[CompanyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Profile] ADD  CONSTRAINT [DF_Profile_ProfileId]  DEFAULT (newsequentialid()) FOR [ProfileId]
GO

ALTER TABLE [dbo].[Profile] ADD  CONSTRAINT [DF_Profile_Status]  DEFAULT ('A') FOR [Status]
GO

ALTER TABLE [dbo].[Profile] ADD  CONSTRAINT [DF_Profile_CreatedAt]  DEFAULT (sysdatetime()) FOR [CreatedAt]
GO

ALTER TABLE [dbo].[Profile]  WITH CHECK ADD  CONSTRAINT [FK_Profile_Company] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[Company] ([CompanyId])
GO

ALTER TABLE [dbo].[Profile] CHECK CONSTRAINT [FK_Profile_Company]
GO

ALTER TABLE [dbo].[Profile]  WITH CHECK ADD  CONSTRAINT [FK_Profile_Status] FOREIGN KEY([Status])
REFERENCES [dbo].[EntityStatus] ([StatusCode])
GO

ALTER TABLE [dbo].[Profile] CHECK CONSTRAINT [FK_Profile_Status]
GO

ALTER TABLE [dbo].[Profile]  WITH CHECK ADD  CONSTRAINT [CK_Profile_Name_NotBlank] CHECK  ((len(ltrim(rtrim([Name])))>(0)))
GO

ALTER TABLE [dbo].[Profile] CHECK CONSTRAINT [CK_Profile_Name_NotBlank]
GO
