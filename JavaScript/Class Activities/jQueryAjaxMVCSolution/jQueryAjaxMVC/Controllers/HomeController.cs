using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
//Added
using jQueryAjaxMVC.Models;


namespace jQueryAjaxMVC.Controllers
{
    public class HomeController : Controller
    {
        // GET: Home
        public ActionResult Index()
        {
            HomeModel model = new HomeModel();
            model.PageTitle = "JQuery Tutorial";

            return View(model);     //Sends model object to the front end
        }
    }
}