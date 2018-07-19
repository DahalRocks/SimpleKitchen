<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Signup.aspx.cs" Inherits="KitCalc.ProgramFiles.Signup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <title>Signup</title>
     <link href="../StyleSheet/simple.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheet/tablesorter.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheet/template.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>

    <script src="../JavaScript/json2.js" type="text/javascript"></script>
    <script type="text/javascript">
        function RequiredFieldValidation(){
          $('#registration').find('input.required').each(function(){
            var clas=$(this).attr('class');
            if($.trim(clas)=='textbox required'){
                if(!$(this).val()){
                 //check whether it already exists or not
                 if($(this).parents('.rowrapper').find("td:eq(2)").length<1){
                     $(this).parents('.rowrapper').append('<td class="errormessage"> is required field</td>').css('color:red');
                 }
                }
                else{
                    $(this).parents('.rowrapper').find("td:eq(2)").remove();
                }
            }
          });
        }
        function PasswordConfirmation (){
           // alert($.trim(pass1)+' '+$.trim(pass2));
                var pass1=$("#password").val();
                var pass2=$("#confirmpassword").val();
                $('#registration').find('.conpass').each(function(){
                if($.trim(pass1)!=$.trim(pass2)){
               //check whether it already exists or not
                     if($(this).parents('.rowrapper').find("td:eq(2)").length<1){
                         $(this).parents('.rowrapper').append('<td class="errormessage"> password did not match</td>').css('color:red');
                      }
                  }
                  else{
                        $(this).parents('.rowrapper').find("td:eq(2)").remove();
                    }
            });
        }
        $(document).ready(function() {
            $('a.signup').bind('click', function() {
                $('table.tablesorters').fadeIn(4000);

            });
            $('#kitname').keydown(function() {
                CheckKitchenName();

            });
            $('input.required').keydown(function() {
                RequiredFieldValidation();
            });
            $('#confirmpassword').change(function() {
                PasswordConfirmation();
            });
            $('#cancel').click(function() {

                location.href = "Login.aspx";
            });

            $('#submit').bind('click', function(e) {
                var gateway = 0;
                e.preventDefault();
                RequiredFieldValidation();
                PasswordConfirmation();
                $('input.required').each(function() {
                    if ($(this).parents('.rowrapper').find('td:eq(2)').length >= 1) {
                        gateway = 1;
                        return false;
                    }
                });
                $('input.conpass').each(function() {
                    if ($(this).parents('.rowrapper').find('td:eq(2)').length >= 1) {
                        gateway = 1;
                        return false;
                    }
                });
                if (gateway <= 0)
                    SaveUser();
            });
            function CheckKitchenName() {
                var kitchenname = $('#kitname').val();
                var param;
                param = {
                    objKitchen: {
                        KitchenName: kitchenname
                    }
                };
                $.ajax({
                    type: "post",
                    url: "../WebService/WebService1.asmx/CheckKitchenName",
                    data: JSON.stringify(param),
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function(data) {
                        $.each(data.d, function(index, item) {
                            if (item.KitchenCount > 0) {
                                alert('This name is already used.');
                                $('#kitname').val('');
                                $(this).focus();
                                return false;
                            }

                        });
                    },
                    error: function() {
                    }
                });
            }
            function SaveUser() {
                var kitchenname = $('#kitname').val();
                var fname = $('#fname').val();
                var mname = $('#mname').val();
                var lname = $('#lname').val();
                var uname = $('#uname').val();
                var password = $('#password').val();
                var param = { objPerson: {
                    KitchenName: kitchenname,
                    FirstName: fname,
                    MiddleName: mname,
                    LastName: lname,
                    UserName: uname,
                    Password: password

                }
                };
                $.ajax({
                    url: "../WebService/WebService1.asmx/AddUser",
                    dataType: "json",
                    data: JSON.stringify(param),
                    type: "post",
                    error: function(err) {
                        'error:' + err.toString()
                    },
                    contentType:'application/json;charset=utf-8',
                    success: function(msg) {
                        alert("Save data successfully");
                        $('#fname').val('');
                        $('#mname').val('');
                        $('#lname').val('');
                        $('#uname').val('');
                        $('#password').val('');
                        $('#confirmpassword').val('');
                        location.href = "login.aspx"
                    }
                });
            }
        });
    </script>

