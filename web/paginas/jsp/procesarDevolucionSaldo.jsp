<%@ page  import = "modelo.*" import = "java.util.*" import = "java.sql.*"    %>
<%
Model model = (Model) session.getAttribute("model");
if(model!=null){
    try{
        if(request.getParameter("idsaldo")!=null){
            long id_saldo = Long .parseLong(request.getParameter("idsaldo"));
            Usuario usuario = (Usuario) session.getAttribute("usuario");
            String numero = request.getParameter("resolucion");
            String fecha = request.getParameter("fecha");
            String observacion = request.getParameter("observacion");

            Saldo_Favor saldoFavor = model.consultarSaldoFavor(id_saldo);
            if(saldoFavor!=null){
                model.getCon().setAutoCommit(false);
                saldoFavor.setResolucion(numero);
                saldoFavor.setFecha_resolucion(new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(fecha).getTime()));
                saldoFavor.setEstado(3);
                saldoFavor.setFecha_devolucion(new java.sql.Timestamp(new java.util.Date().getTime()));
                saldoFavor.setFk_usuario_devolucion(usuario.getId_usuario());
                saldoFavor.setObservacion(observacion);
                model.editarSaldoFavor(saldoFavor);
                model.getCon().commit(); %>
                <script type="text/javascript">
                    alert("Se ha registrado exitosamente la devolucion");
                    document.location.href = "consultarSaldosFavor.jsp";
                </script>
         <% }
        }
    }catch(Exception excw){
        excw.printStackTrace();
        model.getCon().rollback();
    }
} %>