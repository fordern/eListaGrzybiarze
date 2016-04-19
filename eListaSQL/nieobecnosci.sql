CREATE TABLE [dbo].[nieobecnosci]
(
	[id] BIGINT NOT NULL PRIMARY KEY, 
    [id_uzytkownik] BIGINT NOT NULL, 
    [typ] VARCHAR(255) NOT NULL, 
    [data ] DATE NOT NULL, 
    [ilosc_godzin] INT NOT NULL, 
    CONSTRAINT [FK_nieobecnosci_uzytkownik] FOREIGN KEY ([id_uzytkownik]) REFERENCES [uzytkownik]([id]) 
)
