<%--
    Document   : visualizarCarpeta
    Created on : 25/01/2011, 12:34:04 PM
    Author     : Administrador
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%
            try {
                if (session.getAttribute("usuario") != null) {
                    modelo.Model model = (modelo.Model) session.getAttribute("model");
                    if (model != null) {
                        modelo.Usuario usuario = (modelo.Usuario) session.getAttribute("usuario");
                        if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                        String placa = session.getAttribute("placa") + "";
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>VISOR DE IMAGENES</title>

        <script type="text/javascript" language="javascript">
            var retardo_rotacion = 6000
            //indice imagen inicial
            actual = 0

            //ir a la siguiente imagen
            function siguiente() {
                if (document.formulario.imagen[actual+1]) {
                    document.images.visor.src = document.formulario.imagen[actual+1].value
                    document.formulario.imagen.selectedIndex = ++actual
                }
                else inicio()
            }

            //ir a la imagen anterior
            function anterior() {
                if (actual-1 >= 0) {
                    document.images.visor.src = document.formulario.imagen[actual-1].value
                    document.formulario.imagen.selectedIndex = --actual
                }
                else ultimo()
            }

            //ir a la primera imagen
            function inicio() {
                actual = 0
                document.images.visor.src = document.formulario.imagen[0].value
                document.formulario.imagen.selectedIndex = 0
            }

            //ir a la ultima imagen
            function ultimo() {
                actual = document.formulario.imagen.length-1
                document.images.visor.src = document.formulario.imagen[actual].value
                document.formulario.imagen.selectedIndex = actual
            }

            //cambia a modo reproduccion automatica
            function repAuto(text) {
                document.formulario.automatico.value = (text == "Detener") ? "Reproducir" : "Detener"
                reproducir()
            }


            function cambiaLista() {
                actual = document.formulario.imagen.selectedIndex
                document.images.visor.src = document.formulario.imagen[actual].value
            }

            //realiza reproduccion atuomatica
            function reproducir() {
                if (document.formulario.automatico.value == "Detener") {
                    actual = (actual == document.formulario.imagen.length-1) ? 0 : actual+1
                    document.images.visor.src = document.formulario.imagen[actual].value
                    document.formulario.imagen.selectedIndex = actual
                    window.setTimeout("reproducir()", retardo_rotacion)
                }
            }

            function AgregarImagenes(){
                
                document.location.href = "AgregarImgVehiculo.jsp?placa="+"<%=placa%>";
            }
            
        </script>

        <style type="text/css">
            <!--
            .style1 {
                font-family: Arial, Helvetica, sans-serif;
                color: #006699;
                font-size: 14px;
                font-weight: bold;
            }
            -->
        </style>
    </head>
    <body>
        <form name="formulario" method="post" action="">

            <p style="position:absolute; left:1069px; top: -15px;"><img src="../html/images/agregar.png" style="cursor:pointer" onclick="AgregarImagenes()" alt="Agregar Imagenes" width="40" height="40"></p>
                <p style="position:absolute; left:1110px; top: -8px; width: 114px;">Agregar Imagenes</p>
                <table cellspacing=1 cellpadding=4 bgcolor="#ffffff" align="center" width="70%">
               
			   <tr>
			   		<td>&nbsp;</td>
			   </tr>
			   <tr>
			   		<td>&nbsp;</td>
			   </tr>
			  
			   
                <tr>
                    <td align=center bgcolor="white">
                    <div align="center"><span class="style1">VISOR DE IMAGENES </span>                        </div></td>
                </tr>
                <tr>
                    <td align=center bgcolor="white" width="100%" height="400px">
                        <img src="#" name="visor" alt="" width="500px" height="400px" border=0  border=1 style="border-color: 777777">
                        <div align="center"></div></td>
                </tr>
                <%
                
                            if (placa != null) {
                                modelo.Vehiculo vehiculo = model.consultarVehiculo(placa.toUpperCase().trim());
                                if (vehiculo != null) {
                                    java.util.List<modelo.DigitalCarpeta> lista = model.consultarImagenesVehiculo(vehiculo.getId_vehiculo());
                                    if(lista.size()==0)
                                        lista = model.actualizarImagenesVehiculo(vehiculo.getId_vehiculo());
                                    if (lista.size() > 0) {%>
                                  

                                    <tr bgcolor="#006699">
                    <td align=center>
                        <div align="center">
                          <select name="imagen" onChange="cambiaLista();" style=" font-family:Arial, Helvetica, sans-serif; font-weight:bold; width:300px">
                            <% for (int i = 0; i < lista.size(); i++) {
                                modelo.DigitalCarpeta digitalCarpeta = lista.get(i);%>
                            <option value="<%=digitalCarpeta.getDireccion()%>"><%=digitalCarpeta.getNombre()%></option>
                              <% }%>
                          </select>
                        </div></td>
                </tr>
                <tr bgcolor="#006699">
                    <td align=center>
                        <div align="center">
                          <input type=button onClick="inicio();" value="|<<" title="Inicio">
                          <input type=button onClick="anterior();" value="<<" title="Anterior">
                          <input type=button name="automatico" onClick="repAuto(this.value);" value="Reproducir" title="Reproducción automática">
                          <input type=button onClick="siguiente();" value=">>" title="Siguiente">
                          <input type=button onClick="ultimo();" value=">>|" title="Ultimo">
                        </div></td>
                </tr>
                <%       }
                                 }
                             }
                %>
            </table>
        </form>
    </body>
</html>
<%        } else {%>
                <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="1"></jsp:param></jsp:forward>
<%        }
       } else {%>
            <script type="text/javascript">window.parent.document.location.href = "../../index.jsp";</script>
<%    }
    } else {%>
        <script type="text/javascript">window.parent.document.location.href = "../../index.jsp";</script>
<% }
} catch (Exception mexe) {
   mexe.printStackTrace();  %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<% }%>
