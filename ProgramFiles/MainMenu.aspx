<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MainMenu.aspx.cs" Inherits="KitCalc.ProgramFiles.MainMenu" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Main Menu</title>
    <link href="../StyleSheet/simple.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheet/template.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheet/tablesorter.css" rel="stylesheet" type="text/css" />
    <script src="../JavaScript/json2.js" type="text/javascript"></script>

    <script src="../JavaScript/jquery.js" type="text/javascript"></script>
    <script type="text/javascript">
        var userid;
        function RequiredFieldValidation() {
            $('table.addusertable').find('input.required').each(function() {
                var clas = $(this).attr('class');
                //if ($.trim(clas) == 'textbox required') {
                    if (!$(this).val()) {
                        //check whether it already exists or not
                        if ($(this).parents('.rowrapper').find("td:eq(2)").length < 1) {
                            $(this).parents('.rowrapper').append('<td class="errormessage"> is required field</td>').css('color:red');
                        }
                    }
                    else {
                        $(this).parents('.rowrapper').find("td:eq(2)").remove();
                    }
                //}
            });
        }
        function validateEmail($email) {
            var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
            if (!emailReg.test($email)) {
                alert('Email not in correct format');
                $('input.email').val('');
                $('input.email').focus();
                return false;
            } 
        }
        function SelectBasicInfo(){
            $.ajax({
                url: '../WebService/WebService1.asmx/SelectBasicInfo',
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                type: 'post',
                data: '{}',
                success: function(data) {
                    $.each(data.d, function(index, item) {
                        var name;
                        if (item.MiddleName.length == 0) {
                            name = item.FirstName + '  ' + item.LastName;
                        }
                        else {
                            name = item.FirstName + '  ' + item.MiddleName + '  ' + item.LastName;
                        }
                        $('tr.rowrapper').find('#name').html(name).css('color:red;text-style:italic');
                        $('tr.rowrapper').find('#date').html(item.Date).css('color:red;text-style:italic');
                        $('tr.rowrapper').find('#kitchen').html('You are in Kitchen------' + item.KitchenName).css('color:red;text-style:italic');
                        var usertype = item.UserType;
                        if ($.trim(usertype) == 'admin') {
                            $('table.admintable').fadeIn(2000);

                        }
                        userid = item.UserID;

                    });

                },
                error: function(msg) {

                }

            });
        }
        function SelectUserList() {
            $.ajax({
                url: '../WebService/WebService1.asmx/SelectUserList',
                data: '{}',
                dataType: 'json',
                contentType: 'application/json;charset=utf-8',
                type: 'post',
                success: function(data) {
                    var html;
                    html += '<tr class="rowrapper">';
                    html += '<th>User Name</th>';
                    html += '</tr>';
                    $.each(data.d, function(index, item) {
                        if (userid != item.UserID) {
                            html += '<tr class=rowrapper>';

                            html += '<td>' + item.FirstName + '  ' + item.MiddleName + '  ' + item.LastName + '</td>';
                            html += '<td class="hidden">' + item.UserID + '</td>';
                            html += '<td>';
                            html += '<input type="button" class="delete button" value="delete" />';
                            html += '</td>';
                            html += '</tr>';
                        }

                    });
                    html += '<tr><td><input type="button" value="close" class="close button"/></td></tr>'
                    $('table.deleteusertable').html(html);
                },
                error: function() {
                }

            });
        }
        function DeleteUser(userid) {
                var param={
                objPerson: {
                                      UserID:userid
                                      }
                          }
                          $.ajax({
                              url: '../WebService/WebService1.asmx/DeleteUser',
                              data: JSON.stringify(param),
                              dataType: 'json',
                              contentType: 'application/json;charset=utf-8',
                              type: 'post',
                              success: function(data) {
                                  SelectUserList();
                              },
                              error: function() {
                              }

                          });
                  }
           function GetSession(){
               $.ajax({
                   url: '../WebService/WebService1.asmx/GetSession',
                   data: '{}',
                   dataType: 'json',
                   contentType: 'application/json;charset=utf-8',
                   type: 'post',
                   success: function(data) {
                       $.each(data.d, function(index, item) {

                           if (item.UserID < 1) {
                               window.location.href='Login.aspx';
                           }
                       });
                   },
                   error: function(msg) {
                   }
               });
           
           }
           function ClearSession() {
               $.ajax({
                   url: '../WebService/WebService1.asmx/ClearSession',
                   data: '{}',
                   dataType: 'json',
                   contentType: 'application/json;charset=utf-8',
                   type: 'post',
                   success: function(data) {
                       $.each(data.d, function(index, item) {
                           window.location.href = 'Login.aspx';
                       });
                       
                   },
                   error: function(msg) {
                       alert(msg);
                   }
               });
           }
           function randString(n) {
               if (!n) {
                   n = 5;
               }

               var text = '';
               var possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

               for (var i = 0; i < n; i++) {
                   text += possible.charAt(Math.floor(Math.random() * possible.length));
               }

               return text;
           }
           function SaveNormalUser() {
               var fname = $('#fname').val();
               var mname = $('#mname').val();
               var lname = $('#lname').val();
               var uname = randString(8);
               var password = randString(6);
               var email = $('#email').val();
               var param = { objPerson: {
                   FirstName: fname,
                   MiddleName: mname,
                   LastName: lname,
                   UserName: uname,
                   Password: password
                   }
               };
               $.ajax({
                   url: "../WebService/WebService1.asmx/AddNormalUser",
                   dataType: "json",
                   data: JSON.stringify(param),
                   type: "post",
                   contentType:'application/json;charset=utf-8',
                   error: function(err) {
                       'error:' + err.toString()
                   },
                   success: function(msg) {
                       SendMail(fname + '123', password);
                       alert("Save data successfully");
                       $('#fname').val('');
                       $('#mname').val('');
                       $('#lname').val('');
                       $('#email').val('');
                       SelectUserList();
                       $('#fname').focus();
                   }
               });
           }
           function SendMail(uname,password) {
               var email = $('#email').val();
               var param = { objPerson: {
                   UserName: uname,
                   Password: password,
                   Email: email
                 }
               };
               $.ajax({
                   url: "../WebService/WebService1.asmx/SendMail",
                   dataType: "json",
                   data: JSON.stringify(param),
                   type: "post",
                   contentType:'application/json;charset=utf-8',
                   error: function(err) {
                       'error:' + err.toString()
                   },
                   success: function(msg) {
                       
                   }
               });
           
           
           }
           $(document).ready(function() {
               GetSession();
               SelectBasicInfo();
               SelectUserList();
               $('a.addusertokitchen').bind('click', function() {
                   $('table.addusertable').fadeIn(3000);
               });
               $('a.deleteuser').bind('click', function() {
                   SelectUserList();
                   $('table.deleteusertable').fadeIn(3000);
               });
               $('input.delete').die();
               $('input.delete').live('click', function() {
                   var userid = $(this).parents('tr.rowrapper').find('td.hidden').html();
                   DeleteUser(userid);

               });
               $('input.close').die();
               $('input.close').live('click', function() {
                   $('table.deleteusertable').fadeOut(3000);
               });
               $('#fname').keydown(function() {
                   RequiredFieldValidation();
               });
               $('#lname').keydown(function() {
                   RequiredFieldValidation();
               });

               $('#cancel').bind('click', function() {
                   $('table.addusertable').fadeOut(1500);

               });
               $('#submit').bind('click', function() {
                   RequiredFieldValidation();
                   if ($('input.email').val() != '') {
                       validateEmail($('input.email').val());
                   }
                   var gateway = 0;
                   $('input.required').each(function() {
                       if ($(this).parents('.rowrapper').find('td:eq(2)').length >= 1) {
                           gateway = 1;
                           return false;
                       }
                   });
                   if (gateway != 1) {
                       SaveNormalUser();
                   }


               });
               $('a.logout').bind('click', function() {
                   ClearSession();
               });
           });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="mainrapperdiv">
       
    </div>
    <div id="mainWrap">
        <div id="mainPanel">
            <div id="menu">
                <ul>
                    
                    <li><a href="MainMenu.aspx"><span>Control&nbsp;Panel</span></a></li>
                    <li>
                        <div class="blank">
                        </div>
                    </li>
                    <li><a class="logout" href="#"><span>LogOut</span></a></li>
                    <li>
                        <div class="blank">
                        </div>
                    </li>
                    
                </ul>
            </div>
            <div id="logoWrap">
                <h1>
                    KitCalc</h1>
            </div>
            <div id="loginPanel">
                
                
            </div>
            <div id="quots">
               <%-- <p> This is your  control panel </p>--%>
            </div>
            
                <div id="leftPanel">
                
                    <table class="tablesorter">
                        <tr class="rowrapper">
                            <td id="name">
                            </td>
                            <td id="date">
                            </td>
                            <td id="kitchen"></td>
                            
                        </tr>
                        <tr>
                            <td>
                                <a href="Settings.aspx">
                                    <img src="../images/icons/Settings-icon.png" alt="settingicon" class="icon" /></a>
                                <a href="Settings.aspx">My Setting</a>
                            </td>
                            <td>
                                <a href="Expenses.aspx">
                                <img src="../images/icons/expenses.png" alt="expensesicon" class="icon" /></a>
                               <a href="Expenses.aspx">My Expenses</a>
                            </td>
                            <td>
                               <a href="Report.aspx"> <img src="../images/icons/reporticon.png" alt="reporticon" class="icon" /></a>
                                <a href="Report.aspx">My Reports</a>
                            </td>
                            <td>
                                <a href="Transaction.aspx"><img src="../images/icons/transactionicon.png" alt="transactionicon" class="icon" /></a>
                                <a href="Transaction.aspx">My Transactions</a>
                            </td>
                        </tr>
                    </table>
                    <table class="tablesorter admintable" style="display:none">
                        <tr>
                            <td>
                             <a class="addusertokitchen" href="#">
                               <img src="../images/icons/adduser.png" alt="settingicon" class="icon" />
                                  Add User 
                               </a>
                            
                            <%--</td>
                            <td>--%>
                                <a class="deleteuser" href="#">
                                <img src="../images/icons/removeuser.png" alt="settingicon" class="icon" />
                                   Remove User
                                </a>
                            </td>
                        
                        </tr>
                    
                    </table>
                    <table class="tablesorter addusertable" style="display:none;">
                    <tr>
                        <td>
                            Insert users personal credentials:
                        </td>
                    </tr>
                    
                    <tr class="rowrapper">
                        <td>
                            <label>
                                First name:</label><em class="required">*</em>
                        </td>
                        <td>
                            <input type="text" class="textbox required " id="fname" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Middle name:
                        </td>
                        <td>
                            <input type="text" class="textbox " id="mname" />
                        </td>
                    </tr>
                    <tr class="rowrapper">
                        <td>
                            <label>
                                Last name:</label>
                            <em class="required">*</em>
                        </td>
                        <td>
                            <input type="text" class="textbox required" id="lname" />
                        </td>
                    </tr>
                    <tr class="rowrapper">
                        <td>
                            <label>Email address:</label>
                            <em class="required">*</em>
                        
                        </td>
                        <td>
                            <input type="text" class="textbox required email" id="email"/>
                        </td>
                    
                    </tr>
                    <tr>
                        <td>
                            <input type="button" class="button" value="ok" name="submit" id="submit" />
                        </td>
                        <td>
                            <input type="button" class="button" value="cancel" name="cancel" id="cancel" />
                        </td>
                    </tr>
                </table>
                    <table class="tablesorter deleteusertable" style="display:none">
                        
                    
                    
                    </table>
               </div>
            
                
            
            
            
        </div>
    </div>
    
    
    </form>
</body>
</html>
