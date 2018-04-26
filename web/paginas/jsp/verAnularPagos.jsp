<%-- 
    Document   : verAnularPagos
    Created on : 31/07/2012, 02:53:41 PM
    Author     : Administrador
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="java.util.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
try{
	
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("AnularPagosCajas.jsp")){
                    if(session.getAttribute("model")!=null){
                        
                    modelo.Model model = (modelo.Model)session.getAttribute("model");
                    modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");

%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style type="text/css">


<!--


.Estilo7 {
	color: #333333;
	font-size: 12px;
	font-weight: bold;
}
.Estilo8 {
	font-size: 14px;
	color: #333333;
	font-weight: bold;
}
.style2 {font-size: 12px; color: #333333; font-weight: bold; font-family: Tahoma; }
.style3 {font-size: 11px}
.style5 {font-size: 10px}
.style8 {color: #333333; font-size: 11px; font-weight: bold; font-family: Tahoma; }
.style9 {color: #FFFFFF}
.style10 {color: #FFFFFF; font-size: 11px; font-weight: bold; }
.Estilo11 {color: #DE2021}

-->
</style>
       
<script>
        function Marcar(){

        if(document.form.marcartodo.checked){
             for (i=0;i<document.form.elements.length;i++)
                if(document.form.elements[i].type == "checkbox")
                    document.form.elements[i].checked=1
        }else{
             for (i=0;i<document.form.elements.length;i++)
                if(document.form.elements[i].type == "checkbox")
                    document.form.elements[i].checked=0
        }


        }
</script>
       
</head>
    <body>
        <form name="form" method="post" action="ProcesarAnularPago.jsp">
            

<%
    if(request.getParameter("fi")!=null&&request.getParameter("ff")!=null){
        String fechaI = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.text.SimpleDateFormat("yyyy/MM/dd").parse(request.getParameter("fi")));
        String fechaF = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.text.SimpleDateFormat("yyyy/MM/dd").parse(request.getParameter("ff")));
        java.sql.Date  fecha_inicial = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(fechaI).getTime());
        java.sql.Date  fecha_final = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(fechaF).getTime());
                
        java.util.List list = model.listarTiquetesNoCancelados(fecha_inicial,fecha_final,1);
        Taquilla taq = model.consultarTaquillaActivaByUsuario(usuario.getId_usuario());
        
        int cont = 0;
        if(taq!=null){
        %>

<table width="100%" border="1" align="center" cellpadding="1" cellspacing="0" id="tabla1">

<tr style="border:none; background:url(../html/images/inicio_3.png)">
<td colspan="11" align="center">LISTADO DE TIQUETES</td>

      <tr>
          <td colspan="8">&nbsp;</td>
          <td style="border-left:none" align="center"><span class="Estilo2"><font color="#333333">Marcar todo</font></span></td>
          <td align="center"><input type="checkbox" name="marcartodo" id="marcartodo" onclick="Marcar()" /></td>
      </tr>

        <tr>

                          <tr style="border:none; background:url(../html/images/inicio_3.png)">
                               <td width="2%"><div align="center" class="Estilo7 style3 style9">#</div></td>
                                <td width="12%"><div align="center" class="Estilo7 style3 style9">TIPO PAGO </div></td>
                                <td width="8%"><div align="center" class="style10">FACTURA</div></td>
                                <td width="8%"><div align="center" class="style10">PLACA</div></td>
                                <td width="8%"><div align="center" class="style10">FECHA</div></td>
                                <td width="12%"><div align="center" class="style10">DOCUMENTO</div></td>
                                <td width="30%"><div align="center" class="style10">NOMBRE&nbsp;PERSONA </div></td>
                                <td width="11%"><div align="center" class="style10">USUARIO</div></td>
                                <td width="11%"><div align="center" class="style10">VALOR</div></td>
                                <td width="11%"><div align="center" class="style10">ANULAR</div></td>
                         </tr>
<%
        for(int t=0;t<list.size();t++){
        
        Tiquete ti = (Tiquete)list.get(t);
        Taquilla tac = model.consultarTaquillaById(ti.getFk_taquilla());
       
        if(tac.getFk_caja()== taq.getFk_caja()){
           Persona persona = new Persona();
           Parametro tipoP = new Parametro();
           Parametro estadoT = new Parametro();
           java.text.SimpleDateFormat   sdf  =new java.text.SimpleDateFormat("dd/MM/yyyy");


           java.util.HashMap listaTipos = model.crearHashParametrosAbreviatura(5);
           String nombre="";
           float total=0;
           
                   Tiquete tiq = (Tiquete)list.get(t);
                   if(tiq.getEstado()!=2 && tiq.getTipo_pago()==1){
                   
                   tipoP =  model.consultarParametro(tiq.getTipo_pago(),301);
                   estadoT = model.consultarParametro(tiq.getEstado(),77);
                   persona = model.consultarPersona(tiq.getFk_persona());
                   if(tiq.getEstado()==3){
                   total=total+tiq.getValor_total();
                   }
                   String placaV = "";
                   if(tiq.getFk_vehiculo()!=0){
                       placaV = model.consultarVehiculoById(tiq.getFk_vehiculo()).getPlaca();
                   }else{
                       if(tiq.getDescripcion()!=null)
                           placaV = tiq.getDescripcion().toUpperCase();
                   }
                   usuario = model.consultarUsuario(tiq.getFk_usuario());

                   nombre = persona.getApellido_1() + " " + (persona.getApellido_2() != null ? persona.getApellido_2() : "") + " " + persona.getNombre_1();
                   cont +=1;%>
                        <tr bordercolor="#FFFFFF" class="style2" style="cursor:pointer" onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
                            <td align="center" style="font-size:11px"><span class="style5"><%= (cont) %></span></td>
                            <td align="center" style="font-size:11px"><span class="style5"><%= tipoP.getNombre() %></span></td>
                            <td align="center" style="font-size:11px"><span class="style5"><%= tiq.getNumero_factura() %></span></td>
                            <td align="center" style="font-size:11px"><span class="style5"><%= placaV%></span></td>
                            <td align="center" style="font-size:11px"><span class="style5"><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(tiq.getFecha())%></span></td>
                            <td align="center" style="font-size:11px"><span class="style5"><%=listaTipos.get(persona.getTipo_documento() + "")+" "+persona.getDocumento()%></span></td>
                            <td align="center" style="font-size:11px"><span class="style5"><%=nombre%></span></td>
                            <td align="center" style="font-size:11px"><span class="style5"><%= usuario.getNombre() %></span></td>
                            <td align="right" style="font-size:11px"><span class="style5"><%= tiq.getValor_total() %></span></td>
                            <td align="right" style="font-size:11px"><center><input type="checkbox" align="center" value="<%=tiq.getNumero_factura()%>" <%=list.contains(tiq.getNumero_factura()+"")?"checked":""%>name="Num_factura" id="Num_factura" title="Anular pago"/></center></td>
                        </tr>
   <% } %>
                       

       <%}
        }
%>

                        <tr bordercolor="#FFFFFF" class="style2" style="cursor:pointer">
                            <td align="right" colspan="10" style="font-size:11px"><span class="style5"></span></td>
                        </tr>

                        <tr bordercolor="#FFFFFF" class="style2" style="cursor:pointer">
                            <td><input type="hidden" name="anular" id="anular" value="1"></td>
                            <td align="right" colspan="10" style="font-size:11px"><input type="submit" name="AnularPagos" value="Anular Pagos"></td>
                        </tr>

					</table>
</form>
    </body>
</html>
<%

}else{ %>
	 <script>
             alert("No se encuentran taquillas abiertas")
             document.form.location.href = "AnularPagosCajas.jsp";
         </script>
<%}

}else{
               %><script>alert("Los campos entre fechas no pueden estar vacios")</script>><%
}

}else{ %>
			   <jsp:forward page="no_access.jsp">
				 <jsp:param name="tipo" value="1"></jsp:param>
			   </jsp:forward>
<%}
}else{ %>
		<script>
			window.parent.document.location.href = "../../index.jsp";
		</script>  <%
	}

}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>