<%@ page import = "modelo.Model" import = "modelo.Banco" import = "modelo.Entidad_Distribucion" 
         import = "java.util.LinkedList" import = "modelo.Persona"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
               
%>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Documento sin t&iacute;tulo</title>
        <style type="text/css">
            <!--
            .Estilo1 {
                color: #CCCCCC;
                font-weight: bold;
                font-family: "Courier New", Courier, monospace;
            }
            .Estilo2 {
                font-size: 12px;
                font-weight: bold;
                color: #000000;
            }
.style3 {font-family: Tahoma}
.style4 {font-size: 12px; font-weight: bold; color: #000000; font-family: Tahoma; }
.style5 {font-family: Tahoma; color: #333333; }
.style6 {color: #333333}
.style8 {color: #FFFFFF; font-weight: bold; font-family: Tahoma; font-size: 12px; }
.style9 {font-size: 12px; font-weight: bold; color: #333333; font-family: Tahoma; }
            -->
        </style>

                <script src="../html/scripts/personas.js" type="text/javascript"></script>
		<script language="javascript" type="text/javascript">
		
		 function nuevoAjax(){
                var xmlhttp= false;
                try{
                    xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
                }catch(e){
                    try {
                        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                    }catch(E){
                        xmlhttp = false;
                    }
                }

                if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
                    xmlhttp = new XMLHttpRequest();
                }

                return xmlhttp;
            }		
		
		
		function salir(){
			window.location.href = "entidades_de_distribucion.jsp?id=1";
		}
		
		function consultaPersona(){
				documento = document.getElementById("documento");
				if(!isNaN(documento.value)&&documento.value.length>0){
					ajax=nuevoAjax();
					ajax.open("POST", "getPersona.jsp",true);
					ajax.onreadystatechange=function() {
						if (ajax.readyState==4) {
							var respuesta = "" ;
							for(var i = 0; i < ajax.responseText.length ; i++){
								if(isNaN(ajax.responseText.charAt(i))||ajax.responseText.charAt(i)==' ')
									respuesta += ajax.responseText.charAt(i);
							}
							if(respuesta.indexOf("nueva")!=-1){
								viewPersona(2,documento.value);
							}else{
								document.form1.nombre.value = respuesta;
							}  
						}
					}
					ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
					ajax.send("documento="+documento.value+"&tipo=2"); 
				}
			}
			
		function adicionar_entidad(){
		
		   if(document.getElementById("documento").value.length>0){
                            if(document.getElementById("nombre").value.length>0){
                                    if(document.getElementById("cuenta").value.length>0){

                                        document.form1.submit();
                                    }else{
                                        alert("Escriba un numero de cuenta");
                                    }
                            }else{
                                    alert("Escriba el nombre de la Entidad");
                            }
                   }else{
                           alert("Debe digitar el nit de la Entidad");
                   }
             
                }

			
			
			
		
		
		
		</script>
	
		
    </head>
    <%

            Model model = (Model) session.getAttribute("model");
            LinkedList listado_bancos = model.listado_bancos();
            if (request.getParameter("add_ent") != null) {
                Entidad_Distribucion entidad_distribucion = new Entidad_Distribucion();
                Persona persona = model.consultarPersona(2, request.getParameter("nit"));
                entidad_distribucion.setFk_persona(persona.getId_persona());
                entidad_distribucion.setFk_banco(Long.parseLong(request.getParameter("bancos")));
                entidad_distribucion.setCuenta(request.getParameter("cuenta"));
                entidad_distribucion.setDefecto(Integer.parseInt(request.getParameter("defecto")));
                if (entidad_distribucion.getDefecto() == 1) {
                    model.updateDefecto(entidad_distribucion);
                }
                model.adicionar_entidad_distribucion(entidad_distribucion);
    %>
    <jsp:forward  page="entidades_de_distribucion.jsp"/>
    <%	} else {
    %>
    <body>
        <form id="form1" name="form1" method="post" action="procesar_entidad_distribucion.jsp">
            <div align="center">
                <p>&nbsp;</p>
               
                <table width="70%" border="1"  style="border-color:#000099">
                    <tr class="style4">
                        <th colspan="2"  style="background:url(../html/images/inicio_3.png)"><div align="center"><span class="style8">DATOS ENTIDAD</span> </div></th>
                    </tr>
                   
                    <tr>
                        <th class="style4" style="border:none"><div align="left"><span class="style6">NIT</span></div></th>
                        <td style="border:none">
                         <input name="documento" type="text" id="documento" style="width:400px" onblur="consultaPersona()" />                      </td>
                    </tr>
                    <tr>
                        <th class="style4" style="border:none"><div align="left"><span class="style6">ENTIDAD</span></div></th>
                        <td style="border:none">
                         <input name="nombre" type="text" id="nombre" style="width:400px" readonly/>   
						  </td>
                    </tr>
                    <tr>
                        <th class="style9" style="border:none"><div align="left">BANCO</div></th>
                        <td style="border:none"><label>
                                <select name="bancos" style="width:400px">
                                    <%
                    if (!listado_bancos.isEmpty()) {
                        for (int i = 0; i < listado_bancos.size(); i++) {
                            Banco banco = (Banco) listado_bancos.get(i);
                                    %>
                                    <option value="<%= banco.getId_banco()%>"><%=banco.getNombre()%></option>
                                    <%		}
                    }
                                    
                                    %>
                                </select>
                        </label></td>
                    </tr>
                    <tr>
                        <th class="style9" style="border:none"><div align="left">CUENTA</div></th>
                        <td style="border:none"><input name="cuenta" type="text" id="cuenta" style="width:400px" /></td>
                    </tr>
                    <tr class="style4">
                      <th colspan="2" style="border:none">
                               
                                    <div align="left">
                                      <input type="checkbox" id="defecto" name="defecto" value="" />
                                    <span class="style9">                                  EMPRESA POR DEFECTO</span> </div></th>
                    </tr>
                </table>
				  <table width="70%" border="0"  style="border-color:#000099">
				  <tr class="style4">
                        <th width="50%" style="border:none">
<button type="button" name="enviar" onclick="adicionar_entidad()"><span class="styl4">Enviar</span><img src="../html/images/enviar.png" width="18" height="18" /></button>									
                          <!-- <input type="button" name="enviar"  style="width:100px" value="Enviar" onclick="adicionar_entidad()" /> -->
                                       
                    </th>
						<th width="50%" style="border:none">
<button type="reset" name="cancelar" onclick="salir()" ><span class="styl2">Cancelar</span><img src="../html/images/cancelar.png" width="18" height="18" /></button>							
						<!--  <input type="reset" name="cancelar" style="width:100px" value="Cancelar" onclick="salir()" /> -->
					</th>
                    </tr>
				  </table>
            </div>
        </form>
    </body>
</html>
<%}%>
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