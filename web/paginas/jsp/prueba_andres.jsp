<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro" import="modelo.Vehiculo" import="modelo.Concepto" import="modelo.Valor" errorPage="" %>
<%
try{
if(session.getAttribute("usuario")!=null){
    modelo.Model model = (modelo.Model)session.getAttribute("model");
    if(model!=null){
        modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
        if(model.tienePermiso(usuario.getId_usuario(), 56)){
%>
<html>
<head>
    <title>liquidarTramites</title>
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

	function verTramites(placa){
		var clasestramites = document.getElementById("clasestramites");
                var valor1 = 0;
		var valor2 = 0;
		if(clasestramites.value==1){
			document.getElementById('param1').style.display = 'block';
			document.getElementById('param2').style.display = 'block';
			document.getElementById('clasesvehiculos').style.display = 'block';
			document.getElementById('servicio').style.display = 'block';

			document.getElementById('param3').style.display = 'none';
			document.getElementById('param4').style.display = 'none';
			document.getElementById('modalidad').style.display = 'none';
			document.getElementById('radio').style.display = 'none';

			document.getElementById('categoria').style.display = 'none';
			document.getElementById('param5').style.display = 'none';
			valor1 = document.getElementById('clasesvehiculos').value;
			valor2 = document.getElementById('servicio').value;
		}else{
                    if(clasestramites.value==2){
                        document.getElementById('param1').style.display = 'none';
                        document.getElementById('param2').style.display = 'none';
                        document.getElementById('clasesvehiculos').style.display = 'none';
                        document.getElementById('servicio').style.display = 'none';

                        document.getElementById('param3').style.display = 'none';
                        document.getElementById('param4').style.display = 'none';
                        document.getElementById('modalidad').style.display = 'none';
                        document.getElementById('radio').style.display = 'none';

                        document.getElementById('categoria').style.display = 'block';
                        document.getElementById('param5').style.display = 'block';
                        valor1 = document.getElementById('categoria').value;
                        valor2 = 0;
                    }else{
                            document.getElementById('param1').style.display = 'none';
                            document.getElementById('param2').style.display = 'none';
                            document.getElementById('clasesvehiculos').style.display = 'none';
                            document.getElementById('servicio').style.display = 'none';

                            document.getElementById('param3').style.display = 'none';
                            document.getElementById('param4').style.display = 'none';
                            document.getElementById('modalidad').style.display = 'none';
                            document.getElementById('radio').style.display = 'none';

                            document.getElementById('categoria').style.display = 'none';
                            document.getElementById('param5').style.display = 'none';
                    }
		}
		var sedeT = document.getElementById("sedeT");
                var valCheck = document.getElementById("valorCheck").value;
		window.frames[0].location.href = "cargarTramites.jsp?clase="+clasestramites.value+"&sede="+sedeT.value+"&valor1="+valor1+"&valor2="+valor2+"&placa="+placa+"&check="+valCheck;
	}

</script>
<style type="text/css">
<!--
.Estilo1 {color: #333333}
-->
</style>
</head>
<body>
<% try{
        if (!request.getParameter("parametro").equals("")) {
                String placa = request.getParameter("placa").toUpperCase();
	        Vehiculo vehiculo = model.consultarVehiculo(placa);
                modelo.Preasignacion preasignacion = null;
                if(vehiculo==null)
                    preasignacion = model.consultarPreasignacion(request.getParameter("placa").toUpperCase());
%>
		<input type="hidden" id="sedeT" value="<%=request.getParameter("parametro")%>" />
                <input type="hidden" id="valorCheck" value="<%=request.getParameter("check")%>">
        <table width="34%" border="0" align="center">
          <tr>
            <th colspan="2" scope="col">&nbsp;</th>
          </tr>
          <tr>
            <td width="24%">
              <label style="font-size:12px"><b><font color="#333333">CLASE&nbsp;TRAMITE</font> </b></label>
            </td>
            <td width="76%"><select name="clasestramites" id="clasestramites" style="color:#333333; font:bold;font-size:12px; width:250px" onchange="verTramites('<%=placa%>')" >
							<% try {
								java.util.List listaTipos =model.listadoParametros(71);
								for (int i = 0; i < listaTipos.size(); i++) {
									Parametro parametro = (Parametro) listaTipos.get(i);
                                                                        if(placa.length()>0){
                                                                            if(parametro.getCodigo()==1||parametro.getCodigo()==3){ %>
                                                                                <option value="<%=parametro.getCodigo() + ""%>"><%=parametro.getNombre()%></option>
							<%                  }
                                                                        }else{
                                                                            if(parametro.getCodigo()==2||parametro.getCodigo()==3){%>
                                                                                <option value="<%=parametro.getCodigo() + ""%>"><%=parametro.getNombre()%></option>
							<%                  }
                                                                        }
                                                                }
							} catch (Exception exc) {
								out.println(exc.getMessage());
							}%>
							</select>			</td>
          </tr>
          <tr>
            <td>
              <span style="color: #333333">
              <label id="param1" style="font-size:12px"><b>CLASE&nbsp;VEHICULO</b></label>
              </span>


              <span style="color: #333333">
              <label id="param3" style="display:none;font-size:12px"><b>MODALIDAD</b></label>
              </span>


              <span style="color: #333333">
              <label id="param5" style="display:none;font-size:12px"><b>CATEGORIA</b></label>
              </span>

                </td>
            <td><select id="clasesvehiculos"  style="color:#333333; font:bold;font-size:12px; width:250px" onchange="verTramites('<%=placa%>')" >
                    <option value="0">---Seleccione Clase---</option>
				<% try {
					java.util.List listaTipos = model.listadoParametros(1);
					for (int i = 0; i < listaTipos.size(); i++) {
						Parametro parametro = (Parametro) listaTipos.get(i);
						if(vehiculo!=null){
							if(vehiculo.getClase_vehiculo()==parametro.getCodigo()){%>
							<option value="<%=parametro.getCodigo() + ""%>" selected><%=parametro.getNombre()%></option>
                                                <%	}
						}else{
                                                   if(preasignacion!=null){
                                                       if(preasignacion.getClase()==parametro.getCodigo()){ %>
                                                            <option value="<%=parametro.getCodigo() + ""%>" selected><%=parametro.getNombre()%></option>
                                                    <% }
                                                   }else{ %>
                                                        <option value="<%=parametro.getCodigo() + ""%>"><%=parametro.getNombre()%></option>
				      <%           }
                                               }
					}
				} catch (Exception exc) {
					out.println(exc.getMessage());
				}%>
				</select>
				<select id="modalidad"  style="color:#333333;font-size:12px; display:none; width:250px" onchange="verTramites('<%=placa%>')" >
				<% try {
					java.util.List listaTipos = model.listadoParametros(94);
					for (int i = 0; i < listaTipos.size(); i++) {
						Parametro parametro = (Parametro) listaTipos.get(i);%>
						<option value="<%=parametro.getCodigo() + ""%>"><%=parametro.getNombre()%></option>
				<%	}
				} catch (Exception exc) {
					out.println(exc.getMessage());
				}%>
				</select>
				<select id="categoria"  style="color:#333333;font-size:12px; display:none; width:250px" onchange="verTramites('<%=placa%>')" >
                                     <option value="0">---Seleccione Categoria---</option>
				<% try {
					java.util.List listaTipos = model.listadoParametros(221);
					for (int i = 0; i < listaTipos.size(); i++) {
						Parametro parametro = (Parametro) listaTipos.get(i);%>
						<option value="<%=parametro.getCodigo() + ""%>"><%=parametro.getNombre()%></option>
				<%	}
				} catch (Exception exc) {
					out.println(exc.getMessage());
				}%>
				</select>
            </td>
          </tr>
          <tr>
            <td><span class="Estilo1">
              <label id="param2" style="font-size:12px"><b>SERVICIO</b></label>
			  <label id="param4" style="display:none;font-size:12px"><b>RADIO&nbsp;ACCION</b></label>
			</span></td>
            <td><select id="servicio"  style="color:#333333;font-size:12px; width:250px" onchange="verTramites('<%=placa%>')" >
                    <option value="0">---Seleccione Servicio---</option>
				<% try {
					java.util.List listaTipos = model.listadoParametros(3);
					for (int i = 0; i < listaTipos.size(); i++) {
						Parametro parametro = (Parametro) listaTipos.get(i);
						if(vehiculo!=null){
							if(vehiculo.getServicio()==parametro.getCodigo()){%>
                                                        <option value="<%=parametro.getCodigo() + ""%>" selected><%=parametro.getNombre()%></option>
                                                <%	}
						}else{
                                                   if(preasignacion!=null){
                                                       if(preasignacion.getServicio()==parametro.getCodigo()){ %>
                                                            <option value="<%=parametro.getCodigo() + ""%>" selected><%=parametro.getNombre()%></option>
                                                    <% }
                                                   }else{ %>
                                                        <option value="<%=parametro.getCodigo() + ""%>"><%=parametro.getNombre()%></option>
				      <%           }
                                               }
					}
				} catch (Exception exc) {
					out.println(exc.getMessage());
				}%>
				</select>
				<select id="radio"  style="color:#333333;font-size:12px;display:none; width:250px" onchange="verTramites('<%=placa%>')" >
				<% try {
					java.util.List listaTipos = model.listadoParametros(93);
					for (int i = 0; i < listaTipos.size(); i++) {
						Parametro parametro = (Parametro) listaTipos.get(i);%>
						<option value="<%=parametro.getCodigo() + ""%>"><%=parametro.getNombre()%></option>
				<%	}
				} catch (Exception exc) {
					out.println(exc.getMessage());
				}%>
				</select>			</td>
          </tr>

		  <tr>
            <td colspan="2">
			<table width="100%" border="0">
                          <tr>
                              <td>
                                <iframe src="cargarTramites.jsp" id="listat"  marginwidth="0" height="370" width="100%" marginheight="0" align="top" scrolling="auto" style="display:block; border:none"></iframe>
                              </td>
                          </tr>
                    </table>
            </td>
          </tr>
		  <script language="javascript" type="text/javascript">
                        verTramites('<%=placa%>');
                </script>
         </table>

	<% }
 } catch (Exception exc) {
            out.println(exc.getMessage());
	}%>
</body>
</html>
<%
        }else{  %>
           <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="1"></jsp:param></jsp:forward>
<%        }
     }else{ %>
        <script>window.parent.document.location.href = "../../index.jsp";</script>
<%  }
 }else{ %>
     <script>window.parent.document.location.href = "../../index.jsp";</script>
<% }
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<% } %>