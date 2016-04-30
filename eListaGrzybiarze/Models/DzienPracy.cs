using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace eListaGrzybiarze.Models
{
    public class DzienPracy
    {
        public int DzienPracyID { get; set; }
        public int PracownikID { get; set; }
        public DateTime PoczatekPracy { get; set; }
        public DateTime? KoniecPracy { get; set; }
        public virtual Pracownik Pracownik { get; set; }

    }
}