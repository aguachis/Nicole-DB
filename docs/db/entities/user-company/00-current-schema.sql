USE [Nicole]
GO

/****** Object:  Table [dbo].[UserCompany]    Script Date: 19/6/2026 12:03:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[UserCompany](
	[UserCompanyId] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[CompanyId] [uniqueidentifier] NOT NULL,
	[Status] [char](1) NOT NULL,
	[CreatedBy] [nvarchar](80) NOT NULL,
	[CreatedAt] [datetime2](0) NOT NULL,
	[UpdatedBy] [nvarchar](80) NULL,
	[UpdatedAt] [datetime2](0) NULL,
 CONSTRAINT [PK_UserCompany] PRIMARY KEY CLUSTERED 
(
	[UserCompanyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_UserCompany_User_Company] UNIQUE NONCLUSTERED 
(
	[UserId] ASC,
	[CompanyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_UserCompany_UserCompanyId_CompanyId] UNIQUE NONCLUSTERED 
(
	[UserCompanyId] ASC,
	[CompanyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[UserCompany] ADD  CONSTRAINT [DF_UserCompany_UserCompanyId]  DEFAULT (newsequentialid()) FOR [UserCompanyId]
GO

ALTER TABLE [dbo].[UserCompany] ADD  CONSTRAINT [DF_UserCompany_Status]  DEFAULT ('A') FOR [Status]
GO

ALTER TABLE [dbo].[UserCompany] ADD  CONSTRAINT [DF_UserCompany_CreatedAt]  DEFAULT (sysdatetime()) FOR [CreatedAt]
GO

ALTER TABLE [dbo].[UserCompany]  WITH CHECK ADD  CONSTRAINT [FK_UserCompany_Company] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[Company] ([CompanyId])
GO

ALTER TABLE [dbo].[UserCompany] CHECK CONSTRAINT [FK_UserCompany_Company]
GO

ALTER TABLE [dbo].[UserCompany]  WITH CHECK ADD  CONSTRAINT [FK_UserCompany_Status] FOREIGN KEY([Status])
REFERENCES [dbo].[EntityStatus] ([StatusCode])
GO

ALTER TABLE [dbo].[UserCompany] CHECK CONSTRAINT [FK_UserCompany_Status]
GO

ALTER TABLE [dbo].[UserCompany]  WITH CHECK ADD  CONSTRAINT [FK_UserCompany_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[AppUser] ([UserId])
GO

ALTER TABLE [dbo].[UserCompany] CHECK CONSTRAINT [FK_UserCompany_User]
GO
