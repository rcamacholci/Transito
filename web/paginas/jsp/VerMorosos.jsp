<%-- 
    Document   : VerMorosos
    Created on : 7/06/2016, 12:43:35 PM
    Author     : Jcarreno
--%>

<%@page import="modelo.Deudores"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    response.setContentType("application/vnd.ms-excel"); //Tipo de fichero.
    response.setHeader("Content-Disposition", "attachment;filename=\"Deudores Morosos.xls\"");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form  >
            <%try {
                    modelo.Model model = (modelo.Model) session.getAttribute("model");
                    modelo.Usuario usuario = (modelo.Usuario) session.getAttribute("usuario");
                    modelo.Persona persona = model.consultarPersona(usuario.getFk_persona());
                    String nombreU = persona.getNombre_1() + " " + persona.getApellido_1() + " " + (persona.getApellido_2() != null ? persona.getApellido_2() : "");
                    String fecha = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());
                    Long deuda = Long.parseLong(request.getParameter("periodo"));
            %>
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

                    <td width="20%" style="border:none" align="center" class="style1" style="color:#000000">TIPO_DOCUMENTO</td>
                    <td width="20%" style="border:none" align="center" class="style1" style="color:#000000">DOCUMENTO</td>
                    <td width="20%" style="border:none" align="center" class="style1" style="color:#000000">NOMBRES</td>
                    <td width="20%" style="border:none" align="center" class="style1" style="color:#000000">APELLIDO_1</td>
                    <td width="20%" style="border:none" align="center" class="style1" style="color:#000000">APELLIDO_2</td>
                    <td width="20%" style="border:none" align="center" class="style1" style="color:#000000">DIRECCION</td>
                    <td width="20%" style="border:none" align="center" class="style1" style="color:#000000">CIUDAD</td>
                    <td width="20%" style="border:none" align="center" class="style1" style="color:#000000">TELEFONO</td>
                    <td width="20%" style="border:none" align="center" class="style1" style="color:#000000">DEUDA</td>
                </tr>
                <%
                    java.util.List<Deudores> temp = model.ListDeudores(deuda);
                    System.err.println(">>>> " + temp.size());
                    for (Deudores deu : temp) {%>
                <tr >
                    <td width="20%" style="border:none" align="center" class="style1" ><%=deu.getTDocumento()%></td>
                    <td width="20%" style="border:none" align="center" class="style1" ><%=deu.getDocumento()%></td>
                    <td width="20%" style="border:none" align="center" class="style1" ><%=deu.getNombre()%></td>
                    <td width="20%" style="border:none" align="center" class="style1" ><%=deu.getApeliido1()%></td>
                    <td width="20%" style="border:none" align="center" class="style1" ><%=deu.getApellido2()%></td>
                    <td width="20%" style="border:none" align="center" class="style1" ><%=deu.getDirreccion()%></td>
                    <td width="20%" style="border:none" align="center" class="style1" ><%=deu.getCiudad()%></td>
                    <td width="20%" style="border:none" align="center" class="style1" ><%=deu.getTelefono()%></td>
                    <td width="20%" style="border:none" align="center" class="style1" ><%=deu.getDeuda()%></td>
                </tr>            
                <%
                    }
                %>
            </table>
            <script type="text/javascript"  language="javascript">
                window.parent.document.getElementById("Generar").disabled = false;
                window.parent.document.getElementById("Generar").value = "Generar";
            </script>
            <%} catch (Exception exc) {
                    exc.printStackTrace();
                }%>
        </form>
    </body>
</html>
