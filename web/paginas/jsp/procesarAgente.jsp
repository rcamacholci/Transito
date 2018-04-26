<%
    modelo.Model modelo = (modelo.Model) session.getAttribute("model");
    String mensaje = "";
    try {
        if (request.getParameter("placa") != null && !request.getParameter("placa").isEmpty()) {
            if (request.getParameter("nombre") != null && !request.getParameter("nombre").isEmpty()) {
                java.sql.Date fecha_System = new java.sql.Date(new java.util.Date().getTime());
                int placa = Integer.parseInt(request.getParameter("placa"));
                String nombre = request.getParameter("nombre").toUpperCase();
                modelo.Agente agente = new modelo.Agente();
                agente.setNombre(nombre);
                agente.setPlaca(placa);
                agente.setTipo(1);
                agente.setFecha_inicio(fecha_System);
                agente.setFecha_proceso(fecha_System);
                modelo.getCon().setAutoCommit(false);
                modelo.adicionarAgente(agente);
                modelo.getCon().commit();
                mensaje = "Agente ingresado con exito"; %>
                <script language="javascript" type="text/javascript">
                    window.opener.document.form.placaAgente.value = "<%=placa%>";
                    window.opener.document.form.nombreAgente.value = "<%=nombre%>";
                    window.close();
                </script>
       <%   } else {
                mensaje = "falta nombre del agente";
            }
        } else {
            mensaje = "falta placa del agente";
        }
    } catch (Exception ecx) {
        modelo.getCon().rollback();
        ecx.printStackTrace();%>
        <script language="javascript" type="text/javascript">
            alert("Error en el proceso");
            document.location.href = "adicionarAgente.jsp";
        </script>
<%  } %>