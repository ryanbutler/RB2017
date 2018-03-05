USE [RB]
GO

/****** Object:  Table [dukeblue].[Contact_Form]    Script Date: 3/5/2018 12:15:45 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dukeblue].[Contact_Form](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Article_Name] [varchar](100) NOT NULL,
	[Guid] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dukeblue].[Contact_Form] ADD  CONSTRAINT [DF_Contact_Form_Guid]  DEFAULT (newid()) FOR [Guid]
GO


