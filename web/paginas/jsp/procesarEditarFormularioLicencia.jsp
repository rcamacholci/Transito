<%--
    Document   : procesarEditarFormulario
    Created on : 30/04/2010, 06:18:18 PM
    Author     : Administrador
--%>

<%@ page  import = "modelo.*" import = "java.util.*" import = "java.sql.*"    %>
<%
	Model model = (Model) session.getAttribute("model");
    try{
        model.getCon().setAutoCommit(false);
        Formulario_Licencia formulario = model.consultarFormularioLicencia(Long.parseLong(request.getParameter("rad")));
        if(formulario!=null){
                Radicacion_Licencia rl = model.consultar_RadicacionLicencia(Long.parseLong(request.getParameter("rad")));
                if(request.getParameter("runt")!=null)
                formulario.setRunt(request.getParameter("runt"));
                if(request.getParameter("categoria")!=null)
                    formulario.setCategoria(request.getParameter("categoria"));
                 if(request.getParameter("categoriaA")!=null)
                    formulario.setCategoria_anterior(request.getParameter("categoriaA"));
                model.editarFormularioTramiteLC(formulario.getIdFormularioLicencia(), formulario.getRunt(),formulario.getCategoria(),formulario.getCategoria_anterior());
                model.getCon().commit(); %>
                <script>
                        alert("El formulario ha sido editado correctamente..");
                        document.location.href = "radicarLicencia.jsp?radicacionl=<%=rl.getId_radicacion_licencia()%>"
                </script>
<%         
        }
    }catch(Exception exc){
        model.getCon().rollback();
        exc.printStackTrace();%>
        <script>
                alert("El formulario no pudo ser editado");
        </script>
        <%
    }
%>

