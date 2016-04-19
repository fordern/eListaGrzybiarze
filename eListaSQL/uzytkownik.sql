CREATE TABLE [dbo].[uzytkownik]
(
	[id] BIGINT NOT NULL PRIMARY KEY, 
    [imie] VARCHAR(255) not NULL, 
    [nazwisko] VARCHAR(255) not NULL, 
    [email] VARCHAR(255) not NULL, 
    [haslo] VARCHAR(255) not NULL, 
    [telefon] VARCHAR(15) not NULL, 
    [aktywny] BIT not NULL 
)
