USE [StockData]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RoundData_Prediction](
	[RoundID] [int] NOT NULL,
	[PredictionIsBull] [bit] NULL,
	[PredictionIsBull2] [bit] NULL,
	[PredictionIsBullV2] [bit] NULL,
	[PredictionIsBullV3_0123] [bit] NULL,
	[PredictionIsBullV1_0123] [bit] NULL,
	[Score] [float] NULL,
	[TestSetAccuracy] [float] NULL,
	[kValue] [int] NULL,
	[AgainstPercent] [float] NULL,
 CONSTRAINT [PK_RoundData_Prediction1] PRIMARY KEY CLUSTERED 
(
	[RoundID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO