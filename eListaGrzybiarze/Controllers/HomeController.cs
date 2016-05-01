using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using eListaGrzybiarze.DAL;
using eListaGrzybiarze.Models;
using Microsoft.AspNet.Identity;

namespace eListaGrzybiarze.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Aplikacja stworzona w celu potwierdzania obecności w miejscu pracy.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Kontakty z twórcami.";

            return View();
        }

        [Authorize]
        public ActionResult Obecnosc()
        {
            eListaContext db = new eListaContext();
            UserConnector connector = new UserConnector();
            foreach (var connect in db.Userzy)
            {
                if (connect.UserName == User.Identity.Name)
                {
                    connector.ID = connect.ID;
                }
            }
            Pracownik pracownik = db.Pracownik.Find(connector.ID);
            ViewBag.Message = "Potwierdzanie obecności.";
            return View(pracownik);
        }
    }
}