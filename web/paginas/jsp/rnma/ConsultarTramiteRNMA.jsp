<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <%
        try {
            if (session.getAttribute("model") != null) {
               // if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                if(1==1){
                    Parametro parametro = new Parametro();
                    Model modelo = (Model) session.getAttribute("model");
    %>    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Documento sin t&iacute;tulo</title>
    </head>

 <link rel=stylesheet href="../../html/css/Style.css" type="text/css" media=screen>
 <script type="text/javascript" src="../../html/scripts/motorAjax.js"></script>
        <script type="text/javascript" >
            function Consultar() {
                if (document.form.txtdocumento.value.length > 0) {
                    window.frames['trg'].location.href = "TramitesPermitidos.jsp";
                }
            }
                function Validar() {
                    var numero= document.getElementById("txtnumeromaquinaria").value;
                    ajax3 = new nuevoAjax();
                    ajax3.open("POST", "EvaluarDatos.jsp", true);
                    ajax3.onreadystatechange = function () {
                        if (ajax3.readyState == 4) {
                            if (ajax3.responseText.indexOf("existe") == -1) {
                                document.form.submit();
                                return true;
                            } else {
                                alert(ajax3.responseText);
                                return false;
                            }
                        }
                    }
                    ajax3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                    ajax3.send("registro=" + numero + "&opcion=2");
                }

        </script>
    <body>
        <form name="form" id="form" method="post" action="FormularioRNMA.jsp">
            <table align="center" border="0" cellpadding="1" width="70%">
                <tr align="center">
                    <td width="16%" class="label">No Maquinaria</td>
                    <td width="17%" class="text"><input type="text" maxlength="9" name="txtnumeromaquinaria" id="txtnumeromaquinaria" value="<%=request.getParameter("txtnumeromaquinaria")!=null?request.getParameter("txtnumeromaquinaria"):"" %>" /></td>
                    <td width="23%" class="label">Tipo&nbsp;Documento</td>
                    <td width="13%" class="select">
                        <select name="cmdtipodocumento" id="cmdtipodocumento" style="width:auto">
                            <%
                                long fk_grupo = 5;
                                java.util.List listaTipos = modelo.listadoParametros(fk_grupo);
                                for (int i = 0; i < listaTipos.size(); i++) {
                                    parametro = (Parametro) listaTipos.get(i);%>
                            <option value="<%=parametro.getCodigo()%>"><%=parametro.getNombre()%></option>
                            <%  }  %>
                        </select>                    </td>
                    <td width="16%" class="label">Documento</td>
                    <td width="17%" class="text"><input type="text" name="txtdocumento" id="txtdocumento" /></td>
                    <td width="31%" align="center" class="text"><input type="button" value="Consultar" onclick="Consultar()" /></td>
                </tr>
                <tr>
                    <td colspan="3" valign="top">
                        <fieldset>
                            <legend class="text">Tramites permitidos</legend>
                            <iframe name="trg" id="trg" src="#" width="100%" height="400" scrolling="auto" frameborder="0"></iframe>
                        </fieldset>                    </td>
                    <td colspan="5" valign="top" style="display: ">
                        <fieldset>
                            <legend class="text">Tramites Seleccionados</legend>
                            <iframe name="trget" id="trget" src="#" width="100%" height="400" scrolling="auto" frameborder="0" ></iframe>
                        </fieldset>                    </td>
                </tr>
                <tr>
                    <td colspan="6">&nbsp;</td>
                    <td width="50%" align="center">
                        <input type="button" name="limpiar" value="Limpiar" onClick="limpiarSeleccion()"/>                    </td>
                    <td width="50%" align="center">
                        <input type="button" name="enviar" onclick="Validar()" value="Enviar Tramites"/>                    </td>
                </tr>
            </table>
        </form>

    </body>
    <%  } else { %>
    <jsp:forward page="no_access.jsp">
        <jsp:param name="tipo" value="1"></jsp:param>
    </jsp:forward>
    <%  }
        } else { %>
    <script>
        window.parent.document.location.href = "../../../index.jsp";
    </script>  <%
        }
    } catch (Exception mexe) {%>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
    <%
    }%>
</html>
