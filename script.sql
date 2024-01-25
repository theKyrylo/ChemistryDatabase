USE master;

IF EXISTS (SELECT * FROM sysdatabases WHERE name = 'ChemistryDatabase')
	DROP DATABASE ChemistryDatabase;

DECLARE @device_dir NVARCHAR(520);
SELECT @device_dir = SUBSTRING(filename, 1, CHARINDEX('master.mdf', LOWER(filename))-1)
FROM master.dbo.sysaltfiles WHERE dbid = 1 AND fileid = 1;

EXECUTE('
CREATE DATABASE [ChemistryDatabase] ON PRIMARY
(
	NAME = N''ChemistryDatabase'',
	FILENAME = ''' + @device_dir + 'chemdb.mdf''
)
LOG ON
(
	NAME = N''ChemistryDatabase_LOG'',
	FILENAME = ''' + @device_dir + 'chemdblog.ldf''
);');

USE ChemistryDatabase;