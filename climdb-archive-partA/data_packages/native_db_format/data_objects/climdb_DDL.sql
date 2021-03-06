USE [climdb]
GO
/****** Object:  User [yxia]    Script Date: 02/18/2021 09:38:29 ******/
CREATE USER [yxia] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[yxia]
GO
/****** Object:  User [suzanne]    Script Date: 02/18/2021 09:38:29 ******/
CREATE USER [suzanne] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[suzanne]
GO
/****** Object:  User [sremillard]    Script Date: 02/18/2021 09:38:29 ******/
CREATE USER [sremillard] WITH DEFAULT_SCHEMA=[sremillard]
GO
/****** Object:  User [sbackup]    Script Date: 02/18/2021 09:38:29 ******/
CREATE USER [sbackup] WITH DEFAULT_SCHEMA=[sbackup]
GO
/****** Object:  User [LTER\yxia]    Script Date: 02/18/2021 09:38:29 ******/
CREATE USER [LTER\yxia] WITH DEFAULT_SCHEMA=[LTER\yxia]
GO
/****** Object:  User [LTER\jbrunt]    Script Date: 02/18/2021 09:38:29 ******/
CREATE USER [LTER\jbrunt] WITH DEFAULT_SCHEMA=[LTER\jbrunt]
GO
/****** Object:  User [kotwicak]    Script Date: 02/18/2021 09:38:29 ******/
CREATE USER [kotwicak] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[kotwicak]
GO
/****** Object:  User [james]    Script Date: 02/18/2021 09:38:29 ******/
CREATE USER [james] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[james]
GO
/****** Object:  User [FORESTRY\Remillar]    Script Date: 02/18/2021 09:38:29 ******/
CREATE USER [FORESTRY\Remillar] WITH DEFAULT_SCHEMA=[FORESTRY\Remillar]
GO
/****** Object:  User [flow]    Script Date: 02/18/2021 09:38:29 ******/
CREATE USER [flow] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[flow]
GO
/****** Object:  User [climdbquery]    Script Date: 02/18/2021 09:38:29 ******/
CREATE USER [climdbquery] FOR LOGIN [climdbquery] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [climdb]    Script Date: 02/18/2021 09:38:29 ******/
CREATE USER [climdb] FOR LOGIN [climdb] WITH DEFAULT_SCHEMA=[climdb]
GO
/****** Object:  Schema [yxia]    Script Date: 02/18/2021 09:38:29 ******/
CREATE SCHEMA [yxia] AUTHORIZATION [yxia]
GO
/****** Object:  Schema [suzanne]    Script Date: 02/18/2021 09:38:29 ******/
CREATE SCHEMA [suzanne] AUTHORIZATION [suzanne]
GO
/****** Object:  Schema [sremillard]    Script Date: 02/18/2021 09:38:29 ******/
CREATE SCHEMA [sremillard] AUTHORIZATION [sremillard]
GO
/****** Object:  Schema [sbackup]    Script Date: 02/18/2021 09:38:29 ******/
CREATE SCHEMA [sbackup] AUTHORIZATION [sbackup]
GO
/****** Object:  Schema [LTER\yxia]    Script Date: 02/18/2021 09:38:29 ******/
CREATE SCHEMA [LTER\yxia] AUTHORIZATION [LTER\yxia]
GO
/****** Object:  Schema [LTER\jbrunt]    Script Date: 02/18/2021 09:38:29 ******/
CREATE SCHEMA [LTER\jbrunt] AUTHORIZATION [LTER\jbrunt]
GO
/****** Object:  Schema [kotwicak]    Script Date: 02/18/2021 09:38:29 ******/
CREATE SCHEMA [kotwicak] AUTHORIZATION [kotwicak]
GO
/****** Object:  Schema [james]    Script Date: 02/18/2021 09:38:29 ******/
CREATE SCHEMA [james] AUTHORIZATION [james]
GO
/****** Object:  Schema [FORESTRY\Remillar]    Script Date: 02/18/2021 09:38:29 ******/
CREATE SCHEMA [FORESTRY\Remillar] AUTHORIZATION [FORESTRY\Remillar]
GO
/****** Object:  Schema [flow]    Script Date: 02/18/2021 09:38:29 ******/
CREATE SCHEMA [flow] AUTHORIZATION [flow]
GO
/****** Object:  Schema [climdb]    Script Date: 02/18/2021 09:38:29 ******/
CREATE SCHEMA [climdb] AUTHORIZATION [climdb]
GO
/****** Object:  Table [dbo].[aggregate_type]    Script Date: 02/18/2021 09:38:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[aggregate_type](
	[aggregate_type] [varchar](10) NOT NULL,
	[agg_type_desc] [char](50) NULL,
 CONSTRAINT [PK_aggregate_type] PRIMARY KEY CLUSTERED 
(
	[aggregate_type] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [LTER\yxia].[agg_temp]    Script Date: 02/18/2021 09:38:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [LTER\yxia].[agg_temp](
	[res_site_id] [int] NOT NULL,
	[site_id] [int] NOT NULL,
	[site_code] [varchar](3) NOT NULL,
	[station] [varchar](10) NOT NULL,
	[variable] [varchar](4) NOT NULL,
	[year] [numeric](4, 0) NOT NULL,
	[month] [numeric](2, 0) NOT NULL,
	[aggregate_type] [varchar](10) NOT NULL,
	[value] [varchar](15) NULL,
	[num_get] [numeric](7, 0) NOT NULL,
	[num_e] [numeric](7, 0) NOT NULL,
	[last_update] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[agg_temp]    Script Date: 02/18/2021 09:38:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[agg_temp](
	[res_site_id] [int] NOT NULL,
	[site_id] [int] NOT NULL,
	[site_code] [varchar](3) NOT NULL,
	[station] [varchar](10) NOT NULL,
	[variable] [varchar](4) NOT NULL,
	[year] [numeric](4, 0) NOT NULL,
	[month] [numeric](2, 0) NOT NULL,
	[aggregate_type] [varchar](10) NOT NULL,
	[value] [varchar](12) NULL,
	[num_get] [numeric](7, 0) NOT NULL,
	[num_e] [numeric](7, 0) NOT NULL,
	[last_update] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[climdb_site_variable_dates_old]    Script Date: 02/18/2021 09:38:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[climdb_site_variable_dates_old](
	[site_id] [int] NOT NULL,
	[site_code] [varchar](3) NOT NULL,
	[station] [varchar](10) NOT NULL,
	[variable] [varchar](4) NOT NULL,
	[first_seen] [datetime] NOT NULL,
	[most_recent] [datetime] NOT NULL,
	[last_update] [datetime] NOT NULL,
 CONSTRAINT [PK_climdb_site_variable_dates] PRIMARY KEY CLUSTERED 
(
	[site_code] ASC,
	[station] ASC,
	[variable] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[descriptor_category]    Script Date: 02/18/2021 09:38:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[descriptor_category](
	[descriptor_category_id] [int] NOT NULL,
	[descriptor_category_name] [varchar](50) NULL,
	[descriptor_category_desc] [varchar](140) NULL,
	[descriptor_order] [int] NULL,
 CONSTRAINT [PK_descriptor_category] PRIMARY KEY CLUSTERED 
(
	[descriptor_category_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [LTER\yxia].[dates_temp]    Script Date: 02/18/2021 09:38:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [LTER\yxia].[dates_temp](
	[res_site_id] [int] NOT NULL,
	[site_id] [int] NOT NULL,
	[site_code] [varchar](3) NOT NULL,
	[station] [varchar](10) NOT NULL,
	[variable] [varchar](4) NOT NULL,
	[first_seen] [datetime] NOT NULL,
	[most_recent] [datetime] NOT NULL,
	[last_update] [datetime] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[dates_temp]    Script Date: 02/18/2021 09:38:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dates_temp](
	[res_site_id] [int] NOT NULL,
	[site_id] [int] NOT NULL,
	[site_code] [varchar](3) NOT NULL,
	[station] [varchar](10) NOT NULL,
	[variable] [varchar](4) NOT NULL,
	[first_seen] [datetime] NOT NULL,
	[most_recent] [datetime] NOT NULL,
	[last_update] [datetime] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [kotwicak].[glitch_test]    Script Date: 02/18/2021 09:38:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [kotwicak].[glitch_test](
	[date_time] [datetime] NOT NULL,
	[precip5] [numeric](6, 2) NULL,
	[fp1] [char](1) NULL,
	[probe] [char](8) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[hydrodb]    Script Date: 02/18/2021 09:38:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[hydrodb](
	[LTER_SITE] [varchar](3) NOT NULL,
	[STATION] [varchar](10) NOT NULL,
	[SAMPLEDATE] [datetime] NOT NULL,
	[VARIABLE] [varchar](4) NOT NULL,
	[VALUE] [varchar](10) NOT NULL,
	[FLAG] [varchar](1) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[descriptor_type]    Script Date: 02/18/2021 09:38:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[descriptor_type](
	[descriptor_type_id] [int] NOT NULL,
	[descriptor_type_code] [varchar](50) NULL,
	[descriptor_type_name] [varchar](50) NULL,
	[descriptor_type_unit] [varchar](50) NULL,
	[descriptor_type_desc] [varchar](254) NULL,
	[descriptor_type_length] [char](1) NULL,
 CONSTRAINT [PK_descriptor_type] PRIMARY KEY CLUSTERED 
(
	[descriptor_type_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[masterdate]    Script Date: 02/18/2021 09:38:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[masterdate](
	[sampledate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mailing_list]    Script Date: 02/18/2021 09:38:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[mailing_list](
	[mailing_list_id] [int] NOT NULL,
	[mailing_list_name] [varchar](128) NOT NULL,
	[mailing_list_address] [varchar](128) NOT NULL,
	[mailing_list_desc] [varchar](4000) NULL,
 CONSTRAINT [PK_mailing_list] PRIMARY KEY CLUSTERED 
(
	[mailing_list_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[junk1]    Script Date: 02/18/2021 09:38:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[junk1](
	[res_site_id] [int] NOT NULL,
	[site_id] [int] NOT NULL,
	[res_site_parent_id] [int] NULL,
	[res_sitetype_id] [int] NULL,
	[res_site_code] [varchar](10) NULL,
	[res_site_name] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[junk]    Script Date: 02/18/2021 09:38:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[junk](
	[site_code] [varchar](3) NOT NULL,
	[station] [varchar](10) NOT NULL,
	[variable] [varchar](4) NOT NULL,
	[date] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[personnel]    Script Date: 02/18/2021 09:38:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[personnel](
	[personnel_id] [int] NOT NULL,
	[last_name] [varchar](45) NOT NULL,
	[first_name] [varchar](25) NOT NULL,
	[middle_name] [varchar](25) NULL,
	[address] [varchar](260) NULL,
	[city] [varchar](50) NULL,
	[state] [varchar](25) NULL,
	[postal_code] [varchar](25) NULL,
	[country] [varchar](25) NULL,
	[telephone1] [varchar](25) NULL,
	[telephone2] [varchar](25) NULL,
	[email1] [varchar](50) NULL,
	[email2] [varchar](50) NULL,
	[fax1] [varchar](15) NULL,
	[fax2] [varchar](15) NULL,
 CONSTRAINT [PK_personnel] PRIMARY KEY CLUSTERED 
(
	[personnel_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [kotwicak].[tmp]    Script Date: 02/18/2021 09:38:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [kotwicak].[tmp](
	[month] [numeric](2, 0) NOT NULL,
	[year] [numeric](4, 0) NOT NULL,
	[value] [varchar](12) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [climdb].[tmp]    Script Date: 02/18/2021 09:38:33 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [climdb].[tmp](
	[month] [numeric](2, 0) NOT NULL,
	[year] [numeric](4, 0) NOT NULL,
	[value] [varchar](15) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [climdb].[temp9]    Script Date: 02/18/2021 09:38:33 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [climdb].[temp9](
	[site_code] [varchar](3) NOT NULL,
	[station] [varchar](10) NOT NULL,
	[sampledate] [datetime] NOT NULL,
	[value] [varchar](10) NULL,
	[flag] [varchar](1) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [climdb].[temp8]    Script Date: 02/18/2021 09:38:33 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [climdb].[temp8](
	[site_code] [varchar](3) NOT NULL,
	[station] [varchar](10) NOT NULL,
	[sampledate] [datetime] NOT NULL,
	[value] [varchar](10) NULL,
	[flag] [varchar](1) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [climdb].[temp7]    Script Date: 02/18/2021 09:38:33 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [climdb].[temp7](
	[site_code] [varchar](3) NOT NULL,
	[station] [varchar](10) NOT NULL,
	[sampledate] [datetime] NOT NULL,
	[value] [varchar](10) NULL,
	[flag] [varchar](1) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [climdb].[temp6]    Script Date: 02/18/2021 09:38:33 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [climdb].[temp6](
	[site_code] [varchar](3) NOT NULL,
	[station] [varchar](10) NOT NULL,
	[sampledate] [datetime] NOT NULL,
	[value] [varchar](10) NULL,
	[flag] [varchar](1) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [climdb].[temp5]    Script Date: 02/18/2021 09:38:33 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [climdb].[temp5](
	[site_code] [varchar](3) NOT NULL,
	[station] [varchar](10) NOT NULL,
	[sampledate] [datetime] NOT NULL,
	[value] [varchar](10) NULL,
	[flag] [varchar](1) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [climdb].[temp4]    Script Date: 02/18/2021 09:38:33 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [climdb].[temp4](
	[site_code] [varchar](3) NOT NULL,
	[station] [varchar](10) NOT NULL,
	[sampledate] [datetime] NOT NULL,
	[value] [varchar](10) NULL,
	[flag] [varchar](1) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [climdb].[temp3]    Script Date: 02/18/2021 09:38:33 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [climdb].[temp3](
	[site_code] [varchar](3) NOT NULL,
	[station] [varchar](10) NOT NULL,
	[sampledate] [datetime] NOT NULL,
	[value] [varchar](10) NULL,
	[flag] [varchar](1) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [kotwicak].[temp2]    Script Date: 02/18/2021 09:38:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [kotwicak].[temp2](
	[date_time] [datetime] NOT NULL,
	[precip5] [numeric](6, 2) NULL,
	[fp1] [char](1) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [climdb].[temp2]    Script Date: 02/18/2021 09:38:33 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [climdb].[temp2](
	[site_code] [varchar](3) NOT NULL,
	[station] [varchar](10) NOT NULL,
	[sampledate] [datetime] NOT NULL,
	[value] [varchar](10) NULL,
	[flag] [varchar](1) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [climdb].[temp17]    Script Date: 02/18/2021 09:38:33 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [climdb].[temp17](
	[site_code] [varchar](3) NOT NULL,
	[station] [varchar](10) NOT NULL,
	[year] [numeric](4, 0) NOT NULL,
	[month] [numeric](2, 0) NOT NULL,
	[variable] [varchar](4) NOT NULL,
	[value] [varchar](15) NULL,
	[num_e] [numeric](7, 0) NOT NULL,
	[num_get] [numeric](7, 0) NOT NULL,
	[decimals] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [climdb].[temp16]    Script Date: 02/18/2021 09:38:33 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [climdb].[temp16](
	[site_code] [varchar](3) NOT NULL,
	[station] [varchar](10) NOT NULL,
	[year] [numeric](4, 0) NOT NULL,
	[month] [numeric](2, 0) NOT NULL,
	[variable] [varchar](4) NOT NULL,
	[value] [varchar](15) NULL,
	[num_e] [numeric](7, 0) NOT NULL,
	[num_get] [numeric](7, 0) NOT NULL,
	[decimals] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [climdb].[temp15]    Script Date: 02/18/2021 09:38:33 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [climdb].[temp15](
	[site_code] [varchar](3) NOT NULL,
	[station] [varchar](10) NOT NULL,
	[sampledate] [datetime] NOT NULL,
	[value] [varchar](10) NULL,
	[flag] [varchar](1) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [climdb].[temp14]    Script Date: 02/18/2021 09:38:33 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [climdb].[temp14](
	[site_code] [varchar](3) NOT NULL,
	[station] [varchar](10) NOT NULL,
	[sampledate] [datetime] NOT NULL,
	[value] [varchar](10) NULL,
	[flag] [varchar](1) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [climdb].[temp13]    Script Date: 02/18/2021 09:38:33 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [climdb].[temp13](
	[site_code] [varchar](3) NOT NULL,
	[station] [varchar](10) NOT NULL,
	[sampledate] [datetime] NOT NULL,
	[value] [varchar](10) NULL,
	[flag] [varchar](1) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [climdb].[temp12]    Script Date: 02/18/2021 09:38:33 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [climdb].[temp12](
	[site_code] [varchar](3) NOT NULL,
	[station] [varchar](10) NOT NULL,
	[sampledate] [datetime] NOT NULL,
	[value] [varchar](10) NULL,
	[flag] [varchar](1) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [climdb].[temp11]    Script Date: 02/18/2021 09:38:33 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [climdb].[temp11](
	[site_code] [varchar](3) NOT NULL,
	[station] [varchar](10) NOT NULL,
	[sampledate] [datetime] NOT NULL,
	[value] [varchar](10) NULL,
	[flag] [varchar](1) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [climdb].[temp10]    Script Date: 02/18/2021 09:38:33 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [climdb].[temp10](
	[site_code] [varchar](3) NOT NULL,
	[station] [varchar](10) NOT NULL,
	[sampledate] [datetime] NOT NULL,
	[value] [varchar](10) NULL,
	[flag] [varchar](1) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [kotwicak].[temp1]    Script Date: 02/18/2021 09:38:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [kotwicak].[temp1](
	[site_code] [varchar](3) NOT NULL,
	[station] [varchar](10) NOT NULL,
	[year] [numeric](4, 0) NOT NULL,
	[month] [numeric](2, 0) NOT NULL,
	[variable] [varchar](4) NOT NULL,
	[value] [varchar](15) NULL,
	[num_e] [numeric](7, 0) NOT NULL,
	[num_get] [numeric](7, 0) NOT NULL,
	[decimals] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [climdb].[temp1]    Script Date: 02/18/2021 09:38:33 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [climdb].[temp1](
	[site_code] [varchar](3) NOT NULL,
	[station] [varchar](10) NOT NULL,
	[sampledate] [datetime] NOT NULL,
	[value] [varchar](10) NULL,
	[flag] [varchar](1) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [kotwicak].[glitch1]    Script Date: 02/18/2021 09:38:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [kotwicak].[glitch1]
@begin datetime, @end datetime, @now datetime, @frequency int
AS

CREATE TABLE climdb..temp1 (date_time datetime)

WHILE (DATEDIFF (minute, @now ,@end) > 0)
BEGIN
	SET @now = (DATEADD(minute, @frequency, @now)) 
	INSERT INTO climdb..temp1
		(DATE_TIME)
	VALUES 
		(@now)
END
GO
/****** Object:  Table [kotwicak].[temp0]    Script Date: 02/18/2021 09:38:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [kotwicak].[temp0](
	[site_code] [varchar](3) NOT NULL,
	[station] [varchar](10) NOT NULL,
	[year] [numeric](4, 0) NOT NULL,
	[month] [numeric](2, 0) NOT NULL,
	[variable] [varchar](4) NOT NULL,
	[value] [varchar](15) NULL,
	[num_e] [numeric](7, 0) NOT NULL,
	[num_get] [numeric](7, 0) NOT NULL,
	[decimals] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [climdb].[temp0]    Script Date: 02/18/2021 09:38:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [climdb].[temp0](
	[site_code] [varchar](3) NOT NULL,
	[station] [varchar](10) NOT NULL,
	[sampledate] [datetime] NOT NULL,
	[value] [varchar](10) NULL,
	[flag] [varchar](1) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [kotwicak].[temp_union]    Script Date: 02/18/2021 09:38:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kotwicak].[temp_union](
	[mindate] [numeric](4, 0) NULL,
	[maxdate] [numeric](4, 0) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [climdb].[temp_union]    Script Date: 02/18/2021 09:38:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [climdb].[temp_union](
	[mindate] [datetime] NULL,
	[maxdate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [FORESTRY\Remillar].[temp_kbs]    Script Date: 02/18/2021 09:38:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [FORESTRY\Remillar].[temp_kbs](
	[res_site_id] [int] NOT NULL,
	[site_id] [int] NOT NULL,
	[site_code] [varchar](3) NOT NULL,
	[station] [varchar](10) NOT NULL,
	[sampledate] [datetime] NOT NULL,
	[variable] [varchar](4) NOT NULL,
	[value] [varchar](10) NULL,
	[flag] [varchar](1) NULL,
	[last_update] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [kotwicak].[temp_dates]    Script Date: 02/18/2021 09:38:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [kotwicak].[temp_dates](
	[site_code] [varchar](3) NOT NULL,
	[station] [varchar](6) NOT NULL,
	[year] [int] NULL,
	[month] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [climdb].[temp_dates]    Script Date: 02/18/2021 09:38:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [climdb].[temp_dates](
	[site_code] [varchar](3) NOT NULL,
	[station] [varchar](6) NOT NULL,
	[sampledate] [datetime] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[temp]    Script Date: 02/18/2021 09:38:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[temp](
	[site_code] [varchar](3) NOT NULL,
	[station] [varchar](10) NOT NULL,
	[year] [numeric](4, 0) NOT NULL,
	[month] [numeric](2, 0) NOT NULL,
	[variable] [varchar](4) NOT NULL,
	[value] [varchar](15) NULL,
	[num_e] [numeric](7, 0) NOT NULL,
	[decimals] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TABLE1]    Script Date: 02/18/2021 09:38:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TABLE1](
	[LTER_SITE] [varchar](3) NOT NULL,
	[STATION] [varchar](10) NOT NULL,
	[VARIABLE] [varchar](4) NOT NULL,
	[FIRST_SEEN] [datetime] NOT NULL,
	[MOST_RECENT] [datetime] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[stations_old]    Script Date: 02/18/2021 09:38:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stations_old](
	[site_code] [varchar](3) NOT NULL,
	[station] [varchar](10) NOT NULL,
	[description] [varchar](100) NULL,
	[latitude_dec] [numeric](7, 4) NULL,
	[longitude_dec] [numeric](7, 4) NULL,
 CONSTRAINT [PK_STATIONS] PRIMARY KEY CLUSTERED 
(
	[site_code] ASC,
	[station] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[weirdate]    Script Date: 02/18/2021 09:38:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[weirdate](
	[sitecode] [char](1) NOT NULL,
	[wsnumber] [char](2) NOT NULL,
	[eq_set] [char](1) NOT NULL,
	[eq_ver] [char](1) NOT NULL,
	[current] [bit] NOT NULL,
	[date_bgn] [char](8) NOT NULL,
	[time_bgn] [char](4) NOT NULL,
	[date_end] [char](8) NOT NULL,
	[time_end] [char](4) NOT NULL,
	[comments] [char](50) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[weir_eqn]    Script Date: 02/18/2021 09:38:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[weir_eqn](
	[sitecode] [char](1) NOT NULL,
	[wsnumber] [char](2) NOT NULL,
	[eq_set] [char](1) NOT NULL,
	[eq_ver] [char](1) NOT NULL,
	[eq_num] [char](1) NOT NULL,
	[ws_area] [char](5) NOT NULL,
	[max_ht] [char](5) NOT NULL,
	[ln_a] [char](8) NOT NULL,
	[b] [char](8) NOT NULL,
	[c] [char](8) NOT NULL,
	[d] [char](8) NOT NULL,
	[ln_a_old] [char](9) NOT NULL,
	[b_old] [char](9) NOT NULL,
	[c_old] [char](9) NOT NULL,
	[d_old] [char](9) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[site]    Script Date: 02/18/2021 09:38:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[site](
	[site_id] [int] NOT NULL,
	[site_code] [varchar](3) NOT NULL,
	[site_name] [varchar](50) NULL,
	[loc1] [varchar](30) NULL,
	[loc2] [varchar](30) NULL,
	[latitude_dec] [numeric](7, 4) NULL,
	[longitude_dec] [numeric](7, 4) NULL,
	[hydro_data_url] [char](190) NULL,
	[clim_data_url] [char](190) NULL,
	[usgs_data_url] [char](190) NULL,
	[site_url] [char](140) NULL,
 CONSTRAINT [PK_site] PRIMARY KEY CLUSTERED 
(
	[site_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [IX_lter_sites] UNIQUE NONCLUSTERED 
(
	[site_code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_site] ON [dbo].[site] 
(
	[site_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_site_1] ON [dbo].[site] 
(
	[site_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[session]    Script Date: 02/18/2021 09:38:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[session](
	[session_id] [int] NOT NULL,
	[datetime] [datetime] NOT NULL,
	[ip_address] [char](15) NOT NULL,
	[requestor] [char](35) NOT NULL,
	[organization] [char](50) NOT NULL,
	[purpose] [char](254) NOT NULL,
 CONSTRAINT [PK_session] PRIMARY KEY CLUSTERED 
(
	[session_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[research_site_type]    Script Date: 02/18/2021 09:38:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[research_site_type](
	[res_sitetype_id] [int] NOT NULL,
	[res_sitetype_name] [varchar](50) NULL,
	[res_sitetype_desc] [varchar](50) NULL,
 CONSTRAINT [PK_research_site_type_1] PRIMARY KEY CLUSTERED 
(
	[res_sitetype_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[research_module]    Script Date: 02/18/2021 09:38:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[research_module](
	[res_module_id] [int] NOT NULL,
	[res_module_name] [varchar](10) NOT NULL,
 CONSTRAINT [PK_research_module] PRIMARY KEY CLUSTERED 
(
	[res_module_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[personnel_role]    Script Date: 02/18/2021 09:38:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[personnel_role](
	[personnel_role_id] [int] NOT NULL,
	[personnel_role_desc] [varchar](50) NOT NULL,
 CONSTRAINT [PK_personnel_role] PRIMARY KEY CLUSTERED 
(
	[personnel_role_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[download]    Script Date: 02/18/2021 09:38:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[download](
	[download_id] [int] NOT NULL,
	[session_id] [int] NOT NULL,
	[ip_address] [char](15) NOT NULL,
	[file_type] [char](10) NOT NULL,
	[datetime] [datetime] NOT NULL,
 CONSTRAINT [PK_download] PRIMARY KEY CLUSTERED 
(
	[download_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[research_site]    Script Date: 02/18/2021 09:38:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[research_site](
	[res_site_id] [int] NOT NULL,
	[site_id] [int] NOT NULL,
	[res_site_parent_id] [int] NULL,
	[res_site_code] [varchar](10) NOT NULL,
	[res_site_name] [varchar](100) NULL,
 CONSTRAINT [PK_research_site] PRIMARY KEY CLUSTERED 
(
	[res_site_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_research_site] ON [dbo].[research_site] 
(
	[res_site_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[research_module_descriptor]    Script Date: 02/18/2021 09:38:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[research_module_descriptor](
	[res_module_id] [int] NOT NULL,
	[descriptor_category_id] [int] NOT NULL,
 CONSTRAINT [PK_research_module_descriptor] PRIMARY KEY CLUSTERED 
(
	[res_module_id] ASC,
	[descriptor_category_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[personnel_mailing_list]    Script Date: 02/18/2021 09:38:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[personnel_mailing_list](
	[mailing_list_id] [int] NOT NULL,
	[personnel_id] [int] NOT NULL,
 CONSTRAINT [PK_personnel_mailing_list] PRIMARY KEY CLUSTERED 
(
	[mailing_list_id] ASC,
	[personnel_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sitetype_descriptor_category]    Script Date: 02/18/2021 09:38:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sitetype_descriptor_category](
	[descriptor_category_id] [int] NOT NULL,
	[res_sitetype_id] [int] NOT NULL,
 CONSTRAINT [PK_sitetype_descriptor_category] PRIMARY KEY CLUSTERED 
(
	[descriptor_category_id] ASC,
	[res_sitetype_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[site_personnel_role]    Script Date: 02/18/2021 09:38:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[site_personnel_role](
	[site_id] [int] NOT NULL,
	[personnel_id] [int] NOT NULL,
	[personnel_role_id] [int] NOT NULL,
	[res_module_id] [int] NOT NULL,
 CONSTRAINT [PK_site_personnel_role] PRIMARY KEY CLUSTERED 
(
	[site_id] ASC,
	[personnel_id] ASC,
	[personnel_role_id] ASC,
	[res_module_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [kotwicak].[mydate]    Script Date: 02/18/2021 09:38:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [kotwicak].[mydate] @begin datetime, @end datetime, @now datetime
AS
SELECT @begin as mynow INTO temp1
WHILE (DATEDIFF (minute, (SELECT @now FROM temp1),@end) > 0)
	INSERT INTO temp2
		(@now)
	VALUES
		(DATEADD(minute, 5, @now))
GO
/****** Object:  Table [dbo].[descriptor_category_type]    Script Date: 02/18/2021 09:38:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[descriptor_category_type](
	[descriptor_category_id] [int] NOT NULL,
	[descriptor_type_id] [int] NOT NULL,
	[type_order] [int] NOT NULL,
 CONSTRAINT [PK_descriptor_category_type] PRIMARY KEY CLUSTERED 
(
	[descriptor_category_id] ASC,
	[descriptor_type_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[climdb_variables]    Script Date: 02/18/2021 09:38:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[climdb_variables](
	[variable_name] [varchar](60) NOT NULL,
	[variable] [varchar](4) NOT NULL,
	[fullname] [varchar](60) NULL,
	[aggregate_mean] [varchar](1) NOT NULL,
	[aggregate_total] [varchar](1) NOT NULL,
	[aggregate_min] [varchar](1) NOT NULL,
	[aggregate_max] [varchar](1) NOT NULL,
	[qc_min] [varchar](10) NULL,
	[qc_max] [varchar](10) NULL,
	[descriptor_category_id] [int] NOT NULL,
	[unit_desc] [char](30) NULL,
	[unit] [char](10) NULL,
	[decimals] [int] NULL,
 CONSTRAINT [PK_climdb_variables] PRIMARY KEY CLUSTERED 
(
	[variable] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [IX_climdb_variables] ON [dbo].[climdb_variables] 
(
	[descriptor_category_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[climdb_site_variable_dates]    Script Date: 02/18/2021 09:38:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[climdb_site_variable_dates](
	[res_site_id] [int] NOT NULL,
	[site_id] [int] NOT NULL,
	[site_code] [varchar](3) NOT NULL,
	[station] [varchar](10) NOT NULL,
	[variable] [varchar](4) NOT NULL,
	[first_seen] [datetime] NOT NULL,
	[most_recent] [datetime] NOT NULL,
	[last_update] [datetime] NOT NULL,
 CONSTRAINT [PK_climdb_site_variable_dates_1] PRIMARY KEY CLUSTERED 
(
	[res_site_id] ASC,
	[variable] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[climdb_raw]    Script Date: 02/18/2021 09:38:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[climdb_raw](
	[res_site_id] [int] NOT NULL,
	[site_id] [int] NOT NULL,
	[site_code] [varchar](3) NOT NULL,
	[station] [varchar](10) NOT NULL,
	[sampledate] [datetime] NOT NULL,
	[variable] [varchar](4) NOT NULL,
	[value] [varchar](10) NULL,
	[flag] [varchar](1) NULL,
	[last_update] [datetime] NULL,
 CONSTRAINT [PK_climdb_raw] PRIMARY KEY NONCLUSTERED 
(
	[res_site_id] ASC,
	[sampledate] ASC,
	[variable] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE CLUSTERED INDEX [IX_climdb_raw] ON [dbo].[climdb_raw] 
(
	[res_site_id] ASC,
	[variable] ASC,
	[sampledate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[climdb_agg]    Script Date: 02/18/2021 09:38:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[climdb_agg](
	[res_site_id] [int] NOT NULL,
	[site_id] [int] NOT NULL,
	[site_code] [varchar](3) NOT NULL,
	[station] [varchar](10) NOT NULL,
	[variable] [varchar](4) NOT NULL,
	[year] [numeric](4, 0) NOT NULL,
	[month] [numeric](2, 0) NOT NULL,
	[aggregate_type] [varchar](10) NOT NULL,
	[value] [varchar](15) NULL,
	[num_get] [numeric](7, 0) NOT NULL,
	[num_e] [numeric](7, 0) NOT NULL,
	[last_update] [datetime] NULL,
 CONSTRAINT [PK_climdb_agg] PRIMARY KEY CLUSTERED 
(
	[res_site_id] ASC,
	[variable] ASC,
	[year] ASC,
	[month] ASC,
	[aggregate_type] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[harvest_raw]    Script Date: 02/18/2021 09:38:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[harvest_raw](
	[res_site_id] [int] NOT NULL,
	[site_id] [int] NULL,
	[site_code] [varchar](3) NOT NULL,
	[station] [varchar](10) NOT NULL,
	[sampledate] [datetime] NOT NULL,
	[variable] [varchar](4) NOT NULL,
	[value] [varchar](10) NULL,
	[flag] [varchar](1) NULL,
 CONSTRAINT [PK_harvest_raw] PRIMARY KEY CLUSTERED 
(
	[res_site_id] ASC,
	[sampledate] ASC,
	[variable] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[get_personnel_mailing_list]    Script Date: 02/18/2021 09:38:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[get_personnel_mailing_list]
	
as
declare @procedure_name varchar(255)
select @procedure_name = sysobjects.name 
	from sysobjects where sysobjects.id = @@procid

select c.mailing_list_id,  c.mailing_list_name, rtrim(rtrim(a.last_name)+', '+rtrim(a.first_name) +' '+rtrim(a.middle_name)) as fullname,
	 a.email1
 from personnel a, personnel_mailing_list b,  mailing_list  c
 	 where a.personnel_id=b.personnel_id and
 	     b.mailing_list_id=c.mailing_list_id 
 	 order by c.mailing_list_id,fullname
return
GO
/****** Object:  Table [dbo].[research_site_sitetype]    Script Date: 02/18/2021 09:38:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[research_site_sitetype](
	[res_site_id] [int] NOT NULL,
	[res_sitetype_id] [int] NOT NULL,
 CONSTRAINT [PK_research_site_sitetype] PRIMARY KEY CLUSTERED 
(
	[res_site_id] ASC,
	[res_sitetype_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[research_site_module]    Script Date: 02/18/2021 09:38:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[research_site_module](
	[res_site_id] [int] NOT NULL,
	[res_module_id] [int] NOT NULL,
 CONSTRAINT [PK_research_site_module] PRIMARY KEY CLUSTERED 
(
	[res_site_id] ASC,
	[res_module_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[research_site_descriptor]    Script Date: 02/18/2021 09:38:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[research_site_descriptor](
	[res_site_id] [int] NOT NULL,
	[site_id] [int] NOT NULL,
	[descriptor_type_id] [int] NOT NULL,
	[descriptor_value] [varchar](8000) NULL,
	[last_update] [datetime] NULL,
 CONSTRAINT [PK_research_site_descriptor] PRIMARY KEY CLUSTERED 
(
	[res_site_id] ASC,
	[descriptor_type_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[vw_unnest_res_site_four_levels]    Script Date: 02/18/2021 09:38:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_unnest_res_site_four_levels]
AS
SELECT     TOP (10000) rs.res_site_id AS parent_res_site_id, rs.site_id, rs.res_site_parent_id, rs.res_site_code, rs.res_site_name, 
                      child1.res_site_id AS child1_res_site_id, child1.site_id AS Expr1, child1.res_site_parent_id AS Expr2, child1.res_site_code AS Expr3, 
                      child1.res_site_name AS Expr4, child2.res_site_id AS child2_res_site_id, child2.site_id AS Expr5, child2.res_site_parent_id AS Expr6, 
                      child2.res_site_code AS Expr7, child2.res_site_name AS Expr8, child3.res_site_id AS child3_res_site_id, child3.site_id AS Expr9, 
                      child3.res_site_parent_id AS Expr10, child3.res_site_code AS Expr11, child3.res_site_name AS Expr12
FROM         dbo.research_site AS rs LEFT OUTER JOIN
                      dbo.research_site AS child1 ON child1.res_site_parent_id = rs.res_site_id LEFT OUTER JOIN
                      dbo.research_site AS child2 ON child2.res_site_parent_id = child1.res_site_id LEFT OUTER JOIN
                      dbo.research_site AS child3 ON child3.res_site_parent_id = child2.res_site_id
ORDER BY rs.res_site_code, Expr3, Expr7, Expr11
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "rs"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "child1"
            Begin Extent = 
               Top = 114
               Left = 38
               Bottom = 222
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "child2"
            Begin Extent = 
               Top = 222
               Left = 38
               Bottom = 330
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "child3"
            Begin Extent = 
               Top = 330
               Left = 38
               Bottom = 438
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_unnest_res_site_four_levels'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_unnest_res_site_four_levels'
GO
/****** Object:  View [dbo].[vw_join_site_descriptors]    Script Date: 02/18/2021 09:38:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_join_site_descriptors]
AS
SELECT     TOP (100) PERCENT s.site_name, rs.res_site_id, rs.site_id, rs.res_site_parent_id, rs.res_site_code, rs.res_site_name, t.descriptor_type_name, 
                      d.descriptor_value, t.descriptor_type_unit
FROM         dbo.research_site AS rs INNER JOIN
                      dbo.site AS s ON rs.site_id = s.site_id INNER JOIN
                      dbo.research_site_descriptor AS d ON rs.res_site_id = d.res_site_id INNER JOIN
                      dbo.descriptor_type AS t ON d.descriptor_type_id = t.descriptor_type_id
WHERE     (d.descriptor_type_id IN (7, 8, 21, 22, 165, 166, 167, 168, 188, 189, 190, 191)) AND (d.descriptor_value IS NOT NULL) AND 
                      (d.descriptor_value NOT LIKE '')
ORDER BY s.site_name, rs.res_site_name
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "rs"
            Begin Extent = 
               Top = 114
               Left = 38
               Bottom = 222
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "s"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 192
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "d"
            Begin Extent = 
               Top = 222
               Left = 38
               Bottom = 330
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t"
            Begin Extent = 
               Top = 330
               Left = 38
               Bottom = 438
               Right = 230
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_join_site_descriptors'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_join_site_descriptors'
GO
/****** Object:  View [dbo].[research_site_descriptor_view]    Script Date: 02/18/2021 09:38:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[research_site_descriptor_view]
AS
SELECT     dbo.research_site_descriptor.*
FROM         dbo.research_site_descriptor
GO
/****** Object:  View [dbo].[join_methods_descriptions_sites]    Script Date: 02/18/2021 09:38:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[join_methods_descriptions_sites]
AS
SELECT     dt.descriptor_type_code AS dt_descriptor_type_code, dt.descriptor_type_name AS dt_descriptor_type_name, rsd.last_update AS rsd_last_update, 
                      rsd.site_id AS rsd_site_id, rs.site_id AS rs_res_site_id, rs.res_site_code AS rs_res_site_code, rs.res_site_name AS rs_res_site_name, 
                      site.site_code AS parent_site_code, site.site_name AS parent_site_name, REPLACE(rsd.descriptor_value, CHAR(13) + CHAR(10), '') 
                      AS rsd_method_description
FROM         dbo.descriptor_type AS dt INNER JOIN
                      dbo.research_site_descriptor AS rsd ON dt.descriptor_type_id = rsd.descriptor_type_id INNER JOIN
                      dbo.research_site AS rs ON rsd.site_id = rs.site_id INNER JOIN
                      dbo.site AS site ON site.site_id = rs.site_id
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "dt"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 230
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "rsd"
            Begin Extent = 
               Top = 114
               Left = 38
               Bottom = 222
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "rs"
            Begin Extent = 
               Top = 222
               Left = 38
               Bottom = 330
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "site"
            Begin Extent = 
               Top = 330
               Left = 38
               Bottom = 438
               Right = 192
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'join_methods_descriptions_sites'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'join_methods_descriptions_sites'
GO
/****** Object:  Default [DF_personnel_country]    Script Date: 02/18/2021 09:38:33 ******/
ALTER TABLE [dbo].[personnel] ADD  CONSTRAINT [DF_personnel_country]  DEFAULT ('USA') FOR [country]
GO
/****** Object:  Default [DF_session_datetime]    Script Date: 02/18/2021 09:38:37 ******/
ALTER TABLE [dbo].[session] ADD  CONSTRAINT [DF_session_datetime]  DEFAULT (getdate()) FOR [datetime]
GO
/****** Object:  Default [DF_download_datetime]    Script Date: 02/18/2021 09:38:37 ******/
ALTER TABLE [dbo].[download] ADD  CONSTRAINT [DF_download_datetime]  DEFAULT (getdate()) FOR [datetime]
GO
/****** Object:  Default [DF__climdb_va__AGGRE__05B8E52D]    Script Date: 02/18/2021 09:38:37 ******/
ALTER TABLE [dbo].[climdb_variables] ADD  CONSTRAINT [DF__climdb_va__AGGRE__05B8E52D]  DEFAULT ('Y') FOR [aggregate_mean]
GO
/****** Object:  Default [DF__climdb_va__AGGRE__06AD0966]    Script Date: 02/18/2021 09:38:37 ******/
ALTER TABLE [dbo].[climdb_variables] ADD  CONSTRAINT [DF__climdb_va__AGGRE__06AD0966]  DEFAULT ('N') FOR [aggregate_total]
GO
/****** Object:  Default [DF__climdb_va__AGGRE__07A12D9F]    Script Date: 02/18/2021 09:38:37 ******/
ALTER TABLE [dbo].[climdb_variables] ADD  CONSTRAINT [DF__climdb_va__AGGRE__07A12D9F]  DEFAULT ('Y') FOR [aggregate_min]
GO
/****** Object:  Default [DF__climdb_va__AGGRE__089551D8]    Script Date: 02/18/2021 09:38:37 ******/
ALTER TABLE [dbo].[climdb_variables] ADD  CONSTRAINT [DF__climdb_va__AGGRE__089551D8]  DEFAULT ('Y') FOR [aggregate_max]
GO
/****** Object:  ForeignKey [FK_download_session]    Script Date: 02/18/2021 09:38:37 ******/
ALTER TABLE [dbo].[download]  WITH NOCHECK ADD  CONSTRAINT [FK_download_session] FOREIGN KEY([session_id])
REFERENCES [dbo].[session] ([session_id])
GO
ALTER TABLE [dbo].[download] CHECK CONSTRAINT [FK_download_session]
GO
/****** Object:  ForeignKey [FK_research_site_research_site]    Script Date: 02/18/2021 09:38:37 ******/
ALTER TABLE [dbo].[research_site]  WITH CHECK ADD  CONSTRAINT [FK_research_site_research_site] FOREIGN KEY([res_site_parent_id])
REFERENCES [dbo].[research_site] ([res_site_id])
GO
ALTER TABLE [dbo].[research_site] CHECK CONSTRAINT [FK_research_site_research_site]
GO
/****** Object:  ForeignKey [FK_research_site_site]    Script Date: 02/18/2021 09:38:37 ******/
ALTER TABLE [dbo].[research_site]  WITH NOCHECK ADD  CONSTRAINT [FK_research_site_site] FOREIGN KEY([site_id])
REFERENCES [dbo].[site] ([site_id])
GO
ALTER TABLE [dbo].[research_site] CHECK CONSTRAINT [FK_research_site_site]
GO
/****** Object:  ForeignKey [FK_research_module_descriptor_descriptor_category]    Script Date: 02/18/2021 09:38:37 ******/
ALTER TABLE [dbo].[research_module_descriptor]  WITH CHECK ADD  CONSTRAINT [FK_research_module_descriptor_descriptor_category] FOREIGN KEY([res_module_id])
REFERENCES [dbo].[descriptor_category] ([descriptor_category_id])
GO
ALTER TABLE [dbo].[research_module_descriptor] CHECK CONSTRAINT [FK_research_module_descriptor_descriptor_category]
GO
/****** Object:  ForeignKey [FK_research_module_descriptor_research_module]    Script Date: 02/18/2021 09:38:37 ******/
ALTER TABLE [dbo].[research_module_descriptor]  WITH NOCHECK ADD  CONSTRAINT [FK_research_module_descriptor_research_module] FOREIGN KEY([res_module_id])
REFERENCES [dbo].[research_module] ([res_module_id])
GO
ALTER TABLE [dbo].[research_module_descriptor] CHECK CONSTRAINT [FK_research_module_descriptor_research_module]
GO
/****** Object:  ForeignKey [FK_personnel_mailing_list_mailing_list]    Script Date: 02/18/2021 09:38:37 ******/
ALTER TABLE [dbo].[personnel_mailing_list]  WITH CHECK ADD  CONSTRAINT [FK_personnel_mailing_list_mailing_list] FOREIGN KEY([mailing_list_id])
REFERENCES [dbo].[mailing_list] ([mailing_list_id])
GO
ALTER TABLE [dbo].[personnel_mailing_list] CHECK CONSTRAINT [FK_personnel_mailing_list_mailing_list]
GO
/****** Object:  ForeignKey [FK_personnel_mailing_list_personnel]    Script Date: 02/18/2021 09:38:37 ******/
ALTER TABLE [dbo].[personnel_mailing_list]  WITH CHECK ADD  CONSTRAINT [FK_personnel_mailing_list_personnel] FOREIGN KEY([personnel_id])
REFERENCES [dbo].[personnel] ([personnel_id])
GO
ALTER TABLE [dbo].[personnel_mailing_list] CHECK CONSTRAINT [FK_personnel_mailing_list_personnel]
GO
/****** Object:  ForeignKey [FK_sitetype_descriptor_category_descriptor_category]    Script Date: 02/18/2021 09:38:37 ******/
ALTER TABLE [dbo].[sitetype_descriptor_category]  WITH CHECK ADD  CONSTRAINT [FK_sitetype_descriptor_category_descriptor_category] FOREIGN KEY([descriptor_category_id])
REFERENCES [dbo].[descriptor_category] ([descriptor_category_id])
GO
ALTER TABLE [dbo].[sitetype_descriptor_category] CHECK CONSTRAINT [FK_sitetype_descriptor_category_descriptor_category]
GO
/****** Object:  ForeignKey [FK_sitetype_descriptor_category_research_site_type]    Script Date: 02/18/2021 09:38:37 ******/
ALTER TABLE [dbo].[sitetype_descriptor_category]  WITH CHECK ADD  CONSTRAINT [FK_sitetype_descriptor_category_research_site_type] FOREIGN KEY([res_sitetype_id])
REFERENCES [dbo].[research_site_type] ([res_sitetype_id])
GO
ALTER TABLE [dbo].[sitetype_descriptor_category] CHECK CONSTRAINT [FK_sitetype_descriptor_category_research_site_type]
GO
/****** Object:  ForeignKey [FK_site_personnel_role_personnel]    Script Date: 02/18/2021 09:38:37 ******/
ALTER TABLE [dbo].[site_personnel_role]  WITH CHECK ADD  CONSTRAINT [FK_site_personnel_role_personnel] FOREIGN KEY([personnel_id])
REFERENCES [dbo].[personnel] ([personnel_id])
GO
ALTER TABLE [dbo].[site_personnel_role] CHECK CONSTRAINT [FK_site_personnel_role_personnel]
GO
/****** Object:  ForeignKey [FK_site_personnel_role_personnel_role]    Script Date: 02/18/2021 09:38:37 ******/
ALTER TABLE [dbo].[site_personnel_role]  WITH NOCHECK ADD  CONSTRAINT [FK_site_personnel_role_personnel_role] FOREIGN KEY([personnel_role_id])
REFERENCES [dbo].[personnel_role] ([personnel_role_id])
GO
ALTER TABLE [dbo].[site_personnel_role] CHECK CONSTRAINT [FK_site_personnel_role_personnel_role]
GO
/****** Object:  ForeignKey [FK_site_personnel_role_research_module]    Script Date: 02/18/2021 09:38:37 ******/
ALTER TABLE [dbo].[site_personnel_role]  WITH CHECK ADD  CONSTRAINT [FK_site_personnel_role_research_module] FOREIGN KEY([res_module_id])
REFERENCES [dbo].[research_module] ([res_module_id])
GO
ALTER TABLE [dbo].[site_personnel_role] CHECK CONSTRAINT [FK_site_personnel_role_research_module]
GO
/****** Object:  ForeignKey [FK_site_personnel_role_site]    Script Date: 02/18/2021 09:38:37 ******/
ALTER TABLE [dbo].[site_personnel_role]  WITH NOCHECK ADD  CONSTRAINT [FK_site_personnel_role_site] FOREIGN KEY([site_id])
REFERENCES [dbo].[site] ([site_id])
GO
ALTER TABLE [dbo].[site_personnel_role] CHECK CONSTRAINT [FK_site_personnel_role_site]
GO
/****** Object:  ForeignKey [FK_descriptor_category_type_descriptor_category]    Script Date: 02/18/2021 09:38:37 ******/
ALTER TABLE [dbo].[descriptor_category_type]  WITH NOCHECK ADD  CONSTRAINT [FK_descriptor_category_type_descriptor_category] FOREIGN KEY([descriptor_category_id])
REFERENCES [dbo].[descriptor_category] ([descriptor_category_id])
GO
ALTER TABLE [dbo].[descriptor_category_type] CHECK CONSTRAINT [FK_descriptor_category_type_descriptor_category]
GO
/****** Object:  ForeignKey [FK_descriptor_category_type_descriptor_type]    Script Date: 02/18/2021 09:38:37 ******/
ALTER TABLE [dbo].[descriptor_category_type]  WITH NOCHECK ADD  CONSTRAINT [FK_descriptor_category_type_descriptor_type] FOREIGN KEY([descriptor_type_id])
REFERENCES [dbo].[descriptor_type] ([descriptor_type_id])
GO
ALTER TABLE [dbo].[descriptor_category_type] CHECK CONSTRAINT [FK_descriptor_category_type_descriptor_type]
GO
/****** Object:  ForeignKey [FK_climdb_variables_descriptor_category]    Script Date: 02/18/2021 09:38:37 ******/
ALTER TABLE [dbo].[climdb_variables]  WITH NOCHECK ADD  CONSTRAINT [FK_climdb_variables_descriptor_category] FOREIGN KEY([descriptor_category_id])
REFERENCES [dbo].[descriptor_category] ([descriptor_category_id])
GO
ALTER TABLE [dbo].[climdb_variables] CHECK CONSTRAINT [FK_climdb_variables_descriptor_category]
GO
/****** Object:  ForeignKey [FK_climdb_site_variable_dates_research_site]    Script Date: 02/18/2021 09:38:37 ******/
ALTER TABLE [dbo].[climdb_site_variable_dates]  WITH CHECK ADD  CONSTRAINT [FK_climdb_site_variable_dates_research_site] FOREIGN KEY([res_site_id])
REFERENCES [dbo].[research_site] ([res_site_id])
GO
ALTER TABLE [dbo].[climdb_site_variable_dates] CHECK CONSTRAINT [FK_climdb_site_variable_dates_research_site]
GO
/****** Object:  ForeignKey [FK_climdb_raw_climdb_variables]    Script Date: 02/18/2021 09:38:37 ******/
ALTER TABLE [dbo].[climdb_raw]  WITH NOCHECK ADD  CONSTRAINT [FK_climdb_raw_climdb_variables] FOREIGN KEY([variable])
REFERENCES [dbo].[climdb_variables] ([variable])
GO
ALTER TABLE [dbo].[climdb_raw] CHECK CONSTRAINT [FK_climdb_raw_climdb_variables]
GO
/****** Object:  ForeignKey [FK_climdb_raw_research_site]    Script Date: 02/18/2021 09:38:37 ******/
ALTER TABLE [dbo].[climdb_raw]  WITH CHECK ADD  CONSTRAINT [FK_climdb_raw_research_site] FOREIGN KEY([res_site_id])
REFERENCES [dbo].[research_site] ([res_site_id])
GO
ALTER TABLE [dbo].[climdb_raw] CHECK CONSTRAINT [FK_climdb_raw_research_site]
GO
/****** Object:  ForeignKey [FK_climdb_agg_aggregate_type]    Script Date: 02/18/2021 09:38:37 ******/
ALTER TABLE [dbo].[climdb_agg]  WITH NOCHECK ADD  CONSTRAINT [FK_climdb_agg_aggregate_type] FOREIGN KEY([aggregate_type])
REFERENCES [dbo].[aggregate_type] ([aggregate_type])
GO
ALTER TABLE [dbo].[climdb_agg] CHECK CONSTRAINT [FK_climdb_agg_aggregate_type]
GO
/****** Object:  ForeignKey [FK_climdb_agg_research_site]    Script Date: 02/18/2021 09:38:37 ******/
ALTER TABLE [dbo].[climdb_agg]  WITH NOCHECK ADD  CONSTRAINT [FK_climdb_agg_research_site] FOREIGN KEY([res_site_id])
REFERENCES [dbo].[research_site] ([res_site_id])
GO
ALTER TABLE [dbo].[climdb_agg] CHECK CONSTRAINT [FK_climdb_agg_research_site]
GO
/****** Object:  ForeignKey [FK_harvest_raw_climdb_variables]    Script Date: 02/18/2021 09:38:37 ******/
ALTER TABLE [dbo].[harvest_raw]  WITH NOCHECK ADD  CONSTRAINT [FK_harvest_raw_climdb_variables] FOREIGN KEY([variable])
REFERENCES [dbo].[climdb_variables] ([variable])
GO
ALTER TABLE [dbo].[harvest_raw] CHECK CONSTRAINT [FK_harvest_raw_climdb_variables]
GO
/****** Object:  ForeignKey [FK_harvest_raw_research_site]    Script Date: 02/18/2021 09:38:37 ******/
ALTER TABLE [dbo].[harvest_raw]  WITH NOCHECK ADD  CONSTRAINT [FK_harvest_raw_research_site] FOREIGN KEY([res_site_id])
REFERENCES [dbo].[research_site] ([res_site_id])
GO
ALTER TABLE [dbo].[harvest_raw] CHECK CONSTRAINT [FK_harvest_raw_research_site]
GO
/****** Object:  ForeignKey [FK_research_site_sitetype_research_site]    Script Date: 02/18/2021 09:38:37 ******/
ALTER TABLE [dbo].[research_site_sitetype]  WITH CHECK ADD  CONSTRAINT [FK_research_site_sitetype_research_site] FOREIGN KEY([res_site_id])
REFERENCES [dbo].[research_site] ([res_site_id])
GO
ALTER TABLE [dbo].[research_site_sitetype] CHECK CONSTRAINT [FK_research_site_sitetype_research_site]
GO
/****** Object:  ForeignKey [FK_research_site_sitetype_research_site_type]    Script Date: 02/18/2021 09:38:37 ******/
ALTER TABLE [dbo].[research_site_sitetype]  WITH CHECK ADD  CONSTRAINT [FK_research_site_sitetype_research_site_type] FOREIGN KEY([res_sitetype_id])
REFERENCES [dbo].[research_site_type] ([res_sitetype_id])
GO
ALTER TABLE [dbo].[research_site_sitetype] CHECK CONSTRAINT [FK_research_site_sitetype_research_site_type]
GO
/****** Object:  ForeignKey [FK_research_site_module_research_module]    Script Date: 02/18/2021 09:38:37 ******/
ALTER TABLE [dbo].[research_site_module]  WITH CHECK ADD  CONSTRAINT [FK_research_site_module_research_module] FOREIGN KEY([res_module_id])
REFERENCES [dbo].[research_module] ([res_module_id])
GO
ALTER TABLE [dbo].[research_site_module] CHECK CONSTRAINT [FK_research_site_module_research_module]
GO
/****** Object:  ForeignKey [FK_research_site_module_research_site]    Script Date: 02/18/2021 09:38:37 ******/
ALTER TABLE [dbo].[research_site_module]  WITH CHECK ADD  CONSTRAINT [FK_research_site_module_research_site] FOREIGN KEY([res_site_id])
REFERENCES [dbo].[research_site] ([res_site_id])
GO
ALTER TABLE [dbo].[research_site_module] CHECK CONSTRAINT [FK_research_site_module_research_site]
GO
/****** Object:  ForeignKey [FK_research_site_descriptor_descriptor_type]    Script Date: 02/18/2021 09:38:37 ******/
ALTER TABLE [dbo].[research_site_descriptor]  WITH NOCHECK ADD  CONSTRAINT [FK_research_site_descriptor_descriptor_type] FOREIGN KEY([descriptor_type_id])
REFERENCES [dbo].[descriptor_type] ([descriptor_type_id])
GO
ALTER TABLE [dbo].[research_site_descriptor] CHECK CONSTRAINT [FK_research_site_descriptor_descriptor_type]
GO
/****** Object:  ForeignKey [FK_research_site_descriptor_research_site]    Script Date: 02/18/2021 09:38:37 ******/
ALTER TABLE [dbo].[research_site_descriptor]  WITH CHECK ADD  CONSTRAINT [FK_research_site_descriptor_research_site] FOREIGN KEY([res_site_id])
REFERENCES [dbo].[research_site] ([res_site_id])
GO
ALTER TABLE [dbo].[research_site_descriptor] CHECK CONSTRAINT [FK_research_site_descriptor_research_site]
GO
