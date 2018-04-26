<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java"  errorPage="" import="modelo.*" pageEncoding="UTF-8"%>


<%
    Model modelo = (Model) session.getAttribute("model");

    try {

        modelo.getCon().setAutoCommit(false);
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        String placa = request.getParameter("placa");
        int usu = (int) usuario.getId_usuario();
        int viIn = Integer.parseInt(request.getParameter("vigini"));
        int viFin = Integer.parseInt(request.getParameter("vigfin"));
        int NResol = Integer.parseInt(request.getParameter("numresolucion"));
        String numR = request.getParameter("numR").toUpperCase();
        java.sql.Date FResol = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecharesolucion")).getTime());
        //System.out.println("NResol= "+NResol+" FResol= "+FResol+" Usuario= "+usu);
        Vehiculo vehiculo = modelo.consultarVehiculo(placa.toUpperCase());
        int anoactual = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
        String ano = "" + anoactual + "".trim();
        String periodo = modelo.consultarPeriodoRev(vehiculo.getId_vehiculo());
        int servicio = (int) vehiculo.getServicio();
        long idveh = vehiculo.getId_vehiculo();
        //System.out.println("FE_INI= "+viIn+" FE_FIN= "+viFin+" Placa= "+placa+" Periodo= "+periodo+" Servicio= "+servicio+" Usuario= "+usu);

        /*String periodo = modelo.consultarPeriodoRev(vehiculo.getId_vehiculo());
         int servicio=(int)vehiculo.getServicio();*/
        int i = viFin - viIn;
        int vig = viIn;
        int dif = 0;
        int estado = 0;

        for (int x = 0; x <= i; x++) {
            dif = anoactual - vig;
            estado = dif >= 3 ? 4 : dif == 2 ? 3 : dif == 1 ? 2 : 1;
            System.out.println("dif=" + dif + " estado=" + estado + " i=" + i + " servicio=" + servicio);
            modelo.AdicionarCarteraRevocatoria(placa.toUpperCase(), vig, Integer.parseInt(periodo), servicio, estado, (int) usuario.getId_usuario(), ano);
            modelo.AdicionarDetalleCarteraRevocatoria(placa.toUpperCase(), vig, servicio, (int) usuario.getId_usuario());

            vig++;
        }
        Movimiento movimiento = modelo.ConsultarMovimientoVehiculo(vehiculo.getId_vehiculo());
        if (movimiento != null) {
            movimiento.setEstado(2);
            modelo.actualizarMovimientoVehiculo(movimiento);
            Radicacion radicacion = modelo.consultarRadicacionPlacaTramite(numR, placa, 3);
            if (radicacion != null) {
                modelo.actualizarEstadoRadicacion(radicacion.getId_radicacion(), 9);
            }
        }
        modelo.actualizarEstadoVehiculo(idveh, 1, 1);
        modelo.AdicionarTrasladoCuenta(FResol, NResol, (int) usuario.getId_usuario(), vehiculo.getId_vehiculo());
        modelo.getCon().commit();
%>
<script>alert("Revocatoria Realizada Correctamente !!!");
        document.location.href = "revocatoria_tram_traslado.jsp";</script>
<%
    } catch (Exception ex) {
        modelo.getCon().rollback();
        System.out.println("/*-" + ex + "*/");
    }
%>
