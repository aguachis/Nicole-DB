USE [Nicole]
GO

/****** Object:  Table [dbo].[ProfilePermission]    Script Date: 19/6/2026 11:51:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ProfilePermission](
	[ProfilePermissionId] [uniqueidentifier] NOT NULL,
	[ProfileId] [uniqueidentifier] NOT NULL,
	[PermissionId] [uniqueidentifier] NOT NULL,
	[Status] [char](1) NOT NULL,
	[CreatedBy] [nvarchar](80) NOT NULL,
	[CreatedAt] [datetime2](0) NOT NULL,
	[UpdatedBy] [nvarchar](80) NULL,
	[UpdatedAt] [datetime2](0) NULL,
 CONSTRAINT [PK_ProfilePermission] PRIMARY KEY CLUSTERED
(
	[ProfilePermissionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_ProfilePermission_Profile_Permission] UNIQUE NONCLUSTERED
(
	[ProfileId] ASC,
	[PermissionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ProfilePermission] ADD  CONSTRAINT [DF_ProfilePermission_Id]  DEFAULT (newsequentialid()) FOR [ProfilePermissionId]
GO

ALTER TABLE [dbo].[ProfilePermission] ADD  CONSTRAINT [DF_ProfilePermission_Status]  DEFAULT ('A') FOR [Status]
GO

ALTER TABLE [dbo].[ProfilePermission] ADD  CONSTRAINT [DF_ProfilePermission_CreatedAt]  DEFAULT (sysdatetime()) FOR [CreatedAt]
GO

ALTER TABLE [dbo].[ProfilePermission]  WITH CHECK ADD  CONSTRAINT [FK_ProfilePermission_Permission] FOREIGN KEY([PermissionId])
REFERENCES [dbo].[Permission] ([PermissionId])
GO

ALTER TABLE [dbo].[ProfilePermission] CHECK CONSTRAINT [FK_ProfilePermission_Permission]
GO

ALTER TABLE [dbo].[ProfilePermission]  WITH CHECK ADD  CONSTRAINT [FK_ProfilePermission_Profile] FOREIGN KEY([ProfileId])
REFERENCES [dbo].[Profile] ([ProfileId])
GO

ALTER TABLE [dbo].[ProfilePermission] CHECK CONSTRAINT [FK_ProfilePermission_Profile]
GO

ALTER TABLE [dbo].[ProfilePermission]  WITH CHECK ADD  CONSTRAINT [FK_ProfilePermission_Status] FOREIGN KEY([Status])
REFERENCES [dbo].[EntityStatus] ([StatusCode])
GO

ALTER TABLE [dbo].[ProfilePermission] CHECK CONSTRAINT [FK_ProfilePermission_Status]
GO
