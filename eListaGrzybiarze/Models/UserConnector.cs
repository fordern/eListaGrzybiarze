using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace eListaGrzybiarze.Models
{
    public class UserConnector
    {
        public int ID { get; set; }
        public string UserName { get; set; }

        public virtual Pracownik Pracownik { get; set; }
    }
}