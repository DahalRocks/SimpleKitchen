<%@ Page Language="C#" AutoEventWireup="true"  CodeBehind="Login.aspx.cs" Inherits="KitCalc.ProgramFiles.Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
     <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>

    <link href="../StyleSheet/tablesorter.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheet/template.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheet/simple.css" rel="stylesheet" type="text/css" />
     <script src="../JavaScript/json2.js" type="text/javascript"></script>
     <script type="text/javascript">
        $(document).ready(function(){
            $('#uname').focus();
            $('input.button').bind('click',function(){
                var uname=$('#uname').val();
                var password=$('#password').val();
                if(!uname && !password){
                alert('please enter your user name and password');
                return false;
                }
                
                if(!uname){
                alert('please enter your user name');
                return false;
                }
                
                if(!password){
                alert('please enter your password');
                return false;
                }
                
                
                var param = {
                        objPerson: {
                                    UserName:uname,
                                    Password:password
                            }
            };
            $.ajax({
                    type:"post",
                    url:"../WebService/WebService1.asmx/Login",
                    data:JSON.stringify(param),
                    dataType:"json",
                    contentType: "application/json; charset=utf-8",
                    success:function(data){
                            if(data.d.length==0){
                                if($('tr.rowrapper').find('td:eq(2)').length<=0){
                                var html='<td class="errormessage">your username/password is not correct</td>';
                                $('tr.rowrapper').append(html);
                                }
                                    
                            }
                            else{
                                $('tr.rowrapper').find('td:eq(2)').remove();
                                $.each(data.d,function(index,item){
                                location.href="MainMenu.aspx";
                               });  
                            
                            }
                                          
                 },
                 error:function(data){
                            alert("system fail");
                 
                 }
            
              });
            
            });
        });
     
    </script>

</head>
<body>
<div class="outerrapper">
    <form id="form1" runat="server">
    
    <div class="mainrapperdiv">
       
    </div>
    <div id="mainWrap">
        <div id="mainPanel">
            <div id="logoWrap">
                <h1>
                    KitCalc</h1>
            </div>
            <div id="loginPanel">
               
                <table class="tablesorters">
                    <tr>
                        <td>
                            User name:
                        </td>
                        <td>
                            <input type="text" class="textbox" id="uname" />
                        </td>
                    </tr>
                    <tr class="rowrapper">
                        <td>
                            Password:
                        </td>
                        <td>
                            <input type="password" class="textbox" id="password" />
                            
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="button" class="button" value="ok" /></td>
                                <td><a href="Signup.aspx">sign up</a>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="quots">
                <p>
                    "KitCalc makes life easier"</p>
            </div>
            <%--
                <div id="leftPanel">
                <div class="about">
                    <h2>
                        Here goes invester of the month</h2>
                    <h3>
                        Pi-Chart of current month</h3>
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
                        <span>Pellentesque dolor.</span> Make life easy using KitCalc.
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
                </div>
            </div>
            <div id="rightPanel">
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
            </div>
            <div id="footPanel">
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
</div>
</body>
</html>
