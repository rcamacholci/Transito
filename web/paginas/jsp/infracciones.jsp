<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*"  import="modelo.Parametro"  errorPage="" %>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){

                    java.sql.Date fechaSystem= new java.sql.Date(new java.util.Date().getTime());
                    String fecha = new java.text.SimpleDateFormat("yyyy").format(fechaSystem);
                    

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Vehiculo</title>
    <!-- filter: alpha(opacity=85);-moz-opacity:0.85; -->
        <LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
		<script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js"ol type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
	<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
        <script type="text/javascript" src="../html/scripts/motorAjax.js"></script>
	<script language="javascript" type="text/javascript">

        function buscarS(){
             window.frames[0].location.href = "verInfracciones.jsp?vigencia="+document.form.vigencia.value+"&infraccion="+document.form.infraccion.value;
        }
        function revisar(){
                if(document.form.infraccionN.value.length>0){
                    if(document.form.valor.value.length>0){
                          if(document.form.salarios.value.length>0){
                                if(document.form.fecha.value.length>0){
                                       if(document.form.descripcion.value.length>0){
                                           document.form.submit();
                                       }else{
                                           alert("Digite la Descripcion de la Infraccion No. : "+(document.form.infraccionN.value).toUpperCase());
                                       }
                                }else{
                                     alert("Digite la Fecha de Creacion de la Infraccion No. : "+(document.form.infraccionN.value).toUpperCase());
                                }                               
                            }else{
                                alert("Digite la cantidad de Salarios Minimos de la Infraccion No. : "+(document.form.infraccionN.value).toUpperCase());
                            }
                        }else{
                            alert("Digite El valor de La Infraccion No. : "+(document.form.infraccionN.value).toUpperCase());
                        } 
                }else{ 
                    alert("Digite un numero de Infraccion");
                } 
        }             

  
			function ver(){
				if(document.form.busqueda[0].checked){
					document.getElementById('tabla1').style.display = "block";
					document.getElementById('tabla2').style.display = "none";
                                }else{
                                      	document.getElementById('tabla1').style.display = "none";
					document.getElementById('tabla2').style.display = "block";
                                }
			}

		</script>
		<STYLE>
