<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro" import="modelo.Vehiculo" import="modelo.Cartera" import="modelo.Concepto"  import="modelo.Propietario"  import="modelo.Persona" errorPage="" %>

<% try{
    Model model = (Model) session.getAttribute("model");
    if (request.getParameter("parametro")!=null&&model!=null) {
        java.util.HashMap listaTipos = model.crearHashParametrosAbreviatura(5);
        if(request.getParameter("documento").trim().equals("")){
			Vehiculo vehiculo = model.consultarVehiculo(request.getParameter("parametro").toUpperCase());
			if (vehiculo != null) {
                            java.util.List lista =model.crearListaPropietarios(vehiculo.getId_vehiculo());        
                if (lista.size() > 0) {%>
				<select id="propietario" style="width:430px;color:#333333;font-size:11px">
				<%	for (int i = 0; i < lista.size(); i++) {
                          Propietario propietario = (Propietario) lista.get(i);
                          Persona persona = model.consultarPersona(propietario.getFk_persona());%>
                             <option  value="<%=persona.getId_persona() + ""%>"><font size="10px"><%=listaTipos.get(persona.getTipo_documento() + "") + " " + persona.getDocumento() + " - " + persona.getApellido_1() + " " + (persona.getApellido_2() != null ? persona.getApellido_2() : "") + " " + persona.getNombre_1()%></font></option>
                        <%
                    }  
            %> </select><%
               }
			}else{
                            modelo.Preasignacion preasignacion = model.consultarPreasignacion(request.getParameter("parametro").toUpperCase());
                            if(preasignacion!=null){
                                Persona persona = model.consultarPersona(preasignacion.getFk_persona());
                                if(persona!=null){ %>
                                        <select id="propietario" style="width:430px;color:#333333;font-size:11px">
                                         <option value="<%=persona.getId_persona() + ""%>"><font size="10px"><%=listaTipos.get(persona.getTipo_documento() + "") + " " + persona.getDocumento() + " - " + persona.getApellido_1() + " " + (persona.getApellido_2() != null ? persona.getApellido_2() : "") + " " + persona.getNombre_1()%></font></option>
                                        </select>
        <%                      }
                            }
                        }
		}else{
			Persona persona = model.consultarPersona(Integer.parseInt(request.getParameter("tipo")), request.getParameter("documento")); 
			if(persona!=null){ %>
				<select id="propietario" style="width:430px;color:#333333;font-size:11px">
				 <option value="<%=persona.getId_persona() + ""%>"><font size="10px"><%=listaTipos.get(persona.getTipo_documento() + "") + " " + persona.getDocumento() + " - " + persona.getApellido_1() + " " + (persona.getApellido_2() != null ? persona.getApellido_2() : "") + " " + persona.getNombre_1()%></font></option>
		                </select>
<%			}
		}    
    }
  }catch(Exception exc){
      exc.printStackTrace();
      out.println("No conectado a Oracle");
  }       %>
  
