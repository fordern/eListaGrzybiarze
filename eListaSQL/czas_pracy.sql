CREATE TABLE [dbo].[czas_pracy]
(
	[id] BIGINT NOT NULL PRIMARY KEY, 
    [id_uzytkownik] BIGINT NOT NULL, 
    [zakres_prac] VARCHAR(255) NOT NULL, 
    [dzien] DATE NOT NULL, 
    [rozpoczecie] DATE NOT NULL, 
    [zakonczenie] DATE NOT NULL, 
    CONSTRAINT [FK_czas_pracy_uzytkownik] FOREIGN KEY ([id_uzytkownik]) REFERENCES [uzytkownik]([id])
)
