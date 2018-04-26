<%-- 
    Document   : verFacturaDomiciliaria
    Created on : 28/05/2012, 09:09:36 AM
    Author     : Sistemas
--%>

<% request.setCharacterEncoding("UTF-8"); %> 
<%@ page contentType="text/html; charset=iso-8859-1"  pageEncoding="ISO-8859-1" language="java" import="java.sql.*" import="modelo.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("facturadomiciliaria.jsp")){
                    modelo.Model model = (modelo.Model)session.getAttribute("model");
                    modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
                    modelo.Persona persona = model.consultarPersona(usuario.getFk_persona());
                    String nombreU = persona.getNombre_1()+" "+persona.getApellido_1()+" "+(persona.getApellido_2()!=null?persona.getApellido_2():"");
                    String fecha = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());
                    String periodo = request.getParameter("periodo");
                    
                    %>

<%

response.setContentType ("application/vnd.ms-excel"); //Tipo de fichero.
response.setHeader ("Content-Disposition", "attachment;filename=\"Factura Domiciliaria.xls\"");

%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ver Factura Domiciliaria</title>
    </head>
    <body>

         <table width="100%" border="1" align="center"  cellpadding="1" cellspacing="0">

             
             <tr>
                 <td>Generado por:</td>
                 <td><%=nombreU%></td>
             </tr>
             <tr>
                 <td>Fecha:</td>
                 <td><%=fecha%></td>
             </tr>
             
           <tr bgcolor="#CCCCCC" style="border:none;background:url(../html/images/inicio_3.png)">

    <td width="20%" style="border:none" align="center" class="style1" style="color:#000000">FACTURA</td>
    <td width="20%" style="border:none" align="center" class="style1" style="color:#000000">ORGANISMO</td>
    <td width="20%" style="border:none" align="center" class="style1" style="color:#000000">PLACA</td>
    <td width="20%" style="border:none" align="center" class="style1" style="color:#000000">NOMBRE PROPIETARIO</td>
    <td width="20%" style="border:none" align="center" class="style1" style="color:#000000">DIRECCION</td>
    <td width="20%" style="border:none" align="center" class="style1" style="color:#000000">TELEFONO</td>
    <td width="20%" style="border:none" align="center" class="style1" style="color:#000000">CELULAR</td>
    <td width="20%" style="border:none" align="center" class="style1" style="color:#000000">MOTOR</td>
    <td width="20%" style="border:none" align="center" class="style1" style="color:#000000">CHASIS</td>
    <td width="20%" style="border:none" align="center" class="style1" style="color:#000000">SERIAL</td>
    <td width="20%" style="border:none" align="center" class="style1" style="color:#000000">MARCA</td>
    <td width="20%" style="border:none" align="center" class="style1" style="color:#000000">LINEA</td>
    <td width="20%" style="border:none" align="center" class="style1" style="color:#000000">CLASE</td>
    <td width="20%" style="border:none" align="center" class="style1" style="color:#000000">SERVICIO</td>
    <td width="20%" style="border:none" align="center" class="style1" style="color:#000000">MODELO</td>
    <td width="20%" style="border:none" align="center" class="style1" style="color:#000000">FECHA EXPEDICION</td>
    <td width="20%" style="border:none" align="center" class="style1" style="color:#000000">SALDO ACTUAL</td>
    <td width="20%" style="border:none" align="center" class="style1" style="color:#000000">FECHA LIMITE PERIODO PAGO</td>
    <td width="20%" style="border:none" align="center" class="style1" style="color:#000000">OBLIGACIONES VENCIDAS</td>
    <td width="20%" style="border:none" align="center" class="style1" style="color:#000000">COMPARENDOS</td>
    <td width="20%" style="border:none" align="center" class="style1" style="color:#000000">SALDOS A FAVOR</td>
    <td width="20%" style="border:none" align="center" class="style1" style="color:#000000">SALDO EN CONTRA</td>
    <td width="20%" style="border:none" align="center" class="style1" style="color:#000000">TOTAL A CANCELAR</td>
    <td width="20%" style="border:none" align="center" class="style1" style="color:#000000">CIUDAD ENVIOS</td>
    <td width="20%" style="border:none" align="center" class="style1" style="color:#000000">PERIODO DE PAGO</td>
    
           </tr>

    <tr>

        <%

        java.util.List<FacturaDomiciliaria> FacturaDomiciliaria = null;
        int ano =Integer.parseInt(fecha.substring(6,10));
        System.out.println(fecha);
        System.out.println(ano);
        FacturaDomiciliaria  = model.generarfacturadomiciliaria(ano, periodo);
        for(int i=0;i<FacturaDomiciliaria.size();i++){
        FacturaDomiciliaria fact = FacturaDomiciliaria.get(i);

        String direccion, telefono, celular, motor, chasis, serial, marca, linea, ciudad_envio;

        if(fact.getdireccion()==null){
                direccion="";

        }else{
            direccion=fact.getdireccion();
        }

        if(fact.gettelefono()==null){
                telefono="";

        }else{
            telefono=fact.gettelefono();
        }

         if(fact.getcelular()==null){
                celular="";

        }else{
            celular=fact.getcelular();
        }

         if(fact.getmotor()==null){
                motor="";

        }else{
            motor=fact.getmotor();
        }

         if(fact.getchasis()==null){
                chasis="";

        }else{
            chasis=fact.getchasis();
        }

          if(fact.getserial()==null){
                serial="";

        }else{
            serial=fact.getserial();
        }

        if(fact.getmarca()==null){
                marca="";

        }else{
            marca=fact.getmarca();
        }

        if(fact.getlinea()==null){
                linea="";

        }else{
            linea=fact.getlinea();
        }

        if(fact.getciudad_envio()==null){
                ciudad_envio="";

        }else{
            ciudad_envio=fact.getciudad_envio();
        }

%>

        <td width="20%" align="center" class="style2" style="color:#333333; font-size:12px"><%=fact.getfactura()%></td>
        <td width="20%" align="center" class="style2" style="color:#333333; font-size:12px"><%=fact.getorganismo()%></td>
        <td width="20%" align="center" class="style2" style="color:#333333; font-size:12px"><%=fact.getplaca()%></td>
        <td width="20%" align="center" class="style2" style="color:#333333; font-size:12px"><%=fact.getnombre_propietario()%></td>
        <td width="20%" align="center" class="style2" style="color:#333333; font-size:12px"><%=direccion%></td>
        <td width="20%" align="center" class="style2" style="color:#333333; font-size:12px"><%=telefono%></td>
        <td width="20%" align="center" class="style2" style="color:#333333; font-size:12px"><%=celular%></td>
        <td width="20%" align="center" class="style2" style="color:#333333; font-size:12px"><%=motor%></td>
        <td width="20%" align="center" class="style2" style="color:#333333; font-size:12px"><%=chasis%></td>
        <td width="20%" align="center" class="style2" style="color:#333333; font-size:12px"><%=serial%></td>
        <td width="20%" align="center" class="style2" style="color:#333333; font-size:12px"><%=marca%></td>
        <td width="20%" align="center" class="style2" style="color:#333333; font-size:12px"><%=linea%></td>
        <td width="20%" align="center" class="style2" style="color:#333333; font-size:12px"><%=fact.getclase()%></td>
        <td width="20%" align="center" class="style2" style="color:#333333; font-size:12px"><%=fact.getservicio()%></td>
        <td width="20%" align="center" class="style2" style="color:#333333; font-size:12px"><%=fact.getmodelo()%></td>
        <td width="20%" align="center" class="style2" style="color:#333333; font-size:12px"><%=fact.getfecha_expedicion()%></td>
        <td width="20%" align="center" class="style2" style="color:#333333; font-size:12px"><%=fact.getsaldo_actual()%></td>
        <td width="20%" align="center" class="style2" style="color:#333333; font-size:12px"><%=fact.getfecha_lim_periodo_pago()%></td>
        <td width="20%" align="center" class="style2" style="color:#333333; font-size:12px"><%=fact.getobligaciones_vencidas()%></td>
        <td width="20%" align="center" class="style2" style="color:#333333; font-size:12px"><%=fact.getcomparendos()%></td>
        <td width="20%" align="center" class="style2" style="color:#333333; font-size:12px"><%=fact.getsaldos_a_favor()%></td>
        <td width="20%" align="center" class="style2" style="color:#333333; font-size:12px"><%=fact.getsaldos_en_contra()%></td>
        <td width="20%" align="center" class="style2" style="color:#333333; font-size:12px"><%=fact.gettotal_a_cancelar()%></td>
        <td width="20%" align="center" class="style2" style="color:#333333; font-size:12px"><%=ciudad_envio%></td>
        <td width="20%" align="center" class="style2" style="color:#333333; font-size:12px"><%=fact.getperiodo_de_pago()%></td>

    </tr>

     <% } %>

</table>

     
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