<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Usuario" import="net.sf.jasperreports.engine.*" errorPage="" %>
<%
	Model model = null;
	try {
            String servicio = request.getParameter("servicio");
            String clase = request.getParameter("clase");
            if(servicio!=null&&clase!=null){
                if(!servicio.equals("0")&&!clase.equals("0")){
                    model = (Model) session.getAttribute("model");
                    Usuario usuario = (Usuario)session.getAttribute("usuario");
                    int clase2 = model.consultarClaseTipificacionRUNT(Integer.parseInt(clase));
                    int tipo = 0;
                    if(clase2==10){
                        tipo = 4;
                    }else{
                        switch(Integer.parseInt(servicio)){
                            case 1:tipo = 1;break;
                            case 2:tipo = 2;break;
                            case 4:tipo = 3;break;
                            default: tipo = 0;break;
                        }
                    }
                    if(tipo!=0){
                        modelo.Sede sede = (modelo.Sede)session.getAttribute("sede");
                        if(sede!=null){
                            String placa = model.getPlacaDisponible(sede.getId_sede(), tipo,usuario.getId_usuario());
                            out.print(placa);
                        }else{
                            out.print("");
                        }
                    }else{
                        out.print("");
                    }
            }else{
                out.print("");
            }
        }
    } catch (Exception exc) {
        out.print("");
    }
%>
 