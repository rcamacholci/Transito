<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java"  errorPage="" import="modelo.*" pageEncoding="UTF-8"%>


<%
Model modelo = (Model)session.getAttribute("model");

try{

        modelo.getCon().setAutoCommit(false);
        Usuario usuario = (Usuario)session.getAttribute("usuario");
        String placa = request.getParameter("placa");
        int usu = (int)usuario.getId_usuario();
        int viIn = Integer.parseInt(request.getParameter("vigini"));
        int viFin = Integer.parseInt(request.getParameter("vigfin"));
        String observ = request.getParameter("observacion");
        //int NResol = Integer.parseInt(request.getParameter("numresolucion"));
        //java.sql.Date FResol = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecharesolucion")).getTime());
        //System.out.println("NResol= "+NResol+" FResol= "+FResol+" Usuario= "+usu);
        Vehiculo vehiculo = modelo.consultarVehiculo(placa.toUpperCase());
        int anoactual = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
        String ano = ""+anoactual+"".trim();
        String periodo = modelo.consultarPeriodoRev(vehiculo.getId_vehiculo());
        int servicio =(int)vehiculo.getServicio();

        if(servicio==1){
            if(vehiculo.getClase_vehiculo()==10||vehiculo.getClase_vehiculo()==13||vehiculo.getClase_vehiculo()==14||vehiculo.getClase_vehiculo()==17||vehiculo.getClase_vehiculo()==19){
                servicio = 3;
            }
        }

        //long idveh = vehiculo.getId_vehiculo();
        System.out.println("FE_INI= "+viIn+" FE_FIN= "+viFin+" Placa= "+placa+" Periodo= "+periodo+" Servicio= "+servicio+" Usuario= "+usu+" Observacion:"+observ);

        /*String periodo = modelo.consultarPeriodoRev(vehiculo.getId_vehiculo());
        int servicio=(int)vehiculo.getServicio();*/
        int i = viFin-viIn;
        int vig=viIn;
        int dif=0;
        int estado=0;
        int sw = 0;
        for(int x=0;x<=i;x++){
           dif=anoactual-vig;
           estado = dif>=3?4:dif==2?3:dif==1?2:1;
               System.out.println("dif="+dif+" estado="+estado+" i="+i+" servicio="+servicio);
               String vigS = ""+vig+"";
               Cartera carte = modelo.consultarCarteraImp(vehiculo.getId_vehiculo(), vigS);
               if(carte==null){
               modelo.CargarImpuestosCartera(placa.toUpperCase(), vig, Integer.parseInt(periodo), servicio, estado, (int)usuario.getId_usuario(), ano);
               modelo.CargarImpuestosDetalleCartera(placa.toUpperCase(), vig, servicio, (int)usuario.getId_usuario());
               sw++;
               }
           vig++;
           }
           //modelo.actualizarEstadoVehiculo(idveh,1,1);
        if(sw==0){
%>
            <script>alert("Las vigencias seleccionadas ya estan cargadas !!!"); document.location.href = "CargarImpuestos.jsp";</script>
<%
        }else{
           modelo.AdicionarCargueImpuesto(observ, (int)usuario.getId_usuario(), vehiculo.getId_vehiculo());
           modelo.getCon().commit();
%>
            <script>alert("Impuestos Cargados Correctamente !!!"); document.location.href = "CargarImpuestos.jsp";</script>
<%
        }
}catch(Exception ex){
    modelo.getCon().rollback();
    System.out.println("/*-"+ex+"*/");
}
%>
