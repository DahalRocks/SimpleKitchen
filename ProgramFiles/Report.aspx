<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="KitCalc.ProgramFiles.Report" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Report</title>
    <link href="../StyleSheet/simple.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheet/jquery.fancybox.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheet/tablesorter.css" rel="stylesheet" type="text/css" />
    <script src="../JavaScript/jquery.js" type="text/javascript"></script>
    <script src="../JavaScript/json2.js" type="text/javascript"></script>
    <script type="text/javascript">
            var userid,fullname,selecteddate;
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
                        $('tr.rowrapper').find('#name').html(name);
                        $('tr.rowrapper').find('#date').html(item.Date);
                        userid=item.UserID;
                        
                    });
                
                },
                   error:function(msg){
                
                    }      
            
               });
            }
            
            function SelectUserList(){
                $.ajax({
                    url:'../WebService/WebService1.asmx/SelectUserList',
                    data:'{}',
                    dataType:'json',
                    type:'post',
                    contentType:'application/json;charset=utf-8',
                    success:function(data){
                        var name,html;
                        $.each(data.d,function(index,item){
                            name=item.FirstName+' '+item.MiddleName+'  '+item.LastName;
                            if(item.UserID!=userid){
                               html+='<tr class="rowrapper">';
                                   html+=' <th>'+name+'</th>';
                                   html+='<td class="hidden">'+item.UserID+'</td>';
                                   html+='<td><a href="" class="popuptrigger">show report</a></td>';
                               html+='</tr>'; 
                            }
                            $('table.userlist').html(html);                          
                        });
                    
                    },
                    error:function(msg){
                    }
                });
            }
            
            
            function CreateReport(popup){
            var purchasemonth,purchaseyear;
            if(!popup){
             purchasemonth=$('table.dateselection').find('select.monthdropdown').val();
             purchaseyear=$('table.dateselection').find('select.yeardropdown').val();
            }
            else{
             purchasemonth=$('table.dateselectionpopup').find('select.monthdropdown').val();
             purchaseyear=$('table.dateselectionpopup').find('select.yeardropdown').val();
            }
            var param;
            if(!popup){
                param={
                    objCategory:{
                                     PurchaseMonth:purchasemonth,
                                     PurchaseYear:purchaseyear
                                }
                        };
            }
            else{
                param={
                    objCategory:{
                                     PurchaseMonth:purchasemonth,
                                     PurchaseYear:purchaseyear,
                                     UserID:userid,
                                     Flag:true
                                }
                        };    
                
            }
            
            
             $.ajax({
                    url:'../WebService/WebService1.asmx/SelectMonthlyExpensesDetail',
                    type:'post',
                    data:JSON.stringify(param),
                    dataType:'json',
                    contentType:'application/json; charset=utf-8',
                    success:function(data){
                         var html,totalexpenses=0;
                         if(popup){
                             html+='<tr>';
                                html+='<td>'+fullname+'</td>';
                                html+='<td>'+selecteddate+'</td>';
                                html+='<td class="close"><label class="close">close</label></td>';      
                             html+='</tr>'
                         }
                         html+='<tr>';
                                  html+='<th>Catregory</th>';
                                  html+='<th>Total Expenses</th>';
                          html+='</tr>';
                          if(data.d==0){
                                            html+='<tr class="">';
                                            html+='<td>No item found</td>'; 
                                            html+='</tr>';
                                     }
                        $.each(data.d,function(index,item){
                            totalexpenses+=item.CategoricalExpenses;
                            html+='<tr>';
                                  html+='<td>'+item.CategoryName+'</td>';
                                  html+='<td>'+item.CategoricalExpenses+'</td>';
                            html+='</tr>';
                                
                        
                        });
                        html+='<tr>'
                                  html+='<td class="totalexpenses">your total expenses of this month </th>';
                                  html+='<td class="totalexpenses">'+totalexpenses+'</th>';
                        html+='</tr>';
                        if(!popup){ 
                          $('table.monthlyexpenses').html(html);
                        }
                        else{
                          $(".popup").fadeOut(500);
                          $('table.monthlyexpensespopup').html(html);
                          $('table.monthlyexpensespopup').fadeIn(1000);
                           positionPopup();
                         }
                        
                    },
                    error:function(msg){
                       
                    }
                });
              }
           function CreatePopUp(){
            //open popup
            $(".popuptrigger").die();
            $(".popuptrigger").live('click',function(e){
                e.preventDefault();
                //$(".popup").removeClass('hidden');
                $(".dateselectionpopup").fadeIn(1000);
                userid=$(this).parents('tr.rowrapper').find('.hidden').html();
                fullname=$(this).parents('tr.rowrapper').find('th:eq(0)').html();
                positionPopup();
            });
             
            //close popup
            $(".close").die();
            $(".close").live('click',function(){
              $(".popup").fadeOut(500);
              $('table.dateselectionpopup').find('select.monthdropdown option:eq(0)').attr('selected',true);
            });
           } 
           //position the popup at the center of the page
            function positionPopup(){
                if(!$(".popup").is(':visible')){
                    return;
                }
                $(".popup").css({
                    //left: ($(window).width() - $('.popup').width()) / 50,
                    'top': ($(window).width() - $('.popup').width()) / 1,
                    'position':'absolute',
                    'box-shadow': '5px 10px 5px #888888'
                    
                });
            }  
           //maintain the popup at center of the page when browser resized
          $(window).bind('resize',positionPopup);
          
          
          $(document).ready(function(){
            SelectBasicInfo();
            SelectUserList();
            CreatePopUp();
            $('table.dateselection').find('select.monthdropdown,select.yeardropdown').bind('change',function(){
                CreateReport(false);
            }); 
            $('table.dateselectionpopup').find('select.monthdropdown,select.yeardropdown').bind('change',function(){
                selecteddate='('+$('table.dateselectionpopup').find('select.monthdropdown option:selected').text()+','+$('table.dateselectionpopup').find('select.yeardropdown').val()+')';
                CreateReport(true);
            }); 
            $('table.userlist').find('a.popuptrigger').die();
            $('table.userlist').find('a.popuptrigger').live('click',function(){
                userid=$(this).parents('tr.rowrapper').find('.hidden').html();
                //alert(userid);
                //selecteddate='('+$('table.dateselectionpopup').find('select.monthdropdown option:selected').text()+','+$('table.dateselectionpopup').find('select.yeardropdown').val()+')';
                //CreateReport(true);
            });     
        
        });
    </script>
    
    
