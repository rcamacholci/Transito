<%
modelo.Model model = (modelo.Model)session.getAttribute("model");
inscripcion.registrarPersonaRunt registro = new inscripcion.registrarPersonaRunt(model);
registro.inscribirPersona(4, request.getParameter("doc"));

%>