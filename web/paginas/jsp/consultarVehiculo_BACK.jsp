<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  errorPage="" %>
<%
            try {
                if (session.getAttribute("model") != null) {
                    if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
%>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Vehiculo</title>
        <style type="text/css">
            <!--
            .Estilo4 {
                font-weight: bold;
                font-family: "Times New Roman", Times, serif;
                color: #FFFF99;
                font-size:12px;
            }
            -->

        </style>
        <!-- filter: alpha(opacity=85);-moz-opacity:0.85; -->
        <META http-equiv=Content-Type content="text/html; charset=windows-1252">
        <LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <link rel="stylesheet" type="text/css" href='../html/css/style.css' />
       <!-- <SCRIPT SRC="../html/scripts/ssm.js" language="JavaScript1.2"></SCRIPT>
        <SCRIPT SRC="../html/scripts/ssmItems.js" language="JavaScript1.2"></SCRIPT> !-->
        <script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js"ol type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <script language="javascript" type="text/javascript">
            function consultarPlacas(){
                if(document.form.placa.value.length>=1&&document.form.placa.value.length<=6){
                    var nplaca = document.form.placa.value;
                    document.form.placax.value = document.form.placa.value;
                    window.frames[0].location.href = "datosVehiculo.jsp?id=0&placa="+nplaca;
                    document.form.action = "datosVehiculo.jsp?id=0&placa="+nplaca;
                    return true;
                }else{
                    alert("Digite un numero de placa correcta");
                    return false;
                }
            }
            function obtener(){
                document.form.placa.focus();
            }
        </script>
        <STYLE>
            <!--
            A.ssmItems:link		{color:black;text-decoration:none}
            A.ssmItems:hover	{color:black;text-decoration:none}
            A.ssmItems:active	{color:black;text-decoration:none}
            A.ssmItems:visited	{color:black;text-decoration:none}
            .style3 {font-size: 12px; font-family: Tahoma; }
            .style6 {color: #333333; font-size: 12px; font-weight: bold; }
            .Estilo32 {
                color: #FFFFFF;
                font-weight: bold;
                font-size: 12px;
            }
            -->
        </STYLE>
    </head>
    <body onLoad="obtener()"> 
        <table width="100%" border="0" align="center">		
            <tr valign="middle">
                <th height="50" colspan="2" scope="col">
                    <form action="" method="post" name="form" target="vehiculo" class="style3" id="form" onSubmit="return consultarPlacas()">

                        <fieldset>


                            <table width="100%" border="0">
                                <tr style="border:none; background:url(../html/images/inicio_3.png)">
                                    <td colspan="11" align="center" class="title_">CONSULTA DE VEHICULO</td>
                                </tr>
                                <tr>
                                <input type="hidden" id="placax" value=""/>
                                <th width="35%" scope="col"><label style="color:#CC0000"></label></th>
                                <th width="7%" scope="col"><label style="color:#CC0000"><span class="style6">PLACA</span></label>                              </th>
                                <th width="16%" scope="col"> <input id="placa" name="placa" type="text" maxlength="6" style="text-align:center;color:#333333; font:bold; text-transform:uppercase; width:150px"/></th>
                                <th width="7%" scope="col"><input id="consultarPlaca"  name="consultarPlaca" type="button" value="Consultar" class="boton_"  onclick="consultarPlacas()" /></th>
                                <th width="35%" scope="col">&nbsp;</th>
                                </tr>
                            </table>
                        </fieldset>
                    </form>                </th>
            </tr>
            <tr valign="top">
                <th height="469" colspan="4" class="Estilo4" scope="col" valign="top">
                    <iframe src="#" id="vehiculo" name="vehiculo" marginwidth="0" height="900" width="100%" marginheight="0" align="top"  style="border:none" frameborder="0"></iframe>
                </th>
            </tr>
        </table>
    </body>
</html>
<%  } else {%>
<jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="1"></jsp:param>
</jsp:forward>
<%  }
        } else {%>
<script>
    window.parent.document.location.href = "../../index.jsp";
</script>  <%    }
} catch (Exception mexe) {
mexe.printStackTrace();
%>

<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
            }%>