CREATE TABLE [dbo].[uzytkownik_grupa]
(
	[id] BIGINT NOT NULL PRIMARY KEY, 
    [id_uzytkownik] BIGINT NOT NULL, 
    [grupa] VARCHAR(255) NOT NULL, 
    [cdfsfsdfsd] NCHAR(10) NULL, 
    CONSTRAINT [FK_uzytkownik_grupa_uzytkownik] FOREIGN KEY ([id_uzytkownik]) REFERENCES [uzytkownik]([id]) 
)
