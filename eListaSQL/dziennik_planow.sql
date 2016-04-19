CREATE TABLE [dbo].[dziennik_planow]
(
	[id] BIGINT NOT NULL PRIMARY KEY, 
    [id_uzytkownik] BIGINT NOT NULL, 
    [dzien_tygodnia] VARCHAR(15) NOT NULL, 
    [plan_od] DATE NOT NULL, 
    [plan_do] DATE NOT NULL, 
    CONSTRAINT [FK_dziennik_planow_uzytkownik] FOREIGN KEY ([id_uzytkownik]) REFERENCES [uzytkownik]([id]) 
)
