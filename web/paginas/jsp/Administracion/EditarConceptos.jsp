<%@page import="com.movillife.Parametros"%>
<%@page import="modelo.Parametro"%>
<%@page import="modelo.Model"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <%
            try {
                modelo.Model model = new Model();
                model.conectar();
                model.getCon().setAutoCommit(false);
                long id = Long.parseLong(request.getParameter("id"));
                modelo.Concepto conc = model.consultarConcepto(id);

        %>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <!-- Viewport Metatag -->
        <meta name="viewport" content="width=device-width,initial-scale=1.0">
            <!-- Viewport Metatag -->
            <meta name="viewport" content="width=device-width,initial-scale=1.0">
                <script>
                    function guardarConceptos(){
                        ajax2=nuevoAjax3();
                        var prioridad = document.form.Prioridad.value;
                        var NombreColor= document.form.txt_Nombre_Concepto.value;
                        var Cconcepto = document.form.C_concepto.value;
                        var Tconcepto = document.form.T_concepto.value;
                        var id =document.form.id.value
                        ajax2.open("POST", "SetConcepto.jsp",true);
                        ajax2.onreadystatechange=function() {
                                
                            if (ajax2.readyState==4 ) {
                                var docxml = ajax2.responseXML;
                                var result = docxml.getElementsByTagName('result')[0].childNodes[0].nodeValue
                                    
                                if(result == '1'){
                                    var mensaje = docxml.getElementsByTagName('msg')[0].childNodes[0].nodeValue
                                    document.form.Prioridad.value="";
                                    document.form.txt_Nombre_Concepto.value="";
                                    document.form.C_concepto.value=0;
                                    document.form.T_concepto.value=0;                                   
                                    alert(mensaje);
                                    document.location.href="ListadoConcepto.jsp";
                                }else{
                                    var mensaje = docxml.getElementsByTagName('msg')[0].childNodes[0].nodeValue
                                    alert(mensaje);
                                }                                                
                            }
                        }
                        ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                        ajax2.send("c_concepto="+Cconcepto+"&t_concepto="+Tconcepto+"&prioridad="+prioridad+"&nombre="+NombreColor+"&id="+id);
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
                    function validarDatos(){
                        var prioridad = document.form.Prioridad.value;
                        var NombreColor= document.form.txt_Nombre_Concepto.value.trim();
                        var Cconcepto = document.form.C_concepto.value;
                        var Tconcepto = document.form.T_concepto.value;
                        alert(Cconcepto+" "+Tconcepto+" "+prioridad+ " "+NombreColor.length)
                        if(NombreColor.length>0){
                            if(Tconcepto>0){
                                if(Cconcepto>0){
                                    if(prioridad>0){
                                        guardarConceptos();
                                    } else{
                                        alert("Escoja una prioridad") 
                                    }                                       
                                }else{
                                    alert("Escoja una opcion de clase de concepto") 
                                }
                            }else{
                                alert("Escoja una opcion de tipo de concepto")    
                            }
                        }else{
                            alert("El campo nombre no puede estar vacio")
                        }
                    } 
                    function Datos(pri,Ncon,Ccon,Tcon){
                         document.form.Prioridad.value=pri;
                         document.form.txt_Nombre_Concepto.value=Ncon;
                         document.form.C_concepto.value=Ccon;
                         document.form.T_concepto.value=Tcon;
                    }
                </script>
                <!-- Plugin Stylesheets first to ease overrides -->
                <link rel="stylesheet" type="text/css" href="../../plugins/colorpicker/colorpicker.css" media="screen">
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

                                                                <title>Documento sin t&iacute;tulo</title>
                                                                </head>
                                                                <form id="form" name="form" class="mws-form">
                                                                    <body>
                                                                        <div class="mws-panel-body" style="width: 99%" align="center">
                                                                            <div class="mws-panel grid_8">
                                                                                <div class="mws-panel-header">
                                                                                    <span><i class="icon-table"></i>Table Edit Conceptos</span>
                                                                                </div>
                                                                                <table class="mws-table" style="width: 100%">                                                                        
                                                                                    <tr >
                                                                                        <td class="" style="color: #000000;text-align: left"><i class="icon-tasks"/>&nbsp;&nbsp;Nombre</td>
                                                                                        <td colspan="3"><input type="text" style="font-variant-caps: all-small-caps" size="70%" name="txt_Nombre_Concepto" id="txt_Nombre_Concepto" onKeyPress="return soloTexto(event)" /></td>

                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td class="" style="color: #000000;text-align: left"><i class="icon-tasks"></i>&nbsp;Tipo Concepto</td>
                                                                                        <td>
                                                                                            <select class="mws-form" id="T_concepto" name="T_concepto">
                                                                                                <%
                                                                                                    try {


                                                                                                        modelo.Parametro pa = new modelo.Parametro();
                                                                                                        java.util.LinkedList<Parametro> tempa = model.listadoParametros(22);
                                                                                                %>

                                                                                                <option value="0">---Tipo  Concepto---</option>
                                                                                                <%
                                                                                                    for (int i = 0; i < tempa.size(); i++) {
                                                                                                        pa = tempa.get(i);
                                                                                                %>
                                                                                                <option value="<%=pa.getCodigo()%>" ><%=pa.getNombre()%></option>                                                                                                      
                                                                                                <%
                                                                                                    }
                                                                                                %>

                                                                                                <%
                                                                                                    } catch (Exception ex) {
                                                                                                        ex.printStackTrace();
                                                                                                    }
                                                                                                %>
                                                                                            </select>
                                                                                        </td>
                                                                                        <td class="" style="color: #000000;text-align: left"><i class="icon-tasks"></i>&nbsp;Clase Concepto</td>
                                                                                        <td>
                                                                                            <select class="mws-form" id="C_concepto" name="C_concepto">
                                                                                                <%
                                                                                                    try {
                                                                                                        modelo.Parametro pa = new modelo.Parametro();
                                                                                                        java.util.LinkedList<Parametro> tempa = model.listadoParametros(25);
                                                                                                %>

                                                                                                <option value="0">---Clase Concepto---</option>
                                                                                                <%
                                                                                                    for (int i = 0; i < tempa.size(); i++) {
                                                                                                        pa = tempa.get(i);
                                                                                                %>
                                                                                                <option value="<%=pa.getCodigo()%>" ><%=pa.getNombre()%></option>                                                                                                      
                                                                                                <%
                                                                                                    }
                                                                                                %>

                                                                                                <%
                                                                                                    } catch (Exception ex) {
                                                                                                        ex.printStackTrace();
                                                                                                    }
                                                                                                %>
                                                                                            </select>
                                                                                        </td>                                                                                                                                                                         
                                                                                    </tr>
                                                                                    <tr style="color: #000000;text-align: left">
                                                                                        <td class=""><i class="icon-tasks"></i>&nbsp;Prioridad </td>
                                                                                        <td colspan="2" align="left" >
                                                                                            <select id="Prioridad" name="Prioridad">
                                                                                                <option value="0">-- Prioridad --</option>
                                                                                                <option value="1">Alta</option>
                                                                                                <option value="2">Media</option>
                                                                                                <option value="3">Baja</option>                                                                                                        
                                                                                            </select>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr style="color: #000000;text-align: center">
                                                                                        <td colspan="3" class=""><i class="icon-tasks"/>&nbsp;Adicionar</td>
                                                                                        <td style="cursor: pointer" onclick="validarDatos()"><i class="icol32-add"/></td>
                                                                                    </tr>
                                                                                </table>
                                                                            </div>
                                                                        </div>
                                                                        <input type="hidden" id="id" name="id" value="<%=conc.getId_concepto()%>" />
                                                                        <script>
                                                                            Datos('<%=conc.getPrioridad()%>','<%=conc.getNombre()%>','<%=conc.getClase()%>','<%=conc.getTipo()%>')
                                                                        </script>
                                                                         </body>
                                                                         </form>
                                                                        </html> <%
                                                                        }catch (Exception ex) {
                                                                        ex.printStackTrace();
                                                                        }%>