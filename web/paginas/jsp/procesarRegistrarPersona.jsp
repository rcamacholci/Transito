<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="modelo.*" import="java.util.*"%>
 <%
 String msg = "";
 int tipo = 0;
 String documento = "";
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
                java.sql.Date  fecha_nacimiento = null;
                tipo = Integer.parseInt(request.getParameter("tipo"));
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
                
                java.sql.Date  fecha_expedicion = null;
                if(request.getParameter("fecha_expedicion")!=null)
                    if(request.getParameter("fecha_expedicion").trim().length()>0)
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
                byte[] firma = null;
                byte[] bidimensional = null;
                String estadoBiometricos = request.getParameter("biometric");

                Persona p=  modelo.consultarPersona(tipo, documento);
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
                            if(request.getParameter("foto")!=null)
                                foto = request.getParameter("foto").getBytes();

                            if(request.getParameter("firma")!=null)
                                firma = request.getParameter("firma").getBytes();

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
                                dedo1 = dedo1==0?2:dedo1;

                                if(request.getParameter("dedo2")!=null)
                                    if(request.getParameter("dedo2").trim().length()>0)
                                        dedo2 = Integer.parseInt(request.getParameter("dedo2"));
                                dedo2 = dedo2==0?7:dedo2;

                                if(request.getParameter("huella1")!=null)
                                    huella1 = request.getParameter("huella1").getBytes();

                                if(request.getParameter("huella2")!=null)
                                    huella2 = request.getParameter("huella2").getBytes();
                            }
                            biometrico.setTemplate(template);
                            biometrico.setFoto(foto);
                            biometrico.setBidimensional(bidimensional);
                            biometrico.setFirma(firma);
                            biometrico.setDedo1(dedo1);
                            biometrico.setDedo2(dedo2);
                            biometrico.setHuella1(huella1);
                            biometrico.setHuella2(huella2);
                            biometrico.setId_persona(p.getId_persona());
                            modelo.actualizarBiometrico(biometrico);
                        }
                        modelo.getCon().commit();
                        msg = "La persona ha sido actualizada exitosamente";
                    }
                }else{
                    long idPersona = model.adicionarPersona(persona);
                    if(direccion_pers!=null){
                        if(direccion_pers.trim().length()>0){
                            if(dir_municipios!=null){
                                direccion.setDescripcion(direccion_pers);
                                direccion.setUbicacion(1);
                                direccion.setFecha(fechaSystem);
                                direccion.setEstado(1);
                                direccion.setFk_persona(idPersona);
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
                        if(request.getParameter("foto")!=null)
                            foto = request.getParameter("foto").getBytes();

                        if(request.getParameter("firma")!=null)
                            firma = request.getParameter("firma").getBytes();

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
                            dedo1 = dedo1==0?2:dedo1;

                            if(request.getParameter("dedo2")!=null)
                                if(request.getParameter("dedo2").trim().length()>0)
                                    dedo2 = Integer.parseInt(request.getParameter("dedo2"));
                            dedo2 = dedo2==0?7:dedo2;

                            if(request.getParameter("huella1")!=null)
                                huella1 = request.getParameter("huella1").getBytes();

                            if(request.getParameter("huella2")!=null)
                                huella2 = request.getParameter("huella2").getBytes();
                        }
                        biometrico.setTemplate(template);
                        biometrico.setFoto(foto);
                        biometrico.setBidimensional(bidimensional);
                        biometrico.setFirma(firma);
                        biometrico.setDedo1(dedo1);
                        biometrico.setDedo2(dedo2);
                        biometrico.setHuella1(huella1);
                        biometrico.setHuella2(huella2);
                        biometrico.setId_persona(idPersona);
                        modelo.actualizarBiometrico(biometrico);
                    }
                    modelo.getCon().commit();
                   msg = "La persona ha sido ingresada exitosamente";
                   %>
                    <script>
                        alert("<%=msg %>")
                    </script>
                    <%
                    
                }
            }catch(Exception exc){
            msg = "Error de ingreso :"+exc.getMessage();
%>
                <script>
                        alert("<%=msg %>")
                </script>
                <%
                
                modelo.getCon().rollback();
                exc.printStackTrace();
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
<script type="text/javascript" language="javascript">
    alert('<%=msg%>');
    document.location.href = "formularioLicencia.jsp?tipo=<%=tipo%>&documento=<%=documento%>";
</script>
