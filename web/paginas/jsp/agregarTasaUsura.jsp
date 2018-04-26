<%-- 
    Document   : agregarTasaUsura
    Created on : 10-nov-2017, 16:22:22
    Author     : acadrasco
--%>

<%@page import="java.util.Calendar"%>
<%@page import="modelo.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    try {
        if (session.getAttribute("model") != null) {
            if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                Model modelo = (Model) session.getAttribute("model");
                Calendar cal = Calendar.getInstance();
                int yearServer = cal.get(Calendar.YEAR);
                int dia = (cal.get(Calendar.DATE));
                int mes = (cal.get(Calendar.MONTH));

                String Tasa[][] = modelo.getIntereses();//recorre los registros de la tabla de intereses                
                String fechaFinal = Tasa[modelo.consultarMaxCodigo() - 1][1];//obtiene la fecha final del ultimo registro insertado en la tabla intereses
                String Interes = Tasa[modelo.consultarMaxCodigo() - 1][2];
                String vigenciaTasa = fechaFinal.substring(6);//obtengo la vigencia actual del ultimo registro de la tabla intereses
                int vigTasa = Integer.parseInt(vigenciaTasa);
                String month = fechaFinal.substring(0, 2); //obtengo el mes de la vigencia actual del ultimo registro de la tabla intereses
                int mesTasa = Integer.parseInt(month);


%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="../../estilos/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <script src="../../estilos/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>        
        <script src="../../estilos/js/jquery-3.2.1.js" type="text/javascript"></script>
        <script src="../html/scripts/motorAjax.js" type="text/javascript"></script>
        <link href="../../estilos/css/tasaUsura.css" rel="stylesheet" type="text/css"/>
        <script src="../../estilos/js/TasadeUsura.js" type="text/javascript"></script>
    </head>
    <body >

        <div class='centrar'>  
            <h4 align="center">Ingresar Tasa de Usura</h4>
            <%                if (yearServer == vigTasa && mesTasa <= 11) {
                    ///misma vigencia y el mes de la tasa es menor o igual a noviembre
            %>
            </br>
            <table width="100%" border="1">
                <tr>
                    <td><label for="vigencia">Vigencia:</label></td>
                    <td> <label for="Mes">Mes:</label></td>
                    <td><label>Tasa de Usura:</label></td>

                </tr>
                <tr>
                    <td><input type="text" name="vigencia" id="vigencia" readonly="readonly" value="<%=yearServer%>"></td>
                    <td><select id="Mes" name="Mes">
                            <option value="-1">Seleccione una opcion.......</option>
                            <option value="1">Enero</option>
                            <option value="2">Febrero</option>
                            <option value="3">Marzo</option>
                            <option value="4">Abril</option>
                            <option value="5">Mayo</option>
                            <option value="6">Junio</option>
                            <option value="7">Julio</option>
                            <option value="8">Agosto</option>
                            <option value="9">Septiembre</option>
                            <option value="10">Octubre</option>
                            <option value="11">Noviembre</option>
                            <option value="12">Diciembre</option>
                        </select></td>
                    <td><input type="text"  id="tasa" name="tasa" onkeypress="return soloNumeros(event)" ></td>

                </tr>    

            </table>
            </br>
            <input type="submit" id="submit" value="Guardar Tasa" class="btn btn-default"/>
            </br>
            <div id="respuesta">
                <h5 align="center">Ultima Tasa de usura: <%=fechaFinal%>, Tasa: <%=Float.parseFloat(Interes) * 100%> </h5>    
            </div>
            <%

            } else if (yearServer == vigTasa && mesTasa == 12) {
                //misma vigencia y la tasa de usura de diciembre ya diligenciada
            %>

            </br>
            <table width="100%" border="1">
                <tr>
                    <td><label for="vigencia">Vigencia:</label></td>
                    <td> <label for="Mes">Mes:</label></td>
                    <td><label>Tasa de Usura:</label></td>

                </tr>
                <tr>
                    <td><input type="text" name="vigencia" id="vigencia" readonly="readonly" value="<%=(yearServer + 1)%>"></td>
                    <td><select id="Mes" name="Mes">
                            <option value="-1">Seleccione una opcion.......</option>
                            <option value="1">Enero</option>

                        </select></td>
                    <td><input type="text"  id="tasa" name="tasa" onkeypress="return soloNumeros(event)" ></td>

                </tr>    

            </table>
            </br>
            <input type="submit" id="submit" value="Guardar Tasa" class="btn btn-default"/>




            </br>
            <div id="respuesta">
                <h5 align="center">Ultima Tasa de usura: <%=fechaFinal%>, Tasa: <%=Float.parseFloat(Interes) * 100%> </h5>    
            </div>

            <%} else if (yearServer > vigTasa) {
                ///vigencia del servidor menor que la de la tasa de usura.
            %>

            </br>
            <table width="100%" border="1">
                <tr>
                    <td><label for="vigencia">Vigencia:</label></td>
                    <td> <label for="Mes">Mes:</label></td>
                    <td><label>Tasa de Usura:</label></td>

                </tr>
                <tr>
                    <td><input type="text" name="vigencia" id="vigencia" readonly="readonly" value="<%=yearServer%>"></td>
                    <td><select id="Mes" name="Mes">
                            <option value="-1">Seleccione una opcion.......</option>
                            <option value="1">Enero</option>
                            <option value="2">Febrero</option>
                            <option value="3">Marzo</option>
                            <option value="4">Abril</option>
                            <option value="5">Mayo</option>
                            <option value="6">Junio</option>
                            <option value="7">Julio</option>
                            <option value="8">Agosto</option>
                            <option value="9">Septiembre</option>
                            <option value="10">Octubre</option>
                            <option value="11">Noviembre</option>
                            <option value="12">Diciembre</option>
                        </select></td>
                    <td><input type="text"  id="tasa" name="tasa" onkeypress="return soloNumeros(event)" ></td>

                </tr>    

            </table>
            </br>
            <input type="submit" id="submit" value="Guardar Tasa" class="btn btn-default"/>




            </br>

            <div id="respuesta">
                <h5 align="center">Ultima Tasa de usura: <%=fechaFinal%>, Tasa: <%=Math.round(Float.parseFloat(Interes) * 100)%> </h5>    
            </div>





            <%}%>


        </div>    

    </body>
</html>
<%  } else { %>
<jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="1"></jsp:param>
</jsp:forward>
<%  }
} else { %>
<script>
    window.parent.document.location.href = "../../index.jsp";
</script>  <%
    }
} catch (Exception mexe) {%>
<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
    }%>