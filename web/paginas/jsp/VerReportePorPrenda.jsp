
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>

<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("prendasPorBeneficiario.jsp")){
                    modelo.Model model = (modelo.Model)session.getAttribute("model");
                    modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
                    modelo.Persona persona = model.consultarPersona(usuario.getFk_persona());
                    String nombreU = persona.getNombre_1()+" "+persona.getApellido_1()+" "+(persona.getApellido_2()!=null?persona.getApellido_2():"");
                    String prenda2 = request.getParameter("nombprenda");
                    %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ver reporte por prenda</title>
    </head>

    <script language="javascript">

	function verReporte(){
				ancho = 789;
				alto = 250;
				barra = 0;
				izquierda = (document.width) ? (document.width-ancho)/2 : 100;
				arriba = (document.height) ? (document.height-alto)/2 : 100;
				opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
				var dir = "Prendasporbeneficiario/prendasporbeneficiario.jasper";
                                var nombre = "verreporteporprenda";
				url = "verReportes.jsp?nombreReporte="+nombre+"&dirReporte="+dir;6
				window.open(url, 'popUp', opciones);
			}

           function Regresar(){
                document.form.action = "prendasPorBeneficiario.jsp?";
                document.form.submit();
}
 function reporteExcel(){
             document.form.submit();
}
     
     </script>


    <body>
         <form action="prendasexcel.jsp" method="post" name="form" class="style3" id="form">

        <table width="100%" border="0" align="center"  cellpadding="1" cellspacing="0">
             <tr>
                 <td colspan="6" align="right">
                     <img src="../html/images/reporte.png" width="22" height="22" onclick="verReporte()" style="cursor:pointer"/>REPORTE</td>
                 <td colspan="6" align="right"><img src="../html/images/reporte.png"  onclick="reporteExcel()" width="22" height="22" style="cursor:pointer"/>REPORTE EXCEL</td>
        
             </tr>
        </table>

        <table width="100%" border="1" align="center"  cellpadding="1" cellspacing="0">
 
           <tr bgcolor="#CCCCCC" style="border:none;background:url(../html/images/inicio_3.png)">
        
                <td width="6%" style="border:none" align="center" class="style1" style="color:#FFFFFF">Placa</td>
                <td width="15%" style="border:none" align="center" class="style1" style="color:#FFFFFF">Estado vehiculo</td>
                <td width="10%" style="border:none" align="center" class="style1" style="color:#FFFFFF">Estado alerta</td>
                <td width="15%" style="border:none" align="center" class="style1" style="color:#FFFFFF">Fecha prenda</td>
                <td width="15%" style="border:none" align="center" class="style1" style="color:#FFFFFF">Fecha levantamiento</td>
                <td width="29%" style="border:none" align="center" class="style1" style="color:#FFFFFF">Prenda</td>
          </tr>

          <tr>

        <%
        
        java.util.List<Prendasporbeneficiario> prendas = null;
        String prenda = request.getParameter("nombprenda");

        HashMap parameters = new java.util.HashMap();

        parameters.put("PRENDATARIO",prenda);
        parameters.put("USUARIO", nombreU);
        session.setAttribute("verreporteporprenda", parameters);
       
        prendas  = model.reporteporprenda(prenda);
        for(int i=0;i<prendas.size();i++){
        Prendasporbeneficiario prend = prendas.get(i);
        
        String fl;

        if(prend.getFechalevantada()==null){
                fl="";

        }else{
            fl=prend.getFechaprenda().toString();
        }
        %>
       <td width="6%" align="center" class="style2" style="color:#333333; font-size:12px"><%=prend.getPlaca()%></td>
       <td width="15%" align="center" class="style2" style="color:#333333; font-size:12px"><%=prend.getEstadovehiculo()%></td>
       <td width="10%" align="center" class="style2" style="color:#333333; font-size:12px"><%=prend.getEstadoalerta()%></td>
       <td width="15%" align="center" class="style2" style="color:#333333; font-size:12px"><%=prend.getFechaprenda()%></td>
       <td width="15%" align="center" class="style2" style="color:#333333; font-size:12px"><%=fl%></td>
       <td width="29%" align="center" class="style2" style="color:#333333; font-size:12px"><%=prend.getObservaciones()%></td>
     </tr>

     <% } %>
     <tr><td style = "display:none"><input name="prend" id="prend" type="text" value="<%=prenda%>"></td></tr>
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
}catch(Exception mexe){
mexe.printStackTrace();
%>

    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>