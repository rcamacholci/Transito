
<%@ page import = "modelo.Model" import = "modelo.Vehiculo" %>

<%
            try {
                Model model = (Model) session.getAttribute("model");
                String placa = request.getParameter("placa");
                int tiene = 0;
                Vehiculo vehiculo = model.consultarVehiculo(placa.toUpperCase());
                if (vehiculo != null) {
                    if (model.tieneAlertas(vehiculo.getId_vehiculo())) {
                        tiene = 1;
                    }
                }
                out.print(tiene);
            } catch (Exception e) {
                e.printStackTrace();
            }
%>