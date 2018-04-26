<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <!-- Viewport Metatag -->
        <meta name="viewport" content="width=device-width,initial-scale=1.0">
            <!-- Viewport Metatag -->
            <meta name="viewport" content="width=device-width,initial-scale=1.0">
                <!-- Plugin Stylesheets first to ease overrides -->
                <link rel="stylesheet" type="text/css" href="../../plugins/colorpicker/colorpicker.css" media="screen">
                    <script src="../../html/scripts/Administracion.js" type="text/javascript"></script>
                    <script src="../../html/scripts/motorAjax.js" type="text/javascript"></script>
                    <script>
                        function guardarColores(){
                            ajax2=nuevoAjax3();
                            var IdColor = document.form.txt_IdColor.value;
                            var NombreColor= document.form.txt_NombreColor.value;
                            alert(IdColor +"-"+NombreColor);
                            ajax2.open("POST", "GuardarColor.jsp",true);
                            ajax2.onreadystatechange=function() {
                                
                                if (ajax2.readyState==4) {                                    
                                    var docxml = ajax2.responseXML;
                                    var result = docxml.getElementsByTagName('result')[0].childNodes[0].nodeValue
                                        if(result!='3'){
                                    if(result == '1'){
                                        var mensaje = docxml.getElementsByTagName('mensaje')[0].childNodes[0].nodeValue
                                        document.getElementById("txt_IdColor").value='';
                                        document.getElementById("txt_NombreColor").value='';                                        
                                        alert(mensaje);
                                    }else{
                                        var mensaje = docxml.getElementsByTagName('mensaje')[0].childNodes[0].nodeValue
                                        alert(mensaje);
                                        document.form.txt_IdColor.value = "";
                                        document.form.txt_NombreColor.value = "";
                                    }
                                            
                                        }else{
                                        var mensaje = docxml.getElementsByTagName('mensaje')[0].childNodes[0].nodeValue
                                        alert(mensaje);
                                        }
                                }
                            }
                            ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                            ajax2.send("id_color="+IdColor+"&nombre_color="+NombreColor);
                        }
                        function nuevoAjax3(){
                            var xmlhttp= false;
                            try{
                                xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
                            }catch(e){
                                try {
                                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                                }catch(E){
                                    xmlhttp = false;
                                }
                            }
                            if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
                                xmlhttp = new XMLHttpRequest();
                            }
                            return xmlhttp;
                        }
                    </script>
                    <!-- Required Stylesheets -->
                    <link rel="stylesheet" type="text/css" href="../../bootstrap/css/bootstrap.min.css" media="screen">
                        <link rel="stylesheet" type="text/css" href="../../css/fonts/ptsans/stylesheet.css" media="screen">
                            <link rel="stylesheet" type="text/css" href="../../css/fonts/icomoon/style.css" media="screen">

                                <link rel="stylesheet" type="text/css" href="../../css/mws-style.css" media="screen">
                                    <link rel="stylesheet" type="text/css" href="../../css/icons/icol16.css" media="screen">
                                        <link rel="stylesheet" type="text/css" href="../../css/icons/icol32.css" media="screen">
                                            <!-- Demo Stylesheet -->
                                            <link rel="stylesheet" type="text/css" href="../../css/demo.css" media="screen">
                                                <!-- jQuery-UI Stylesheet -->
                                                <link rel="stylesheet" type="text/css" href="../../jui/css/jquery.ui.all.css" media="screen">
                                                    <link rel="stylesheet" type="text/css" href="../../jui/jquery-ui.custom.css" media="screen">
                                                        <!-- Theme Stylesheet -->
                                                        <link rel="stylesheet" type="text/css" href="../../css/mws-theme.css" media="screen">
                                                            <link rel="stylesheet" type="text/css" href="../../css/themer.css" media="screen">
                                                                </head>
                                                                <body>
                                                                    <form class="mws-panel-toolbar" name="form" id="form">
                                                                        <div style="width: 95%" align="center" class="mws-panel grid_8">
                                                                            <div class="mws-panel grid_8" align="center">
                                                                                <div class="mws-panel-header">
                                                                                    <span><i class="icon-table"></i>Parametrizacion Colores</span>
                                                                                </div>
                                                                                <table width="100%" align="center" border="1" class="mws-table">
                                                                                    <tr style="color: #ffffff;text-align: center" >
                                                                                        <td class="mws-panel-header" ><i class="icon-tasks"/>&nbsp;Codigo Color</td>
                                                                                        <td class="mws-panel-header" ><i class="icon-tasks"/>&nbsp;Nombre Color</td>
                                                                                        <td class="mws-panel-header" ><i class="icon-tasks"/>&nbsp;Adicionar</td>
                                                                                    </tr>
                                                                                    <tr style="color: #000099;text-align: center" >
                                                                                        <td width="20%" ><i class="icon-attachment"/>&nbsp;<input type="text" size="5%" name="txt_IdColor" id="txt_IdColor"  onKeyPress="return soloNumeros(event)" /></td>
                                                                                        <td width="80%" ><i class="icon-attachment"/>&nbsp;<input type="text" style="font-variant-caps: all-small-caps" size="70%" name="txt_NombreColor" id="txt_NombreColor" onKeyPress="return soloTexto(event)" /></td>
                                                                                        <td width="20%" style="cursor: pointer" onclick="guardarColores()"><i class="icol32-add" /></td>
                                                                                    </tr>

                                                                                </table>
                                                                            </div>
                                                                        </div>
                                                                    </form>
                                                                </body>
                                                                </html>