<!--
A.ssmItems:link		{color:black;text-decoration:none;}
A.ssmItems:hover	{color:black;text-decoration:none;}
A.ssmItems:active	{color:black;text-decoration:none;}
A.ssmItems:visited	{color:black;text-decoration:none;}
.style1 {
	font-size: 12px;
	font-family: Tahoma;
}
.style5 {color: #FFFFFF; font-weight: bold; font-size: 12px; font-family: Tahoma; }
.Estilo11 {
	color: #0066CC;
	font-weight: bold;
	font-size: 10px;
}
-->
        </STYLE>


</head>
    <%
    Model model = null;
    try {
        model = (Model) session.getAttribute("model");
    } catch (Exception exc) {
        exc.printStackTrace();
    }
    %> 
    <body>
        <form name="form" id="form" method="post" action="procesarInfracciones.jsp">
	        <fieldset>
			<table width="100%" border="0" align="center">
           <tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="4" align="center"><span class="style5">CONSULTA E INGRESO DE INFRACCIONES</span></td>
	    </tr>
				<tr>
				  <td colspan="2" valign="middle" align="center" width="50%"><span class="Estilo11">
				  <input type="radio" name="busqueda" value="1" checked="checked" onClick="ver()">
				  CONSULTAR INFRACCIONES</span></td>
				  <td colspan="2" valign="middle" align="center" width="50%"><span class="Estilo11">
				  <input type="radio" name="busqueda" value="2" onClick="ver()">
				  INGRESAR INFRACCIONES </span></td>
				</tr>

				<tr>
					<td colspan="4">
                                            <fieldset>
                                         <table border="0" width="100%" id="tabla1" style="">

					<tr valign="middle">
                                            <td width="20%" scope="col" align="center" colspan="3"><label style="color:#333333"><span class="Estilo11">INFRACCION</span></label></td>
                                            <td width="20%" align="center"><span style="border:none">
                                              <select id="infraccion" name="infraccion" style="width:100px; font-size:12px">
                                                <option value="1000"  selected="selected" > -- infraccion -- </option>
                                                    <%
                                                       java.util.List<Infraccion> lista = model.listaDeInfracciones();
                                                       for(int i = 0;i<lista.size();i++){
                                                       Infraccion infra = lista.get(i);
                                                       %>
                                                         <option value="<%=infra.getNumero()+""%>"><%=infra.getNumero()%></option>
                                                         <%
                                                          }//while
                                                         %>
                                            </select>
                      </span></td>
                                            <td width="20%" scope="col" align="center" colspan="3"><span class="Estilo11">VIGENCIA</span></td>
                                            <td width="20%" align="center"><span style="border:none">
                                              <select name="vigencia" id="vigencia" style="width:100px; font-size:11px">
                                                <option value="0"> -- Vigencia -- </option>
                                                <% 
                                                for (int i = 2000; i <= Long.parseLong(fecha) ; i++){      %>
                                                <option value="<%=i%>"><%=i%></option>
                                                <% } %>
                                              </select>
                      </span></td>
                                            <td width="40%" scope="col" align="center" colspan="3"><input id="consultar"  name="consultar" onClick="buscarS()" type="button" value="Consultar Infraccion" style="color:#333333"/></td>
                                            <td>&nbsp;</td>

                                        </tr>
						</table> 
                                            <table border="0" width="100%" id="tabla2" style="display:none">

					<tr valign="middle">
                       <td>&nbsp;</td>
                       
           <td>&nbsp;</td>
                                            <td scope="col" align="center" width="15%"  colspan="2"><label style="color:#333333"><span class="Estilo11">INFRACCION</span></label></td>
                                            <td width="15%" align="center"><input id="infraccionN"  maxlength="3"  name="infraccionN" type="text" style="text-align:center;color:#333333; text-transform:uppercase; font:bold; width:90px"/></td>
                                            <td>&nbsp;</td>
                                              <td>&nbsp;</td>
                                            <td scope="col" align="center" width="5%" colspan="3"><span class="Estilo11">VALOR</span></td>
                                            <td width="10%" align="center"><input id="valor" maxlength="7" name="valor" onKeyPress="return soloNumeros(event)" type="text" style="text-align:center;color:#333333;font:bold; width:100px;" /></td>
                                            <td>&nbsp;</td>
                                             <td>&nbsp;</td>
                                            <td width="10%" colspan="2" align="center" class="Estilo11" scope="col">SALARIOS</td>
                                              <td width="10%"  align="center" class="Estilo11" scope="col"><input id="salarios" maxlength="2" name="salarios"  onKeyPress="return soloNumeros(event)" type="text" style="text-align:center;color:#333333;font:bold; width:40px"/></td>   <td>&nbsp;</td>                         
                                              <td>&nbsp;</td>                
 <td width="15%" colspan="2" align="center"><span class="Estilo11" >FECHA</span></td>
      <td  colspan="3" width="30%">
	     <input  id="fecha" name="fecha" style="text-align:center; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; width:90px" onKeyUp="mascara(this,'/',true)" maxlength="10"/>&nbsp;
<button name="button" type="button" id="lanzador"><img src="../html/images/calendario.png" width="19" height="18"/></button>		 
         <!-- <input name="button" type="button" id="lanzador" style="width:22px; color:#000000" value="<<"/> -->
        <SCRIPT type="text/javascript">
           Calendar.setup({
           inputField     :    "fecha",      // id del campo de texto
           ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
           button         :    "lanzador"   // el id del botón que lanzará el calendario 
          });  
	    </SCRIPT></td>  
        <td colspan="2">&nbsp;</td>        
       
         
        
       
          <td>&nbsp;</td>


                                        </tr>
                                        <tr>
                                         <td colspan="2">&nbsp;
            </td>
            <td colspan="2" class="Estilo11" align="center">DESCRIPCION</td>
             <td colspan="16" align="right">&nbsp;

            </td>
            <td colspan="6"><button name="adicionar" style="width:120px" type="button" id="adicionar"  onclick="revisar()">Adicionar<img src="../html/images/adicionar.png" width="19" height="18"/></button></td>
            </tr>
           <tr>  <td colspan="2">&nbsp;
            </td>
           
             <td colspan="24" align="center">
              <textarea name="descripcion" id="descripcion" style="width:900px; height:50px"></textarea>
             </td>
           </tr>
						</table>
                                                </fieldset>

					</td>
				</tr> 
           </table>
		  </fieldset>
		  <iframe src="#" width="100%" id="respuesta" height="500"  align="center" frameborder="0" scrolling="auto"></iframe>
        </form>
    </body>
</html>
<%  }else{ %>
			   <jsp:forward page="no_access.jsp">
				 <jsp:param name="tipo" value="1"></jsp:param>
			   </jsp:forward>
	<%  }
	}else{ %>
		<script>
			window.parent.document.location.href = "../../index.jsp";
		</script>  <%
	}
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>
