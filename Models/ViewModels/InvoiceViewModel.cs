using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PruebaSchad.Models.ViewModels
{
    public class InvoiceViewModel
    {
        public int Id { get; set; }
        public int CustomerId { get; set; }
        public String Customer { get; set;  }
        public decimal TotalItbis { get; set; }
        public decimal SubTotal { get; set; }
        public decimal Total { get; set; }

        public List<InvoiceDetail> InvoiceDetail { get; set; }

        public bool AddLine { get; set; }

        public InvoiceViewModel()
        {
            this.InvoiceDetail = new List<InvoiceDetail>();
        }

    }
}