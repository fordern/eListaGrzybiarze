using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using eListaGrzybiarze.DAL;
using eListaGrzybiarze.Models;

namespace eListaGrzybiarze.Controllers
{
    [Authorize]
    public class PracownikController : Controller
    {
        private eListaContext db = new eListaContext(); 

        // GET: Pracownik
        public ActionResult Index()
        {
            return View(db.Pracownik.ToList());
        }

        // GET: Pracownik/Details/5
        public ActionResult Details(int? id)
        {
            Pracownik pracownik = null;
            if (id != null)
            {
                pracownik = db.Pracownik.Find(id);
                
            }
            else 
            {
                UserConnector connector = new UserConnector();
                foreach (var connect in db.Userzy)
                {
                    if (connect.UserName == User.Identity.Name)
                    {
                        connector.ID = connect.ID;
                    }
                }
                pracownik = db.Pracownik.Find(connector.ID);
            }

            if (pracownik == null)
            {
                return HttpNotFound();
            }
            return View(pracownik);
        }

        // GET: Pracownik/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Pracownik/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ID,LastName,FirstName,DataUrodzenia")] Pracownik pracownik)
        {
            if (ModelState.IsValid)
            {
                db.Pracownik.Add(pracownik);
                db.Userzy.Add(new UserConnector {ID = db.Userzy.ToList().Last().ID + 1, UserName = User.Identity.Name});
                db.SaveChanges();
                return RedirectToAction("Index", "Home");
            }

            return View(pracownik);
        }

        // GET: Pracownik/Edit/5
        public ActionResult Edit()
        {
            
            UserConnector connector = new UserConnector();
            foreach (var connect in db.Userzy)
            {
                if (connect.UserName == User.Identity.Name)
                {
                    connector.ID = connect.ID;
                }
            }
            
            Pracownik pracownik = db.Pracownik.Find(connector.ID);
            if (pracownik == null)
            {
                return HttpNotFound();
            }
            return View(pracownik);
        }

        // POST: Pracownik/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ID,LastName,FirstName,DataUrodzenia")] Pracownik pracownik)
        {
            if (ModelState.IsValid)
            {
                db.Entry(pracownik).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index", "Home");
            }
            return View(pracownik);
        }

        // GET: Pracownik/Delete/5
        public ActionResult Delete()
        {
            UserConnector connector = new UserConnector();
            foreach (var connect in db.Userzy)
                {
                    if (connect.UserName == User.Identity.Name)
                    {
                        connector.ID = connect.ID;
                    }
                }
            Pracownik pracownik = db.Pracownik.Find(connector.ID);
            if (pracownik == null)
            {
                return HttpNotFound();
            }
            return View(pracownik);
        }

        // POST: Pracownik/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Pracownik pracownik = db.Pracownik.Find(id);
            db.Pracownik.Remove(pracownik);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public ActionResult RozpocznijPrace()
        {
            UserConnector connector = new UserConnector();
            foreach (var connect in db.Userzy)
            {
                if (connect.UserName == User.Identity.Name)
                {
                    connector.ID = connect.ID;
                }
            }
            Pracownik pracownik = db.Pracownik.Find(connector.ID);
            pracownik.DniPracy.Add(new DzienPracy
            {
                PracownikID = pracownik.ID,
                PoczatekPracy = DateTime.Now
            }); 
            if (ModelState.IsValid)
            {
                db.SaveChanges();
                
            }
            return RedirectToAction("Index", "Home");
        }

        public ActionResult ZakonczPrace(int id)
        {
            Pracownik pracownik = db.Pracownik.Find(id);
            pracownik.DniPracy.Last().KoniecPracy = DateTime.Now; 
            if (ModelState.IsValid)
            {
                db.SaveChanges();
            }
            return RedirectToAction("Index", "Home");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
