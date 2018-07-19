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
    public class Person
    {
        public int UserID { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public string Date { get; set; }
        public decimal TotalExpenses { get; set;}
        public int TotalPeople { get; set; }
        public string UserType { get; set; }
        public string KitchenName { get; set; }
        public string Email { get; set; }

        public int KitchenID { get; set; }
    }
}
