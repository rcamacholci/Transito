<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Adicionar Agente</title>
        <style type="text/css">
            <!--
            .label {font-size: 11px; color:#666666; text-align:left ; font-family:Arial; font-weight:bold ; width:110px}
            .text {font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold ; width:120px; text-transform:uppercase}
            .check { font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold; }
            -->
        </style>
        <script language="javascript" type="text/javascript">

            function revisar(){
                if(document.form.nombre.value.length >0){
                    if(document.form.placa.value.length >0){
                        document.form.submit();
                    }else{
                        alert("Favor digite placa del agente");
                    }
                }else{
                    alert("Favor digite nombre del agente");
                }
            }

        </script>
    </head>
    <body>
        <div align="center" style="width:360px">
            <div style="width:360px" align="center">
                <form name="form" id="form" method="post" action="procesarAgente.jsp">
                    <fieldset>
                        <table width="350px" border="0" align="center" >
                            <tr>
                                <td colspan="2" align="center"><div align="center" class="text">ADICIONAR AGENTE</div></td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="label">Numero de Placa</td>
                                <td align="left"><input name="placa" id="placa" class="text" type="text" value="<%=request.getParameter("placa")%>" readonly style="width:100px"/></td>
                            </tr>
                            <tr>
                                <td class="label">Nombre del Agente</td>
                                <td align="left"><input name="nombre"  id="nombre" class="text" type="text" style="width:250px"/></td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="2" align="center">
<button name="adicionar" type="button" id="adicionar" class="check" onclick="revisar()"><span class="styl2">Adicionar Agente </span><img src="../html/images/adicionar.png" width="18" height="18" /></button>								
<!--<input name="adicionar" align="center" type="button" id="adicionar" value="Adicionar Agente" class="check" style="width:150px; text-align:center" onclick="revisar()"/>-->
                                </td>
                            </tr>

                        </table>
                    </fieldset>
                </form>
            </div>
        </div>
    </body>
</html>
