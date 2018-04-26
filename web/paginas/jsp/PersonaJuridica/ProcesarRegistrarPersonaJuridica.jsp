<%@page import="com.heinsohn.runt.general.solicitudes.InscribirPersonaOutDTO"%>
<%@page import="com.heinsohn.runt.general.personas.DireccionDTO"%>
<%@page import="webservices.radicacion.RadicacionServicesClient"%>
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html;charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" errorPage="" %>
<%
    String msg = "";
    try {
        if (session.getAttribute("model") != null) {
            modelo.Model model = (modelo.Model) session.getAttribute("model");
            modelo.Usuario usuario = (modelo.Usuario) session.getAttribute("usuario");
            UsuarioRunt userRunt = model.consultarUsuarioRunt(usuario.getId_usuario());

            webservices.radicacion.RadicacionServicesClient radicacionPersonaJuridica = new RadicacionServicesClient();
            radicacionPersonaJuridica.setTokenHuellaDigital("");
            radicacionPersonaJuridica.setUser(userRunt.getCodigo());
            modelo.Model.userHandler = userRunt.getCodigo();
            modelo.Model.passUserHandler = userRunt.getPassword();
            if (session.getAttribute("token2") != null) {
            radicacionPersonaJuridica.setTokenHuellaDigital(session.getAttribute("token2").toString());
            String fecha_actual = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());
            java.sql.Date FechaActual = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(fecha_actual).getTime());
            Divipo div = new Divipo();
            long fk_persona = 0;
            int tipoDocumentoRepresentante =0;
            String documento_representante = "", tipo_documento_representate = "";
            String documento = "", digitoV ="", razon_social = "", sigla = "", celular = "", certificado_exitencia = "", registro_mercantil = "", email = "", dir_municipios = "", dir_departamento = "", descripcion_dir = "", telefono = "", capital_pagado = "", patrimonio_liquido = "", tipo_sociedad = "", tipo_entida = "", empresa_prestadora = "";
            Date fecha_vencimiento = null;
            if (request.getParameter("txt_razonSocial") != null || !request.getParameter("txt_razonSocial").equals("")) {
                razon_social = request.getParameter("txt_razonSocial");
            }
            if (request.getParameter("txt_sigla") != null || !request.getParameter("txt_sigla").equals("")) {
                sigla = request.getParameter("txt_sigla");
            }
            if (request.getParameter("txt_CapitalPagado") != null || !request.getParameter("txt_CapitalPagado").equals("")) {
                capital_pagado = request.getParameter("txt_CapitalPagado");
            }
            if (request.getParameter("txt_PatrimonioLiquido") != null || !request.getParameter("txt_PatrimonioLiquido").equals("")) {
                patrimonio_liquido = request.getParameter("txt_PatrimonioLiquido");
            }
            if (request.getParameter("txt_EmpresaPrestadora") != null || !request.getParameter("txt_EmpresaPrestadora").equals("")) {
                empresa_prestadora = request.getParameter("txt_EmpresaPrestadora");
            }
            if (request.getParameter("txt_Certificado") != null || !request.getParameter("txt_Certificado").equals("")) {
                certificado_exitencia = request.getParameter("txt_Certificado");
            }
            if (request.getParameter("tipoSociendad") != null || !request.getParameter("tipoSociendad").equals("")) {
                tipo_sociedad = request.getParameter("tipoSociendad");
            }
            if (request.getParameter("tipoEntidad") != null || !request.getParameter("tipoEntidad").equals("")) {
                tipo_entida = request.getParameter("tipoEntidad");
            }
            if (request.getParameter("txt_NResgistroMercantil") != null || !request.getParameter("txt_NResgistroMercantil").equals("")) {
                registro_mercantil = request.getParameter("txt_NResgistroMercantil");
            }
            if (request.getParameter("fecha") != null || !request.getParameter("fecha").equals("")) {
                fecha_vencimiento = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha")).getTime());
            }
            if (request.getParameter("txt_Correo") != null || !request.getParameter("txt_Correo").equals("")) {
                email = request.getParameter("txt_Correo");
            }
            if (request.getParameter("txt_Direccion") != null || !request.getParameter("txt_Direccion").equals("")) {
                descripcion_dir = request.getParameter("txt_Direccion");
            }
            if (request.getParameter("txt_Telefono") != null || !request.getParameter("txt_Telefono").equals("")) {
                telefono = request.getParameter("txt_Telefono");
            }

            if (request.getParameter("dir_departamento") != null || !request.getParameter("dir_departamento").equals("")) {
                dir_departamento = request.getParameter("dir_departamento");
            }
            if (request.getParameter("dir_municipio") != null || !request.getParameter("dir_municipio").equals("")) {
                dir_municipios = request.getParameter("dir_municipio");
            }
            if (request.getParameter("txt_Celular") != null || !request.getParameter("txt_Celular").equals("")) {
                celular = request.getParameter("txt_Celular");
            }
            if (request.getParameter("numerodocumento") != null || !request.getParameter("numerodocumento").equals("")) {
                documento_representante = request.getParameter("numerodocumento");
            }
            if (request.getParameter("tipoDocumentop") != null || !request.getParameter("tipoDocumentop").equals("")) {
                tipoDocumentoRepresentante  = Integer.parseInt(request.getParameter("tipoDocumentop"));
                switch (tipoDocumentoRepresentante) {
                    case 1:
                        tipo_documento_representate = "C";
                        break;
                    case 3:
                        tipo_documento_representate = "E";
                        break;
                    case 4:
                        tipo_documento_representate = "T";
                        break;
                    case 5:
                        tipo_documento_representate = "P";
                        break;
                }
            }
            if (request.getParameter("documento") != null || !request.getParameter("documento").equals("")) {
                documento = request.getParameter("documento");
            }
            if (request.getParameter("digitoV") != null || !request.getParameter("digitoV").equals("")) {
                digitoV = request.getParameter("digitoV");
            }
            long dpto = Long.parseLong(dir_departamento);
            long munp = Long.parseLong(dir_municipios);
            if (dpto != 0 && munp != 0) {
                div = model.consultarDvipo(dpto, munp);
            }

                InscribirPersonaOutDTO Inscripcionout = radicacionPersonaJuridica.inscribirPersonaJuridica("N", documento, digitoV,razon_social, sigla, tipo_sociedad, tipo_entida, empresa_prestadora, Double.parseDouble(capital_pagado), Double.parseDouble(patrimonio_liquido), celular, email, certificado_exitencia, tipo_documento_representate, documento_representante, "ACTIVO", FechaActual, FechaActual, "2", null, null, 0, fecha_vencimiento, "800000000000007037");
            if (Inscripcionout != null) {
            if (Inscripcionout.getStatus().getStatusCode().equals("1")) {
            if (documento != null || !documento.equals("")) {
                Persona persona = model.consultarPersona(2, documento);
                model.getCon().setAutoCommit(false);
                if (persona == null) {
                    Persona nueva_persona = new Persona();
                    nueva_persona.setNombre_1(razon_social);
                    nueva_persona.setApellido_1(sigla);
                    nueva_persona.setTipo_documento(2);
                    nueva_persona.setDocumento(documento);
                    nueva_persona.setFk_divipo(div.getId_divipo());
                    nueva_persona.setFk_lugar_nacimiento(0);
                    nueva_persona.setCelular(celular);
                    nueva_persona.setEmail(email);
                    model.adicionarPersona(nueva_persona);
                    persona = model.consultarPersona(2, documento);
                    fk_persona = persona.getId_persona();
                } else {
                    persona.setNombre_1(razon_social);
                    persona.setApellido_1(sigla);
                    persona.setTipo_documento(2);
                    persona.setFk_divipo(0);
                    persona.setCelular(celular);
                    persona.setEmail(email);
                    model.actualizarPersona(persona, persona.getId_persona());
                    fk_persona = persona.getId_persona();
                }
                Representante representante = new Representante();
                Persona persona_representante = model.consultarPersona(tipoDocumentoRepresentante, documento_representante);
                if (persona_representante != null) {
                    representante.setFk_persona(persona_representante.getId_persona());
                } else {
                    representante.setFk_persona(0);
                }
                representante.setTipo_contrato("12");
                representante.setFecha_inicio_representacion(FechaActual);
                representante.setEstado_representacion("ACTIVO");
                representante.setFecha_vigencia(FechaActual);
                model.adicionarRepresentante(representante);
                long fk_representante = model.consultarRepresentantebyPersona(persona_representante.getId_persona()).getId_representante();
                Empresa empresa = new Empresa();
                empresa.setFk_divipo(div.getId_divipo());
                empresa.setRazon_social(razon_social);
                empresa.setSigla(sigla);
                empresa.setTipo_entidad(tipo_entida);
                empresa.setTipo_sociedad(tipo_sociedad);
                empresa.setPrestador_servicio(empresa_prestadora);
                empresa.setEmail(email);
                empresa.setTelefono(telefono);
                empresa.setCelular(celular);
                empresa.setCapital_pagado(capital_pagado);
                empresa.setPatrimonio_liquido(patrimonio_liquido);
                empresa.setNro_certificado(certificado_exitencia);
                empresa.setFk_representante(fk_representante);
                empresa.setNit(documento);
                empresa.setTipo_documento(Long.parseLong("2"));
                model.adicionarEmpresa(empresa);
                Direccion direccion = new Direccion();
                direccion.setDescripcion(descripcion_dir);
                direccion.setUbicacion(1);
                direccion.setFecha(FechaActual);
                direccion.setEstado(1);
                direccion.setFk_persona(fk_persona);
                direccion.setFk_divipo(div.getId_divipo());
                direccion.setTelefono(telefono);
                model.adicionarDireccion(direccion);

            } else {
                msg = "Error al Consultar persona";
            }
            model.getCon().commit();
                    } else {%>

<script>
alert("<%=Inscripcionout.getStatus().getStatusDesc()%>");
</script>
<%}
    }

    }
%>
<script>
    alert("Guardado Correctamente");
</script>
<%    //
} else { %>
<script>window.parent.document.location.href = "../../index.jsp";</script>
<%  }
    } catch (Exception mexe) {
        mexe.printStackTrace();
    }%>

