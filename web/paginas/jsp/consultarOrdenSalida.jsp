<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="java.util.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%

                     Model modelo = (Model)session.getAttribute("model");
                      modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
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
.style2 {font-weight: bold; color: #333333;}
.style3 {font-size: 11px}
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

              function GenerarReporte(){
                //document.form.motor.value
                ancho = 789;
                alto = 250;
                barra = 0;
                izquierda = (document.width) ? (document.width-ancho)/2 : 100;
                arriba = (document.height) ? (document.height-alto)/2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + 			ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                var dir = "certificados/OrdenSalida.jasper";
                var nombre = "ordenSalida";
                url = "verReportes.jsp?nombreReporte="+nombre+"&dirReporte="+dir;
                window.open(url, 'popUp', opciones);
            }
	</script>

</head>
    <body>
	<fieldset><div align="center">
		    <legend class="Estilo4"  align="center">DATOS DEL VEHICULO</legend>
		  	</div>
            <table width="100%" border="1" cellpadding="1" align="center" cellspacing="0">
                <tr style="background:url(../html/images/inicio_3.png); border:none">
                <th width="10%" style="border:none" scope="col"><span class="Estilo3">COMPARENDO</span></th>
                <th width="30%" style="border:none" scope="col"><span class="Estilo3">FECHA&nbsp;INMOVILIZACION</span></th>
                <th width="15%" style="border:none" scope="col"><span class="Estilo3">PLACA</span></th>
                <th width="15%" style="border:none" scope="col"><span class="Estilo3">PATIO </span></th>
                <th width="15%" style="border:none" scope="col"><span class="Estilo3">FECHA&nbsp;DE&nbsp;SALIDA</span></th>
                <th width="15%" style="border:none" scope="col"><span class="Estilo3">AUTORIZADO</span></th>
                </tr>
              <%
       

            COMPARENDO_PATIO comparendoP = new COMPARENDO_PATIO();
            Comparendo cprendo = null;
            String mensaje = "";
            String numComp = "";

     try{
	     if((request.getParameter("numero")!=null)&&(!request.getParameter("numero").isEmpty())){
                 comparendoP = modelo.consultarComparendoPatioByNumeroSalida(request.getParameter("numero"));
                 if(comparendoP!=null){
                     if(comparendoP.getESTADO()==2){
                         cprendo = modelo.consultarComparendoById(comparendoP.getFK_COMPARENDO());
                         if(cprendo!=null){
                             Patio patio = modelo.consultarPatioById(comparendoP.getFK_PATIO());
                             HashMap parameters = new java.util.HashMap();
                             parameters.put("NUMERO",request.getParameter("numero"));
                             session.setAttribute("ordenSalida", parameters);
        %>
                <tr id=""  bgcolor="#FFFFFF"  style="cursor:pointer;"  onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
                <td><div align="center" class="style3"><span class="style2"><%=cprendo.getNumero()%></span></div></td>
                <td><div align="center" class="style3"><span class="style2"><%=cprendo.getFecha()%></span></div></td>
                <td><div align="center" class="style3"><span class="style2"><%=comparendoP.getPLACA()%></span></div></td>
                <td><div align="center" class="style3"><span class="style2"><%=patio.getNombre()%></span></div></td>
                <td><div align="center" class="style3"><span class="style2"><%=comparendoP.getFECHA_SALIDA() %></span></div></td>
                <td><div align="center" class="style3"><span class="style2"><%=comparendoP.getNOMBRE_AUTORIZADO()%></span></div></td>
                </tr>
                </table>
                <table width="100%" border="0"  align="center" >
                <tr>
                <td colspan="6" align="center"><input id="generar"  name="generar" type="button" value="Generar" style="color:#333333; width:100px" onClick="GenerarReporte()"/></td>
                </tr>
                </table>
            
            <%              }else{
                             mensaje = "Error al consultar el comparendo";
                            }
                         }else{
                             mensaje = "No hay Orden de Salida asociada a ese Numero";
                         }
                  }else{
                      mensaje = "No se encontraron registros";
                  }
             }else{
                mensaje = "Error : No se pudo generar el documento";
             }
        
                 
   }catch(Exception exc){
       exc.printStackTrace();
   }

        if(!mensaje.equals("")){
            %>
            <script>
			alert("No se encontraron Documentos Para Imprimir");
		</script>
       <%  
        }
%>
         
    </fieldset>
    </body>
</html>

