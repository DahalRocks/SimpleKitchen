<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Transaction.aspx.cs" Inherits="KitCalc.ProgramFiles.Transaction" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Transaction</title>

    <script src="../JavaScript/jquery.js" type="text/javascript"></script>

    <script src="../JavaScript/json2.js" type="text/javascript"></script>
    <script type="text/javascript" src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>

    <script src="../JavaScript/jquery.ui.datepicker.js" type="text/javascript"></script>

    <link href="../StyleSheet/tablesorter.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheet/jquery.ui.datepicker.css" rel="stylesheet" type="text/css" />

    <link href="../StyleSheet/simple.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
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
          function GetTransaction(){
                var param;
                var fromdate=$('input.fromdate').val();
                var todate=$('input.todate').val();
                param={
                        objCategory:{
                            FromDate:fromdate,
                            ToDate:todate
                        }
                
                }
                $.ajax({
                        url:'../WebService/WebService1.asmx/SelectIndivisualTotalExpenses',
                        data:JSON.stringify(param),
                        dataType:'json',
                        type:'post',
                        contentType:'application/json; charset=utf-8',
                        success:function(data){
                            var html;
                             html+='<tr><th>Paid By</th><th>Paid To</th><th>Amount</th></tr>';
                            if(data.d==0){
                                            html+='<tr>';
                                            html+='<td>No item found</td>'; 
                                            html+='</tr>';
                                     }
                           
                            $.each(data.d,function(index,item){
                                html+='<tr>';
                                   html+='<td>'+item.PaidBy+'</td>';
                                   html+='<td>'+item.PaidTo+'</td>';
                                   html+='<td>'+item.Amount+'</td>';
                                html+='</tr>';
                            
                            });
                            $('table.transactiontable').html(html);
                        },
                        error:function(msg){
                        }
                  });
          
          
          }  
         $(document).ready(function(){
            SelectBasicInfo();
            GetTransaction();  
            $( "input.datepicker" ).datepicker();
            $('input.search').bind('click',function(){
                var fromdate=$('input.fromdate').val();
                var todate=$('input.todate').val();
                //check date
                    if(fromdate>todate){
                        alert('"From" date cannot be greater than "To" date');
                        return false;
                    }
                    if(!fromdate){
                        alert('please enter "From" date');
                        return false;
                        
                    }
                    if(!todate){
                        alert('please enter "To" date');
                        return false;
                    }
                    $('input.fromdate').bind('keyup',function(){
                        //check urself 
                        var urvalue=$(this).val();
                        if(!urvalue){
                          //close calendar
                          $(this).datepicker( "hide" );
                          //check neighbour 
                          var neighbourvalue=$(this).parents('tr.searchwrapper').find('input.todate').val();
                          if(!neighbourvalue){
                            //call default selection function
                            GetTransaction();
                            $(this).datepicker( "hide" );;
                          } 
                        }
                   });
                   $('input.todate').bind('keyup',function(){
                        //check urself 
                        var urvalue=$(this).val();
                        if(!urvalue){
                          //close calendar
                          $(this).datepicker( "hide" );
                          //check neighbour 
                          var neighbourvalue=$(this).parents('tr.searchwrapper').find('input.fromdate').val();
                          if(!neighbourvalue){
                            //call default selection function
                            GetTransaction();
                            
                          } 
                        }
                    });
                GetTransaction();
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
           
           
            <tr class="searchwrapper">
                <td>From</td>
                <td><input type="text" class="datepicker fromdate textbox" /></td>
                <td>To</td>
                <td><input type="text" class="datepicker todate textbox" /></td>
                <td><input type="button" class="button search"  value="search" /></td>
            </tr>
        
        
        </table>
        <table class="transactiontable tablesorter "></table>
    </div>
    </form>
</body>
</html>
