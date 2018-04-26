<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
</head>

<body>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<%

Model modelo= (Model)session.getAttribute("model");
modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
String mensaje ="";
long numero_interno = 0;
try{
    Oficio_Embargo OficioE = new Oficio_Embargo();
    String numOficio = "",municipio = "",placa = "";
    java.sql.Date fechaO, fechaR;
    int novedad;
    String solicitante = "",cargo = "",direccion = "", referencia = "",numRadicacion = "", entidad = "";
    java.sql.Timestamp fechaSystem= new java.sql.Timestamp(new java.util.Date().getTime());

        if((request.getParameter("numOficio")!=null)&&(request.getParameter("fechaO")!=null)){
            numOficio =  request.getParameter("numOficio");
            OficioE.setNum_oficio(numOficio); 

            fechaO = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fechaO")).getTime());
            OficioE.setFecha_oficio(fechaO);

            if(request.getParameter("municipio")!=null){
                municipio = request.getParameter("municipio");
                OficioE.setMunicipio(municipio);
            }

            if(request.getParameter("entidad")!=null){
                entidad = request.getParameter("entidad");
                OficioE.setEntidad(entidad);
            }

            if(request.getParameter("placa")!=null){
                placa = request.getParameter("placa");
                Vehiculo vehiculo = modelo.consultarVehiculo(placa.toUpperCase());
                if(vehiculo!=null){
                    OficioE.setFk_vehiculo(vehiculo.getId_vehiculo());
                }
            }

            if(request.getParameter("novedad")!=null){
                novedad = Integer.parseInt(request.getParameter("novedad"));
                OficioE.setNovedad(novedad);
            }

            OficioE.setEstado(1);
            OficioE.setFecha_proceso(fechaSystem);
            OficioE.setFk_usuario(usuario.getId_usuario());

            if(request.getParameter("solicitante")!=null){
                solicitante = request.getParameter("solicitante");
                OficioE.setSolicitante(solicitante);
            }

            if(request.getParameter("cargo")!=null){
                cargo = request.getParameter("cargo");
                OficioE.setCargo(cargo);
            }

             if(request.getParameter("direccion")!=null){
                direccion = request.getParameter("direccion");
                OficioE.setDireccion(direccion);
            }

             if(request.getParameter("referencia")!=null&&!request.getParameter("referencia").isEmpty()){
                referencia = request.getParameter("referencia");
                OficioE.setReferencia(referencia);
            }
            if(request.getParameter("numRadicacion")!=null){
                numRadicacion = request.getParameter("numRadicacion");
                OficioE.setNum_radicacion(numRadicacion);
            }

            if(request.getParameter("fechaR")!=null){
                fechaR = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fechaR")).getTime());
                OficioE.setFecha_radicacion(fechaR);
            }

            if(request.getParameter("num").equals("1")){
                    modelo.getCon().setAutoCommit(false);
                    modelo.adicionarOficioEmbargo(OficioE);
                    mensaje = "Solicitud Realizada con Exito";
                    modelo.getCon().commit();
            }else{
                if(request.getParameter("num").equals("2")){
                    if(request.getParameter("id_oficio")!=null){

                        long id_oficio = Long.parseLong(request.getParameter("id_oficio"));
                        OficioE.setId_oficio(id_oficio);
                        modelo.getCon().setAutoCommit(false);
                        modelo.editarOficioEmbargo(OficioE);
                        mensaje = "1";
                        modelo.getCon().commit();
                    }
                    
                }
           }



       }else{
           mensaje= "SOlicitud de Oficio No pudo ser Ingresada";
       }
%>


    <%
	}catch(Exception ecx){
		modelo.getCon().rollback();
		ecx.printStackTrace();        %>
		<script language="javascript" type="text/javascript">
			alert("Solicitud No pudo Ser Realizada");
			document.location.href = "GenerarOficioEmbargo.jsp";
		</script>
<%  } %>

<%

    try{

        long proc = Long.parseLong(request.getParameter("proc"));
        
        if(proc==1){
        
        modelo.getCon().setAutoCommit(false);

        int departamento =     Integer.parseInt(request.getParameter("departamento"));
        int municipio    =     Integer.parseInt(request.getParameter("municipio"));

        String placa = request.getParameter("placa");
        Vehiculo vehic = modelo.consultarVehiculo(placa.toUpperCase());
        long vehiculo  = vehic.getId_vehiculo();

        long oficina  = Long.parseLong(request.getParameter("oficina"));
        int tipoembargo   = Integer.parseInt(request.getParameter("tipoembargo"));
        int proceso  =  Integer.parseInt(request.getParameter("proceso"));
        String numero_oficio = request.getParameter("numOficio");
        java.sql.Date  fecha_oficio = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fechaO")).getTime());
        String observacion  =  request.getParameter("observacion");
        String demandante = request.getParameter("demandante");
        String numero_radicacion = request.getParameter("numRadicacion");
       java.sql.Date fecha_radicacion = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fechaR")).getTime());

        long consecutivo = (modelo.Ultimo_Embargo()+1);
        Embargo embargo =  new Embargo();
        Usuario user = (Usuario)session.getAttribute("usuario");
        embargo.setFk_usuario(user.getId_usuario());
        embargo.setProceso(proceso);
        embargo.setTipo(tipoembargo);
        embargo.setFecha_oficio(fecha_oficio);
        embargo.setOficio(numero_oficio);
        embargo.setObservaciones(observacion);
        embargo.setDemandante(demandante);
        embargo.setFecha_proceso(new java.sql.Timestamp(new java.util.Date().getTime()));
        embargo.setFk_oficina(oficina);
        embargo.setFk_vehiculo(vehiculo);
        Sede sede = (Sede)session.getAttribute("sede");
        embargo.setFk_sede(sede.getId_sede());
        Divipo div= modelo.consultarDvipo(departamento, municipio);
        embargo.setFk_divipo(div.getId_divipo());
        embargo.setNro_radicacion(numero_radicacion);
        embargo.setFecha_radicacion(fecha_radicacion);
        embargo.setId_embargo(consecutivo);
        modelo.adicionarEmbargo(embargo);
        modelo.actualizarOficioIdEmbargo(consecutivo,numero_oficio , fecha_oficio);
        modelo.getCon().commit();
       }else{

            String nro_levantamiento = request.getParameter("numOficio");
            java.sql.Date fechaO = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fechaO")).getTime());
            long id_embargo = Long.parseLong(request.getParameter("radio"));

            modelo.actualizarLevantamientoEmbargo(nro_levantamiento, fechaO , id_embargo);
            modelo.actualizarOficioIdEmbargo(id_embargo, nro_levantamiento, fechaO);
            modelo.getCon().commit();
       }

        }catch(Exception ecx){
        modelo.getCon().rollback();
        ecx.printStackTrace();        %>
                <script language="javascript" type="text/javascript">alert("El embargo no pudo ser ingresado");document.location.href = "GenerarOficioEmbargo.jsp?id=1";</script>
<%  }%>


<% if(!mensaje.equals("")){
        if(mensaje.equals("1")){%>
            <script language="javascript" type="text/javascript">
                alert("Mensaje : Actualizacion Exitosa");
            </script>
        <%}else{

        %>
        <script language="javascript" type="text/javascript">
           alert("Mensaje : <%=mensaje%>");
            document.location.href = "GenerarOficioEmbargo.jsp";
	</script>
   <% }
   }
%>


</body>
</html>
