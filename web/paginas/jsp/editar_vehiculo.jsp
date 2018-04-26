<%-- 
    Document   : editar_vehiculo
    Created on : 23-feb-2010, 10:56:07
    Author     : Jorge Lopez
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="editarDatosVehiculo.jsp" target="consulta" method="get">
            <table align="center">
                <tr>
                    <th>Placa</th>
                    <td>
                        <input name="placa" type="text" >
                        <input name="id" type="hidden" value="0">
                    </td>
                    <td>
                        <input type="submit" value="Consultar">
                    </td>
                </tr>
            </table>

        </form>
        <iframe name="consulta" frameborder="0" width="100%" height="600px" ></iframe>
    </body>
</html>
