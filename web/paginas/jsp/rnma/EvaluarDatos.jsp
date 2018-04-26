<%@page import="java.util.List"%>
<%
    String msg = "";
    try {
        if (request.getParameter("opcion").equals("1")) {
            modelo.Model model = (modelo.Model) session.getAttribute("model");
            String placa = request.getParameter("registro");
            String motor = request.getParameter("motor");
            String chasis = request.getParameter("chasis");
            String serie = request.getParameter("serie");
            String tramite = request.getParameter("tramite");
            if (tramite.equals("91")) {
                if (motor.length() > 3) {
                    msg += model.verificaMotor(motor, placa) == null ? "" : "Numero MOTOR ya existe - ";
                }
                if (chasis.length() > 3) {
                    msg += model.verificaChasis(chasis, placa) == null ? "" : "Numero CHASIS ya existe - ";
                }
                if (serie.length() > 3) {
                    msg += model.verificaSerie(serie, placa) == null ? "" : "Numero SERIE ya existe";
                }
            }

            if (session.getAttribute("listcupl") == null) {
                msg = "No existe un numero de pago asociado al tramite";
            }
            if (session.getAttribute("listpropietarios") == null) {
                msg = "No existe Propietario(s)  asociado(s) al tramite";
            }
        } else {
            if (request.getParameter("registro") != null && (!request.getParameter("registro").isEmpty())) {
                String registro = request.getParameter("registro");
                if (session.getAttribute("ListTramites") != null) {
                    java.util.List<modelo.Tramite> listtramite = (java.util.List<modelo.Tramite>) session.getAttribute("ListTramites");
                    modelo.Model model = (modelo.Model) session.getAttribute("model");
                    for (modelo.Tramite tramite : listtramite) {
                        String Val = "";
                        Val = model.obtenerPosiblePagoTRANSITO(registro, tramite.getId_tramite());
                        if (Val.isEmpty()) {
                            msg += "No existe pago asociado al tramite " + tramite.getNombre() + " para el numero de registro " + registro + "\n";
                        }
                    }//nexl
                } else {
                    msg = "No existen tramites seleccionados";
                }
            } else {
                msg = "No existe numero de registo para maquinaria agricola";
            }
        }

    } catch (Exception exc) {
        out.println("existe  un error: \r\n" + exc.getMessage());
    }
    out.print(msg.trim());
%>