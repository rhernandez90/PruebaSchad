using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PruebaSchad.Models;
using PruebaSchad.Models.ViewModels;

namespace PruebaSchad.Controllers
{
    public class CustomerTypesController : Controller
    {
        // GET: CustomerTypes
        public ActionResult Index()
        {
            IEnumerable<CustomerTypeViewModel> CustomerTypes;

            using (Test_InvoiceEntities db = new Test_InvoiceEntities())
            {
                CustomerTypes = db.CustomerTypes
                    .Select( x => new CustomerTypeViewModel()
                    {
                        Id = x.Id,
                        Description = x.Description
                    }).ToList();
            }

            return View(CustomerTypes);
        }


        public ActionResult Create()
        {
            return View();
        }


        [HttpPost]
        public ActionResult Create(CustomerTypeViewModel model)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    using (Test_InvoiceEntities db = new Test_InvoiceEntities())
                    {
                        var customerType = new PruebaSchad.Models.CustomerType()
                        {
                            Description = model.Description
                        };

                        db.CustomerTypes.Add(customerType);
                        db.SaveChanges();
                    }
                    return Redirect("~/CustomerTypes");
                }
                return View(model);

            }
            catch(Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public ActionResult Editar(int Id)
        {
            CustomerTypeViewModel model = new CustomerTypeViewModel();
            using (Test_InvoiceEntities db = new Test_InvoiceEntities())
            {
                var customerType = db.CustomerTypes.FirstOrDefault( x => x.Id == Id);
                model.Id = customerType.Id;
                model.Description = customerType.Description;
                     
            }
            return View(model);
        }


        [HttpPost]
        public ActionResult Editar(CustomerTypeViewModel model)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    using (Test_InvoiceEntities db = new Test_InvoiceEntities())
                    {
                        var customerType = db.CustomerTypes.Find(model.Id);
                        customerType.Description = model.Description;
                        db.SaveChanges();
                    }
                    return Redirect("~/CustomerTypes");
                }
                return View(model);

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }


        [HttpGet]
        public ActionResult Eliminar(int Id)
        {
            CustomerTypeViewModel model = new CustomerTypeViewModel();
            using (Test_InvoiceEntities db = new Test_InvoiceEntities())
            {
                var customerType = db.CustomerTypes.Find(Id);
                db.CustomerTypes.Remove(customerType);
                db.SaveChanges();
            }
            return Redirect("~/CustomerTypes");
        }

    }

}