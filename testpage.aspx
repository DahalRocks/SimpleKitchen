<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script> 
    <script type="text/javascript" src="../JavaScript/jquery.js">
        alert('hello');
        $(document).ready(function(){
        $("#div").bind('click',function(){
         alert('hello');
            $.ajax({
                type: "POST",
                url: 'WebService1.asmx/TestMethod',
                data: "{'name':'This is static data from the JavaScript file','age':'100'}",
                //data:JSON2.stringify(param),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    $("#divResult").html(msg.d);
                },
                error: function (e) {
                    $("#divResult").html("WebSerivce unreachable");
                }
            });
        
        
        });
            
        });
      
            
      
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div style="width: 100px; height: 30px; background-color:yellow;" id="div">Click me</div>
    <div id="divResult" style="margin-top: 20px;"></div>
    </form>
</body>
</html>