using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PruebaSchad.Models.ViewModels
{
    public class InvoiceListViewModel
    {
        public int Id { get; set; }
        public string Customer { get; set; }
        public Decimal Total { get; set; }
    }
}