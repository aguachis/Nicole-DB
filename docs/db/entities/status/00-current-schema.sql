USE [Nicole]
GO

/****** Object:  Table [dbo].[EntityStatus]    Script Date: 19/6/2026 11:37:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[EntityStatus](
	[StatusCode] [char](1) NOT NULL,
	[StatusName] [nvarchar](100) NOT NULL,
	[StatusDescription] [nvarchar](255) NULL,
	[IsActive] [bit] NOT NULL,
	[SortOrder] [tinyint] NOT NULL,
	[CreatedAt] [datetime2](0) NOT NULL,
	[UpdatedAt] [datetime2](0) NULL,
 CONSTRAINT [PK_EntityStatus] PRIMARY KEY CLUSTERED
(
	[StatusCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_EntityStatus_StatusName] UNIQUE NONCLUSTERED
(
	[StatusName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[EntityStatus] ADD  CONSTRAINT [DF_EntityStatus_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dbo].[EntityStatus] ADD  CONSTRAINT [DF_EntityStatus_SortOrder]  DEFAULT ((0)) FOR [SortOrder]
GO

ALTER TABLE [dbo].[EntityStatus] ADD  CONSTRAINT [DF_EntityStatus_CreatedAt]  DEFAULT (sysdatetime()) FOR [CreatedAt]
GO

ALTER TABLE [dbo].[EntityStatus]  WITH CHECK ADD  CONSTRAINT [CK_EntityStatus_StatusCode] CHECK  (([StatusCode]='I' OR [StatusCode]='A'))
GO

ALTER TABLE [dbo].[EntityStatus] CHECK CONSTRAINT [CK_EntityStatus_StatusCode]
GO
