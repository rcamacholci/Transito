<%@ page  import = "modelo.*" import = "java.util.*" import = "java.sql.*"    %>
<html>
  <head>
      <title>&nbsp;</title>
        <style type="text/css">
        <!--
.style1 {color: #333333; font-size: 12px; font-weight: bold; }
.style2 {
	color: #FF0000;
	font-weight: bold;
	font-size: 11px;
}
.Estilo14 {
	color: #FFFFFF;
	font-size: 12px;
}
.Estilo18 {font-family: Tahoma}
.Estilo19 {color: #333333; font-size: 12px; font-weight: bold; font-family: Tahoma; }
        -->
        </style>
    <script language="javascript" type="text/javascript">
        function verificar(){
            if(document.form1.anterior.value.length>0){
                if(document.form1.nuevo.value.length>0){
                    if(document.form1.nuevo2.value.length>0){
                        if(document.form1.nuevo.value==document.form1.nuevo2.value){
                            document.form1.action = "procesarPassword.jsp";
                            document.form1.submit();
                        }else{
                            alert("El password nuevo no coincide con la repeticion, verifique");
                        }
                    }else{
                        alert("Repita el password nuevo");
                    }
                }else{
                    alert("Digite el password nuevo");
                }
            }else{
                alert("Digite el password anterior");
            }
        }
    </script>
</head>
<%
Model model = (Model) session.getAttribute("model");
if(model!=null){
    Sede sede = (Sede) session.getAttribute("sede");
    Usuario usuario = (Usuario)session.getAttribute("usuario");
    %>
    <body>
        <form id="form1" name="form1" method="post" action="javascript:verificar()">
            <table width="40%" border="0" align="center">
                <tr>
                    <td colspan="2" valign="top" align="center">
                        <fieldset>
                            
                                <table width="73%" border="0" align="center">
								<tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="11" align="center"><span class="style2 style14 Estilo14"><span class="style14  Estilo18">CAMBIO DE PASSWORD USUARIOS</span></span></td>
		  </tr>
                              <tr>
                                <td width="56%">&nbsp;</td>
                                <td width="44%">&nbsp;</td>
                              </tr>
                              <tr>
                                    <td><span class="style1 Estilo18">NOMBRE&nbsp;USUARIO</span></td>
                                    <td><input name="usuario" type="text" id="usuario" style="width:150px;font-weight:bold; text-align:center" value="<%=usuario.getNombre()%>" readonly /></td>
                                  </tr>
                              <tr>
                                <td><span class="Estilo19">PASSWORD&nbsp;ANTERIOR </span></td>
                                <td><input name="anterior" type="password" id="anterior" style="width:150px; font-weight:bold; text-align:center" value=""/></td>
                              </tr>
                              <tr>
                                <td><span class="Estilo19">PASSWORD&nbsp;NUEVO </span></td>
                                <td><input name="nuevo" id="nuevo" type="password" value="" style="width:150px; font-weight:bold; text-align:center"/></td>
                              </tr>
                              <tr>
                                <td><span class="Estilo19">REPETIR&nbsp;PASSWORD </span></td>
                                <td><input name="nuevo2" id="nuevo2" type="password" value="" style="width:150px;font-weight:bold; text-align:center"/></td>
                               </tr>
                              <tr>
                              <td colspan="2" valign="top">&nbsp;                                               </td>
                              </tr>
                               <tr>
                                    <td align="center" colspan="2"><input type="submit" name="aprobar" value="Guardar" style="width:120px;background-color:#0066CC; font-weight:bold; border-color:#003399;color:#FFFFFF"/></td>
                              </tr>
                            </table>
                        </fieldset>
                    </td>
                  </tr>
            </table>
        </form>
        </body>
<% } %>
</html>

