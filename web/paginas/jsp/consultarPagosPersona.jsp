<%-- 
    Document   : consultar_pagos_persona
    Created on : 9/03/2010, 10:41:31 AM
    Author     : Jorge Lopez
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8" import="modelo.*,java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
                       modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel=StyleSheet href="../html/css/msj.css" type="text/css" media=screen>
        <script type="text/javascript" src="../html/scripts/pagos.js"></script>
<script type="text/javascript" src="../html/scripts/motorAjax.js"></script>
    <style type="text/css">
<!--
.style1 {
	font-family: Tahoma;
	font-size: 12px;
	color: #333333;
}
.style2 {color: #333333}
.style9 {font-family: Tahoma; font-size: 12px; font-weight: bold; color: #333333; }
.style11 {font-family: Tahoma; font-size: 12px; color: #FFFFFF; }
-->
    </style>
    </head>
    <body>

        <%
        Model modelo = (Model)session.getAttribute("model");
        long fk_persona = 0;


        %>
		
		<fieldset>
 			<div align="center">
  			 <legend class="style2 style1" align="center"><strong>LISTA DE PAGOS</strong></legend>
 			</div>
		
		
        <table  width="100%"border="1" cellpadding="1" cellspacing="0">
            <thead>
                <tr bgcolor="#CCCCCC" style="border:none; background:url(../html/images/inicio_3.png)">
                    <th width="10%" style="border:none"><span class="style11">Nº&nbsp;FACTURA</span></th>
                    <th  width="25%" style="border:none"><span class="style11">FECHA</span></th>
                    <th  width="15%" style="border:none"><span class="style11">VALOR&nbsp;TOTAL</span></th>
                    <th width="15%" style="border:none"><span class="style11">TIPO&nbsp;PAGO</span></th>
                    <th width="15%" style="border:none"><span class="style11">ESTADO</span></th>
                    <th width="15%" style="border:none"><span class="style11">VEHICULO</span></th>
                    <th width="15%" style="border:none"><span class="style11">USUARIO</span></th>
              </tr>
            </thead>
            <tbody>
                

        <%


try{
    if(session.getAttribute("id_persona")!=null)
        fk_persona=Long.parseLong(session.getAttribute("id_persona").toString());
    else fk_persona = 0;
        LinkedList<Pago> ListaPagos = modelo.consultarPagosPersona(fk_persona);
        java.util.HashMap tiposFact = modelo.crearHashParametros(301);
        java.util.HashMap estadosFact = modelo.crearHashParametros(19);

        if(ListaPagos!=null){
        int inx =0;
        for(Pago pago : ListaPagos){
            String tipoPago = tiposFact.get(pago.getTipo_pago()+"").toString();
            String Estado = estadosFact.get(pago.getEstado()+"").toString();
            
            Vehiculo vehiculo = modelo.consultarVehiculoById(pago.getFk_vehiculo());
            String placa = vehiculo!=null?vehiculo.getPlaca():"";
            usuario = modelo.consultarUsuario(pago.getFk_usuario());
            Tiquete tiquete = modelo.consultarTiquetePorID(pago.getFk_tiquete());
            %>
            <tr bgcolor="#FFFFFF" ondblclick="DetallePago(<%=inx%>, '<%=pago.getFk_tiquete()%>')">
                <td align="center"><span class="style9"><%=pago.getNumero_factura() %></span></td>
                <td align="center"><span class="style9"><%=new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(tiquete.getFecha_proceso())%></span></td>
                <td align="right"><span class="style9"><%=pago.getValor_total()%></span></td>
                <td><span class="style9"><%=tipoPago%></span></td>
                <td align="center"><span class="style9"><%=Estado%></span></td>
                <td align="center"><span class="style9"><%=placa%></span></td>
                <td align="left"><span class="style9"><%=usuario.getNombre() %></span></td>
            </tr>
            <tr id="detPago<%=inx%>" style="display:none; height:0px">
                  <td colspan="7">
                      <div class="box">

                                    <!--- box border -->
                                    <div class="lb">
                                    <div class="rb">
                                    <div class="bb"><div class="blc"><div class="brc">
                                    <div class="tb"><div class="tlc"><div class="trc">
                                    <!--  -->
                                    <div id="detallePago<%=inx%>" class="content"></div>
                       <!--- end of box border -->
                                    </div></div></div></div>
                                    </div></div></div></div>
                                    <!-- -->
                    </div>                  </td>
              </tr>


                <%

                inx++;


        }

        if(inx==0){
            %>
			 <script>
			 alert("NO HAY PAGOS REGISTRADOS");
			 </script>
           
              <%
        }
        }else{
            %>
			 <script>
			 alert("NO HAY PAGOS REGISTRADOS");
			 </script>
          
              <%
			  
        }

}catch(Exception e){
   // out.print(e.toString());

}


%>
            </tbody>
    </table>
	</fieldset>
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