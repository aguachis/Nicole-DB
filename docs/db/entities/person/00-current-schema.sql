USE [Nicole]
GO

/****** Object:  Table [dbo].[Person]    Script Date: 19/6/2026 11:47:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Person](
	[PersonId] [uniqueidentifier] NOT NULL,
	[IdentificationType] [char](2) NOT NULL,
	[Identification] [nvarchar](20) NOT NULL,
	[PersonType] [char](1) NOT NULL,
	[LastName] [nvarchar](80) NULL,
	[MiddleName] [nvarchar](80) NULL,
	[FirstName] [nvarchar](200) NULL,
	[BusinessName] [nvarchar](200) NULL,
	[Gender] [char](1) NULL,
	[BirthDate] [date] NULL,
	[Address] [nvarchar](300) NULL,
	[Phone] [nvarchar](50) NULL,
	[Email] [nvarchar](150) NULL,
	[Province] [char](3) NULL,
	[City] [int] NULL,
	[Remarks] [nvarchar](500) NULL,
	[Status] [char](1) NOT NULL,
	[CreatedBy] [nvarchar](80) NOT NULL,
	[CreatedAt] [datetime2](0) NOT NULL,
	[UpdatedBy] [nvarchar](80) NULL,
	[UpdatedAt] [datetime2](0) NULL,
 CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Person_IdentificationType_Identification] UNIQUE NONCLUSTERED 
(
	[IdentificationType] ASC,
	[Identification] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Person] ADD  CONSTRAINT [DF_Person_PersonId]  DEFAULT (newsequentialid()) FOR [PersonId]
GO

ALTER TABLE [dbo].[Person] ADD  CONSTRAINT [DF_Person_Status]  DEFAULT ('A') FOR [Status]
GO

ALTER TABLE [dbo].[Person] ADD  CONSTRAINT [DF_Person_CreatedAt]  DEFAULT (sysdatetime()) FOR [CreatedAt]
GO

ALTER TABLE [dbo].[Person]  WITH CHECK ADD  CONSTRAINT [FK_Person_IdentificationType] FOREIGN KEY([IdentificationType])
REFERENCES [dbo].[IdentificationType] ([IdentificationTypeId])
GO

ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_Person_IdentificationType]
GO

ALTER TABLE [dbo].[Person]  WITH CHECK ADD  CONSTRAINT [FK_Person_PersonType] FOREIGN KEY([PersonType])
REFERENCES [dbo].[PersonType] ([PersonTypeId])
GO

ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_Person_PersonType]
GO

ALTER TABLE [dbo].[Person]  WITH CHECK ADD  CONSTRAINT [FK_Person_Status] FOREIGN KEY([Status])
REFERENCES [dbo].[EntityStatus] ([StatusCode])
GO

ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_Person_Status]
GO

ALTER TABLE [dbo].[Person]  WITH CHECK ADD  CONSTRAINT [CK_Person_Gender] CHECK  (([Gender] IS NULL OR ([Gender]='F' OR [Gender]='M')))
GO

ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [CK_Person_Gender]
GO

ALTER TABLE [dbo].[Person]  WITH CHECK ADD  CONSTRAINT [CK_Person_Identification_NotBlank] CHECK  ((len(ltrim(rtrim([Identification])))>(0)))
GO

ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [CK_Person_Identification_NotBlank]
GO

ALTER TABLE [dbo].[Person]  WITH CHECK ADD  CONSTRAINT [CK_Person_NaturalOrLegalData] CHECK  (([PersonType]='N' AND len(ltrim(rtrim(isnull([FirstName],''))))>(0) AND len(ltrim(rtrim(isnull([LastName],''))))>(0) OR [PersonType]='J' AND len(ltrim(rtrim(isnull([BusinessName],''))))>(0)))
GO

ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [CK_Person_NaturalOrLegalData]
GO