</head>
<body>
    <form id="form1" runat="server">
    <div class="mainrapperdiv">
        <table class="dateselection tablesorter">
            <tr class="rowrapper">
                <td id="name">
                </td>
                <td id="date">
                </td>
                <td>
                <a href="MainMenu.aspx">Main Menu</a>
                </td>
            </tr>
           
           
            <tr>
                <th>
                    <label >Date</label>
                </th>
                <th>
                    <select class="yeardropdown dropdown">
                        <option value="2001">2001</option>
                        <option value="2002">2002</option>
                        <option value="2003">2003</option>
                        <option value="2004">2004</option>
                        <option value="2005">2005</option>
                        <option value="2006">2006</option>
                        <option value="2007">2007</option>
                        <option value="2008">2008</option>
                        <option value="2009">2009</option>
                        <option value="2010">2010</option>
                        <option value="2011">2011</option>
                        <option value="2012">2012</option>
                        <option value="2013" selected="selected">2013</option>
                     </select>
                </th>
                <th>
                    <select class="monthdropdown dropdown">
                        <option value="0"></option>
                        <option value="1">January</option>
                        <option value="2">February</option>
                        <option value="3">March</option>
                        <option value="4">April</option>
                        <option value="5">May</option>
                        <option value="6">June</option>
                        <option value="7">July</option>
                        <option value="8">August</option>
                        <option value="9">September</option>
                        <option value="10">October</option>
                        <option value="11">November</option>
                        <option value="12">December</option>
                    
                    </select>
                
                 </th>
            
            </tr>
        
        
        </table>
        <table class="monthlyexpenses tablesorter"></table>
        <table class="monthlyexpensespopup tablesorter popup" style="display:none"></table>
        <table class="userlist tablesorter"></table>
        <table class="dateselectionpopup popup tablesorter" style="display:none">
             <tr>
                <th>
                    <label >Search</label>
                </th>
                <th>
                    <select class="yeardropdown dropdown">
                        <option value="2001">2001</option>
                        <option value="2002">2002</option>
                        <option value="2003">2003</option>
                        <option value="2004">2004</option>
                        <option value="2005">2005</option>
                        <option value="2006">2006</option>
                        <option value="2007">2007</option>
                        <option value="2008">2008</option>
                        <option value="2009">2009</option>
                        <option value="2010">2010</option>
                        <option value="2011">2011</option>
                        <option value="2012">2012</option>
                        <option value="2013" selected="selected">2013</option>
                     </select>
                </th>
                <th>
                    <select class="monthdropdown dropdown">
                        <option value="0"></option>
                        <option value="1">January</option>
                        <option value="2">February</option>
                        <option value="3">March</option>
                        <option value="4">April</option>
                        <option value="5">May</option>
                        <option value="6">June</option>
                        <option value="7">July</option>
                        <option value="8">August</option>
                        <option value="9">September</option>
                        <option value="10">October</option>
                        <option value="11">November</option>
                        <option value="12">December</option>
                    
                    </select>
                
                 </th>
                 <td class="close"><label>close</label></td>
            
            </tr>
        
        </table>
    </div>
    </form>
</body>
</html>
