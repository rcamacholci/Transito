<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="java.util.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("consultarDatosPersona.jsp")){
                     Model modelo = (Model)session.getAttribute("model");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style type="text/css">
<!--
.Estilo3 {font-size: 12px; color: #FFFFFF; }
.Estilo4 {
	color: #333333;
	font-weight: bold;
	font-size: 12px;
}
-->
        </style>
		<script language="javascript" type="text/javascript">

			function sombrear(tr){
				tr.style.backgroundColor = "#CCCCCC";
			}
			function renovar(tr){
				tr.style.backgroundColor = "#FFFFFF";
			}

                        function datosVehiculo(tr){
                            var nplaca = tr.id;
                            window.location.href = "verDatosVehiculo.jsp?id=0&placa="+nplaca;
			}






		</script>

</head>
    <body>
	<fieldset><div align="center">
		    <legend class="Estilo4"  align="center">DATOS DEL VEHICULO</legend>
		  	</div>
            <table width="100%" border="1" cellpadding="1" align="center" cellspacing="0">
                <tr style="background:url(../html/images/inicio_3.png); border:none">
                <th width="20%" style="border:none" scope="col"><span class="Estilo3">PLACA</span></th>
                <th width="20%" style="border:none" scope="col"><span class="Estilo3">SERIE</span></th>
                <th width="20%" style="border:none" scope="col"><span class="Estilo3">MOTOR</span></th>
                <th width="20%" style="border:none" scope="col"><span class="Estilo3">CHASIS</span></th>
                 <th width="20%" style="border:none" scope="col"><span class="Estilo3">VIN</span></th>
              </tr>
              <%
            String motor="";
            String chasis="";
            String vin="";
            String serie="";
            String placa = "";
            String mensaje ="";


     try{
	    if(request.getParameter("opcion").equals("1")){
                    if(request.getParameter("motor")!=null){
                         motor = request.getParameter("motor");
                         placa = modelo.consultarPlacaVehiculoMotorChasisSerieVin(19,motor);
                    }
            }

            if(request.getParameter("opcion").equals("2")){
                if(request.getParameter("chasis")!=null){
                         chasis = request.getParameter("chasis");
                         placa = modelo.consultarPlacaVehiculoMotorChasisSerieVin(20,chasis);
                    }
            }
             if(request.getParameter("opcion").equals("3")){
                if(request.getParameter("serie")!=null){
                         serie = request.getParameter("serie");
                         placa = modelo.consultarPlacaVehiculoMotorChasisSerieVin(21,serie);
                    }
            }
             if(request.getParameter("opcion").equals("4")){
                if(request.getParameter("vin")!=null){
                         vin = request.getParameter("vin");
                         placa = modelo.consultarPlacaVehiculoMotorChasisSerieVin(25,vin);
                    }
            }


            if(placa!=null){
                java.util.HashMap especif = modelo.listarEspecificacionesVehiculo(placa.toUpperCase());
                    if(especif!=null){
  %>
                         <tr id="<%=placa%>"  bgcolor="#FFFFFF"  style="cursor:pointer;"  onclick="datosVehiculo(this)" onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
                        <td><div align="center"><span class="Estilo4"><%=placa%></span></div></td>
                        <td><div align="center"><span class="Estilo4"><%=especif.get("21")!=null?especif.get("21"):""%></span></div></td>
                        <td><div align="center"><span class="Estilo4"><%=especif.get("19")!=null?especif.get("19"):""%></span></div></td>
                        <td><div align="center"><span class="Estilo4"><%=especif.get("20")!=null?especif.get("20"):""%></span></div></td>
                        <td><div align="center"><span class="Estilo4"><%=especif.get("25")!=null?especif.get("25"):""%></span></div></td>
                        </tr>
            <%
                    }
                  
                }else{
                mensaje = "No se encontraron Registros";
           }
   }catch(Exception exc){
       exc.printStackTrace();
   }

        if(!mensaje.equals("")){
            %>
            <script>
            alert("No se encontraron Registros");
            </script>
            <%
        }
%>
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