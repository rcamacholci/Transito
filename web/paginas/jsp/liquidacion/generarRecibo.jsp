<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" import="modelo.*" import="java.util.*"%>
<%try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
                    Model model= (Model)session.getAttribute("model");
                    Usuario usuario= (Usuario)session.getAttribute("usuario");
                    
                    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Generacion de Liquidaciones RUNT</title>
        <style type="text/css">
            <!--
            .Estilo4 {
                font-weight: bold;
                font-family: "Times New Roman", Times, serif;
                color: #FFFF99;
                font-size:12px;
            }
			
            -->
            
        </style>
	    <!-- filter: alpha(opacity=85);-moz-opacity:0.85; -->
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

        function cleaner(){
            document.form.nombre.value = "";
        }

        function consultarDocumentos(){
                var doc = document.form.documento.value;
                var tipo = document.form.tipos.value;
                document.form.action = "verRecibo.jsp?id=0";
                document.form.submit();
                if(doc.length>0&&tipo.length>0){
                        ajax=nuevoAjax();
                        ajax.open("POST", "../getPersona.jsp",true);
                        ajax.onreadystatechange=function() {
                                if (ajax.readyState==4) {
                                        var respuesta = "" ;
                                        for(var i = 0; i < ajax.responseText.length ; i++){
                                                if(isNaN(ajax.responseText.charAt(i))||ajax.responseText.charAt(i)==' ')
                                                        respuesta += ajax.responseText.charAt(i);
                                        }
                                        if(respuesta == "nueva"){
                                                document.form.nombre.value = "";
                                                document.form.action = "../adicionarPersona.jsp?tipo="+tipo+"&documento="+doc;
						document.form.submit();
                                        }else{
                                                document.form.nombre.value = respuesta;
                                        }
                                }
                        }
                        ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                        ajax.send("documento="+doc+"&tipo="+tipo);
                }
        }

        function generarLiquidacion(){
                        if(document.form.nombre.value.length>0){
                                if(document.form.tramite.value!=0){
                                        if(document.form.categoria.value!=0){
                                                if(confirm("Esta seguro aplicar esta liquidacion")){
                                                        document.form.action = "verRecibo.jsp?id=1";
                                                        document.form.submit();
                                                }
                                        }else{
                                                alert("Seleccione una categoria para la licencia");
                                        }
                                }else{
                                        alert("Seleccione un tramite a liquidar");
                                }
                        }else{
                                alert("No existe un solicitante valido");
                        }
        }

        function nuevaLiquidacion(){
            document.location.href = "generarRecibo.jsp";
        }
        
        </script>
        <style type="text/css">
            <!--
            .Estilo1 {
                font-family: "Vendana";
                font-weight: bold;
                color: #003366;
				font-size: 14px;
            }
			.Estilo2 {
				font-family: "Vendana";
				font-weight: bold;
				color: #006666;
				font-size: 14px;
			}
						-->
        </style>
</head>
    <body>
        <form name="form" method="post" action="" target="reporte">
        <table width="60%" border="0" align="center">
		    <tr>
				<th><span class="Estilo2">GENERAR LIQUIDACION RUNT LICENCIAS DE CONDUCCION </span></th>
			</tr>
			<tr>
			  <th>&nbsp;</th>
			</tr>  	
            <tr>
                <th colspan="2" scope="col" width="100%">
					<fieldset>
                        <table width="100%" border="0">
                            <tr>
                              <td width="16%" scope="col"><label><span class="Estilo1">Tipo&nbsp;Documento </span></label></td>
                                <td width="20%" scope="col">
                                <select name="tipos" id="tipos" size="1" style="width:170px; font-size:12px;color:#333333; ">
                                    <%
                                    java.util.List listaTipos = model.listadoParametros(5);
                                    for (int i = 0; i < listaTipos.size(); i++) {
                                        Parametro parametro = (Parametro) listaTipos.get(i);%>
                                        <option value="<%=parametro.getCodigo() + ""%>"><%=parametro.getNombre()%></option>
                                 <%	} %>	
                              </select>                              </td>
                              <th width="24%" scope="col"><label><span class="Estilo1">Documento</span></label></th>
                              <th width="19%" scope="col"><input name="documento" id="documento" type="text" maxlength="11" style="text-align:center; color:#333333; width:90px" onfocus="cleaner()"/></th>
                         
                              <th width="21%" scope="col"><input id="consultar" name="consultar" style="width:80px" type="button" value="Consultar" onclick="consultarDocumentos()"/></th>
                            </tr>
                            <tr>
                              <td><span class="Estilo1">Nombre&nbsp;Persona </span></td>
                              <td colspan="3" align="left">
							  <input name="nombre" id="nombre" type="text" style="text-align:center; font-weight:bold;color:#003366; width:320px" readonly="true"/></td>
                              <th>&nbsp;</th>
                            </tr>
                            <tr>
                              <td scope="col"><span class="Estilo1">Tramite&nbsp;/&nbsp;Categ.</span></td>
                              <td colspan="3" align="left">
                                  <select name="tramite" id="tramite" size="1" style="width:290px; font-size:12px;color:#333333; ">
                                      <option value="0">--- Seleccione un Tramite --</option>
                                <%
                                
                                listaTipos = model.consultarTramites(2, usuario.getFk_sede());
                                for (int i = 0; i < listaTipos.size(); i++) {
                                    Tramite tramite = (Tramite) listaTipos.get(i);%>
                                <option value="<%=tramite.getId_tramite() + ""%>"><%=tramite.getNombre()%></option>
                                <%	}  %>
                              </select>
							  <select name="categoria" id="categoria" style="width:45px; font-size:12px;color:#333333; ">
                                                              <option value="0">--</option>
                                    <%
                                    listaTipos = model.listadoParametros(221);
                                    for (int i = 0; i < listaTipos.size(); i++) {
                                        Parametro parametro = (Parametro) listaTipos.get(i);%>
                                        <option value="<%=parametro.getCodigo() + ""%>"><%=parametro.getNombre()%></option>
                                 <%	} %>	
                              </select>
                         </td>
                              <th scope="col">
					<input name="aceptar" type="button" id="aceptar" style="width:80px" value="Generar" onclick="generarLiquidacion()"/>
                              </th>
                            </tr>
                    </table>
               		</fieldset>					</th>
            </tr>
			<tr>
			  <th>&nbsp;</th>
			</tr>  
			<tr>
			  <th>
			  <iframe name="reporte" id="reporte" allowtransparency="true" frameborder="0" marginheight="0" marginwidth="0" scrolling="auto" width="100%" height="300px" src="#">
			  </iframe>
			  </th>
			</tr>
    </table>
    </form>	
    </body>
</html>
<%  }else{ %>
			   <jsp:forward page="no_access.jsp">
				 <jsp:param name="tipo" value="1"></jsp:param>
			   </jsp:forward>
	<%  }
	}else{ %>
		<script>
			window.parent.document.location.href = "../../index.jsp";
		</script>  <%
	}
}catch(Exception mexe){ %>
    <jsp:forward page="../no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>


