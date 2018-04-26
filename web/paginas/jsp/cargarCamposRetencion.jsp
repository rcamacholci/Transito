<%--
    Document   : cargarCamposRetencion
    Created on : 19/05/2016, 09:22:42 PM
    Author     : Andres
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="modelo.*" import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%  Model model = (Model) session.getAttribute("model");
        int tipoCampo = 0;
        int codtablaAvaluo = 0;
        String nombreTabla = "";
        int clase_cod = 0;
        int claseVeh = 0;
        String marcaVeh = "";
        long marca_cod = 0;
        long linea_cod = 0;
        long cilindraje = 0, cilindrajeVeh = 0;
        long modelo = 0, modeloVeh = 0;
        long cantpasajeros = 0;
        String capatonelaje = "";

        Parametro parametroTabla = new Parametro();

        if(request.getParameter("tipoC")!=null){
            tipoCampo = Integer.parseInt(request.getParameter("tipoC").toString());
	}

        if(request.getParameter("tablaAva")!=null){
            codtablaAvaluo = Integer.parseInt(request.getParameter("tablaAva").toString());
            if(codtablaAvaluo>0){
                parametroTabla = model.consultarParametro(codtablaAvaluo, 371);
                if(parametroTabla!=null){
                    if(codtablaAvaluo==2){
                        nombreTabla = "CAMIONETAS";
                    }else{
                        if(codtablaAvaluo==5){
                            nombreTabla = "MOTOCICLETAS";
                        }else{
                            nombreTabla = parametroTabla.getNombre();
                        }
                    }
                }

        if(request.getParameter("clase")!=null){
            clase_cod = Integer.parseInt(request.getParameter("clase").toString());
	}

        if(request.getParameter("codClase")!=null){
            claseVeh = Integer.parseInt(request.getParameter("codClase").toString());
	}

	if(request.getParameter("marca")!=null){
            marca_cod = Long.parseLong(request.getParameter("marca").toString());
	}

        if(request.getParameter("marcaVeh")!=null){
            marcaVeh = request.getParameter("marcaVeh").toString();
	}

        if(request.getParameter("linea")!=null){
            linea_cod = Long.parseLong(request.getParameter("linea").toString());
        }

        if(request.getParameter("cilindraje")!=null){
            cilindraje = Long.parseLong(request.getParameter("cilindraje").toString());
        }

        if(request.getParameter("cilindrajeVeh")!=null){
            cilindrajeVeh = Long.parseLong(request.getParameter("cilindrajeVeh").toString());
        }

        if(request.getParameter("cantpasajeros")!=null){
            cantpasajeros = Long.parseLong(request.getParameter("cantpasajeros").toString());
        }

        if(request.getParameter("capatonelaje")!=null){
            capatonelaje = request.getParameter("capatonelaje").toString();
        }

        if(request.getParameter("modelo")!=null){
            modelo = Long.parseLong(request.getParameter("modelo").toString());
        }

        if(request.getParameter("modeloVeh")!=null){
            modeloVeh = Long.parseLong(request.getParameter("modeloVeh").toString());
        }

        if(tipoCampo==1){
            //CLASES
            Parametro claseRetencion = model.ConsultarClaseRetencionByCodigo(claseVeh, nombreTabla);
            if(claseRetencion!=null){
                %>
            <select name="clases" id="clases" style="width:250px;" disabled >
                <option value="<%=claseRetencion.getCodigo() %>"><%= claseRetencion.getNombre() %></option>
            </select>
    <%
            }else{
                java.util.List clasesRetencion = model.listarClasesVehiculo(nombreTabla);
            %>
            <select name="clases" id="clases" onchange="verComboRetencion('Clase')" style="width:250px;" >
            <option value="0"><<--Seleccione Clase-->></option>
    <%
            for (int i = 0; i < clasesRetencion.size(); i++) {
                claseRetencion = (Parametro) clasesRetencion.get(i);
%>
                <option value="<%=claseRetencion.getCodigo() %>"><%= claseRetencion.getNombre() %></option>
<%
            }
%>
		</select>
                <%
            }
        }

        if(tipoCampo==2){
            //MARCAS
            Marca marcaRetencion = model.ConsultarMarcaRetencionByNombre(marcaVeh, nombreTabla);
            if(marcaRetencion!=null){
                %>
                <select name="marcas" id="marcas" style="width:250px;" disabled >
                    <option value="<%=marcaRetencion.getCodigo() %>"><%= marcaRetencion.getNombre() %></option>
            </select>
    <%

            }else{

            java.util.List marcasRetencion = model.listarMarcasRetencion(nombreTabla);
            %>
            <select name="marcas" id="marcas" onchange="verComboRetencion('Marca')" style="width:250px;" >
            <option value="0"><<--Seleccione Marca-->></option>
    <%
    for (int i = 0; i < marcasRetencion.size(); i++) {
        marcaRetencion = (Marca) marcasRetencion.get(i);
%>
<option value="<%=marcaRetencion.getCodigo() %>"><%= marcaRetencion.getNombre() %></option>
<%
        }
%>
		</select>
                <%
                }
        }

        if(tipoCampo==3){
            //LISTAR LINEAS
            java.util.List lineasRetencion = model.listarLineasRetencion(marca_cod,nombreTabla);
            %>
            <select name="lineas" id="lineas" onchange="verComboRetencion('Linea')" style="width:250px;" >
            <option value="0"><<--Seleccione Linea-->></option>
    <%
    for (int i = 0; i < lineasRetencion.size(); i++) {
        Linea lineaRetencion = (Linea) lineasRetencion.get(i);
%>
<option value="<%=lineaRetencion.getId_linea()%>"><%= lineaRetencion.getNombre()%></option>
<%
        }
%>
		</select>
                <%
            }

            if(tipoCampo==4){
                //LISTAR CILINDRAJES
                long codcilindraje = model.consultarCilindrajeRetencion(clase_cod, marca_cod, linea_cod, codtablaAvaluo, nombreTabla, cilindrajeVeh);
                if(codcilindraje != 0){
                    %>
                    <select name="cilindrajes" id="cilindrajes" onchange="verComboRetencion('Cilindraje')" style="width:250px;"  disabled >
		<option value="<%=codcilindraje %>"><%=codcilindraje %></option>
                </select>
                    <%
                }else{
                    java.util.List cilindrajesRetencion = model.listarCilindrajes(clase_cod,marca_cod,linea_cod,nombreTabla);
                    if(cilindrajesRetencion.size()>0){
                        %>
                            <select name="cilindrajes" id="cilindrajes" onchange="verComboRetencion('Cilindraje')" style="width:250px;" >
                    <%
                    for (int i = 0; i < cilindrajesRetencion.size(); i++) {
                        long cilindrajes = (Long) cilindrajesRetencion.get(i);
                        //if(cilindrajes>=cilindrajeVeh){

                %>
                <option value="<%=cilindrajes %>"><%=cilindrajes %></option>
            <%
                        //}
                    }
    %>
                    </select>
                    <%

                    }else{
                        %>
                        <select name="cilindrajes" id="cilindrajes" onchange="verComboRetencion('Cilindraje')" style="width:250px;" disabled >
                            <option value="<%= cilindrajeVeh %>"><%= cilindrajeVeh %></option>
                        </select>
<%
                    }
                }
            }

                if(tipoCampo==5){
                //LISTAR CANTIDAD PASAJEROS
                java.util.List cantpasajerosRetencion = model.listarCantPasajeros(clase_cod,marca_cod,linea_cod,nombreTabla,cilindraje);
                %>
                <select name="pasajeros" id="pasajeros" onchange="verComboRetencion('CantPasajero')" style="width:250px;" >
		<option value="0"><<--Seleccione Cant. Pasajeros-->></option>
	<%
        for (int i = 0; i < cantpasajerosRetencion.size(); i++) {
            long cantPasajeros = (Long) cantpasajerosRetencion.get(i);
    %>
    <option value="<%=cantPasajeros %>"><%=cantPasajeros %></option>
<%
        }
%>
		</select>
                <%
            }

                if(tipoCampo==6){
                //LISTAR CAPACIDAD TONELADAS
                java.util.List capatonelajeRetencion = model.listarCapaTonelaje(clase_cod,marca_cod,linea_cod,nombreTabla,cilindraje);
                %>
                <select name="toneladas" id="toneladas" onchange="verComboRetencion('CapaTonelaje')" style="width:250px;" >
		<option value="0"><<--Seleccione Cap. Toneladas-->></option>
	<%
        for (int i = 0; i < capatonelajeRetencion.size(); i++) {
            String capaTonelaje = (String) capatonelajeRetencion.get(i);
    %>
    <option value="<%=capaTonelaje %>"><%=capaTonelaje %></option>
<%
        }
%>
		</select>
                <%
            }

        if(tipoCampo==7){
                //MODELOS
                %>
                <select name="modelos" id="modelos" onchange="verComboRetencion('Modelo')" style="width:250px;" disabled>
    <option value="<%=modeloVeh %>"><%=modeloVeh %></option>
		</select>
                <%
            }

        if(tipoCampo==8){
                //VALOR AVALUO
                float avaluoRetencion = model.consultarValorAvaluo(clase_cod,marca_cod,linea_cod,codtablaAvaluo,nombreTabla,cilindraje,modelo,cantpasajeros,capatonelaje);
                long ValorRetencion = 0;
                if(avaluoRetencion>0){
                    ValorRetencion = Math.round((avaluoRetencion*1000)*0.01);
                }

                %>
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="33%" scope="col" align="right"><label><span class="style2">VALOR&nbsp;AVALUO&nbsp;</span></label></td>
                        <td width="67%" scope="col" align="left"><input name="valorAvaluo" id="valorAvaluo" value="<%= Math.round(avaluoRetencion*1000) %>" style="width:195px;" disabled ></td>
                    </tr>
                    <tr>
                        <td scope="col" align="right"><label><span class="style2">VALOR&nbsp;RETENCION&nbsp;</span></label></td>
                        <td scope="col" align="left"><input name="valorRetencion" id="valorRetencion" value="<%= ValorRetencion %>" style="width:195px;" disabled ></td>
                    </tr>
                </table>
	<%
            }
        }
        }

%>