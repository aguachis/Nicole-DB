USE [Nicole]
GO

/****** Object:  Table [dbo].[AppUser]    Script Date: 19/6/2026 11:53:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AppUser](
	[UserId] [uniqueidentifier] NOT NULL,
	[PersonId] [uniqueidentifier] NOT NULL,
	[Username] [nvarchar](80) NULL,
	[PasswordHash] [nvarchar](500) NOT NULL,
	[Email] [nvarchar](150) NOT NULL,
	[IsBlocked] [bit] NOT NULL,
	[RequiresNewPassword] [bit] NOT NULL,
	[MustUpdate] [bit] NOT NULL,
	[Status] [char](1) NOT NULL,
	[CreatedBy] [nvarchar](80) NOT NULL,
	[CreatedAt] [datetime2](0) NOT NULL,
	[UpdatedBy] [nvarchar](80) NULL,
	[UpdatedAt] [datetime2](0) NULL,
 CONSTRAINT [PK_AppUser] PRIMARY KEY CLUSTERED
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_AppUser_Email] UNIQUE NONCLUSTERED
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[AppUser] ADD  CONSTRAINT [DF_AppUser_UserId]  DEFAULT (newsequentialid()) FOR [UserId]
GO

ALTER TABLE [dbo].[AppUser] ADD  CONSTRAINT [DF_AppUser_IsBlocked]  DEFAULT ((0)) FOR [IsBlocked]
GO

ALTER TABLE [dbo].[AppUser] ADD  CONSTRAINT [DF_AppUser_RequiresNewPassword]  DEFAULT ((0)) FOR [RequiresNewPassword]
GO

ALTER TABLE [dbo].[AppUser] ADD  CONSTRAINT [DF_AppUser_MustUpdate]  DEFAULT ((0)) FOR [MustUpdate]
GO

ALTER TABLE [dbo].[AppUser] ADD  CONSTRAINT [DF_AppUser_Status]  DEFAULT ('A') FOR [Status]
GO

ALTER TABLE [dbo].[AppUser] ADD  CONSTRAINT [DF_AppUser_CreatedAt]  DEFAULT (sysdatetime()) FOR [CreatedAt]
GO

ALTER TABLE [dbo].[AppUser]  WITH CHECK ADD  CONSTRAINT [FK_AppUser_Person] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([PersonId])
GO

ALTER TABLE [dbo].[AppUser] CHECK CONSTRAINT [FK_AppUser_Person]
GO

ALTER TABLE [dbo].[AppUser]  WITH CHECK ADD  CONSTRAINT [FK_AppUser_Status] FOREIGN KEY([Status])
REFERENCES [dbo].[EntityStatus] ([StatusCode])
GO

ALTER TABLE [dbo].[AppUser] CHECK CONSTRAINT [FK_AppUser_Status]
GO

ALTER TABLE [dbo].[AppUser]  WITH CHECK ADD  CONSTRAINT [CK_AppUser_Email_NotBlank] CHECK  ((len(ltrim(rtrim([Email])))>(0)))
GO

ALTER TABLE [dbo].[AppUser] CHECK CONSTRAINT [CK_AppUser_Email_NotBlank]
GO

ALTER TABLE [dbo].[AppUser]  WITH CHECK ADD  CONSTRAINT [CK_AppUser_PasswordHash_NotBlank] CHECK  ((len(ltrim(rtrim([PasswordHash])))>(0)))
GO

ALTER TABLE [dbo].[AppUser] CHECK CONSTRAINT [CK_AppUser_PasswordHash_NotBlank]
GO
