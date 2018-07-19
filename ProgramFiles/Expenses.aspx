<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Expenses.aspx.cs" Inherits="KitCalc.ProgramFiles.Expenses" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Expenses</title>
    <link href="../StyleSheet/jquery.ui.datepicker.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheet/simplePagination.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheet/template.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheet/jquery.fancybox.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheet/tablesorter.css" rel="stylesheet" type="text/css" />
    
    <script src="../JavaScript/jquery.js" type="text/javascript"></script>

    <script src="../JavaScript/jquery.ui.datepicker.js" type="text/javascript"></script>

    
    
    <script src="../JavaScript/jquery.tablesorter.js" type="text/javascript"></script>

    <script type="text/javascript" src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>

    <script src="../JavaScript/json2.js" type="text/javascript"></script>

    <script src="../JavaScript/jquery.simplePagination.js" type="text/javascript"></script>

    
    
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
                        $('tr.rowrapper').find('#name').html(name).css('color:red;text-style:italic');
                        $('tr.rowrapper').find('#date').html(item.Date).css('color:red;text-style:italic');
                        
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
           function CreatePopUp() {
               //open popup
               $(".addexpenses").die();
               $(".addexpenses").live('click', function(e) {
                   e.preventDefault();
                   //$(".popup").removeClass('hidden');
                   $(".addexpensestable").fadeIn(1000);
                   positionPopup();
                   //$('input.textbox').focus();
               });
               

               //close popup
               $(".close").click(function() {
                   $(".popup").fadeOut(500);
               });
               

               //position the popup at the center of the page
               function positionPopup() {
                   if (!$(".popup").is(':visible')) {
                       return;
                   }
                   $(".popup").css({
                       //left: ($(window).width() - $('.popup').width()) / 2,
                       //top: ($(window).height() - $('.popup').height()) ,
                       top: $(window).height() / 2,
                       position: 'absolute'

                   });
               }

               //maintain the popup at center of the page when browser resized
               $(window).bind('resize', positionPopup);
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
                    html+='<option value=""></option>';
                    $.each(data.d,function(index,item){
                         html+='<option value="'+item.CategoryID+'">'+item.CategoryName+'</option>';
                    });
                    $('#categorylist').html(html);
                   },
                   error:function(msg){
                   }
            });
        }
        function RequiredFieldValidation(){
            $('.addexpensestable').find('#categorylist,input.textbox').each(function() {
                var clas = $(this).attr('class');
                if ($.trim(clas).contains('required')) {
                    if (!$(this).val()) {
                        //check whether it already exists or not
                        if ($(this).parents('.rowrapper').find("td:eq(2)").length < 1) {
                            $(this).parents('.rowrapper').append('<td class="errormessage"> is required field</td>').css('color:red');
                        }
                    }

                    else {
                        $(this).parents('.rowrapper').find("td:eq(2)").remove();
                    }
                }
            });
        }
        $(document).ready(function() {
            GetSession();
            CreatePopUp();
            $('a.logout').bind('click', function() {
                ClearSession();

            });
            $('input.required').keydown(function() {
                RequiredFieldValidation();
            });
            $('#categorylist').change(function() {
                RequiredFieldValidation();
            });
            $('input.numeric').bind('keyup', 'keydown', function() {
                $(this).val($(this).val().replace(/[^\d]/, ''));
            });
            $("input.datepicker").datepicker();
            SelectBasicInfo();
            SelectCategory();
            SelectExpensesDetail();
            $('div.block').pagination({
                items: 30,
                itemsOnPage: 2,
                cssStyle: 'dark-theme'
            });
            //$('div.block').pagination('selectPage', pageNumber);
            $('div.block').pagination('prevPage');
            $('div.block').pagination('nextPage');
            $("#testtable").tablesorter();
            EditExpenseDetail();
            DeleteExpensesDetail();
            $('input.fromdate').bind('keyup', function() {
                //check urself 
                var urvalue = $(this).val();
                if (!urvalue) {
                    //close calendar
                    $(this).datepicker("hide");
                    //check neighbour 
                    var neighbourvalue = $(this).parents('tr.searchwrapper').find('input.todate').val();
                    if (!neighbourvalue) {
                        //call default selection function
                        SelectExpensesDetail();
                        $(this).datepicker("hide"); ;
                    }
                }
            });
            $('input.todate').bind('keyup', function() {
                //check urself 
                var urvalue = $(this).val();
                if (!urvalue) {
                    //close calendar
                    $(this).datepicker("hide");
                    //check neighbour 
                    var neighbourvalue = $(this).parents('tr.searchwrapper').find('input.fromdate').val();
                    if (!neighbourvalue) {
                        //call default selection function
                        SelectExpensesDetail();

                    }
                }
            });

            $('input.search').bind('click', function() {
                var fromdate = $('input.fromdate').val();
                var todate = $('input.todate').val();
                //check date
                if (fromdate > todate) {
                    alert('"From" date cannot be greater than "To" date');
                    return false;
                }
                if (!fromdate) {
                    alert('please enter "From" date');
                    return false;

                }
                if (!todate) {
                    alert('please enter "To" date');
                    return false;
                }
                SelectExpensesDetail();
            });
            $('input.ok').bind('click',function() {
                alert('this is going to database');
                RequiredFieldValidation();
                var gateway = 0;
                $('input.required').each(function() {
                    if ($(this).parents('.rowrapper').find('td:eq(2)').length >= 1) {
                        alert('value of gateway=1');
                        gateway = 1;
                        return false;
                    }
                });
                //save item here
                if (gateway < 1) {
                    alert('check and status yes');
                    SaveExpenses()
                    SelectExpensesDetail();
                    //clear textbox here
                    $('#item').val('');
                    $('#price').val('');
                    $('#amount').val('');
                    $('input.datepicker').val('');
                    $('#categorylist').val('');
                }

            });

            function DeleteExpenses() { }
            function SaveExpenses() {
                var categoryid = $('#categorylist option:selected').val();
                var itemname = $('#item').val();
                var itemprice = $('#price').val();
                var itemamount = $('#amount').val();
                if (!itemamount)
                    itemamount = 0.0;
                var purchasedate = $('input.datepicker').val();
                var param;
                param = {
                    objExpense: {
                        CategoryID: categoryid,
                        ItemName: itemname,
                        ItemPrice: itemprice,
                        ItemAmount: itemamount,
                        PurchaseDate: purchasedate

                    }
                };
                $.ajax({
                    url: '../WebService/WebService1.asmx/AddExpenses',
                    dataType: 'json',
                    data: JSON.stringify(param),
                    contentType: 'application/json;charset=utf-8',
                    type: 'post',
                    success: function(data) {

                    },
                    error: function(msg) {
                        alert('error occured in page');
                    }

                });
            }

            function SelectExpensesDetail() {

                var fromdate = $('input.fromdate').val();
                var todate = $('input.todate').val();
                var param = {
                    objCategory: {
                        FromDate: fromdate,
                        ToDate: todate
                    }
                }
                $.ajax({
                    url: "../WebService/WebService1.asmx/SelectExpensesDetail",
                    data: JSON.stringify(param),
                    dataType: "json",
                    contentType: "application/json;charset=utf-8",
                    type: 'post',
                    success: function(data) {
                        var html;
                        html += '<thead><tr><th class="header">Category</th>';
                        html += '<th class="header">Item</th>';
                        html += '<th class="header">Amount</th>';
                        html += '<th class="header">Price</th>';
                        html += '<th class="header">Date</th></tr></thead><tbody>';
                        if (data.d == 0) {
                            html += '<tr class="expensechart">';
                            html += '<td>No item found</td>';
                            html += '</tr>';
                        }
                        $.each(data.d, function(index, item) {
                            html += '<tr class="expensechart">';
                            html += '<td>' + item.CategoryName + '</td>';
                            html += '<td>' + item.ItemName + '</td>';
                            html += '<td>' + item.ItemAmount + '</td>';
                            html += '<td>' + item.ItemPrice + '</td>';
                            html += '<td>' + item.PurchaseDate + '</td>';
                            html += '<td class="hidden">' + item.ItemID + '</td>';
                            html += '<td><input type="button" class="button" value="edit" id="edit"/>';
                            html += '<input type="button" class="button" value="delete" id="delete"/></td>';
                            html += '</tr>';
                        });
                        html += '</tbody>';
                        $('#expensesdetail').html(html);
                    },

                    error: function(msg) {
                        alert('error');
                    }

                });
            }
            function EditExpenseDetail() {
                //edit expenses here
                $('#edit').die();
                $('#edit').live('click', function() {
                    var category = $(this).parents('tr.expensechart').find('td:eq(0)').html();
                    var itemname = $(this).parents('tr.expensechart').find('td:eq(1)').html();
                    var itemamount = $(this).parents('tr.expensechart').find('td:eq(2)').html();

                    var itemprice = $(this).parents('tr.expensechart').find('td:eq(3)').html();
                    var purchasedate = $(this).parents('tr.expensechart').find('td:eq(4)').html();
                    $(this).parents('tr.expensechart').find('td:eq(1)').html('<input type="text" class="itemname edittextbox"/>');
                    $(this).parents('tr.expensechart').find('td:eq(2)').html('<input type="text" class="itemamount edittextbox"/>');
                    $(this).parents('tr.expensechart').find('td:eq(3)').html('<input type="text" class="itemprice edittextbox"/>');
                    $(this).parents('tr.expensechart').find('td:eq(4)').html('<input type="text" class="purchasedate edittextbox"/>');
                    $(this).parents('tr.expensechart').find('input.itemname').val(itemname);
                    $(this).parents('tr.expensechart').find('input.itemamount').val(itemamount);
                    $(this).parents('tr.expensechart').find('input.itemprice').val(itemprice);
                    $(this).parents('tr.expensechart').find('input.purchasedate').val(purchasedate);
                    $('input.itemname').focus();
                    $(this).parents('tr.expensechart').find('td:eq(6)').html('<input type="button" class="ok button" value="ok"/>');
                    $('input.itemamount,input.itemprice').bind('keyup', 'keydown', function() {
                        $(this).val($(this).val().replace(/[^\d]/, ''));
                    });
                    $('input.purchasedate').datepicker();
                    $('input.ok').die();
                    $('input.ok').live('click', function() {
                        itemname = $(this).parents('tr.expensechart').find('input.itemname').val();
                        itemamount = $(this).parents('tr.expensechart').find('input.itemamount').val();
                        if (!itemamount) {
                            itemamount = 0.0;
                        }
                        itemprice = $(this).parents('tr.expensechart').find('input.itemprice').val();
                        purchasedate = $(this).parents('tr.expensechart').find('input.purchasedate').val();
                        var itemid = $(this).parents('tr.expensechart').find('td:eq(5)').html();
                        if (!itemname) {
                            alert('item name can not be null');
                            return false;
                        }

                        if (!itemprice) {
                            alert('item price can not be null');
                            return false;
                        }
                        if (!purchasedate) {
                            alert('purchase date can not be null');
                            return false;
                        }

                        var param = {
                            objCategory: {
                                ItemName: itemname,
                                ItemAmount: itemamount,
                                ItemPrice: itemprice,
                                ItemID: itemid,
                                PurchaseDate: purchasedate
                            }
                        }
                        $.ajax({
                            url: '../WebService/WebService1.asmx/EditExpenseDetails',
                            dataType: 'json',
                            data: JSON.stringify(param),
                            contentType: 'application/json;char-set=utf-8',
                            type: 'post',
                            success: function(data) {
                                SelectExpensesDetail();
                            },
                            error: function(msg) {
                            }
                        });
                    });
                });

            }
            function DeleteExpensesDetail() {
                $('#delete').die();
                $('#delete').live('click', function() {
                    var itemid = $(this).parents('tr.expensechart').find('td:eq(5)').html();
                    var param = {
                        objCategory: {
                            ItemID: itemid

                        }
                    }
                    $.ajax({
                        url: '../WebService/WebService1.asmx/DeleteExpensesDetail',
                        dataType: 'json',
                        data: JSON.stringify(param),
                        contentType: 'application/json;charset=utf-8',
                        type: 'post',
                        success: function(data) {
                            SelectExpensesDetail();
                        },
                        error: function(msg) {
                        }

                    });

                });




            }
        });
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <%--<div class="mainrapperdiv">
        
        
        
    </div>--%>
    </form>
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
                    <table id="expenseinput" class="tablesorter">
                        <tr class="rowrapper">
                            <td id="name">
                            </td>
                            <td id="date">
                            </td>
                            
                        </tr>
                     </table>
                    <table  class="tablesorter popup addexpensestable " style="display: none">   
                        <tr>
                            <th>
                                Insert your expenses here
                            </th>
                        
                        </tr>
                        <tr class="rowrapper">
                            <td>
                                Category<em class="required">*</em>
                                
                            </td>
                            <td>
                            <select id="categorylist" class="required dropdown">
                                </select>
                            </td>
                            <td>
                                <label>Take bill picture</label>
                              <a href="#" class="takepicture">  <img src="../images/icons/takepicture.jpeg" class="icon" /></a>
                            
                            </td>
                            
                            
                        </tr>
                        <tr class="rowrapper">
                            <td>
                                Item:<em class="required">*</em>
                                
                            </td>
                            <td>
                                <input class="textbox required " type="text" id="item" />
                            </td>
                            
                        </tr>
                        <tr class="rowrapper">
                            <td>
                                Amount:
                                
                            </td>
                            <td>
                                <input class="textbox numeric" type="text" id="amount" />
                            </td>
                            
                        </tr>
                        <tr class="rowrapper">
                            <td>
                                Price:<em class="required">*</em>
                                
                            </td>
                            <td>
                                <input class="textbox required numeric " type="text" id="price" />
                            </td>
                            
                        </tr>
                        <tr class="rowrapper">
                            <td>
                                Date:<em class="required">*</em>
                                
                            </td>
                            <td>
                                <input class="textbox required datepicker" type="text" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="button" class="button ok" value="ok"  />
                            </td>
                            <td>
                                <a href="#" class="close">close</a>
                            </td>
                        </tr>
                    </table>
                    <table id="searchdiv " class="tablesorter">
                        <tr class="searchwrapper ">
                            <td><input type="button" value="click to add new expenses" class="addexpenses" /></td>
                            <td>
                                From
                            </td>
                            <td>
                                <input type="text" class="datepicker textbox fromdate" />
                                To
                                <input type="text" class="datepicker textbox todate" />
                                <input type="button" class="button search " value="search" />
                            </td>
                        </tr>
                    </table>
                    <table id="expensesdetail" class="tablesorter">
                    </table>
                    <div class="block">
    	           </div>
                    
               </div>
        </div>
    </div>
</body>
</html>
