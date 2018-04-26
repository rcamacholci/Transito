<%@ page  import = "modelo.*" import = "java.util.*" import = "java.sql.*"    %>
<html>
  <head>
      <title>&nbsp;</title>
          <style type="text/css">
<!--
.Estilo1 {
	color: #000033;
	font-weight: bold;
	font-style: italic;
}
.Estilo2 {
	color: #0066CC;
	font-style: italic;
	font-weight: bold;
	font-size:12px;
}
.Estilo3 {
	color: #000033;
	font-weight: bold;
	text-decoration:underline;
	font-size: 12px;
	font-family: Tahoma;
}
.Estilo4 {
	font-family: Tahoma;
	font-size: 12px;
}
.Estilo14 {
	color: #FFFFFF;
	font-size: 12px;
}
.Estilo18 {font-family: Tahoma}
.Estilo19 {color: #333333; font-size: 12px; font-weight: bold; font-family: Tahoma; }
.style1 {font-weight: bold}
-->
          </style>
    <script language="javascript" type="text/javascript">
        function verificar(){
            if(document.form1.anterior.value.length>=0){
                if(document.form1.nuevo.value.length>=6){
                    if(document.form1.nuevo2.value.length>=6){
                        if(document.form1.nuevo.value==document.form1.nuevo2.value){
                            document.form1.action = "procesarPasswordBD.jsp?tipo=1";
                            document.form1.submit();
                        }else{
                            alert("El password nuevo no coincide con la repeticion, verifique");
                        }
                    }else{
                        alert("Repita el password nuevo corectamente con una longitud miníma de seis (8)");
                    }
                }else{
                     alert("Repita el password nuevo correctamente con una longitud miníma de seis (8) caracteres");
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
	
            <p>&nbsp;</p>
            <table width="40%" border="0" align="center">
                <tr>
                    <td colspan="2" valign="top" align="center">
                        <fieldset>

                                <table width="73%" border="0" align="center">
								<tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="11" align="center"><span class="Estilo14 style14"><strong><span class="Estilo18 style14"><strong>CAMBIO DE PASSWORD USUARIOS</strong></span></strong></span></td>
		  </tr>
                              <tr>
                                <td width="56%">&nbsp;</td>
                                <td width="44%">&nbsp;</td>
                              </tr>
                              <tr>
                                  <td><span class="Estilo19">NOMBRE&nbsp;USUARIO</span></td>
                                  <td><input name="usuario" type="text" id="usuario" style="width:150px;font-weight:bold; text-align:center" value="TRANSITO" readonly /></td>
                              </tr>
                              <tr>
                                <td><span class="Estilo19">PASSWORD&nbsp;ANTERIOR </span></td>
                                <td><input title="Escriba su contraseña actual"  name="anterior" type="password" id="anterior"  style="width:150px; font-weight:bold; text-align:center" value=""/></td>
                              </tr>
                              <tr>
                                <td><span class="Estilo19">PASSWORD&nbsp;NUEVO </span></td>
                                <td><input title="Escriba el password nuevo correctamente con una longitud miníma de seis (8) carácteres" name="nuevo" id="nuevo" type="password" value=""  style="width:150px; font-weight:bold; text-align:center"/></td>
                              </tr>
                              <tr>
                                <td><span class="Estilo19">REPETIR&nbsp;PASSWORD </span></td>
                                <td><input title="Repita el password nuevo correctamente con una longitud miníma de seis (8) carácteres" name="nuevo2" id="nuevo2" type="password" value="" style="width:150px;font-weight:bold; text-align:center"/></td>
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
            <p>&nbsp;</p>
        </form>
        </body>
<% } %>
</html>

