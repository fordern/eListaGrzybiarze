using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Web;

namespace eListaGrzybiarze.Models
{
    public class Pracownik
    {
        public int ID { get; set; }
        //public int AccountID { get; set; }
        public string LastName { get; set; }
        public string FirstName { get; set; }
        public DateTime DataUrodzenia { get; set; }

        public virtual ICollection<DzienPracy> DniPracy { get; set; } 
    }
}