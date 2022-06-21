using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using System.Net;
using System.Web;
using System.Web.Mvc;
using PruebaSchad.Models;
using PruebaSchad.Models.ViewModels;

namespace PruebaSchad.Controllers
{
    public class InvoicesController : Controller
    {
        private Test_InvoiceEntities db = new Test_InvoiceEntities();

        // GET: Invoices
        public async Task<ActionResult> Index()
        {
            var invoices = db.Invoices
                .Include(i => i.Customer)
                .Select( x => new InvoiceListViewModel()
                {
                    Id = x.Id,
                    Customer = x.Customer.CustName ?? "",
                    Total = x.Total
                })
                .ToList();
            return View(invoices);
        }

        public ActionResult Create()
        {
            ViewBag.CustomerId = new SelectList(db.Customers, "Id", "CustName");
            var invoice = new InvoiceViewModel();
            invoice.InvoiceDetail.Add(new InvoiceDetail()
            {
                SubTotal = 0,
                Qty = 0,
                Price = 0,
                Total = 0,
                Description = "",
                TotalItbis = 0

            });
            return View(invoice);
        }

        [HttpPost]
        public ActionResult Create(InvoiceViewModel model)
        {

            ViewBag.CustomerId = new SelectList(db.Customers, "Id", "CustName");
            if (model.AddLine)
            {
                model.InvoiceDetail.Add(new InvoiceDetail()
                {
                    SubTotal = 0,
                    Qty = 0,
                    Price = 0,
                    Total = 0,
                    Description = "",
                    TotalItbis = 0

                });
                return View(model);
            }
            else
            {

                var invoice = new Invoice()
                {
                    CustomerId = model.CustomerId,
                    Total = model.Total,
                };

                db.Invoices.Add(invoice);
                db.SaveChanges();

                foreach(var item in model.InvoiceDetail)
                {
                    item.InvoiceId = invoice.Id;
                    db.InvoiceDetails.Add(item);
                }

                db.SaveChanges();


                return Redirect("~/invoices");
            }
        }

        // GET: invoices/Delete/5
        public async Task<ActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Invoice invoice = await db.Invoices.FindAsync(id);
            if (invoice == null)
            {
                return HttpNotFound();
            }

            var invoiceDetails = db.InvoiceDetails.Where(x => x.InvoiceId == id);

            foreach(var item in invoiceDetails)
            {
                db.InvoiceDetails.Remove(item);
            }
            await db.SaveChangesAsync();

            db.Invoices.Remove(invoice);
            await db.SaveChangesAsync();
            return RedirectToAction("Index");
        }


        public async Task<ActionResult> Details(int id)
        {
            ViewBag.CustomerId = new SelectList(db.Customers, "Id", "CustName");
            Invoice invoice = await db.Invoices.Include(c => c.Customer).FirstOrDefaultAsync( x => x.Id == id);
            var invoiceDetails = db.InvoiceDetails.Where(x => x.InvoiceId == id);

            var returnModel = new InvoiceViewModel()
            {
                Id = invoice.Id,
                CustomerId = invoice.CustomerId,
                Customer = invoice.Customer.CustName ?? "",
                Total = invoice.Total,
                InvoiceDetail = invoiceDetails.ToList(),
                SubTotal = invoice.SubTotal,
                TotalItbis = invoice.TotalItbis
            };


            return View(returnModel);
        }

        public async Task<ActionResult> Edit(int id)
        {
            ViewBag.CustomerId = new SelectList(db.Customers, "Id", "CustName");
            Invoice invoice = await db.Invoices.Include(c => c.Customer).FirstOrDefaultAsync(x => x.Id == id);
            var invoiceDetails = db.InvoiceDetails.Where(x => x.InvoiceId == id);

            var returnModel = new InvoiceViewModel()
            {
                Id = invoice.Id,
                CustomerId = invoice.CustomerId,
                Customer = invoice.Customer.CustName ?? "",
                Total = invoice.Total,
                InvoiceDetail = invoiceDetails.ToList(),
                SubTotal = invoice.SubTotal,
                TotalItbis = invoice.TotalItbis
            };


            return View(returnModel);
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
