<%@page import="com.movillife.Parametros"%>
<%@page import="modelo.Parametro"%>
<%@page import="modelo.Model"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <%
            try {
                Model model = (Model) session.getAttribute("model");
                java.util.LinkedList listado_bancos = model.listado_bancos();
                model.conectar();
                model.getCon().setAutoCommit(false);

        %>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <!-- Viewport Metatag -->
        <meta name="viewport" content="width=device-width,initial-scale=1.0">
            <!-- Viewport Metatag -->
            <meta name="viewport" content="width=device-width,initial-scale=1.0">
                <script src="../../html/scripts/personas.js" type="text/javascript"></script>
                <script language="javascript" type="text/javascript">
		
                    function nuevoAjax(){
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
		
		
                    function salir(){
                        window.location.href = "entidades_de_distribucion.jsp?id=1";
                    }
                    function newPersona(tipo,numero){
                        if(!isNaN(numero)){
                            var ancho = 689;
                            var alto = 250;
                            var izquierda = (screen.width) ? (screen.width-ancho)/2 : 100;
                            var arriba = (screen.height) ? (screen.height-alto)/2 : 100;
                            var opciones = 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width='+ancho+',height='+alto+',left='+izquierda+',top='+ arriba;
                            var url = "../adicionarPersona.jsp?tipo="+tipo+"&documento="+numero;
                            var ventana = window.open(url, 'popUp', opciones);
                        }
                    }
		
                    function consultaPersona(){
                        documento = document.getElementById("documento");
                        if(!isNaN(documento.value)&&documento.value.length>0){
                            ajax=nuevoAjax();
                            ajax.open("POST", "../getPersona.jsp",true);
                            ajax.onreadystatechange=function() {
                                if (ajax.readyState==4) {
                                    var respuesta = "" ;
                                    for(var i = 0; i < ajax.responseText.length ; i++){
                                        if(isNaN(ajax.responseText.charAt(i))||ajax.responseText.charAt(i)==' ')
                                            respuesta += ajax.responseText.charAt(i);
                                    }
                                    if(respuesta.indexOf("nueva")!=-1){
                                        newPersona(2,documento.value);
                                    }else{
                                        document.form.nombre.value = respuesta;
                                    }  
                                }
                            }
                            ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                            ajax.send("documento="+documento.value+"&tipo=2"); 
                        }
                    }
			
                    function AdicionarEntidad(){
                        ajax2=nuevoAjax();
                        var prioridad = document.form.Prioridad.value;
                        var NombreColor= document.form.txt_Nombre_Concepto.value;
                       
                        ajax2.open("POST", "GuardarConcepto.jsp",true);
                        ajax2.onreadystatechange=function() {
                                
                            if (ajax2.readyState==4) {
                                var docxml = ajax2.responseXML;
                                var result = docxml.getElementsByTagName('result')[0].childNodes[0].nodeValue
                                    
                                if(result == '1'){
                                    var mensaje = docxml.getElementsByTagName('msg')[0].childNodes[0].nodeValue
                                    document.form.Prioridad.value="";
                                    document.form.txt_Nombre_Concepto.value="";
                                    document.form.C_concepto.value="";
                                    document.form.T_concepto.value="";                                   
                                    alert(mensaje);
                                }else{
                                    var mensaje = docxml.getElementsByTagName('msg')[0].childNodes[0].nodeValue
                                    alert(mensaje);
                                }                                                
                            }
                        }
                        ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                        ajax2.send("c_concepto="+Cconcepto+"&t_concepto="+Tconcepto+"&prioridad="+prioridad+"&nombre="+NombreColor);

             
                    }

                    function validarDatos(){
                        var prioridad = document.form.cuenta.value.trim();
                        var NombreColor= document.form.documento.value.trim();
                        if(NombreColor.length>0){
                            if(prioridad>0){
                                AdicionarEntidad()();
                            } else{
                                alert("El campo Cuenta no debe estar vacio") 
                            }                                       
                        }else{
                            alert("El campo nit no debe estar vacio")
                        }
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
                                                                                    <span><i class="icon-table"></i>Table Entidades Distribucion</span>
                                                                                </div>
                                                                                <table class="mws-table" style="width: 100%">

                                                                                    <tr style="color: #000000;text-align: center">
                                                                                        <td   style="border:none"><div align="left"><span ><i class="icon-tasks"/>&nbsp;&nbsp;NIT</span></div></td>
                                                                                        <td style="border:none">
                                                                                            <input name="documento" type="text" id="documento" style="width:400px" onblur="consultaPersona()" />                      </td>
                                                                                    </tr>
                                                                                    <tr style="color: #000000;text-align: center">
                                                                                        <td   style="border:none"><div align="left"><span ><i class="icon-tasks"/>&nbsp;&nbsp;ENTIDAD</span></div></td>
                                                                                        <td style="border:none">
                                                                                            <input name="nombre" type="text" id="nombre" style="width:400px" readonly/>   
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr style="color: #000000;text-align: center">
                                                                                        <td class="style9" style="border:none"><div align="left"><i class="icon-tasks"/>&nbsp;&nbsp;BANCO</div></td>
                                                                                        <td style="border:none"><label>
                                                                                                <select name="bancos" style="width:400px">
                                                                                                    <%
                                                                                                        if (!listado_bancos.isEmpty()) {
                                                                                                            for (int i = 0; i < listado_bancos.size(); i++) {
                                                                                                                modelo.Banco banco = (modelo.Banco) listado_bancos.get(i);
                                                                                                    %>
                                                                                                    <option value="<%= banco.getId_banco()%>"><%=banco.getNombre()%></option>
                                                                                                    <%		}
                                                                                                        }

                                                                                                    %>
                                                                                                </select>
                                                                                            </label></td>
                                                                                    </tr>
                                                                                    <tr style="color: #000000;text-align: center">
                                                                                        <td class="style9" style="border:none"><div align="left"><i class="icon-tasks"/>&nbsp;&nbsp;CUENTA</div></td>
                                                                                        <td style="border:none"><input name="cuenta" type="text" id="cuenta" style="width:400px" /></td>
                                                                                    </tr>
                                                                                    <tr style="color: #000000;text-align: center"  >
                                                                                        <td colspan="2" style="border:none">
                                                                                            <div align="left">
                                                                                                <i class="icon-tasks"/>&nbsp;&nbsp;<input type="checkbox" id="defecto" name="defecto" value="" />&nbsp;&nbsp;EMPRESA POR DEFECTO</div></td>
                                                                                    </tr>
                                                                                    <tr style="color: #000000;text-align: left">
                                                                                        <td colspan="1" class=""><i class="icon-tasks"/>&nbsp;Adicionar</td>
                                                                                        <td style="cursor: pointer" align="center" onclick="validarDatos()"><i class="icol32-add"/></td>
                                                                                    </tr>
                                                                                </table>
                                                                            </div>
                                                                        </div>
                                                                    </body>
                                                                </form>
                                                                </html>
                                                                <%} catch (Exception ex) {
                                                                        ex.printStackTrace();
                                                                    }%>