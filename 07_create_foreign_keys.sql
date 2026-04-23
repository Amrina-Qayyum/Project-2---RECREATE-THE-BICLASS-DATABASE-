USE G9_2;
GO

/* Drop foreign keys first if rerunning */
IF OBJECT_ID('[CH01-01-Fact].[FK_Data_DimProduct]', 'F') IS NOT NULL
    ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT [FK_Data_DimProduct];
GO
IF OBJECT_ID('[CH01-01-Fact].[FK_Data_SalesManagers]', 'F') IS NOT NULL
    ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT [FK_Data_SalesManagers];
GO
IF OBJECT_ID('[CH01-01-Fact].[FK_Data_DimMaritalStatus]', 'F') IS NOT NULL
    ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT [FK_Data_DimMaritalStatus];
GO
IF OBJECT_ID('[CH01-01-Fact].[FK_Data_DimGender]', 'F') IS NOT NULL
    ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT [FK_Data_DimGender];
GO
IF OBJECT_ID('[CH01-01-Fact].[FK_Data_DimOccupation]', 'F') IS NOT NULL
    ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT [FK_Data_DimOccupation];
GO
IF OBJECT_ID('[CH01-01-Fact].[FK_Data_DimOrderDate]', 'F') IS NOT NULL
    ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT [FK_Data_DimOrderDate];
GO
IF OBJECT_ID('[CH01-01-Fact].[FK_Data_DimTerritory]', 'F') IS NOT NULL
    ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT [FK_Data_DimTerritory];
GO
IF OBJECT_ID('[CH01-01-Fact].[FK_Data_DimCustomer]', 'F') IS NOT NULL
    ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT [FK_Data_DimCustomer];
GO

IF OBJECT_ID('[CH01-01-Dimension].[FK_DimProduct_DimProductSubcategory]', 'F') IS NOT NULL
    ALTER TABLE [CH01-01-Dimension].[DimProduct] DROP CONSTRAINT [FK_DimProduct_DimProductSubcategory];
GO

/* Add FK from DimProductSubcategory to DimProductCategory already created in file 06 */

/* Add FK from DimProduct to DimProductSubcategory */
ALTER TABLE [CH01-01-Dimension].[DimProduct]
ADD CONSTRAINT [FK_DimProduct_DimProductSubcategory]
FOREIGN KEY (ProductSubcategoryKey)
REFERENCES [CH01-01-Dimension].[DimProductSubcategory](ProductSubcategoryKey);
GO

/* Add fact-table FKs */
ALTER TABLE [CH01-01-Fact].[Data]
ADD CONSTRAINT [FK_Data_DimProduct]
FOREIGN KEY (ProductKey)
REFERENCES [CH01-01-Dimension].[DimProduct](ProductKey);
GO

ALTER TABLE [CH01-01-Fact].[Data]
ADD CONSTRAINT [FK_Data_SalesManagers]
FOREIGN KEY (SalesManagerKey)
REFERENCES [CH01-01-Dimension].[SalesManagers](SalesManagerKey);
GO

ALTER TABLE [CH01-01-Fact].[Data]
ADD CONSTRAINT [FK_Data_DimMaritalStatus]
FOREIGN KEY (MaritalStatus)
REFERENCES [CH01-01-Dimension].[DimMaritalStatus](MaritalStatus);
GO

ALTER TABLE [CH01-01-Fact].[Data]
ADD CONSTRAINT [FK_Data_DimGender]
FOREIGN KEY (Gender)
REFERENCES [CH01-01-Dimension].[DimGender](Gender);
GO

ALTER TABLE [CH01-01-Fact].[Data]
ADD CONSTRAINT [FK_Data_DimOccupation]
FOREIGN KEY (OccupationKey)
REFERENCES [CH01-01-Dimension].[DimOccupation](OccupationKey);
GO

ALTER TABLE [CH01-01-Fact].[Data]
ADD CONSTRAINT [FK_Data_DimOrderDate]
FOREIGN KEY (OrderDate)
REFERENCES [CH01-01-Dimension].[DimOrderDate](OrderDate);
GO

ALTER TABLE [CH01-01-Fact].[Data]
ADD CONSTRAINT [FK_Data_DimTerritory]
FOREIGN KEY (TerritoryKey)
REFERENCES [CH01-01-Dimension].[DimTerritory](TerritoryKey);
GO

ALTER TABLE [CH01-01-Fact].[Data]
ADD CONSTRAINT [FK_Data_DimCustomer]
FOREIGN KEY (CustomerKey)
REFERENCES [CH01-01-Dimension].[DimCustomer](CustomerKey);
GO

