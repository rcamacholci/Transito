<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="modelo.*" import="java.util.*"%>
 <%
 try{
if(session.getAttribute("usuario")!=null){
    modelo.Model model = (modelo.Model)session.getAttribute("model");
    if(model!=null){
        modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
        if(model.tienePermiso(usuario.getId_usuario(), 32)){
            Persona persona= new Persona();
    Model modelo= (Model)session.getAttribute("model");
    try{
        java.sql.Date fechaSystem = new java.sql.Date(new java.util.Date().getTime());
        modelo.getCon().setAutoCommit(false);
        Direccion direccion=new Direccion();
        java.text.SimpleDateFormat formato = new java.text.SimpleDateFormat("dd/MM/yyyy");
        int  paso = Integer.parseInt(request.getParameter("paso")) ;
        int  tipo = Integer.parseInt(request.getParameter("tipo")) ;
        if(tipo!=2){
            java.sql.Date  fecha_nacimiento = null;
            if(request.getParameter("date")!=null)
                fecha_nacimiento = new java.sql.Date(formato.parse(request.getParameter("date")).getTime());
            String grupo_sanguineo  = request.getParameter("grupo_sanguineo");
            String rh               = request.getParameter("rh");
            String sexo             = request.getParameter("sexo");
            String primer_nombre    = request.getParameter("primer_nombre");
            String segundo_nombre   = request.getParameter("segundo_nombre");
            String primer_apellido  =  request.getParameter("primer_apellido");
            String segundo_apellido = request.getParameter("segundo_apellido");
            String documento    	= request.getParameter("documento");
            String email            = request.getParameter("email");
            String celular          = request.getParameter("celular");
            java.sql.Date  fecha_expedicion = null;
            if((request.getParameter("fecha_expedicion")!=null)&&(!request.getParameter("fecha_expedicion").isEmpty()))
                fecha_expedicion = new java.sql.Date(formato.parse(request.getParameter("fecha_expedicion")).getTime());
            String depar_nacim	= request.getParameter("depar_nacim");
            String munic_nacim    	= request.getParameter("municipio_nacim");
            String nacionalidad 	= request.getParameter("nacionalidad");
            String departamento 	= request.getParameter("departamentos");
            String municipio    	= request.getParameter("municipio");
            String dir_departamento   =  request.getParameter("dir_departamento");
            String dir_municipios     =  request.getParameter("dir_municipio");
            String direccion_pers     =  request.getParameter("direccion");
            String telefono     =  request.getParameter("telefono");

            primer_nombre    =    primer_nombre.toUpperCase();
            segundo_nombre   =    segundo_nombre.toUpperCase();
            primer_apellido  =    primer_apellido.toUpperCase();
            segundo_apellido =    segundo_apellido.toUpperCase();
            if(fecha_nacimiento!=null)
                persona.setFecha_nac(fecha_nacimiento);
            if(grupo_sanguineo!=null)
                persona.setGrupo_sanguineo(grupo_sanguineo);
            if(rh!=null)
                persona.setRh(rh);
            if(sexo!=null)
                persona.setSexo(sexo);
            if(primer_nombre!=null)
                persona.setNombre_1(primer_nombre);
            if(segundo_nombre!=null)
                persona.setNombre_2(segundo_nombre);
            if(primer_apellido!=null)
                persona.setApellido_1(primer_apellido);
            if(segundo_apellido!=null)
                persona.setApellido_2(segundo_apellido);
            persona.setTipo_documento(tipo);
            persona.setDocumento(documento);
            if(municipio!=null){
                long id_dpto = Long.parseLong(departamento);
                long id_munp = Long.parseLong(municipio);
                if(id_dpto!=0&&id_munp!=0){
                    Divipo div = modelo.consultarDvipo(id_dpto, id_munp);
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
                    Divipo div = modelo.consultarDvipo(dpto,munp);
                    persona.setFk_lugar_nacimiento(div.getId_divipo());
                }
            }
            persona.setFecha_exp(fecha_expedicion);

            Biometrico biometrico = new Biometrico();

            byte[] template = null;
            byte[] huella1 = null;
            byte[] huella2 = null;
            int dedo1 = 0;
            int dedo2 = 0;
            String template2 = "";
            byte[] foto = null;
            if(request.getParameter("foto")!=null)
                foto = request.getParameter("foto").getBytes();
            byte[] firma = null;
            if(request.getParameter("firma")!=null)
                firma = request.getParameter("firma").getBytes();
            byte[] bidimensional = null;
            if(request.getParameter("bidimensional")!=null)
                bidimensional = request.getParameter("bidimensional").getBytes();
            if(request.getParameter("bhuella")!=null){
				if(request.getParameter("template")!=null){
					template = request.getParameter("template").getBytes();
					template2 = request.getParameter("template");
				}
                if(request.getParameter("dedo1")!=null)
                    if(request.getParameter("dedo1").trim().length()>0)
                        dedo1 = Integer.parseInt(request.getParameter("dedo1"));
                if(request.getParameter("dedo2")!=null)
                    if(request.getParameter("dedo2").trim().length()>0)
                        dedo2 = Integer.parseInt(request.getParameter("dedo2"));
                if(request.getParameter("huella1")!=null)
                    huella1 = request.getParameter("huella1").getBytes();
                if(request.getParameter("huella2")!=null)
                    huella2 = request.getParameter("huella2").getBytes();
            }
            String estadoBiometricos = request.getParameter("biometric");

            biometrico.setTemplate(template);
            biometrico.setFoto(foto);
            biometrico.setBidimensional(bidimensional);
            biometrico.setFirma(firma);
            biometrico.setDedo1(dedo1);
            biometrico.setDedo2(dedo2);
            biometrico.setHuella1(huella1);
            biometrico.setHuella2(huella2);
			if(request.getParameter("bhuella")==null){
				try{
					biometrico.setMotivoRechazo(Integer.parseInt(request.getParameter("motivos")));
				}catch(Exception excM){
					biometrico.setMotivoRechazo(1);
				}
			}

            Persona p=  modelo.consultarPersona(tipo, documento);
            if(paso==1||paso==4){
                    if(p!=null){
                        if(model.tienePermiso(usuario.getId_usuario(), 33)){
                            modelo.actualizarPersona(persona, p.getId_persona());
                            if(direccion_pers!=null){
                                if(direccion_pers.trim().length()>0){
                                    if(dir_municipios!=null){
                                        direccion.setDescripcion(direccion_pers);
                                        direccion.setUbicacion(1);
                                        direccion.setFecha(fechaSystem);
                                        direccion.setEstado(1);
                                        direccion.setFk_persona(p.getId_persona());
                                        direccion.setTelefono(telefono);
                                        long dpto  = Long.parseLong(dir_departamento);
                                        long munp  = Long.parseLong(dir_municipios);
                                        if(dpto!=0&&munp!=0){
                                            Divipo div = modelo.consultarDvipo(dpto, munp);
                                            direccion.setFk_divipo(div.getId_divipo());
                                        }
                                        if(modelo.listado_direcciones_persona(p.getId_persona()).size()>0){
                                            modelo.actualizarDireccion(direccion);
                                        }else{
                                            modelo.adicionarDireccion(direccion);
                                        }
                                    }
                                }
                            }
                            if(estadoBiometricos.equals("1")){
                                biometrico.setId_persona(p.getId_persona());
                                modelo.actualizarBiometrico(biometrico);
                            }
                            modelo.getCon().commit();
                        }
                        if(paso!=4){ %>
                            <jsp:forward page="consultarPersonaRUNT.jsp">
                                <jsp:param name="paso" value="1"></jsp:param>
                                <jsp:param name="bbdd" value="2"></jsp:param>
                                <jsp:param name="tipo" value="<%=tipo%>"></jsp:param>
                                <jsp:param name="documento" value="<%=documento%>"></jsp:param>
                            </jsp:forward>
                     <%  }
                    }
            }
            if(paso==3||paso==4){
                if(p==null){
                    if(model.tienePermiso(usuario.getId_usuario(), 32)){
                        modelo.adicionarPersona(persona);
                        p = modelo.consultarPersona(tipo, documento);
                        if(direccion_pers!=null){
                            if(direccion_pers.trim().length()>0){
                                if(dir_municipios!=null){
                                    direccion.setDescripcion(direccion_pers);
                                    direccion.setUbicacion(1);
                                    direccion.setFecha(fechaSystem);
                                    direccion.setEstado(1);
                                    direccion.setFk_persona(p.getId_persona());
                                                                    direccion.setTelefono(telefono);
                                    long dpto  = Long.parseLong(dir_departamento);
                                    long munp  = Long.parseLong(dir_municipios);
                                    if(dpto!=0&&munp!=0){
                                        Divipo div = modelo.consultarDvipo(dpto, munp);
                                        direccion.setFk_divipo(div.getId_divipo());
                                    }
                                    modelo.adicionarDireccion(direccion);
                                }
                            }
                        }
                        if(estadoBiometricos.equals("1")){
                            biometrico.setId_persona(p.getId_persona());
                            modelo.actualizarBiometrico(biometrico);
                        }
                        modelo.getCon().commit();
                    }
                    if(paso!=4){ %>
                        <jsp:forward page="consultarPersonaRUNT.jsp">
                            <jsp:param name="paso" value="1"></jsp:param>
                            <jsp:param name="bbdd" value="1"></jsp:param>
                            <jsp:param name="tipo" value="<%=tipo%>"></jsp:param>
                            <jsp:param name="documento" value="<%=documento%>"></jsp:param>
                        </jsp:forward>
                  <% }
                }
            }
            if(paso==30){
                String mensajeTramiteRunt = "";
                com.heinsohn.runt.general.solicitudes.InscribirPersonaNaturalInDTO radicarSolicitudOut = null;
                webservices.radicacion.RadicacionServicesClient radicacionService = new webservices.radicacion.RadicacionServicesClient();
                radicacionService.setTokenHuellaDigital(Model.userToken);
                radicacionService.setUser(Model.userHandler);
                com.heinsohn.runt.general.identificaciones.StatusDTO status = radicacionService.verificarEstadoWS();
                if(status!=null){
                    if(status.getStatusCode().equals("1")||status.getStatusCode().equals("2")){
                        String tipoDocumento = modelo.consultarParametro((int)persona.getTipo_documento(),5).getNombreCorto();
                        String numeroDoc = persona.getDocumento();
                        String nombre1 = persona.getNombre_1();
                        String nombre2 = persona.getNombre_2();
                        String apellido1 = persona.getApellido_1();
                        String apellido2 = persona.getApellido_2();
                        String sex = persona.getSexo();
                        String tiporh = persona.getGrupo_sanguineo()+persona.getRh();
                        java.sql.Date fexpedicion = persona.getFecha_exp();
                        java.sql.Date fnacimiento = persona.getFecha_nac();
                        String municipioNac = modelo.getDivipo(persona.getFk_lugar_nacimiento()).getCodigo();
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
                                    direccion.setFk_persona(p.getId_persona());
                                    long dpto  = Long.parseLong(dir_departamento);
                                    long munp  = Long.parseLong(dir_municipios);
                                    if(dpto!=0&&munp!=0){
                                        Divipo div = modelo.consultarDvipo(dpto, munp);
                                        direccion.setFk_divipo(div.getId_divipo());
                                    }
                                    dir.setDireccion(direccion.getDescripcion());
                                    dir.setTelefono(direccion.getTelefono());
                                    dir.setFax(direccion.getFax());
                                    dir.setTipoDireccion("CASA");//Parametrizar
                                    if(dpto!=0&&munp!=0){
                                        com.heinsohn.runt.general.identificaciones.IdentificadorGeografiaDTO dir_mun = new com.heinsohn.runt.general.identificaciones.IdentificadorGeografiaDTO();
                                        String municipioDir = modelo.getDivipo(direccion.getFk_divipo()).getCodigo();
                                        dir_mun.setIdMunicipio(Integer.parseInt(municipioDir)+"");
                                        dir.setMunicipio(dir_mun);
                                    }
                                    direcciones.add(dir);
                                }
                            }
                        }
                        java.util.List<com.heinsohn.runt.general.solicitudes.MotivoRechazoHuellaDTO> rechazos = new java.util.LinkedList<com.heinsohn.runt.general.solicitudes.MotivoRechazoHuellaDTO>();

                        java.util.List<com.heinsohn.runt.general.solicitudes.ImagenHuellaDedoDTO> huellas = new java.util.LinkedList<com.heinsohn.runt.general.solicitudes.ImagenHuellaDedoDTO>();
                        if(huella1!=null){
                            com.heinsohn.runt.general.solicitudes.ImagenHuellaDedoDTO ImagenHuella1 = new com.heinsohn.runt.general.solicitudes.ImagenHuellaDedoDTO();
                            ImagenHuella1.setTipoDedo(dedo1+"");
                            byte[] imageBytes = Base64Coder.decode(new String(huella1));
                            ImagenHuella1.setFotoHuella(imageBytes);
                            huellas.add(ImagenHuella1);
                        }
                        if(huella2!=null){
                            com.heinsohn.runt.general.solicitudes.ImagenHuellaDedoDTO ImagenHuella2 = new com.heinsohn.runt.general.solicitudes.ImagenHuellaDedoDTO();
                            ImagenHuella2.setTipoDedo(dedo2+"");
                            byte[] imageBytes = Base64Coder.decode(new String(huella2));
                            ImagenHuella2.setFotoHuella(imageBytes);
                            huellas.add(ImagenHuella2);
                        }
                        if(request.getParameter("bhuella")==null){
                            com.heinsohn.runt.general.solicitudes.MotivoRechazoHuellaDTO motivo = new com.heinsohn.runt.general.solicitudes.MotivoRechazoHuellaDTO();
                            motivo.setId(request.getParameter("motivos"));
                            rechazos.add(motivo);
                        }
                        byte[] imageFoto = null;
                       // if(foto!=null)
                       //     imageFoto = Base64Coder.decode(new String(foto));
                        String imageTemplate = "";
                        if(template2!=null)
                            imageTemplate = template2;
                        byte[] imageFirma = null;
                        if(firma!=null)
                            imageFirma = Base64Coder.decode(new String(firma));
                        byte[] imageBidimensional = null;
                        if(bidimensional!=null)
                            imageBidimensional = Base64Coder.decode(new String(bidimensional));
                             if(model.tienePermiso(usuario.getId_usuario(), 36)){
                                //com.heinsohn.runt.general.solicitudes.InscribirPersonaOutDTO inscripcion = radicacionService.inscribirPersonaNatural(tipoDocumento, numeroDoc, nombre1, nombre2, apellido1, apellido2, sex, tiporh,fexpedicion, fnacimiento, municipioNac, cel, mail, direcciones, rechazos,null);
                                //com.heinsohn.runt.general.solicitudes.InscribirPersonaOutDTO inscripcion = radicacionService.inscribirPersonaNatural(tipoDocumento, numeroDoc, nombre1, nombre2, apellido1, apellido2, sex, tiporh,fexpedicion, fnacimiento, municipioNac, cel, mail, direcciones, rechazos,null);
                                com.heinsohn.runt.general.solicitudes.InscribirPersonaOutDTO inscripcion = radicacionService.inscribirPersonaNatural(tipoDocumento, numeroDoc, nombre1, nombre2, apellido1, apellido2, sex, tiporh,fexpedicion, fnacimiento, municipioNac, cel, mail, direcciones, rechazos, "", "");
                                
                                if(inscripcion!=null){
                                    if(inscripcion.getStatus()!=null){
                                        if(inscripcion.getStatus().getStatusCode().equals("1")){
                                           // session.setAttribute("certificado", inscripcion.getCertificado());
                                           // Reports reporteRunt = new Reports(inscripcion.getCertificado(),response);
                                            mensajeTramiteRunt = "RUNT: "+inscripcion.getStatus().getStatusDesc();
                                            modelo.getCon().commit();
                                            %>
                                            <jsp:forward page="consultarPersonaRUNT.jsp">
                                                <jsp:param name="paso" value="2"></jsp:param>
                                                <jsp:param name="runt" value="1"></jsp:param>
                                                <jsp:param name="tipo" value="<%=tipo%>"></jsp:param>
                                                <jsp:param name="documento" value="<%=documento%>"></jsp:param>
                                                <jsp:param name="msg" value="<%=mensajeTramiteRunt%>"></jsp:param>
                                            </jsp:forward>
                                            <%
                                        }else{
                                            mensajeTramiteRunt = "RUNT: "+inscripcion.getStatus().getStatusDesc();
                                        }
                                    }else{
                                        mensajeTramiteRunt = "CIVITRANS: No existe respuesta a la Solicitud de Inscripcion RUNT";
                                    }
                                 }else{
                                    mensajeTramiteRunt = "CIVITRANS: No existe respuesta a la Solicitud de Inscripcion RUNT";
                                 }
                            }
                    }else{
                        mensajeTramiteRunt = "RUNT: "+status.getStatusDesc();
                    }
                }else{
                    mensajeTramiteRunt = "CIVITRANS: No existe conexion con el RUNT";
                }
                 %>
                <jsp:forward page="consultarPersonaRUNT.jsp">
                    <jsp:param name="paso" value="1"></jsp:param>
                    <jsp:param name="bbdd" value="3"></jsp:param>
                    <jsp:param name="tipo" value="_<%=tipo%>"></jsp:param>
                    <jsp:param name="documento" value="<%=documento%>"></jsp:param>
                    <jsp:param name="msg" value="<%=mensajeTramiteRunt%>"></jsp:param>
                </jsp:forward>
                <%
            }//fin paso 4
        }else{
            String documento    	= request.getParameter("documento");
            String nacionalidad 	= request.getParameter("nacionalidad2");
            java.sql.Date  fecha_expedicion = null;
            if((request.getParameter("fecha_expedicion2")!=null)&&(!request.getParameter("fecha_expedicion2").isEmpty()))
                fecha_expedicion = new java.sql.Date(formato.parse(request.getParameter("fecha_expedicion2")).getTime());
            String departamento 	= request.getParameter("departamento2");
            String municipio    	= request.getParameter("municipio2");
            String razon_social     = request.getParameter("razon_social");
            String sigla     = request.getParameter("sigla");
            String tipo_entidad     = request.getParameter("tipo_entidad");
            String tipo_sociedad    = request.getParameter("tipo_sociedad");
            String prest_servicio     = request.getParameter("prestador_servicio");
            String email     = request.getParameter("email2");
            String celular     = request.getParameter("celular2");
            String capital_pagado = request.getParameter("capital_pagado");
            String patrimonio_liquido     = request.getParameter("patrimonio_liquido");
            String nro_certificadoExt = request.getParameter("nro_certificado");
            String dir_departamento   =  request.getParameter("dir_departamento2");
            String dir_municipios     =  request.getParameter("dir_municipio2");
            String direccion_pers     =  request.getParameter("direccion2");
            String telefono     =  request.getParameter("telefono2");
            String fax     =  request.getParameter("fax");

            Empresa empresa = new Empresa();
            razon_social    =    razon_social.toUpperCase();
            sigla   =    sigla.toUpperCase();
             if(municipio!=null){
                long dpto  = Long.parseLong(departamento);
                long munp  = Long.parseLong(municipio);
                if(dpto!=0&&munp!=0){
                    Divipo div = modelo.consultarDvipo(dpto,munp);
                    empresa.setFk_divipo(div.getId_divipo());
                }
            }
            if(fecha_expedicion!=null)
                empresa.setFecha_exp(fecha_expedicion);
            if(razon_social!=null)
                empresa.setRazon_social(razon_social);
            if(sigla!=null)
                empresa.setSigla(sigla);
            if(tipo_entidad!=null)
                empresa.setTipo_entidad(tipo_entidad);
            if(tipo_sociedad!=null)
                empresa.setTipo_sociedad(tipo_sociedad);
            if(prest_servicio!=null)
                empresa.setPrestador_servicio(prest_servicio);
            if(email!=null)
                empresa.setEmail(email);
            if(telefono!=null)
                empresa.setTelefono(telefono);
            if(celular!=null)
                empresa.setCelular(celular);
            if(capital_pagado!=null)
                empresa.setCapital_pagado(capital_pagado);
            if(patrimonio_liquido!=null)
                empresa.setPatrimonio_liquido(patrimonio_liquido);
            if(nro_certificadoExt!=null)
                empresa.setNro_certificado(nro_certificadoExt);
            empresa.setNit(documento);
            empresa.setTipo_documento(tipo);

            int tipo_doc = Integer.parseInt(request.getParameter("tipo_documento"));
            String docRepre = request.getParameter("documento2");
            String tipo_contrato = request.getParameter("tipo_contrato");
            java.sql.Date  fechaInicioRepre = null;
            if(request.getParameter("fecha_representacion")!=null&&!request.getParameter("fecha_representacion").isEmpty())
                fechaInicioRepre = new java.sql.Date(formato.parse(request.getParameter("fecha_representacion")).getTime());

            String estadoRepre = request.getParameter("estado_repre");

            java.sql.Date  fechaVigencia = null;
            if(request.getParameter("fecha_vigencia")!=null&&!request.getParameter("fecha_vigencia").isEmpty())
                fechaVigencia = new java.sql.Date(formato.parse(request.getParameter("fecha_vigencia")).getTime());

            Persona p =  modelo.consultarPersona(tipo_doc, docRepre);
            Representante repres = new Representante();
            if(p!=null){
                repres.setFk_persona(p.getId_persona());
                if(tipo_contrato!=null)
                    repres.setTipo_contrato(tipo_contrato);
                if(fechaInicioRepre!=null)
                    repres.setFecha_inicio_representacion(fechaInicioRepre);
                if(estadoRepre!=null)
                    repres.setEstado_representacion(estadoRepre);
                if(fechaVigencia!=null)
                    repres.setFecha_vigencia(fechaVigencia);
            }
            Empresa e = modelo.consultarEmpresa(tipo,documento);
            if(paso==1||paso==4){
                if(e!=null){
                   if(model.tienePermiso(usuario.getId_usuario(), 33)){
                        persona = modelo.consultarPersona(tipo, documento);
                        if(persona==null){
                            persona = new Persona();
                            persona.setTipo_documento(tipo);
                            persona.setDocumento(documento);
                            if(razon_social!=null)
                                persona.setNombre_1(razon_social);
                            if(razon_social!=null)
                                persona.setApellido_1(razon_social);
                            persona.setFk_divipo(938);
                            modelo.adicionarPersona(persona);
                       }else{
                            if(razon_social!=null)
                                persona.setNombre_1(razon_social);
                            if(razon_social!=null)
                                persona.setApellido_1(razon_social);

                            modelo.actualizarPersona(persona, persona.getId_persona());
                       }
                        if(direccion_pers!=null){
                            if(direccion_pers.trim().length()>0){
                                if(dir_municipios!=null){
                                    direccion.setDescripcion(direccion_pers);
                                    direccion.setUbicacion(1);
                                    direccion.setFecha(fechaSystem);
                                    direccion.setEstado(1);
                                    if(fax!=null)
                                        direccion.setFax(fax);
                                    direccion.setFk_persona(persona.getId_persona());
                                    if(telefono!=null)
                                        direccion.setTelefono(telefono);
                                    long dpto  = Long.parseLong(dir_departamento);
                                    long munp  = Long.parseLong(dir_municipios);
                                    if(dpto!=0&&munp!=0){
                                        Divipo div = modelo.consultarDvipo(dpto, munp);
                                        direccion.setFk_divipo(div.getId_divipo());
                                    }
                                    if(modelo.listado_direcciones_persona(persona.getId_persona()).size()>0){
                                        modelo.actualizarDireccion(direccion);
                                    }else{
                                        modelo.adicionarDireccion(direccion);
                                    }
                                }
                            }
                        }
                        Representante rep = modelo.consultarRepresentante(e.getFk_representante());
                        if(rep!=null){
                            repres.setId_representante(rep.getId_representante());
                            modelo.actualizarRepresentante(repres);
                            empresa.setFk_representante(rep.getId_representante());
                        }else{
                            modelo.adicionarRepresentante(repres);
                            rep = modelo.consultarRepresentantebyPersona(repres.getFk_persona());
                            empresa.setFk_representante(rep.getId_representante());
                        }


                       empresa.setId_empresa(e.getId_empresa());
                       modelo.actualizarEmpresa(empresa);
                       modelo.getCon().commit();
                   }
                        if(paso!=4){ %>
                            <jsp:forward page="consultarPersonaRUNT.jsp">
                                <jsp:param name="paso" value="1"></jsp:param>
                                <jsp:param name="bbdd" value="2"></jsp:param>
                                <jsp:param name="tipo" value="<%=tipo%>"></jsp:param>
                                <jsp:param name="documento" value="<%=documento%>"></jsp:param>
                            </jsp:forward>
                     <%  }
                }
            }
            if(paso==3||paso==4){
                 if(e==null){
                    if(model.tienePermiso(usuario.getId_usuario(), 32)){
                        persona = modelo.consultarPersona(tipo, documento);
                        if(persona==null){
                            persona = new Persona();
                            persona.setTipo_documento(tipo);
                            persona.setDocumento(documento);
                            if(razon_social!=null)
                                persona.setNombre_1(razon_social);
                            if(razon_social!=null)
                                persona.setApellido_1(razon_social);
                            persona.setFk_divipo(938);
                            modelo.adicionarPersona(persona);
                       }else{
                            if(razon_social!=null)
                                persona.setNombre_1(razon_social);
                            if(razon_social!=null)
                                persona.setApellido_1(razon_social);

                            modelo.actualizarPersona(persona, persona.getId_persona());
                       }
                        if(direccion_pers!=null){
                            if(direccion_pers.trim().length()>0){
                                if(dir_municipios!=null){
                                    direccion.setDescripcion(direccion_pers);
                                    direccion.setUbicacion(1);
                                    if(fax!=null)
                                        direccion.setFax(fax);
                                    direccion.setFecha(fechaSystem);
                                    direccion.setEstado(1);
                                    if(telefono!=null)
                                        direccion.setTelefono(telefono);
                                    direccion.setFk_persona(persona.getId_persona());
                                    long dpto  = Long.parseLong(dir_departamento);
                                    long munp  = Long.parseLong(dir_municipios);
                                    if(dpto!=0&&munp!=0){
                                        Divipo div = modelo.consultarDvipo(dpto, munp);
                                        direccion.setFk_divipo(div.getId_divipo());
                                    }
                                    modelo.adicionarDireccion(direccion);
                                }
                            }
                        }
                        if(repres.getFk_persona()!=0){
                            modelo.adicionarRepresentante(repres);
                            Representante rep = modelo.consultarRepresentantebyPersona(repres.getFk_persona());
                            empresa.setFk_representante(rep.getId_representante());
                        }

                       modelo.registrarEmpresa(empresa);
                       modelo.getCon().commit();
                   }
                    if(paso!=4){ %>
                        <jsp:forward page="consultarPersonaRUNT.jsp">
                            <jsp:param name="paso" value="1"></jsp:param>
                            <jsp:param name="bbdd" value="1"></jsp:param>
                            <jsp:param name="tipo" value="<%=tipo%>"></jsp:param>
                            <jsp:param name="documento" value="<%=documento%>"></jsp:param>
                        </jsp:forward>
                  <% }
                }
            }
            if(paso==4){
                String mensajeTramiteRunt = "";
                com.heinsohn.runt.general.solicitudes.InscribirPersonaJuridicaInDTO radicarSolicitudOut = null;
                webservices.radicacion.RadicacionServicesClient radicacionService = new webservices.radicacion.RadicacionServicesClient();
                radicacionService.setTokenHuellaDigital(Model.userToken);
                radicacionService.setUser(Model.userHandler);
                com.heinsohn.runt.general.identificaciones.StatusDTO status = radicacionService.verificarEstadoWS();
                if(status!=null){
                    if(status.getStatusCode().equals("1")||status.getStatusCode().equals("2")){
                        String tipoDocumento = modelo.consultarParametro((int)empresa.getTipo_documento(),5).getNombreCorto();
                        String numeroDoc = empresa.getNit();

                        String razonSocial = empresa.getRazon_social();
                        String Sigla = empresa.getSigla();
                        String tipoSociedad = empresa.getTipo_sociedad();
                        String tipoEntidad = empresa.getTipo_entidad();
                        String prestadorServicio = empresa.getPrestador_servicio();
                        double capitalPagado = 0;
                        if(empresa.getCapital_pagado()!=null){
                            if(empresa.getCapital_pagado().trim().length()>0){
                                try{
                                    capitalPagado = Double.parseDouble(empresa.getCapital_pagado());
                                }catch(Exception cp){
                                }
                            }
                        }

                        double patrimonio = 0;
                        if(empresa.getPatrimonio_liquido()!=null){
                            if(empresa.getPatrimonio_liquido().trim().length()>0){
                                try{
                                    patrimonio = Double.parseDouble(empresa.getPatrimonio_liquido());
                                }catch(Exception cp){
                                }
                            }
                        }

                        String Celular = empresa.getCelular();
                        String mail = empresa.getEmail();
                        String certificado = empresa.getNro_certificado();
                        Persona personaR = modelo.consultarPersona(repres.getFk_persona());
                        String tipoDocR = modelo.consultarParametro((int)personaR.getTipo_documento(),5).getNombreCorto();
                        String numeroDocR = personaR.getDocumento();
                        String estadoR = repres.getEstado_representacion();
                        java.sql.Date fechaInicioR = repres.getFecha_inicio_representacion();
                        java.sql.Date fechaVigenciaR = repres.getFecha_vigencia();
                        String tipoContrato = repres.getTipo_contrato();

                        com.heinsohn.runt.general.personas.DireccionDTO dir = new com.heinsohn.runt.general.personas.DireccionDTO();

                        if(direccion_pers!=null){
                            if(direccion_pers.trim().length()>0){
                                if(dir_municipios!=null){
                                    direccion.setDescripcion(direccion_pers);
                                    direccion.setUbicacion(1);
                                    if(fax!=null)
                                        direccion.setFax(fax);
                                    direccion.setFecha(fechaSystem);
                                    direccion.setEstado(1);
                                    direccion.setFk_persona(p.getId_persona());
                                    long dpto  = Long.parseLong(dir_departamento);
                                    long munp  = Long.parseLong(dir_municipios);
                                    if(dpto!=0&&munp!=0){
                                        Divipo div = modelo.consultarDvipo(dpto, munp);
                                        direccion.setFk_divipo(div.getId_divipo());
                                    }
                                    dir.setDireccion(direccion.getDescripcion());
                                    dir.setTelefono(direccion.getTelefono());
                                    if(fax!=null)
                                        dir.setFax(direccion.getFax());
                                    dir.setTipoDireccion("CASA");//Parametrizar
                                    if(dpto!=0&&munp!=0){
                                        com.heinsohn.runt.general.identificaciones.IdentificadorGeografiaDTO dir_mun = new com.heinsohn.runt.general.identificaciones.IdentificadorGeografiaDTO();
                                        String municipioDir = modelo.getDivipo(direccion.getFk_divipo()).getCodigo();
                                        dir_mun.setIdMunicipio(Integer.parseInt(municipioDir)+"");
                                        dir.setMunicipio(dir_mun);
                                    }
                                }
                            }
                        }
                        if(model.tienePermiso(usuario.getId_usuario(), 36)){
                            com.heinsohn.runt.general.solicitudes.InscribirPersonaOutDTO inscripcion =null; //radicacionService.inscribirPersonaJuridica(tipoDocumento, numeroDoc, razonSocial, Sigla, tipoSociedad, tipoEntidad, prestadorServicio, capitalPagado, patrimonio, Celular, mail, certificado, tipoDocR, numeroDocR, estadoR, fechaInicioR, fechaVigenciaR, tipoContrato, dir);
                            if(inscripcion.getStatus()!=null){
                                if(inscripcion.getStatus().getStatusCode().equals("1")){
                                 //   session.setAttribute("certificado", inscripcion.getCertificado());
                                  //  Reports reporteRunt = new Reports(inscripcion.getCertificado(),response);
                                    mensajeTramiteRunt = "RUNT: "+inscripcion.getStatus().getStatusDesc();
                                    modelo.getCon().commit();
                                    %>
                                    <jsp:forward page="consultarPersonaRUNT.jsp">
                                        <jsp:param name="paso" value="2"></jsp:param>
                                        <jsp:param name="runt" value="1"></jsp:param>
                                        <jsp:param name="tipo" value="<%=tipo%>"></jsp:param>
                                        <jsp:param name="documento" value="<%=documento%>"></jsp:param>
                                        <jsp:param name="msg" value="<%=mensajeTramiteRunt%>"></jsp:param>
                                    </jsp:forward>
                                    <%
                                }else{
                                    mensajeTramiteRunt = "RUNT: "+inscripcion.getStatus().getStatusDesc();
                                }
                            }else{
                                mensajeTramiteRunt = "CIVITRANS: No existe respuesta a la Solicitud de Inscripcion RUNT";
                            }
                        }
                    }else{
                        mensajeTramiteRunt = "RUNT: "+status.getStatusDesc();
                    }
                }else{
                    mensajeTramiteRunt = "CIVITRANS: No existe conexion con el RUNT";
                }
                %>
                <jsp:forward page="consultarPersonaRUNT.jsp">
                    <jsp:param name="paso" value="1"></jsp:param>
                    <jsp:param name="bbdd" value="3"></jsp:param>
                    <jsp:param name="tipo" value="<%=tipo%>"></jsp:param>
                    <jsp:param name="documento" value="<%=documento%>"></jsp:param>
                    <jsp:param name="msg" value="<%=mensajeTramiteRunt%>"></jsp:param>
                </jsp:forward>
                <%
            }
        }
        modelo.getCon().rollback();
    }catch(Exception exc){
        exc.printStackTrace();
        if(modelo!=null){
            modelo.getCon().rollback();
        }
    }
        }else{  %>
           <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="1"></jsp:param></jsp:forward>
<%        }
     }else{ %>
        <script>window.parent.document.location.href = "../../index.jsp";</script>
<%  }
 }else{ %>
     <script>window.parent.document.location.href = "../../index.jsp";</script>
<% }
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<% } %>
