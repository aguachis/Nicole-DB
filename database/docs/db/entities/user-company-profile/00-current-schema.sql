USE [Nicole]
GO

/****** Object:  Table [dbo].[UserCompanyProfile]    Script Date: 19/6/2026 12:05:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[UserCompanyProfile](
	[UserCompanyProfileId] [uniqueidentifier] NOT NULL,
	[UserCompanyId] [uniqueidentifier] NOT NULL,
	[CompanyId] [uniqueidentifier] NOT NULL,
	[ProfileId] [uniqueidentifier] NOT NULL,
	[Status] [char](1) NOT NULL,
	[CreatedBy] [nvarchar](80) NOT NULL,
	[CreatedAt] [datetime2](0) NOT NULL,
	[UpdatedBy] [nvarchar](80) NULL,
	[UpdatedAt] [datetime2](0) NULL,
 CONSTRAINT [PK_UserCompanyProfile] PRIMARY KEY CLUSTERED
(
	[UserCompanyProfileId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_UserCompanyProfile_UserCompany_Profile] UNIQUE NONCLUSTERED
(
	[UserCompanyId] ASC,
	[ProfileId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[UserCompanyProfile] ADD  CONSTRAINT [DF_UserCompanyProfile_Id]  DEFAULT (newsequentialid()) FOR [UserCompanyProfileId]
GO

ALTER TABLE [dbo].[UserCompanyProfile] ADD  CONSTRAINT [DF_UserCompanyProfile_Status]  DEFAULT ('A') FOR [Status]
GO

ALTER TABLE [dbo].[UserCompanyProfile] ADD  CONSTRAINT [DF_UserCompanyProfile_CreatedAt]  DEFAULT (sysdatetime()) FOR [CreatedAt]
GO

ALTER TABLE [dbo].[UserCompanyProfile]  WITH CHECK ADD  CONSTRAINT [FK_UserCompanyProfile_Profile] FOREIGN KEY([ProfileId], [CompanyId])
REFERENCES [dbo].[Profile] ([ProfileId], [CompanyId])
GO

ALTER TABLE [dbo].[UserCompanyProfile] CHECK CONSTRAINT [FK_UserCompanyProfile_Profile]
GO

ALTER TABLE [dbo].[UserCompanyProfile]  WITH CHECK ADD  CONSTRAINT [FK_UserCompanyProfile_Status] FOREIGN KEY([Status])
REFERENCES [dbo].[EntityStatus] ([StatusCode])
GO

ALTER TABLE [dbo].[UserCompanyProfile] CHECK CONSTRAINT [FK_UserCompanyProfile_Status]
GO

ALTER TABLE [dbo].[UserCompanyProfile]  WITH CHECK ADD  CONSTRAINT [FK_UserCompanyProfile_UserCompany] FOREIGN KEY([UserCompanyId], [CompanyId])
REFERENCES [dbo].[UserCompany] ([UserCompanyId], [CompanyId])
GO

ALTER TABLE [dbo].[UserCompanyProfile] CHECK CONSTRAINT [FK_UserCompanyProfile_UserCompany]
GO
