<?xml version="1.0" encoding="UTF-8"?>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" import="java.util.*,modelo.*" %>
<root>
<% Model modelo= (Model)session.getAttribute("model");
if (!request.getParameter("tipo").equals(null)&&!request.getParameter("documento").equals(null)){
    String mensaje = "";
     try {
	co.gov.curso.simit.WSSimitCursoService service = new co.gov.curso.simit.WSSimitCursoService();
        co.gov.curso.simit.WSSimitCurso port = service.getWSSimitCursoPort();
        String tdoc = request.getParameter("tipo");
     //   System.out.println(" t : "+request.getParameter("tipo"));
        String doc = request.getParameter("documento");
       // System.out.println(" d : "+request.getParameter("documento"));
        String tipoI = tdoc;
        String Iinfrac = doc;
        Persona persona = modelo.consultarPersona(Integer.parseInt(tdoc), doc);
        String Hora = "15355000";
        String usuario = "70852125";
        String fecha = "20110726";
        String cuidad = "11001000";
        String CodScia = "0001";
        String codTrac = "000001";
        String Codcia = "9002852265";
        String Numsec = "1";
        String DircAdq = "127.0.0.1";
        

        co.gov.curso.simit.DatosEntradaComparendosDescuento comparendoCurso = new co.gov.curso.simit.DatosEntradaComparendosDescuento();
        comparendoCurso.setTipoIdentificacion(tipoI);
        comparendoCurso.setIdentificacionInfractor(Iinfrac);
        comparendoCurso.setCiudadCia(cuidad);
        comparendoCurso.setHoraTransaccion(Hora);
        comparendoCurso.setFuncionarioConsulta(usuario);
        comparendoCurso.setCodigoSedeCia(CodScia);
        comparendoCurso.setDireccionAdquiriente(DircAdq);
        comparendoCurso.setNumeroSecuencia(Numsec);
        comparendoCurso.setCodigoTransaccion(codTrac);
        comparendoCurso.setCodigoCia(Codcia);
        comparendoCurso.setFechaTransaccion(fecha);
        // TODO process result here
        co.gov.curso.simit.DatosSalidaComparendosDescuento result = port.wsSimitComparendosDescuentos(comparendoCurso);
        if(result.getMensajeRespuesta().equals("Operacion correcta")){
            co.gov.curso.simit.ComparendoDescuento comp = null;
            String resolucion = "";
            java.util.List<co.gov.curso.simit.ComparendoDescuento> list = result.getComparendosDescuento();
            java.util.Iterator it = list.iterator();
            while (it.hasNext()) {
                comp = (co.gov.curso.simit.ComparendoDescuento)it.next();
                System.out.println("Num Comparendo : "+comp.getNumeroComparendo());
                System.out.println("Num Resolucion : "+comp.getNumeroResolucion());
                if(comp.getNumeroResolucion()!=null&&!comp.getNumeroResolucion().equals("")){
                    resolucion = comp.getNumeroResolucion();
                }
            }

            System.out.println("Num Resolucion 2 : "+resolucion);

            if(resolucion.equals("")){
                System.out.println(" Respuesta : "+Iinfrac+" - INFRACCION EN ESTADO COMPARENDOS");
                mensaje = " Respuesta : La persona y/o Empresa "+persona.getNombre_1()+" "+persona.getApellido_1()+" con identificacion "+Iinfrac+" - ESTA A PAZ Y SALVO";
            }else{
                System.out.println(" Respuesta : "+Iinfrac+" - INFRACTOR CON COMPARENDOS PENDIENTES");
                mensaje = " Respuesta : La persona y/o Empresa "+persona.getNombre_1()+" "+persona.getApellido_1()+" con identificacion "+Iinfrac+" - TIENE COMPARENDOS PENDIENTES";
            }
            
        }else{
            System.out.println(" Respuesta : "+Iinfrac+" - "+result.getMensajeRespuesta());
            mensaje = " Respuesta : La persona y/o Empresa "+persona.getNombre_1()+" "+persona.getApellido_1()+" con identificacion "+Iinfrac+" - ESTA A PAZ Y SALVO";
        }

        %>
         <result><%=mensaje%></result>
       <%
    } catch (Exception ex) {
         ex.printStackTrace();
          mensaje = "No se pudo realizar la consulta via WEB al Simit, Vuelva a intentarlo...";
          %>
       <result><%=mensaje%></result>
         <%
	// TODO handle custom exceptions here
    }
     }


%>

</root>




