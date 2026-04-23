USE G9_2;
GO

CREATE SEQUENCE PkSequence.UserAuthorizationSequenceObject AS INT START WITH 1 INCREMENT BY 1;
GO
CREATE SEQUENCE PkSequence.WorkflowStepsSequenceObject AS INT START WITH 1 INCREMENT BY 1;
GO
CREATE SEQUENCE PkSequence.DimProductCategorySequenceObject AS INT START WITH 1 INCREMENT BY 1;
GO
CREATE SEQUENCE PkSequence.DimProductSubcategorySequenceObject AS INT START WITH 1 INCREMENT BY 1;
GO
CREATE SEQUENCE PkSequence.DimProductSequenceObject AS INT START WITH 1 INCREMENT BY 1;
GO
CREATE SEQUENCE PkSequence.SalesManagersSequenceObject AS INT START WITH 1 INCREMENT BY 1;
GO
CREATE SEQUENCE PkSequence.DimCustomerSequenceObject AS INT START WITH 1 INCREMENT BY 1;
GO
CREATE SEQUENCE PkSequence.DimGenderSequenceObject AS INT START WITH 1 INCREMENT BY 1;
GO
CREATE SEQUENCE PkSequence.DimMaritalStatusSequenceObject AS INT START WITH 1 INCREMENT BY 1;
GO
CREATE SEQUENCE PkSequence.DimOccupationSequenceObject AS INT START WITH 1 INCREMENT BY 1;
GO
CREATE SEQUENCE PkSequence.DimOrderDateSequenceObject AS INT START WITH 1 INCREMENT BY 1;
GO
CREATE SEQUENCE PkSequence.DimTerritorySequenceObject AS INT START WITH 1 INCREMENT BY 1;
GO
CREATE SEQUENCE PkSequence.DataSequenceObject AS INT START WITH 1 INCREMENT BY 1;
GO

USE G9_2;
GO

SELECT SCHEMA_NAME(schema_id) AS SchemaName, name AS SequenceName
FROM sys.sequences
ORDER BY name;
GO
