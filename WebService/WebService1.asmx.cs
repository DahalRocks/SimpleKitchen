using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Xml.Linq;
using System.Data.SqlClient;
using System.Collections.Generic;
using KitCalc.ProgramFiles.Classes;
using System.Net;

namespace KitCalc
{
    /// <summary>
    /// Summary description for WebService1
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class WebService1 : System.Web.Services.WebService
    {
        public string connection = "workstation id=KitCalc.mssql.somee.com;packet size=4096;user id=dhruba1234;pwd=dhruba1234;data source=KitCalc.mssql.somee.com;persist security info=False;initial catalog=KitCalc";
        #region addition
        [WebMethod]
        public void SendMail(Person objPerson)
        {
            // Gmail Address from where you send the mail
            var fromAddress = "kitcalc@gmail.com";
            // any address where the email will be sending
            var toAddress = objPerson.Email;
            //Password of your gmail address
            const string fromPassword = "kitcalc1234";
            // Passing the values and make a email formate to display
            string subject = "User Credential for your Kitchen Calculation";
            string body = "From: KitCalc application \n";
            body += "Click this link and make life easier with this grat application: \n";
            body += "http://kitcalc.somee.com"+"\n";
            body += "Your user name :" + objPerson.UserName + "\n";
            body += "Your password:" + objPerson.Password + "\n";
            // smtp settings
            var smtp = new System.Net.Mail.SmtpClient();
            {
                smtp.Host = "smtp.gmail.com";
                smtp.Port = 587;
                smtp.EnableSsl = true;
                smtp.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;
                smtp.Credentials = new NetworkCredential(fromAddress, fromPassword);
                smtp.Timeout = 20000;
            }
            // Passing values to smtp object
            smtp.Send(fromAddress, toAddress, subject, body);
        }
        [WebMethod(EnableSession=true)]
        public string AddUser(Person objPerson)
        {

            try
            {
                SqlConnection con = new SqlConnection(connection);
                SqlCommand cmd = new SqlCommand("Kit_InsertBasicInfo", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@KitchenName", SqlDbType.NVarChar));
                cmd.Parameters["@KitchenName"].Value = objPerson.KitchenName; ;
                cmd.Parameters.Add(new SqlParameter("@FirstName", SqlDbType.NVarChar));
                cmd.Parameters["@FirstName"].Value = objPerson.FirstName; ;
                cmd.Parameters.Add(new SqlParameter("@MiddleName",SqlDbType.NVarChar));
                cmd.Parameters["@MiddleName"].Value = objPerson.MiddleName; ;
                cmd.Parameters.Add(new SqlParameter("@LastName",SqlDbType.NVarChar));
                cmd.Parameters["@LastName"].Value = objPerson.LastName; ;
                cmd.Parameters.Add(new SqlParameter("@UserName",SqlDbType.NVarChar));
                cmd.Parameters["@UserName"].Value = objPerson.UserName; ;
                cmd.Parameters.Add(new SqlParameter("@Password",SqlDbType.NVarChar));
                cmd.Parameters["@Password"].Value = objPerson.Password; ;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                return "good";

            }
            catch(SqlException ex){

                return "not good";
            }
            
        }
        [WebMethod(EnableSession=true)]
        public string AddNormalUser(Person objPerson)
        {

            try
            {
                SqlConnection con = new SqlConnection(connection);
                SqlCommand cmd = new SqlCommand("Kit_InsertNormalUser", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@KitchenID", SqlDbType.Int));
                cmd.Parameters["@KitchenID"].Value = Convert.ToInt32(Session["KitchenID"]);
                cmd.Parameters.Add(new SqlParameter("@FirstName", SqlDbType.NVarChar));
                cmd.Parameters["@FirstName"].Value = objPerson.FirstName; ;
                cmd.Parameters.Add(new SqlParameter("@MiddleName", SqlDbType.NVarChar));
                cmd.Parameters["@MiddleName"].Value = objPerson.MiddleName; ;
                cmd.Parameters.Add(new SqlParameter("@LastName", SqlDbType.NVarChar));
                cmd.Parameters["@LastName"].Value = objPerson.LastName; ;
                cmd.Parameters.Add(new SqlParameter("@UserName", SqlDbType.NVarChar));
                cmd.Parameters["@UserName"].Value = objPerson.FirstName+"123";
                cmd.Parameters.Add(new SqlParameter("@Password", SqlDbType.NVarChar));
                cmd.Parameters["@Password"].Value = objPerson.Password;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                return "good";
                

            }
            catch (SqlException ex)
            {

                return "not good";
            }
            

        }
        [WebMethod(EnableSession=true)]
        public string AddExpenses(Attribute objExpense) {
            try
            {
                SqlConnection con = new SqlConnection(connection);
                SqlCommand cmd = new SqlCommand("Kit_InsertExpenses", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@UserID", SqlDbType.Int)).Value=Convert.ToInt32(Session["UserID"]);
                cmd.Parameters.Add(new SqlParameter("@ItemCategoryID", SqlDbType.Int)).Value=objExpense.CategoryID;
                cmd.Parameters.Add(new SqlParameter("@ItemName", SqlDbType.Text)).Value=objExpense.ItemName;
                cmd.Parameters.Add(new SqlParameter("@ItemPrice", SqlDbType.Float)).Value=objExpense.ItemPrice;
                cmd.Parameters.Add(new SqlParameter("@ItemAmount", SqlDbType.Float)).Value=objExpense.ItemAmount;
                cmd.Parameters.Add(new SqlParameter("@PurchaseDate", SqlDbType.NVarChar)).Value = objExpense.PurchaseDate;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                return "good";

            }
            catch (SqlException ex)
            {

                return "not good";
            }
        
        
        
        }
        [WebMethod (EnableSession=true)]
        public string AddCategory(Setting objSetting)
        {
            try
            {
                SqlConnection con = new SqlConnection(connection);
                SqlCommand cmd = new SqlCommand("Kit_InsertCategoryName", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@CategoryName", SqlDbType.NVarChar)).Value=objSetting.CategoryName;
                cmd.Parameters.Add(new SqlParameter("@UserID", SqlDbType.Int)).Value =Convert.ToInt32(Session["UserID"]);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                return "good";

            }
            catch (SqlException ex)
            {

                return ex.ToString();
            }


        }
        #endregion

        #region edit
        [WebMethod]
        public void EditCategory(Attribute objCategory)
        {
            try
            {
                SqlConnection con = new SqlConnection(connection);
                SqlCommand cmd = new SqlCommand("Kit_EditCategory", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@CategoryID", SqlDbType.Int).Value = objCategory.CategoryID;
                cmd.Parameters.Add("@CategoryName", SqlDbType.NVarChar).Value = objCategory.CategoryName;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
            catch (Exception ex)
            {


            }


        }
        [WebMethod]
        public void EditExpenseDetails(Attribute objCategory)
        {
            try
            {
                SqlConnection con = new SqlConnection(connection);
                SqlCommand cmd = new SqlCommand("Kit_EditExpensesDetail", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@ItemID", SqlDbType.Int).Value = objCategory.ItemID;
                cmd.Parameters.Add("@ItemName", SqlDbType.NVarChar).Value = objCategory.ItemName;
                cmd.Parameters.Add("@ItemPrice", SqlDbType.Decimal).Value = objCategory.ItemPrice;
                cmd.Parameters.Add("@ItemAmount", SqlDbType.Decimal).Value = objCategory.ItemAmount;
                cmd.Parameters.Add("@PurchaseDate", SqlDbType.NVarChar).Value = objCategory.PurchaseDate;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
            catch (Exception ex)
            {


            }


        }
        [WebMethod(EnableSession=true) ]
        public void EditBasicInfo(Person objPerson)
        {
            try
            {
                SqlConnection con = new SqlConnection(connection);
                SqlCommand cmd = new SqlCommand("Kit_EditBasicInfo", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = Convert.ToInt32(Session["UserID"].ToString());
                cmd.Parameters.Add("@FirstName", SqlDbType.NVarChar).Value = objPerson.FirstName;
                cmd.Parameters.Add("@MiddleName", SqlDbType.NVarChar).Value = objPerson.MiddleName;
                cmd.Parameters.Add("@LastName", SqlDbType.NVarChar).Value = objPerson.LastName;
                cmd.Parameters.Add("@UserName", SqlDbType.NVarChar).Value = objPerson.UserName;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
            catch (Exception ex)
            {


            }


        }
        [WebMethod(EnableSession = true)]
        public void EditPassword(Person objPerson)
        {
            try
            {
                SqlConnection con = new SqlConnection(connection);
                SqlCommand cmd = new SqlCommand("Kit_EditPassword", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = Convert.ToInt32(Session["UserID"].ToString());
                cmd.Parameters.Add("@Password", SqlDbType.NVarChar).Value = objPerson.Password;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
            catch (Exception ex)
            {


            }


        }
        #endregion

        #region delete
        [WebMethod(EnableSession = true)]
        public List<Person> ClearSession()
        {
            Session["UserID"] = 0;
            List<Person> person = new List<Person>();
            Person objPerson = new Person()
            {
                UserID = Convert.ToInt32(Session["UserID"].ToString())
            };
            person.Add(objPerson);
            return person;
        
        }
        [WebMethod(EnableSession = true)]
        public List<Person> GetSession()
        {
            List<Person> person = new List<Person>();
            Person objPerson = new Person()
            {
                UserID=Convert.ToInt32(Session["UserID"].ToString())
            };
            person.Add(objPerson);
            return person;
        }
        [WebMethod]
        public void DeleteCategory(Attribute objCategory)
        {
            try
            {
                SqlConnection con = new SqlConnection(connection);
                SqlCommand cmd = new SqlCommand("Kit_DeleteCategory", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@CategoryID", SqlDbType.Int).Value = objCategory.CategoryID;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
            catch (Exception ex)
            {
                
            
            }

        
        }

        [WebMethod]
        public void DeleteUser(Person objPerson)
        {
            try
            {
                SqlConnection con = new SqlConnection(connection);
                SqlCommand cmd = new SqlCommand("Kit_DeleteUsers", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = objPerson.UserID;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
            catch (Exception ex)
            {


            }


        }

        [WebMethod]
        public void DeleteExpensesDetail(Attribute objCategory)
        {
            try
            {
                SqlConnection con = new SqlConnection(connection);
                SqlCommand cmd = new SqlCommand("Kit_DeleteExpensesDetail", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@ItemID", SqlDbType.Int).Value = objCategory.ItemID;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
            catch (Exception ex)
            {


            }


        }
        
        
        #endregion

        #region select
        
        [WebMethod(EnableSession = true)]
        public List<Person> SelectBasicInfo()
        {
            List<Person> result = new List<Person>();
            int UserID=(int)Session["UserID"];

            using (SqlConnection con = new SqlConnection(connection))
            {
                using (SqlCommand cmd = new SqlCommand("Kit_SelectBasicInfo", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@UserID", SqlDbType.Int)).Value = UserID;
                    con.Open();
                    using (SqlDataReader dreader = cmd.ExecuteReader())
                    {
                        while (dreader.Read())
                        {
                            Person user = new Person()
                            {
                                FirstName = dreader["FirstName"].ToString(),
                                MiddleName = dreader["MiddleName"].ToString(),
                                LastName=dreader["LastName"].ToString(),
                                Date= dreader["Date"].ToString(),
                                UserName=dreader["UserName"].ToString(),
                                UserID=Convert.ToInt32(dreader["UserID"].ToString()),
                                UserType=dreader["UserType"].ToString(),
                                KitchenName=dreader["KitchenName"].ToString()
                                
                            };
                            Session["KitchenID"] = Convert.ToInt32(dreader["KitchenID"].ToString());
                            result.Add(user);
                        }
                        dreader.Close();
                    }

                    con.Close();
                }
            }
            return result;
        }

        [WebMethod (EnableSession=true)]
        public List<Person> SelectUserList()
        {
            List<Person> result = new List<Person>();
            using (SqlConnection con = new SqlConnection(connection))
            {
                using (SqlCommand cmd = new SqlCommand("Kit_SelectUserList", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@KitchenID", SqlDbType.Int)).Value = Convert.ToInt32(Session["KitchenID"].ToString());
                    con.Open();
                    using (SqlDataReader dreader = cmd.ExecuteReader())
                    {
                        while (dreader.Read())
                        {
                            Person user = new Person()
                            {
                                FirstName = dreader["FirstName"].ToString(),
                                MiddleName = dreader["MiddleName"].ToString(),
                                LastName = dreader["LastName"].ToString(),
                                UserID=Convert.ToInt32(dreader["UserID"].ToString())
                            };
                            result.Add(user);
                        }
                        dreader.Close();
                    }

                    con.Close();
                }
            }
            return result;
        }

        [WebMethod(EnableSession = true)]
        public List<Attribute> SelectCategory()
        {
             List<Attribute> result = new List<Attribute>();
                int UserID = (int)Session["UserID"];

                using (SqlConnection con = new SqlConnection(connection))
                {
                    using (SqlCommand cmd = new SqlCommand("Kit_SelectCategory", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add(new SqlParameter("@UserID", SqlDbType.Int)).Value = UserID;
                        con.Open();
                        
            
                        using (SqlDataReader dreader = cmd.ExecuteReader())
                        {
                            while (dreader.Read())
                            {
                                try{
                                    Attribute att = new Attribute()
                                    {
                                        CategoryName = dreader["ItemCategoryName"].ToString(),
                                        CategoryID = Convert.ToInt32(dreader["ItemCategoryID"])
                                        
                                    };
                                    result.Add(att);
                                 }
                                catch(Exception ex){
                                    
                                }
                                
                            }
                            dreader.Close();
                        }

                        con.Close();
                    }
                   
                }
                return result;

            
            
        }

        [WebMethod(EnableSession = true)]
        public List<Attribute> SelectExpensesDetail(Attribute objCategory)
        {
            List<Attribute> result = new List<Attribute>();
            int UserID = (int)Session["UserID"];

            using (SqlConnection con = new SqlConnection(connection))
            {
                using (SqlCommand cmd = new SqlCommand("Kit_SelectExpensesDetail", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@UserID", SqlDbType.Int)).Value = UserID;
                    cmd.Parameters.Add(new SqlParameter("@FromDate", SqlDbType.VarChar)).Value = objCategory.FromDate;
                    cmd.Parameters.Add(new SqlParameter("@ToDate", SqlDbType.VarChar)).Value = objCategory.ToDate;
                    con.Open();
                    using (SqlDataReader dreader = cmd.ExecuteReader())
                    {
                        while (dreader.Read())
                        {
                            try
                            {
                                Attribute att = new Attribute()
                                {
                                    CategoryName = dreader["ItemCategoryName"].ToString(),
                                    CategoryID = Convert.ToInt32(dreader["ItemCategoryID"]),
                                    ItemName = dreader["ItemName"].ToString(),
                                    ItemID = Convert.ToInt32(dreader["ItemID"]),
                                    ItemAmount =Convert.ToDecimal(dreader["ItemAmount"].ToString()),
                                    ItemPrice = Convert.ToDecimal(dreader["ItemPrice"].ToString()),
                                    PurchaseDate = dreader["PurchaseDate"].ToString()


                                };
                                result.Add(att);
                            }
                            catch (Exception ex)
                            {
                            }
                        }
                        dreader.Close();
                    }

                    con.Close();
                }
            }
            return result;
        
        
        
        }

        [WebMethod(EnableSession=true) ]
        public List<FinalTransaction> SelectIndivisualTotalExpenses(Attribute objCategory)
        {
            List<Person> result = new List<Person>();
            List<PaidBy> payee = new List<PaidBy>();
            List<PaidTo> payto = new List<PaidTo>();
            List<FinalTransaction> finaltransaction = new List<FinalTransaction>();

            using (SqlConnection con = new SqlConnection(connection))
            {

                using (SqlCommand cmd = new SqlCommand("Kit_SelectIndivisualTotalExpenses", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@FromDate", SqlDbType.VarChar)).Value = objCategory.FromDate;
                    cmd.Parameters.Add(new SqlParameter("@ToDate", SqlDbType.VarChar)).Value = objCategory.ToDate;
                    cmd.Parameters.Add(new SqlParameter("@KitchenID", SqlDbType.Int)).Value = Convert.ToInt32(Session["KitchenID"]);
                    con.Open();
                    using (SqlDataReader dreader = cmd.ExecuteReader())
                    {
                        while (dreader.Read())
                        {
                            try
                            {
                                Person att = new Person()
                                {
                                    TotalExpenses =Convert.ToDecimal(dreader["TotalExpenses"]),
                                    FirstName = dreader["FirstName"].ToString(),
                                    MiddleName = dreader["MiddleName"].ToString(),
                                    LastName = dreader["LastName"].ToString(),
                                    UserID = Convert.ToInt32(dreader["UserID"].ToString()),
                                    TotalPeople=Convert.ToInt32(dreader["TotalPeople"])
                                    
                                };

                                result.Add(att);
                                
                            }
                            catch (Exception ex)
                            {
                            }
                        }
                        dreader.Close();
                    }

                    con.Close();
                }
            }
            decimal totalexpenses = 0;
            decimal perpersonexpenses = 0;
            int totalpeople = 0;
            foreach (Person lst in result)
            {
                totalexpenses += lst.TotalExpenses;
                totalpeople = lst.TotalPeople;
                //lst.TotalExpenses=
            }
            perpersonexpenses = totalexpenses / totalpeople;
            foreach (Person lst in result)
            {
                //categorize people whether payee or paidto groups
                if (lst.TotalExpenses > perpersonexpenses)
                {

                    PaidTo pay2 = new PaidTo()
                    {
                        FirstName = lst.FirstName,
                        MiddleName = lst.MiddleName,
                        LastName = lst.LastName,
                        Amount = lst.TotalExpenses,
                        HaveToGet=lst.TotalExpenses-perpersonexpenses

                    };
                    payto.Add(pay2);


                }
                else if (lst.TotalExpenses < perpersonexpenses)
                {
                    PaidBy payby = new PaidBy()
                    {
                        FirstName = lst.FirstName,
                        MiddleName = lst.MiddleName,
                        LastName = lst.LastName,
                        Amount = lst.TotalExpenses,
                        HaveToPay=perpersonexpenses-lst.TotalExpenses

                    };
                    payee.Add(payby);


                }

            }
            foreach (PaidBy  person in payee)
            {
                foreach (PaidTo person2 in payto)
                {
                    if (person2.HaveToGet != 0)
                    {
                        if (person2.HaveToGet >= person.HaveToPay)
                        {
                            FinalTransaction transaction = new FinalTransaction()
                            {
                                PaidBy = person.FirstName +"   "+ person.MiddleName +"   "+ person.LastName,
                                Amount = person.HaveToPay,
                                PaidTo = person2.FirstName +"   "+ person2.MiddleName +"  "+ person2.LastName
                            };
                            person2.HaveToGet = person2.HaveToGet - person.HaveToPay;
                            person.HaveToPay = person.HaveToPay - person.HaveToPay;
                            finaltransaction.Add(transaction);
                        }
                        else if (person2.HaveToGet <person.HaveToPay)
                        {
                            if (person.HaveToPay != 0)
                            {
                                FinalTransaction transaction = new FinalTransaction()
                                {
                                    PaidBy = person.FirstName +"  "+ person.MiddleName +"  "+ person.LastName,
                                    Amount = person2.HaveToGet,
                                    PaidTo = person2.FirstName +"  "+ person2.MiddleName +"  "+ person2.LastName
                                };
                                person.HaveToPay = person.HaveToPay - person2.HaveToGet;
                                person2.HaveToGet = person2.HaveToGet - person2.HaveToGet;
                                finaltransaction.Add(transaction);
                            }
                            


                        }
                    }
                
                
                
                }
            
            
            
            }
            return finaltransaction;


        }

        [WebMethod (EnableSession=true)]
        public List<Person> Login(Person objPerson)
        {
            List<Person> result = new List<Person>();
            

            using (SqlConnection con = new SqlConnection(connection))
             {
                using (SqlCommand cmd = new SqlCommand("Kit_Login", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@UserName", SqlDbType.NVarChar)).Value = objPerson.UserName;
                    cmd.Parameters.Add(new SqlParameter("@Password", SqlDbType.NVarChar)).Value = objPerson.Password;
                    con.Open();
                    using (SqlDataReader dreader = cmd.ExecuteReader())
                    {
                        while (dreader.Read())
                        {

                            string UserName = dreader["UserName"].ToString();
                            int UserID = Convert.ToInt32(dreader["UserID"]);
                            Session["UserID"] = UserID;
                            Session["UserName"] = UserName;
                            Person user = new Person()
                            {
                                UserID =Convert.ToInt32(dreader["UserID"]),
                                UserName = dreader["UserName"].ToString()
                            };
                            result.Add(user);
                        }
                        dreader.Close();
                    }

                    con.Close();
                }
            }
            return result;
        }

        [WebMethod(EnableSession = true)]
        public List<Person> CheckPassword(Person objPerson)
        {
            List<Person> result = new List<Person>();

            using (SqlConnection con = new SqlConnection(connection))
            {
                using (SqlCommand cmd = new SqlCommand("Kit_Login", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@UserName", SqlDbType.NVarChar)).Value = (string )Session["UserName"];
                    cmd.Parameters.Add(new SqlParameter("@Password", SqlDbType.NVarChar)).Value = objPerson.Password;
                    con.Open();
                    using (SqlDataReader dreader = cmd.ExecuteReader())
                    {
                        while (dreader.Read())
                        {

                            string UserName = dreader["UserName"].ToString();
                            int UserID = Convert.ToInt32(dreader["UserID"]);
                            Session["UserID"] = UserID;
                            Person user = new Person()
                            {
                                UserID = Convert.ToInt32(dreader["UserID"]),
                                UserName = dreader["UserName"].ToString()
                            };
                            result.Add(user);
                        }
                        dreader.Close();
                    }

                    con.Close();
                }
            }
            return result;
        }

        [WebMethod(EnableSession = true)]
        public List<Attribute> SelectMonthlyExpensesDetail(Attribute objCategory)
        {
            List<Attribute> result = new List<Attribute>();
            int UserID;
            if (objCategory.Flag == false)
            {
                UserID = (int)Session["UserID"];
            }
            else
            {
                UserID = objCategory.UserID;
            }
            using (SqlConnection con = new SqlConnection(connection))
            {
                using (SqlCommand cmd = new SqlCommand("Kit_SelectMonthlyExpensesDetail", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@UserID", SqlDbType.Int)).Value = UserID;
                    cmd.Parameters.Add(new SqlParameter("@PurchaseMonth", SqlDbType.VarChar)).Value = objCategory.PurchaseMonth;
                    cmd.Parameters.Add(new SqlParameter("@PurchaseYear", SqlDbType.VarChar)).Value = objCategory.PurchaseYear;
                    con.Open();
                    using (SqlDataReader dreader = cmd.ExecuteReader())
                    {
                        while (dreader.Read())
                        {
                            try
                            {
                                Attribute att = new Attribute()
                                {
                                    CategoryName = dreader["ItemCategoryName"].ToString(),
                                    CategoricalExpenses = Convert.ToInt32(dreader["CategoricalExpenses"]),
                                };
                                result.Add(att);
                            }
                            catch (Exception ex)
                            {
                            }
                        }
                        dreader.Close();
                    }

                    con.Close();
                }
            }
            return result;



        }

        [WebMethod(EnableSession = true)]
        public List<Attribute> CheckKitchenName(Attribute objKitchen)
        {
            List<Attribute> result = new List<Attribute>();
            using(SqlConnection con=new SqlConnection(connection))
                                             {

                                                
                   using(SqlCommand cmd=new SqlCommand("Kit_CheckKitchenName",con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add(new SqlParameter("@KitchenName", SqlDbType.VarChar)).Value = objKitchen.KitchenName;
                        con.Open();
                        using (SqlDataReader dreader = cmd.ExecuteReader())
                        {
                            while (dreader.Read())
                             {
                                 try
                                 {
                                     Attribute obj = new Attribute()
                                     {
                                         KitchenCount = Convert.ToInt32(dreader["KitchenCount"].ToString())
                                     };
                                     result.Add(obj);
                                 }
                                 catch (Exception e)
                                 {
                                 }
                             }
                        }
                        return result;
                    }
                
                  }



        }


        #endregion
    }
        
}