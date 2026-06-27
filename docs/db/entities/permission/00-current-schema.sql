USE [Nicole]
GO

/****** Object:  Table [dbo].[Permission]    Script Date: 19/6/2026 11:42:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Permission](
	[PermissionId] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](150) NOT NULL,
	[Name] [nvarchar](150) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[ModuleCode] [nvarchar](50) NOT NULL,
	[Status] [char](1) NOT NULL,
	[CreatedBy] [nvarchar](80) NOT NULL,
	[CreatedAt] [datetime2](0) NOT NULL,
	[UpdatedBy] [nvarchar](80) NULL,
	[UpdatedAt] [datetime2](0) NULL,
 CONSTRAINT [PK_Permission] PRIMARY KEY CLUSTERED 
(
	[PermissionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Permission_Code] UNIQUE NONCLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Permission] ADD  CONSTRAINT [DF_Permission_PermissionId]  DEFAULT (newsequentialid()) FOR [PermissionId]
GO

ALTER TABLE [dbo].[Permission] ADD  CONSTRAINT [DF_Permission_Status]  DEFAULT ('A') FOR [Status]
GO

ALTER TABLE [dbo].[Permission] ADD  CONSTRAINT [DF_Permission_CreatedAt]  DEFAULT (sysdatetime()) FOR [CreatedAt]
GO

ALTER TABLE [dbo].[Permission]  WITH CHECK ADD  CONSTRAINT [FK_Permission_Status] FOREIGN KEY([Status])
REFERENCES [dbo].[EntityStatus] ([StatusCode])
GO

ALTER TABLE [dbo].[Permission] CHECK CONSTRAINT [FK_Permission_Status]
GO

ALTER TABLE [dbo].[Permission]  WITH CHECK ADD  CONSTRAINT [CK_Permission_Code_NotBlank] CHECK  ((len(ltrim(rtrim([Code])))>(0)))
GO

ALTER TABLE [dbo].[Permission] CHECK CONSTRAINT [CK_Permission_Code_NotBlank]
GO

ALTER TABLE [dbo].[Permission]  WITH CHECK ADD  CONSTRAINT [CK_Permission_ModuleCode_NotBlank] CHECK  ((len(ltrim(rtrim([ModuleCode])))>(0)))
GO

ALTER TABLE [dbo].[Permission] CHECK CONSTRAINT [CK_Permission_ModuleCode_NotBlank]
GO

ALTER TABLE [dbo].[Permission]  WITH CHECK ADD  CONSTRAINT [CK_Permission_Name_NotBlank] CHECK  ((len(ltrim(rtrim([Name])))>(0)))
GO

ALTER TABLE [dbo].[Permission] CHECK CONSTRAINT [CK_Permission_Name_NotBlank]
GO
