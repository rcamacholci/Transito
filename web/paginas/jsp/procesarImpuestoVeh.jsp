<%-- 
    Document   : procesarImpuestoVeh
    Created on : 8/04/2013, 04:38:41 PM
    Author     : Sistemas
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8" import="modelo.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Procesar Impuesto Vehiculo</title>
    </head>
    <body>
<%

    Model modelo = (Model)session.getAttribute("model");
    Usuario usuario = (Usuario)session.getAttribute("usuario");
    Sede sede = (Sede)session.getAttribute("sede");
    
    modelo.getCon().setAutoCommit(false);

    try{
        
    Vehiculo vehiculo = modelo.consultarVehiculo(request.getParameter("placa"));
    Cartera c = modelo.consultarCarteraRev(vehiculo.getId_vehiculo());

    java.util.List lista = modelo.listarCarteraVehiPublico(vehiculo.getId_vehiculo());
    
    String fechah = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());
    java.sql.Date fecha_hoy = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(fechah).getTime());

    Concepto concep = modelo.consultarConcepto(Long.parseLong(request.getParameter("concepto")));

    long verificacion = 0;

    for(int i=0;i<lista.size();i++){
    Cartera car = (Cartera)lista.get(i);
        if(car.getFk_concepto()==concep.getId_concepto()){
            System.out.println("referencia: "+car.getReferencia());
            System.out.println("referencia 2: "+request.getParameter("concepto"));
            verificacion = 1;
        }
    }

    if(c!=null){

    if(verificacion==0){
    
    String fech = "01/01/"+concep.getDescripcion();

    java.sql.Date fec = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(fech).getTime());
    java.sql.Timestamp fechaH = new java.sql.Timestamp(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(fechah).getTime());

    Cartera cartera = new Cartera();
    cartera.setFk_vehiculo(vehiculo.getId_vehiculo());
    cartera.setFk_sede(sede.getId_sede());
    cartera.setTipo(2);
    cartera.setReferencia(concep.getDescripcion());
    cartera.setFecha_creacion(fec);
    cartera.setFecha_ingreso(fecha_hoy);
    cartera.setValor(Double.parseDouble(request.getParameter("vrImpuesto")));
    cartera.setSaldo(Double.parseDouble(request.getParameter("vrImpuesto")));
    cartera.setFecha_saldo(fecha_hoy);
    cartera.setEstado_cartera(1);
    cartera.setFecha_estado(fecha_hoy);
    cartera.setEstado_vigencia(1);
    cartera.setFecha_estado_vigencia(fecha_hoy);
    cartera.setFk_usuario(usuario.getId_usuario());
    cartera.setFk_concepto(Long.parseLong(request.getParameter("concepto")));
    cartera.setPeriodo(1);
    long id_cartera = modelo.adicionarCartera(cartera);


    Detalle_Cartera dt = new Detalle_Cartera();
    dt.setFk_cartera(id_cartera);
    dt.setFk_concepto(Long.parseLong(request.getParameter("concepto")));
    dt.setReferencia(concep.getDescripcion());
    dt.setFecha(fec);
    dt.setFecha_sistema(fechaH);
    dt.setFk_usuario(usuario.getId_usuario());
    dt.setEstado(1);
    dt.setValor(Float.parseFloat(request.getParameter("vrImpuesto")));
    modelo.adicionarDetalleCartera(dt);

    Detalle_Cartera dt2 = new Detalle_Cartera();
    dt2.setFk_cartera(id_cartera);
    dt2.setFk_concepto(1107);
    dt2.setReferencia(concep.getDescripcion());
    dt2.setFecha(fec);
    dt2.setFecha_sistema(fechaH);
    dt2.setFk_usuario(usuario.getId_usuario());
    dt2.setEstado(1);
    dt2.setValor((float)13300);
    modelo.adicionarDetalleCartera(dt2);

    modelo.getCon().commit();
    
%>
    <script>
        alert("Impuesto aplicado correctamente");
    </script>
    <%

    System.out.println("Cartera: "+id_cartera);

    }else{
    %>
    <script>
        alert("La cartera para la vigencia "+<%=concep.getDescripcion() %>+" ya se encuentra cargada");
    </script>
    <%
    }
    }else{

        String fech = "01/01/"+concep.getDescripcion();

    java.sql.Date fec = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(fech).getTime());
    java.sql.Timestamp fechaH = new java.sql.Timestamp(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(fechah).getTime());

    Cartera cartera = new Cartera();
    cartera.setFk_vehiculo(vehiculo.getId_vehiculo());
    cartera.setFk_sede(sede.getId_sede());
    cartera.setTipo(2);
    cartera.setReferencia(concep.getDescripcion());
    cartera.setFecha_creacion(fec);
    cartera.setFecha_ingreso(fecha_hoy);
    cartera.setValor(Double.parseDouble(request.getParameter("vrImpuesto")));
    cartera.setSaldo(Double.parseDouble(request.getParameter("vrImpuesto")));
    cartera.setFecha_saldo(fecha_hoy);
    cartera.setEstado_cartera(1);
    cartera.setFecha_estado(fecha_hoy);
    cartera.setEstado_vigencia(1);
    cartera.setFecha_estado_vigencia(fecha_hoy);
    cartera.setFk_usuario(usuario.getId_usuario());
    cartera.setFk_concepto(Long.parseLong(request.getParameter("concepto")));
    cartera.setPeriodo(1);
    long id_cartera = modelo.adicionarCartera(cartera);


    Detalle_Cartera dt = new Detalle_Cartera();
    dt.setFk_cartera(id_cartera);
    dt.setFk_concepto(Long.parseLong(request.getParameter("concepto")));
    dt.setReferencia(concep.getDescripcion());
    dt.setFecha(fec);
    dt.setFecha_sistema(fechaH);
    dt.setFk_usuario(usuario.getId_usuario());
    dt.setEstado(1);
    dt.setValor(Float.parseFloat(request.getParameter("vrImpuesto")));
    modelo.adicionarDetalleCartera(dt);

    modelo.getCon().commit();

%>
    <script>
        alert("Impuesto aplicado correctamente");
    </script>
    <%

    }

    }catch(Exception ex){
    System.out.println("ERROR: "+ex.getMessage());
    }

%>
    </body>
</html>