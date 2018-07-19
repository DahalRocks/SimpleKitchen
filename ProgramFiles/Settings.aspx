<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="KitCalc.ProgramFiles.Settings" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Setting</title>
    <link href="../StyleSheet/simple.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheet/tablesorter.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheet/jquery.fancybox.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheet/template.css" rel="stylesheet" type="text/css" />
    <script src="../JavaScript/jquery.js" type="text/javascript"></script>
    <script src="../JavaScript/json2.js" type="text/javascript"></script>
    <script type="text/javascript">
        var firstname,middlename,lastname,username;
        function SelectBasicInfo(){
            $.ajax({
                url:'../WebService/WebService1.asmx/SelectBasicInfo',
                dataType:'json',
                contentType:'application/json; charset=utf-8',
                type:'post',
                data:'{}',
                success:function(data){
                    $.each(data.d,function(index,item){
                        var name;
                        if(item.MiddleName.length==0){
                            name=item.FirstName+'  '+item.LastName;
                        }
                        else{
                             name=item.FirstName+'  '+item.MiddleName+'  '+item.LastName;
                        }
                        $('tr.loginname').find('.name').html(name);
                        $('tr.loginname').find('.date').html(item.Date);
                        
                    });
                
                },
                   error:function(msg){
                
                    }      
            
               });
           }
           function GetSession() {
               $.ajax({
                   url: '../WebService/WebService1.asmx/GetSession',
                   data: '{}',
                   dataType: 'json',
                   contentType: 'application/json;charset=utf-8',
                   type: 'post',
                   success: function(data) {
                       $.each(data.d, function(index, item) {

                           if (item.UserID < 1) {
                               window.location.href = 'Login.aspx';
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
        function SelectGeneralSetting(){
                $.ajax({
                    url:'../WebService/WebService1.asmx/SelectBasicInfo',
                    data:'{}',
                    dataType:'json',
                    contentType:'application/json; charset=utf-8',
                    type:'post',
                    success:function(data){
                    var html;
                    $.each(data.d,function(index,item){
                         html+='<tr class="loginname">';
                             html+='<td class="name">';
                             html+='</td><td class="date"></td>';
                         html+='</tr>';
                         html+='<tr class="even" >';
                              html+='<th>Name</th>';
                              html+='<td><label class="firstname">'+item.FirstName+'  '+'</label>';
                              html+='<label class="middlename">'+item.MiddleName+'  '+'</label>';
                              html+='<label class="lastname">'+item.LastName+'</label></td>';
                              html+='<td><a class="edit namepopuptrigger popuptrigger" href=""><img src="../images/icons/editicon.png"/></a></td>';
                         html += '</tr>';
                                                  
                        
                         html+='<tr class="odd" >';
                            html+='<th>Category</th>';
                            html+='<td><a class="categorylist" href="#"></td>';
                            html+='<td><a class="editcategory categorypopuptrigger popuptrigger" href=""><img src="../images/icons/editicon.png"/></a></a></td>';
                         html+='</tr>';
                        
                         html+='<tr class="username even">';
                            html+='<th>Username</th>';
                            html+='<td>'+item.UserName+'</td>';
                            html+='<td><a class="edit usernamepopuptrigger popuptrigger" href=""><img src="../images/icons/editicon.png"/></a></a></td>';
                         html+='</tr>';
                        
                         html+='<tr class="odd" >';
                            html+='<th>Password</th>';
                            html+='<td></td>';
                            html+='<td><a class="edit passwordpopuptrigger popuptrigger" href=""><img src="../images/icons/editicon.png"/></a></a></td>';
                         html+='</tr>';
                                            
                    });
                     $('table.generalsetting').html(html);
                    },
                    error:function(){
                    }
                });
          }    
        function SelectCategory(){
            $.ajax({
                   url:'../WebService/WebService1.asmx/SelectCategory',
                   dataType:'json',
                   data:'{}',
                   contentType:'application/json;char-set=utf-8',
                   type:'post',
                   success:function(data){
                    var html='';
                    $.each(data.d,function(index,item){
                       html+='<tr class="rowrapper">';   
                            html+='<td id="catname">';
                            html+=item.CategoryName;
                            html+='</td>';
                            html+='<td id="catid" style="visibility:hidden">';
                            html+=item.CategoryID;
                            html+='</td>'
                            html+='<td>'
                            html+='<input type="button" class="edit button" value="edit" />';
                            html+='</td>';
                            html+='<td>';
                            html+='<input type="button" class="delete button" value="delete" />';
                            html+='</td>';
                      html+='</tr>';
                    });
                    $('tr.categorychart').html(html);
                   },
                   error:function(msg){
                   }
            });
        }
        function EditBasicInfo(){
             var param={
                        objPerson:{
                                FirstName:firstname,
                                MiddleName:middlename,
                                LastName:lastname,
                                UserName:username
                             }
             
                        }
                        
             $.ajax({
                url:'../WebService/WebService1.asmx/EditBasicInfo',
                data:JSON.stringify(param),
                dataType:'json',
                contentType:'application/json;; charset=utf-8',
                type:'post',
                success:function(data){
                    SelectGeneralSetting();
                    SelectBasicInfo();
                },
                error:function(){
                }
             });
        }
        function CheckPassword(){
           var password=$('input.currentpassword').val();
            var param={
                         objPerson:{ Password:password}
                     }
            
            $.ajax({
                    type:"post",
                    url:"../WebService/WebService1.asmx/CheckPassword",
                    data:JSON.stringify(param),
                    dataType:"json",
                    contentType: "application/json; charset=utf-8",
                    success:function(data){
                            if(data.d.length==0){
                                if($('.passwordpopup').find('input.currentpassword').parents('.rowrapper').find('.errormessage').length<=0)
                                $('.passwordpopup').find('input.currentpassword').parents('.rowrapper').append('<td class="errormessage">this password does not exist</td>');
                                //return false;
                                    
                            }
                            else{
                                $('.passwordpopup').find('input.currentpassword').parents('.rowrapper').find('td:eq(1)').remove();
                            
                            }
                                          
                 },
                 error:function(data){
                            alert("system fail");
                 
                 }
            
              });
        
        
        
        }
        function EditPassword(){
             var password=$('.passwordpopup').find('.confirmpassword').val();
             var param={
                        objPerson:{
                            Password:password
                            
                             }
             
                        }
            
             $.ajax({
                url:'../WebService/WebService1.asmx/EditPassword',
                data:JSON.stringify(param),
                dataType:'json',
                contentType:'application/json;charset=utf-8',
                type:'post',
                success:function(data){
                    $(".popup").fadeOut(500);
                },
                error:function(){
                }
             });
        }
        function DeleteCategory(categoryid){
            var param={
                  objCategory:{
                                CategoryID:categoryid
                              
                              }
                      }
            $.ajax({
                    url:'../WebService/WebService1.asmx/DeleteCategory',
                    data:JSON.stringify(param),
                    dataType:'json',
                    contentType:'application/json;charset=utf-8',
                    type:'post',
                    success:function(data){
                        SelectCategory();
                    },
                    error:function(msg){
                        
                    }
                 });
           }
           function EditCategory(categoryid,categoryname){
                var param={
                  objCategory:{
                                CategoryID:categoryid,
                                CategoryName:categoryname
                              
                              }
                      }
            $.ajax({
                    url:'../WebService/WebService1.asmx/EditCategory',
                    data:JSON.stringify(param),
                    dataType:'json',
                    contentType:'application/json;charset=utf-8',
                    type:'post',
                    success:function(data){
                        SelectCategory();
                    },
                    error:function(msg){
                        
                    }
                 });
           
           }
           function CreatePopUp(){
            //open popup
            $(".categorypopuptrigger").die();
            $(".categorypopuptrigger").live('click',function(e){
                e.preventDefault();
                //$(".popup").removeClass('hidden');
                $(".categorypopup").fadeIn(1000);
                positionPopup();
                $('input.textbox').focus();
            });
            $('input.addcategory').live('click', function() {
            $(".addcategorytable").fadeIn(1000);
                positionPopup();
                $('input.textbox').focus();
            });
            $(".namepopuptrigger").die();
            $(".namepopuptrigger").live('click',function(e){
                e.preventDefault();
                var firstname=$('table.generalsetting').find('label.firstname').html();
                
                var middlename=$('table.generalsetting').find('label.middlename').html();
                
                var lastname= $('table.generalsetting').find('label.lastname').html();
                
                $('table.namepopup').find('input.firstname').val(firstname);
                $('table.namepopup').find('input.middlename').val(middlename);
                $('table.namepopup').find('input.lastname').val(lastname);
                $(".namepopup").fadeIn(1000);
                positionPopup();
            });
            $('.usernamepopuptrigger').die();
            $('.usernamepopuptrigger').live('click',function(e){
                e.preventDefault();
                var username=$('tr.username').find('td:eq(0)').html();
               $('table.usernamepopup').find('input.username').val(username);
               $('.usernamepopup').fadeIn(1000);
               positionPopup();
            });
            $('.passwordpopuptrigger').die();
            $('.passwordpopuptrigger').live('click', function(e) {
                e.preventDefault();
                $('input.currentpassword').focus();
                $('.passwordpopup').fadeIn(1000);
                positionPopup();
            });
             
            //close popup
            $(".close").click(function(){
              $(".popup").fadeOut(500);
            });
            $(".closeaddcategory").click(function() {
              $(".addcategorytable").fadeOut(500);
            });
          
            $("input.editname ").click(function(){
              $(".popup").fadeOut(500);
            });
            $("input.editusername ").click(function(){
              $(".popup").fadeOut(500);
            });
            $("input.editpassword ").click(function(){
              //
            });
            $('.closepasswordpopup').click(function(){
                $('.currentpassword').val('');
                $('.newpassword').val('');
                $('.confirmpassword').val('');
                $.each($('.passwordpopup').find('.errormessage'),function(){
                 $(this).remove();
                });
                $(".popup").fadeOut(500);
            
            });
             
            //position the popup at the center of the page
            function positionPopup(){
                if(!$(".popup").is(':visible')){
                    return;
                }
                $(".popup").css({
                    //left: ($(window).width() - $('.popup').width()) / 2,
                    //top: ($(window).height() - $('.popup').height()) ,
                    top: $(window).height()/2,
                    position:'absolute'
                    
                });
            }

            //maintain the popup at center of the page when browser resized
            $(window).bind('resize',positionPopup);
           }

           $(document).ready(function() {
               GetSession();
               $('a.logout').bind('click', function() {
                   ClearSession();
               });
               SelectGeneralSetting();
               SelectBasicInfo();
               SelectCategory();
               CreatePopUp();
               
               $('input.editname').die();
               $('input.editname').live('click', function() {
                   firstname = $('table.namepopup').find('input.firstname').val();

                   middlename = $('table.namepopup').find('input.middlename').val();

                   lastname = $('table.namepopup').find('input.lastname').val();

                   if (!$.trim(firstname)) {
                       alert('First name can not be empty');
                       return false;
                   }
                   middlename = $('table.namepopup').find('input.middlename').val();
                   if (!$.trim(lastname)) {
                       alert('Last name can not be empty');
                       return false;
                   }
                   username = $('tr.username').find('td:eq(0)').html();
                   EditBasicInfo();

               });
               $('input.editusername').die();
               $('input.editusername').live('click', function() {
                   username = $('table.usernamepopup').find('input.username').val();
                   firstname = $('table.generalsetting').find('label.firstname').html();
                   middlename = $('table.generalsetting').find('label.middlename').html();
                   lastname = $('table.generalsetting').find('label.lastname').html();
                   if (!username) {
                       alert('Username can not be empty');
                       return false;
                   }
                   EditBasicInfo();

               });

               $('input.currentpassword').die();
               $('input.currentpassword').keyup(function() {
                   CheckPassword();
               });
               $('input.confirmpassword').keyup(function() {
                   var newpassword = $('input.newpassword').val();
                   var confirmpassword = $(this).val();
                   if ($.trim(newpassword) != $.trim(confirmpassword)) {
                       if ($(this).parents('tr.rowrapper').find('.errormessage').length <= 0)
                           $(this).parents('tr.rowrapper').append('<td class="errormessage">password did not match</td>');
                   }
                   else {
                       $(this).parents('tr.rowrapper').find('td:eq(1)').remove();
                   }
               });


               $('input.editpassword').die();
               $('input.editpassword').live('click', function() {
                   var currentpassword = $('.passwordpopup ').find('.currentpassword').val();
                   var newpassword = $('.passwordpopup ').find('.newpassword').val();
                   var confirmpassword = $('.passwordpopup ').find('.confirmpassword').val();
                   if (!currentpassword) { alert('please insert current password'); return false; }
                   if (!newpassword) { alert('please insert new password'); return false; }
                   if (!confirmpassword) { alert('please insert confirmation password'); return false; }
                   if ($('.passwordpopup').find('.errormessage').length <= 0) {
                       EditPassword();
                       $('.passwordpopup ').find('.currentpassword').val('');
                       $('.passwordpopup ').find('.newpassword').val('');
                       $('.passwordpopup ').find('.confirmpassword').val('');


                   }

               });
               $('input.delete').die();
               $('input.delete').live('click', function(e) {
                   e.preventDefault();
                   DeleteCategory($(this).parents('tr.rowrapper').find('#catid').html());

               });
               $('input.edit').die();
               $('input.edit').live('click', function(e) {
                   e.preventDefault();
                   $(this).addClass('hidden');
                   var originalvalue = $(this).parents('tr.rowrapper').find('#catname').html();
                   var textbox = '<input type="text" class="newtextbox edittextbox"/>';
                   $(this).parents('tr.rowrapper').find('#catname').html(textbox);
                   $('input.newtextbox').focus();
                   $(this).parents('tr.rowrapper').find('input.newtextbox').val(originalvalue);
                   $('input.newtextbox').die();
                   $('input.newtextbox').live('focusout', function() {
                       var editedvalue = $(this).val();
                       if (!editedvalue) {
                           $(this).parents('tr.rowrapper').find('input.edit').removeClass('hidden');
                           alert('category name is as it is');
                           $(this).parents('tr.rowrapper').find('#catname').html(originalvalue);
                           return false;
                       }
                       var catid = $(this).parents('tr.rowrapper').find('#catid').html();
                       EditCategory(catid, editedvalue)
                       $(this).parents('tr.rowrapper').find('input.edit').removeClass('hidden');
                   });
               });

               $('#ok').click(function() {
                   var CategoryName = $('#category').val();
                   if (!CategoryName) {
                       alert('please enter category');
                       return false;
                   }
                   var param = {
                       objSetting: {
                           CategoryName: CategoryName
                       }
                   }
                   $.ajax({
                       url: '../WebService/WebService1.asmx/AddCategory',
                       type: 'post',
                       dataType: "json",
                       data: JSON.stringify(param),
                       contentType: 'application/json; charset=utf-8',
                       success: function(data) {
                           $('#category').val('');
                           $('#category').focus();
                           //CALL SELECT FUNCTION FOR CATEGORY
                           SelectCategory();
                       },
                       error: function(msg) {
                           alert(msg.d)

                       }
                   });
               });
           });
    
    </script>
</head>
<body>
    <form id="form1"  runat="server">
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
                    <table class="generalsetting tablesorter">
                    </table>
                    <table class="popup namepopup tablesorter" style="display: none">
                        <tr>
                            <th>
                                First name
                            </th>
                            <td>
                                <input type="text" class="firstname textbox" />
                            </td>
                             <td>
                                <a href="#" class="close">Close</a>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                Middle name
                            </th>
                            <td>
                                <input type="text" class="middlename textbox" />
                            </td>
                        </tr>
                        <tr>
                            <th>
                                Last name
                            </th>
                            <td>
                                <input type="text" class="lastname textbox" />
                            </td>
                        </tr>
                        <tr>
                           
                            <td>
                                <input type="button" class="editname button " value="ok" />
                            </td>
                        </tr>
                    </table>
                    <table class=" tablesorter popup categorypopup " style="display: none">
                        
                        <tr>
                            <th>
                                Category
                            </th>
                            <td class="close"><a href="#">close</a></td>
                        
                        </tr>
                        <tr class="categorychart">
                        </tr>
                        <tr class="rowrapper">
                            <td>
                             <a href="#"><input class="addcategory" type="button" value="Click to add new category" /></a>
                            </td>
                        </tr>
                        
                    </table>
                    <table class="addcategorytable tablesorter popup  " style="display: none">
                      <tr class="rowrapper">
                            <th>
                                Category Name
                            </th>
                            <td>
                                <input type="text" class="textbox" id="category" name="normal" />
                                <input type="button" class="button" id="ok" value="ok" />
                            </td>
                            
                            <td>
                                <a href="#" class="closeaddcategory ">Close</a>
                            </td>
                        </tr>
                    </table> 
                    <table class="popup usernamepopup tablesorter" style="display: none">
                        <tr>
                            <th>
                                User name
                            </th>
                            <td>
                                <input type="text" class="username textbox" />
                            </td>
                            <td>
                                <input type="button" class="editusername button" value="ok" />
                                
                                <a href="#" class="close">Close</a>
                            
                            </td>
                        </tr>
                        
                    </table>
                    <table class="popup passwordpopup tablesorter" style="display: none">
                        <tr class="rowrapper">
                            <th>
                                Current Password<em  class="required" >*</em>
                            </th>
                            <td>
                                <input type="password" class="currentpassword textbox required" />
                            </td>
                            
                        </tr>
                        <tr>
                            <th>
                                New Password<em class="required">*</em>
                            </th>
                            <td>
                                <input type="password" class="newpassword textbox required" />
                            </td>
                        </tr>
                        <tr class="rowrapper">
                            <th>
                                Confirm Password<em class="required">*</em>
                            </th>
                            <td>
                                <input type="password" class="confirmpassword textbox required" />
                            </td>
                        </tr>
                        <tr>
                            
                            <td>
                                <input type="button" class="editpassword button" value="ok" />
                            </td>
                            <td>
                                <a href="#" class="closepasswordpopup">Close</a>
                            </td>
                        </tr>
                    </table>
        
               </div>
            
                
            
            
            
        </div>
    </div>
    
    </form>
</body>
</html>
