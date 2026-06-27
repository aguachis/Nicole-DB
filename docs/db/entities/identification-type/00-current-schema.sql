USE [Nicole]
GO

/****** Object:  Table [dbo].[IdentificationType]    Script Date: 19/6/2026 11:40:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[IdentificationType](
	[IdentificationTypeId] [char](2) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](150) NULL,
	[Status] [char](1) NOT NULL,
	[CreatedAt] [datetime2](0) NOT NULL,
	[UpdatedAt] [datetime2](0) NULL,
 CONSTRAINT [PK_IdentificationType] PRIMARY KEY CLUSTERED 
(
	[IdentificationTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_IdentificationType_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[IdentificationType] ADD  CONSTRAINT [DF_IdentificationType_Status]  DEFAULT ('A') FOR [Status]
GO

ALTER TABLE [dbo].[IdentificationType] ADD  CONSTRAINT [DF_IdentificationType_CreatedAt]  DEFAULT (sysdatetime()) FOR [CreatedAt]
GO

ALTER TABLE [dbo].[IdentificationType]  WITH CHECK ADD  CONSTRAINT [FK_IdentificationType_Status] FOREIGN KEY([Status])
REFERENCES [dbo].[EntityStatus] ([StatusCode])
GO

ALTER TABLE [dbo].[IdentificationType] CHECK CONSTRAINT [FK_IdentificationType_Status]
GO
