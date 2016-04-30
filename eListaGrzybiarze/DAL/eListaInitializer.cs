using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using eListaGrzybiarze.Models;
using WebGrease.Css.Extensions;

namespace eListaGrzybiarze.DAL
{
    public class eListaInitializer : System.Data.Entity. DropCreateDatabaseIfModelChanges<eListaContext>
    {
        protected override void Seed(eListaContext context)
        {
            var Pracownicy = new List<Pracownik>
            {
                new Pracownik {DataUrodzenia = DateTime.Parse("1920-05-18"), FirstName = "Karol", LastName = "Wojtyła"},
                new Pracownik {DataUrodzenia = DateTime.Parse("1978-03-18"), FirstName = "Piotr", LastName = "Łuszcz"},
                new Pracownik {DataUrodzenia = DateTime.Parse("1923-07-06"), FirstName = "Wojciech", LastName = "Jaruzelski"},
                new Pracownik {DataUrodzenia = DateTime.Parse("1977-12-03"), FirstName = "Adam", LastName = "Małysz"}
            };
            Pracownicy.ForEach(s => context.Pracownik.Add(s));
            context.SaveChanges();

            var DniPracy = new List<DzienPracy>
            {
                new DzienPracy
                {
                    PracownikID = 1,
                    PoczatekPracy = new DateTime(2016, 04, 28, 9, 0, 0),
                    KoniecPracy = new DateTime(2016, 04, 28, 17, 0, 0)
                },
                new DzienPracy
                {
                    PracownikID = 2,
                    PoczatekPracy = new DateTime(2016, 04, 28, 9, 0, 0),
                    KoniecPracy = new DateTime(2016, 04, 28, 17, 0, 0)
                },
                new DzienPracy
                {
                    PracownikID = 3,
                    PoczatekPracy = new DateTime(2016, 04, 28, 9, 0, 0),
                    KoniecPracy = new DateTime(2016, 04, 28, 17, 0, 0)
                },
                new DzienPracy
                {
                    PracownikID = 4,
                    PoczatekPracy = new DateTime(2016, 04, 28, 9, 0, 0),
                    KoniecPracy = new DateTime(2016, 04, 28, 17, 0, 0)
                },
            };
            DniPracy.ForEach(s => context.DniPracy.Add(s));
            context.SaveChanges();

            var Userzy = new List<UserConnector>
            {
                new UserConnector
                {
                    ID = 1,
                    UserName = "albertgaw@gmail.com"
                }
            };
            Userzy.ForEach(s => context.Userzy.Add(s));
            context.SaveChanges();

        }
    }
}