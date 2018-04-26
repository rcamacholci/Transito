<%@ page  import = "modelo.Model" import = "modelo.Persona" %>
<%
            Model model = (Model) session.getAttribute("model");
            int tipo = Integer.parseInt(request.getParameter("tipo"));
            String documento = request.getParameter("documento");			
            Persona persona = model.consultarPersona(tipo, documento);
            int respuesta = 0;
            long saldo = 0;
            if(persona!=null){
                respuesta = (int)model.consultaTotalCarterasPersona(persona.getId_persona());
            }    
            out.print(respuesta);
%>