</head>
<body>
    <form id="registration" class="req" runat="server">
          
    <div id="mainWrap">
        <div id="mainPanel">
            <%--<div id="menu">
                <ul>
                    <li><a href="#"><span>Home</span></a></li>
                    <li>
                        <div class="blank">
                        </div>
                    </li>
                    <li><a href="#"><span>About&nbsp;Us</span></a></li>
                    <li>
                        <div class="blank">
                        </div>
                    </li>
                    <li><a href="#"><span>Support</span></a></li>
                    <li>
                        <div class="blank">
                        </div>
                    </li>
                    <li><a href="#"><span>Forum</span></a></li>
                    <li>
                        <div class="blank">
                        </div>
                    </li>
                    <li><a href="#"><span>Development</span></a></li>
                    <li>
                        <div class="blank">
                        </div>
                    </li>
                    <li><a href="#"><span>Conact&nbsp;Us</span></a></li>
                </ul>
            </div>--%>
            <div id="logoWrap">
                <h1>
                    solitude</h1>
            </div>
            <div id="loginPanel">
                <a href="#" class="signup" style="font-size:50px;font-family:Agency FB;color:Green;" >create your kitchen</a>
                <table class="tablesorters" style="display:none;">
                    <tr>
                        <td>
                            Insert your personal credentials:
                        </td>
                    </tr>
                    <tr class="rowrapper">
                        <td>
                            <label>
                                Kitchen name:</label><em class="required">*</em>
                        </td>
                        <td>
                            <input type="text" class="textbox required " id="kitname" />
                        </td>
                    </tr>
                    <tr class="rowrapper">
                        <td>
                            <label>
                              Admin  First name:</label><em class="required">*</em>
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
                            User name:<em class="required">*</em>
                        </td>
                        <td>
                            <input type="text" class="textbox required" id="uname" />
                        </td>
                    </tr>
                    <tr class="rowrapper">
                        <td>
                            Password:<em class="required">*</em>
                        </td>
                        <td>
                            <input type="password" class="textbox required" id="password" />
                        </td>
                    </tr>
                    <tr class="rowrapper">
                        <td>
                            Confirm password:<em class="required">*</em>
                        </td>
                        <td>
                            <input type="password" class="textbox conpass " id="confirmpassword" />
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
                
            </div>
            <div id="quots">
                <p>
                    "KitCalc makes your life easier..."</p>
            </div>
            
                <div id="leftPanel">
                <%--<div class="about">
                    <h2>
                        Somelines About Us</h2>
                    <h3>
                        ltrices inh endrerit ac tempor idtellus uis quam uisque</h3>
                    <p>
                        <span>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Nulla libero leo, suscipit
                            acfaucibusnon.</span><br />
                        Etiam est. Etiam ac ipsum sed pede ultricies pretium. Nulla mi lacus, fringilla
                        eu, pulvinar at, commodo eu, dolor. Nam porttitor viverra sapien. Pellentesque vitae
                        augue et lorem laoreet .</p>
                    <div class="date">
                        <div class="left">
                            Saturday, April 26, 2008&nbsp;&nbsp;|</div>
                        <div class="right">
                            <a href="#">Read More</a></div>
                    </div>
                </div>
                <div class="services">
                    <h2>
                        Our Spectrum of Services</h2>
                    <div class="pic">
                        <a href="#">Cras turpis duis at sapien eget nulla vulputate. </a>
                    </div>
                    <p>
                        <span>Donec accumsan porta risus.</span> Vestibulum sollicitudinlibero ut semper
                        commodo, purus enim sollicitudin nulla, dictum vehicula diam lacus at purus. In
                        egestas.
                    </p>
                    <h3>
                        Services</h3>
                    <ul>
                        <li><a href="#">Nam congue quam non augue ivamus porttitor</a></li>
                        <li><a href="#" class="bottom">Jam aongue buam n augue famus</a></li>
                    </ul>
                    <p>
                        <span>Pellentesque dolor.</span> Nunc congue est in ante mattis ultrices. liquam
                        erat volutpat. Nam congue quam non augue.
                    </p>
                </div>
                <div class="testimonial">
                    <h2>
                        Testimonial</h2>
                    <p>
                        <span>Nullam vel justo. Mauris viverra mattis neque.</span> Phasellus feugiat pede
                        ut mauris uis orcies tibulum eleifend. Donec est purusiaculis acauctorNullam vel
                        justo. Mauris viverra mattis neque. Phasellus feugiat pede ut mauris. Duis orci.</p>
                    <h3>
                        <span>by</span> David Jackson</h3>
                    <p>
                        <span>Vel justo. Mauris viverra mattis neque asellus feugiat pede ut mauris uis orcies
                            tibulum</span> eleifend. Donec est purusiaculis acauctorNullam vel justo. Mauris
                        viverra mattis neque. Phasellus feugiat pede ut mauris.</p>
                    <h3>
                        <span>by</span> Tom Sam</h3>
                </div>--%>
            </div>
            <%--<div id="rightPanel">
                <h2>
                    Photo Stock</h2>
                <div class="pic1">
                </div>
                <a href="#" class="view">view large</a>
                <div class="pic2">
                </div>
                <a href="#" class="view">view large</a>
                <div class="pic3">
                </div>
                <a href="#" class="view">view large</a>
                <div class="contacts">
                    <h2>
                        Quick Contact</h2>
                    <p>
                        Name</p>
                    <input name="name" type="text" value="- enter your name -" onfocus="if(this.value=='- enter your name -')this.value=''"
                        onblur="if(this.value=='')this.value='- enter your name -'" />
                    <p>
                        Email</p>
                    <input name="name" type="text" value="- enter your email -" onfocus="if(this.value=='- enter your email -')this.value=''"
                        onblur="if(this.value=='')this.value='- enter your email -'" />
                    <div class="blank2">
                    </div>
                    <a href="#">Need a Quote?</a><div class="blank">
                    </div>
                    <a href="#">Submit</a>
                </div>
                <div class="project">
                    <h2>
                        Projects Link</h2>
                    <ul>
                        <li><a href="#">Lorem ipsum dolor sit amet eros consequat </a></li>
                        <li><a href="#">Consectetuer adipiscing elit</a></li>
                        <li><a href="#">Etiam quis est ut diam viverra rhoncus</a></li>
                        <li><a href="#">Fusce eros consequat </a></li>
                        <li><a href="#">Cras eros massa blandit </a></li>
                        <li><a href="#" class="bottom">Aoreet utdiam viverra</a></li>
                    </ul>
                </div>
            </div>--%>
            <%--<div id="footPanel">
                <div class="nav">
                    <ul>
                        <li><a href="#">Home</a></li>
                        <li>
                            <div class="blank">
                                |</div>
                        </li>
                        <li><a href="#">About Us</a></li>
                        <li>
                            <div class="blank">
                                |</div>
                        </li>
                        <li><a href="#">Suppor</a></li>
                        <li>
                            <div class="blank">
                                |</div>
                        </li>
                        <li><a href="#">Forum</a></li>
                        <li>
                            <div class="blank">
                                |</div>
                        </li>
                        <li><a href="#">Development</a></li>
                        <li>
                            <div class="blank">
                                |</div>
                        </li>
                        <li><a href="#">Conact Us</a></li>
                    </ul>
                </div>
                <div class="copyright">
                    © Copyright Infirmation Goes Here. All Rights Reserved.</div>
                <p class="designInfo">
                    Design by <a href="http://www.templateworld.com/">TemplateWorld</a> and brought
                    to you by <a href="http://www.smashingmagazine.com/">SmashingMagazine</a></p>
                <div class="validation">
                    <ul>
                        <li><a href="http://validator.w3.org/check?uri=referer">xhtml</a></li>
                        <li>
                            <div class="blank">
                            </div>
                        </li>
                        <li><a href="http://jigsaw.w3.org/css-validator/check/referer">css</a></li>
                    </ul>
                </div>
            </div>--%>
            
            
        </div>
    </div>
    </form>
</body>
</html>
