using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.ModelConfiguration.Conventions;
using System.Linq;
using System.Web;   
using eListaGrzybiarze.Models;

namespace eListaGrzybiarze.DAL
{
    public class eListaContext : DbContext
    {
        public eListaContext() : base("eListaContext")
        {
            
        }

        public DbSet<Pracownik> Pracownik { get; set; }
        public DbSet<DzienPracy> DniPracy { get; set; }
        public DbSet<UserConnector> Userzy { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Conventions.Remove<PluralizingTableNameConvention>();
        }
    }
}