<%--
    Documento   : consultaFinanfrm
    Creado      : 23-mar-2010, 13:54:18
    Autor       : Desarrollo
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8" import="modelo.*,java.util.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%
    try {
        if (session.getAttribute("model") != null) {
            if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                
                modelo.Usuario usuario = (Usuario) session.getAttribute("usuario") ;
                modelo.Model model = (Model) session.getAttribute("model");
                Sede sede = (Sede) session.getAttribute("sede") ;
                long idComparendo = (request.getParameter("idc") != null) ? Long.parseLong(request.getParameter("idc")) : 0;
                long idProceso = (request.getParameter("idp") != null) ? Long.parseLong(request.getParameter("idp")) : 0;

                modelo.Comparendo comparendo = model.consultarComparendoById(idComparendo);
                modelo.ProcesoComparendo procesoC = model.consultarProcesoComparendo(idProceso);
                utility.Proceso proceso = model.consultarProceso(procesoC.getFkProceso());

                java.util.HashMap param = new java.util.HashMap();
                int tipo = procesoC.getTipo();
                String nombreR = proceso.getInforme();
                
                System.out.println("IDP  " + idProceso);
                System.out.println("TIPO  " + tipo);
                System.out.println("NOMBRE R  " + nombreR);

                if (tipo == 2) {
                    param.put("ID_COMPARENDO", comparendo.getId_comparendo());
                } else if (tipo == 3) {


                    java.util.HashMap listaTipos = model.crearHashParametrosAbreviatura(5);
                    modelo.Persona persona = model.consultarPersona(comparendo.getFk_persona());
                    String nombrePersona = persona.getApellido_1() + " " + (persona.getApellido_2() != null ? persona.getApellido_2() : "") + " " + persona.getNombre_1();
                    String documentoPersona = listaTipos.get(persona.getTipo_documento() + "") + " " + persona.getDocumento();

                    modelo.Cartera cartera = model.consultarCartera(comparendo.getFk_cartera());
                    modelo.Pago pago = model.consultarPago(cartera.getFk_pago());
                    modelo.Tiquete tiquete = model.consultarTiquetePorID(pago.getFk_tiquete());
                    
                    
                    System.out.println("TIQUETE  " +  tiquete.getId_tiquete());
                    
                    int security = ((int) (Math.random() * 100000));

                    java.util.HashMap parameters = new java.util.HashMap();
                    parameters.put("TIQUETE", tiquete.getId_tiquete());
                    parameters.put("NUMERO", tiquete.getNumero_factura());
                    parameters.put("FECHA", new java.text.SimpleDateFormat("dd/MM/yyyy").format(tiquete.getFecha()));
                    parameters.put("NOMBRE", nombrePersona);
                    parameters.put("NRO_DOC", documentoPersona);
                    Persona personaUsuario = model.consultarPersona(usuario.getFk_persona());
                    String nombreU = personaUsuario.getNombre_1() + " " + personaUsuario.getApellido_1() + " " + (personaUsuario.getApellido_2() != null ? personaUsuario.getApellido_2() : "");
                    parameters.put("USUARIO", nombreU);
                    parameters.put("SEGURIDAD", security + " Impresion ");
                    parameters.put("PLACA", comparendo.getPlaca());
                    parameters.put("VALOR", tiquete.getValor_total());
                    session.setAttribute("reporteOT", parameters);

                } else if (tipo == 5) {
                    modelo.Financiacion financiacion = model.consultarFinanciacion(procesoC.getResolucion());
                    param.put("ID_FINANCIACION", financiacion.getId_financiacion());
                } else {
                    param.put("PROCESO_COMPARENDO", procesoC.getIdProcesoComparendo());
                    //param.put("FK_SEDE" , sede.getId_sede() ) ;
                    System.out.println("AQUIIIIII " + procesoC.getIdProcesoComparendo());
                }

                session.setAttribute(nombreR, param);



%>
<jsp:forward page="../verReportes.jsp">
    <jsp:param name="nombreReporte" value="<%=nombreR%>"/>
    <jsp:param name="dirReporte" value="<%=proceso.getDirInforme()%>"/>
</jsp:forward>


<%  } else {%>
<jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="1"></jsp:param>
</jsp:forward>
<%  }
} else {%>
<script>
    window.parent.document.location.href = "../../index.jsp";
</script>  <%    }
} catch (Exception mexe) {%>
<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%            }%>