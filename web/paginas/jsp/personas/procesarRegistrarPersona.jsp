<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html;charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" errorPage="" %>
 <%
 String msg = "";
 int tipo = 0;
 String documento = "";
 try{
if(session.getAttribute("model")!=null){
    modelo.Model model = (modelo.Model)session.getAttribute("model");
    modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
      UsuarioRunt userRunt = model.consultarUsuarioRunt(usuario.getId_usuario());
    Persona persona= new Persona();
    Inscripciones inscrip = new Inscripciones();
    java.sql.Date fechaSystem = new java.sql.Date(new java.util.Date().getTime());
    Direccion direccion=new Direccion();
    java.text.SimpleDateFormat formato = new java.text.SimpleDateFormat("dd/MM/yyyy");
    java.sql.Date  fecha_nacimiento = null;
    if(request.getParameter("tipo")!=null){
     tipo = Integer.parseInt(request.getParameter("tipo"));
    }
    documento    	= request.getParameter("documento");
    if(request.getParameter("date")!=null)
        if(request.getParameter("date").trim().length()>0)
            fecha_nacimiento = new java.sql.Date(formato.parse(request.getParameter("date")).getTime());

    String grupo_sanguineo  = request.getParameter("grupo_sanguineo");
    String rh               = request.getParameter("rh");
    String sexo             = request.getParameter("sexo");
    String primer_nombre    = request.getParameter("primer_nombre");
    String segundo_nombre   = request.getParameter("segundo_nombre");
    String primer_apellido  =  request.getParameter("primer_apellido");
    String segundo_apellido = request.getParameter("segundo_apellido");
    String email            = request.getParameter("email");
    String celular          = request.getParameter("celular");
    String noLiquidacion    = request.getParameter("noLiquidacion");
            
    java.sql.Date  fecha_expedicion = null;
    if(request.getParameter("fecha_expedicion")!=null)
        if(request.getParameter("fecha_expedicion").trim().length()>0)
            fecha_expedicion = new java.sql.Date(formato.parse(request.getParameter("fecha_expedicion")).getTime());

    String depar_nacim	= request.getParameter("depar_nacim");
    String munic_nacim    	= request.getParameter("municipio_nacim");
    String departamento 	= request.getParameter("departamentos");
    String municipio    	= request.getParameter("municipio");
    String dir_departamento   =  request.getParameter("dir_departamento");
    String dir_municipios     =  request.getParameter("dir_municipio");
    String direccion_pers     =  request.getParameter("direccion");
    String telefono     =  request.getParameter("telefono");

    if(primer_nombre!=null)
        persona.setNombre_1(primer_nombre.toUpperCase());
    if(segundo_nombre!=null)
        persona.setNombre_2(segundo_nombre.toUpperCase());
    if(primer_apellido!=null)
        persona.setApellido_1(primer_apellido.toUpperCase());
    if(segundo_apellido!=null)
        persona.setApellido_2(segundo_apellido.toUpperCase());
    if(fecha_nacimiento!=null)
        persona.setFecha_nac(fecha_nacimiento);
    if(grupo_sanguineo!=null)
        persona.setGrupo_sanguineo(grupo_sanguineo);
    if(rh!=null)
        persona.setRh(rh);
    if(sexo!=null)
        persona.setSexo(sexo);

    persona.setTipo_documento(tipo);
    persona.setDocumento(documento);

    if(municipio!=null){
        long id_dpto = Long.parseLong(departamento);
        long id_munp = Long.parseLong(municipio);
        if(id_dpto!=0&&id_munp!=0){
            Divipo div = model.consultarDvipo(id_dpto, id_munp);
            persona.setFk_divipo(div.getId_divipo());
        }
    }
    if(email!=null)
        persona.setEmail(email);
    if(celular!=null)
        persona.setCelular(celular);
    if(munic_nacim!=null){
        long dpto  = Long.parseLong(depar_nacim);
        long munp  = Long.parseLong(munic_nacim);
        if(dpto!=0&&munp!=0){
            Divipo div = model.consultarDvipo(dpto,munp);
            persona.setFk_lugar_nacimiento(div.getId_divipo());
        }
    }
    persona.setFecha_exp(fecha_expedicion);

    Persona p=  model.consultarPersona(tipo, documento);
    if(p!=null){
        model.actualizarPersona(persona, p.getId_persona());
        if(direccion_pers!=null){
            if(direccion_pers.trim().length()>0){
                if(dir_municipios!=null){
                    direccion.setDescripcion(direccion_pers);
                    direccion.setUbicacion(1);
                    direccion.setFecha(fechaSystem);
                    direccion.setEstado(1);
                    direccion.setFk_persona(p.getId_persona());
                    if(telefono!=null)
                        if(telefono.length()>0)
                            direccion.setTelefono(telefono);
                    long dpto  = Long.parseLong(dir_departamento);
                    long munp  = Long.parseLong(dir_municipios);
                    if(dpto!=0&&munp!=0){
                        Divipo div = model.consultarDvipo(dpto, munp);
                        direccion.setFk_divipo(div.getId_divipo());
                    }
                    
                    if(model.listado_direcciones_persona(p.getId_persona()).size()>0){
                        model.actualizarDireccion(direccion);
                    }else{
                        model.adicionarDireccion(direccion);
                    }
                }
            }
        }     
        
        msg = "La persona ha sido actualizada exitosamente";
    }else{
        long idPersona = model.adicionarPersona(persona);
        persona = model.consultarPersona(idPersona);
        if(direccion_pers!=null){
            if(direccion_pers.trim().length()>0){
                if(dir_municipios!=null){
                    direccion.setDescripcion(direccion_pers);
                    direccion.setUbicacion(1);
                    direccion.setFecha(fechaSystem);
                    direccion.setEstado(1);
                    direccion.setFk_persona(idPersona);
                    if(telefono!=null)
                        if(telefono.length()>0)
                            direccion.setTelefono(telefono);
                    long dpto  = Long.parseLong(dir_departamento);
                    long munp  = Long.parseLong(dir_municipios);
                    if(dpto!=0&&munp!=0){
                        Divipo div = model.consultarDvipo(dpto, munp);
                        direccion.setFk_divipo(div.getId_divipo());
                    }
                    model.adicionarDireccion(direccion);
                }
            }
        }
        

     
        model.getCon().commit();
        msg = "La persona ha sido ingresada exitosamente";
    }
    if(request.getParameter("resultado").equals("0")){

        String mensajeTramiteRunt = "";
        com.heinsohn.runt.general.solicitudes.InscribirPersonaNaturalInDTO radicarSolicitudOut = null;
        webservices.radicacion.RadicacionServicesClient radicacionService = new webservices.radicacion.RadicacionServicesClient();
        radicacionService.setTokenHuellaDigital("");
        radicacionService.setUser(userRunt.getCodigo());
        Model.userHandler = userRunt.getCodigo();
        Model.passUserHandler = userRunt.getPassword();
        if(session.getAttribute("token2")!=null){
            radicacionService.setTokenHuellaDigital(session.getAttribute("token2").toString());
         }
        String tipoDocumento = "";
        switch(persona.getTipo_documento()){
            case 1: tipoDocumento = "C";break;
            case 3: tipoDocumento = "E";break;
            case 4: tipoDocumento = "T";break;
            case 5: tipoDocumento = "P";break;
        }
        String numeroDoc = persona.getDocumento();
        String nombre1 = persona.getNombre_1();
        String nombre2 = persona.getNombre_2();
        String apellido1 = persona.getApellido_1();
        String apellido2 = persona.getApellido_2();
        String sex = persona.getSexo();
        String tiporh = persona.getGrupo_sanguineo()+persona.getRh();
        java.sql.Date fexpedicion = persona.getFecha_exp();
        java.sql.Date fnacimiento = persona.getFecha_nac();
        String municipioNac = "";
        if(persona.getFk_lugar_nacimiento()!=0)
            municipioNac = model.getDivipo(persona.getFk_lugar_nacimiento()).getCodigo();
        String cel = persona.getCelular();
        String mail = persona.getEmail();
        java.util.List<com.heinsohn.runt.general.personas.DireccionDTO> direcciones = new java.util.LinkedList<com.heinsohn.runt.general.personas.DireccionDTO>();

        if(direccion_pers!=null){
            if(direccion_pers.trim().length()>0){
                if(dir_municipios!=null){
                    com.heinsohn.runt.general.personas.DireccionDTO dir = new com.heinsohn.runt.general.personas.DireccionDTO();
                    direccion.setDescripcion(direccion_pers);
                    direccion.setUbicacion(1);
                    direccion.setFecha(fechaSystem);
                    direccion.setEstado(1);
                    direccion.setFk_persona(persona.getId_persona());
                    long dpto  = Long.parseLong(dir_departamento);
                    long munp  = Long.parseLong(dir_municipios);
                    if(dpto!=0&&munp!=0){
                        Divipo div = model.consultarDvipo(dpto, munp);
                        direccion.setFk_divipo(div.getId_divipo());
                    }
                    dir.setDireccion(direccion.getDescripcion());
                    if(telefono!=null)
                        if(telefono.length()>0)
                            dir.setTelefono(telefono);
                    dir.setTipoDireccion("CASA");//Parametrizar
                    if(dpto!=0&&munp!=0){
                        com.heinsohn.runt.general.identificaciones.IdentificadorGeografiaDTO dir_mun = new com.heinsohn.runt.general.identificaciones.IdentificadorGeografiaDTO();
                        String municipioDir = model.getDivipo(direccion.getFk_divipo()).getCodigo();
                        dir_mun.setIdMunicipio(Integer.parseInt(municipioDir)+"");
                        dir.setMunicipio(dir_mun);
                    }
                    direcciones.add(dir);
                }
            }
        }
        java.util.List<com.heinsohn.runt.general.solicitudes.MotivoRechazoHuellaDTO> rechazos = new java.util.LinkedList<com.heinsohn.runt.general.solicitudes.MotivoRechazoHuellaDTO>();

        String trama = "";
        if(request.getParameter("token2")!=null){
            trama = request.getParameter("token2");
        }

            com.heinsohn.runt.general.solicitudes.InscribirPersonaOutDTO inscripcion = radicacionService.inscribirPersonaNatural(tipoDocumento, numeroDoc, nombre1, nombre2, apellido1, apellido2, sex, tiporh,fexpedicion, fnacimiento, municipioNac, cel, mail, direcciones, rechazos,trama,noLiquidacion);
            if(inscripcion!=null){
                if(inscripcion.getStatus()!=null){
                    if(inscripcion.getStatus().getStatusCode().equals("1")){
                        Persona per = model.consultarPersona(tipo, documento);
                        if(per!=null){
                           inscrip.setESTADO(1);
                           inscrip.setFK_PERSONA(per.getId_persona());
                           inscrip.setFK_USUARIO(usuario.getId_usuario());
                           model.adicionarInscripcion(inscrip);

                        }


                        %>
                         <script type='text/javascript' language='javascript'>
                alert("Inscripcion Del ciudadano Exitosa");
                window.parent.document.location.href = "registrarPersona.jsp";
            </script><%      
                    




                    }else{
                         %>
                            <script type='text/javascript' language='javascript'>
                                alert('<%=inscripcion.getStatus().getStatusDesc()%>');
                                window.parent.document.getElementById("primero").style.display = "block";
                                window.parent.document.getElementById("segundo").style.display = "none";
                            </script>
                         <%
                    }
                }
             }else{
                mensajeTramiteRunt = "No se puede acceder al servicio Web, intente nuevamente"; %>
                <script type='text/javascript' language='javascript'>
                    alert('<%=mensajeTramiteRunt%>');
                    window.parent.document.getElementById("primero").style.display = "block";
                    window.parent.document.getElementById("segundo").style.display = "none";
                 </script>
         <%  }
        }else{ %>
            <script type='text/javascript' language='javascript'>
                alert('<%=msg%>');
                window.parent.document.location.href = "registrarPersona.jsp";
            </script>
    <%  }
    }else{ %>
     <script>window.parent.document.location.href = "../../index.jsp";</script>
<%  }
}catch(Exception mexe){
    mexe.printStackTrace();

 } %>
