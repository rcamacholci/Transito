<%-- 
    Document   : verTablaDescuento
    Created on : 15/02/2013, 02:25:53 PM
    Author     : Jefrey
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8" import="modelo.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		//if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("Pase_Conceptos.jsp")){
            if(1==1){
                    modelo.Model modelo = (modelo.Model)session.getAttribute("model");
                    Usuario usuario = (Usuario)session.getAttribute("usuario");
                    Sede sede = (Sede)session.getAttribute("sede");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../html/css/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />
        <script type="text/javascript" src="../html/scripts/tablecloth.js"></script>
        <script type="text/javascript" src="../html/scripts/motorAjax.js"></script>
        <script type="text/javascript" src="../html/scripts/Pase_conceptos.js"></script>
        <LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script type="text/javascript" src="../html/scripts/calendar.js"></script>
        <script type="text/javascript" src="../html/scripts/calendar-setup.js"></script>
        <script type="text/javascript" src="../html/scripts/calendar-es.js"></script>
        <script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
        <title>Ver Tabla Descuento</title>
    </head>
    <body>
        <form name="form" method="post" action="">

          <table border="1">

      <tr>
        <th scope="col">RESOLUCION NO</th>
        <td scope="col"><input type="text" name="noresolucion" id="noresolucion" style="width:150px;"/></td>
        <th scope="col">FECHA INICIO</th>
        <td><input type="text"  name="fecha_inicial" id="fecha_inicial" style="width:95px; background-image:url(../html/images/mascara.png); font-size:12px; background-position:center; background-repeat:no-repeat; text-align:center" onkeyup="mascara(this,'/',true)" maxlength="10" />
        <button name="fecha1" type="button" id="fecha1"><img src="../html/images/calendario.png" width="12" height="12"/></button>
      <!--<input name="fecha1" type="button" id="fecha1" value="<"style="width:20px; text-align:center"/>-->
	  <script type="text/javascript">
			Calendar.setup({
				inputField     :    "fecha_inicial",      // id del campo de texto
				ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
				button         :    "fecha1"   // el id del bot?n que lanzar? el calendario
			});
	</script></td>
      </tr>
      <tr>
        <th scope="col">FECHA RESOLUCION</th>
        <td><input type="text"  name="fecha_resolucion" id="fecha_resolucion" style="width:95px; background-image:url(../html/images/mascara.png); font-size:12px; background-position:center; background-repeat:no-repeat; text-align:center" onkeyup="mascara(this,'/',true)" maxlength="10" />
        <button name="fecha2" type="button" id="fecha2"><img src="../html/images/calendario.png" width="12" height="12"/></button>
      <!--<input name="fecha1" type="button" id="fecha1" value="<"style="width:20px; text-align:center"/>-->
	  <script type="text/javascript">
			Calendar.setup({
				inputField     :    "fecha_resolucion",      // id del campo de texto
				ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
				button         :    "fecha2"   // el id del bot?n que lanzar? el calendario
			});
	</script></td>
        <th scope="col">FECHA FIN</th>
        <td><input type="text"  name="fecha_final" id="fecha_final" style="width:95px; background-image:url(../html/images/mascara.png); font-size:12px; background-position:center; background-repeat:no-repeat; text-align:center" onkeyup="mascara(this,'/',true)" maxlength="10" />
        <button name="fecha3" type="button" id="fecha3"><img src="../html/images/calendario.png" width="12" height="12"/></button>
      <!--<input name="fecha1" type="button" id="fecha1" value="<"style="width:20px; text-align:center"/>-->
	  <script type="text/javascript">
			Calendar.setup({
				inputField     :    "fecha_final",      // id del campo de texto
				ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
				button         :    "fecha3"   // el id del bot?n que lanzar? el calendario
			});
	</script></td>
      </tr>
    </table>

         <table width="888" border="1">
      <tr>
        <th colspan="6" scope="col">NOMBRE DE CONCEPTOS</th>
      </tr>
      <tr>
        <th width="56" scope="row">ID</th>
        <th width="344">NOMBRE CONCEPTO</th>
        <th width="200">VALOR ANTERIOR</th>
        <th width="80" style="display:none">PORCENTAJE</th>
        <th width="359" style="display:none">TRAMITE</th>
        <th width="128">NUEVO VALOR</th>
      </tr>
      
        <%
        if(request.getParameter("id_concepto")!=null){
        long id_concepto = Long.parseLong(request.getParameter("id_concepto"));
        java.util.List st = modelo.listarTramiteByConcepto(id_concepto, sede.getId_sede());        
            //for(int i=0;i<st.size();i++){
            Valor_conceptos_tramite sedet = (Valor_conceptos_tramite)st.get(0);
            Concepto concepto = modelo.consultarConcepto(sedet.getFk_concepto());
            Tramite tramite = modelo.consultarTramite(sedet.getFk_tramite());
            Sede_tramite_concepto stc = modelo.consultarSedeTramiteConc(id_concepto,tramite!=null?tramite.getId_tramite():0,usuario.getFk_sede());
            Configuracion_descuentos conf = new Configuracion_descuentos();

            if(tramite!=null){
            conf = modelo.getConfiguracion_descuentos(sede.getId_sede(),concepto.getId_concepto(),1,1,tramite.getId_tramite());
            }else{
            conf = modelo.getConfiguracion_descuentos(sede.getId_sede(),concepto.getId_concepto(),1,1,0);
            }
            float valorC = stc.getValor();
            String read = valorC==0?"Readonly":"";
            String disable = valorC==0?"disabled":"";
            
    %>

          <tr >
            <td><%=concepto.getId_concepto() %></td>
            <td><%=concepto.getNombre() %></td>
            <td>$ <%=stc.getValor() %></td>
            <td style="display: none">&nbsp;</td>
            <td style="display: none">&nbsp;</td>
            <td><input type="text" name="totalC<%=0%>" id="totalC<%=0%>" <%=read%> <%=disable%>  style="width:70px" onKeyPress="return soloNumeros(event)" value="<%=valorC %>" onblur="CalcularP(this.value,'0','totalC<%=0%>','<%=conf.getId_configuracion_descuentos() %>','<%=tramite!=null?tramite.getId_tramite():0%>')"></td>
          </tr>
    <%
            //}
        }
%>

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
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>