using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

namespace KitCalc
{
    public class Attribute
    {
        
        public string CategoryName { get; set;}
        public int CategoryID { get; set; }
        public string ItemName { get; set;}
        public decimal ItemPrice { get; set; }
        public decimal ItemAmount { get; set; }
        public string PurchaseDate { get; set;}
        public int ItemID { get; set; }
        public string FromDate { get; set;}
        public string ToDate { get; set; }
        public string PurchaseMonth { get; set; }
        public string PurchaseYear { get; set; }
        public decimal CategoricalExpenses { get; set;}
        public bool Flag { get; set;}
        public int UserID { get; set;}
        public string KitchenName { get; set; }
        public int KitchenCount { get; set; }
    
    }
    

}
