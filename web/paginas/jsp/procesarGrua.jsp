<%
    modelo.Model modelo = (modelo.Model) session.getAttribute("model");
    String mensaje = "";
    try {
        if (request.getParameter("numero") != null && !request.getParameter("numero").isEmpty()) {
            if (request.getParameter("placa") != null && !request.getParameter("placa").isEmpty()) {
                java.sql.Date fecha_System = new java.sql.Date(new java.util.Date().getTime());
                int numero = Integer.parseInt(request.getParameter("numero"));
                String placa = request.getParameter("placa").toUpperCase();
                modelo.Grua agente = new modelo.Grua();
                agente.setPlaca(placa);
                agente.setNumero(numero);
                agente.setfk_patio(1);
                agente.setFecha_inicio(fecha_System);
                agente.setFecha_proceso(fecha_System);
                modelo.getCon().setAutoCommit(false);
                modelo.adicionarGrua(agente);
                modelo.getCon().commit();
                mensaje = "Grua ingresado con exito"; %>
                <script language="javascript" type="text/javascript">
                    alert(<%=mensaje%>)
                    window.close();
                </script>
       <%   } else {
                mensaje = "falta Placa del Grua";
            }
        } else {
            mensaje = "falta Numero dela Grua";
        }
    } catch (Exception ecx) {
        modelo.getCon().rollback();
        ecx.printStackTrace();%>
        <script language="javascript" type="text/javascript">
            alert("Error en el proceso");
            document.location.href = "AdicionarGrua.jsp";
        </script>
<%  } %>