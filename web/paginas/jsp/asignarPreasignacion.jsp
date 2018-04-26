<%@ page  import="modelo.Vehiculo" import="modelo.Model" import = "java.util.HashMap"%>
<%
 Model model = null;
 String mensajeRunt = "";
 try{
     model = (Model)session.getAttribute("model");
     if(model!=null){
          modelo.Usuario usuario =(modelo.Usuario)session.getAttribute("usuario");
          modelo.UsuarioRunt userRunt = model.consultarUsuarioRunt2(usuario.getId_usuario());

        if(request.getParameter("placa")!=null){
          modelo.Venal venal = model.consultar_Venal(request.getParameter("placa").toUpperCase(), 1);

          if(venal==null)
                venal = model.consultar_Venal(request.getParameter("placa").toUpperCase(), 4);

          if(venal!=null){

          webservices.consultas.ServicioConsultaRUNTClient consultasService = new webservices.consultas.ServicioConsultaRUNTClient();
          consultasService.setTokenHuellaDigital("");
          consultasService.setUser(userRunt.getCodigo());
         if(session.getAttribute("token2")!=null){
              consultasService.setTokenHuellaDigital(session.getAttribute("token2").toString());
         }

        com.heinsohn.runt.general.identificaciones.IdentificacionAutomotorDTO automotor = new com.heinsohn.runt.general.identificaciones.IdentificacionAutomotorDTO();
        if(request.getParameter("motor")!=null)
            if(request.getParameter("motor").trim().length()>0)
                automotor.setNumeroMotor(request.getParameter("motor"));

        if(request.getParameter("chasis")!=null)
            if(request.getParameter("chasis").trim().length()>0)
                automotor.setNumeroChasis(request.getParameter("chasis"));
            //Model.userHandler = userRunt.getCodigo();
            //Model.passUserHandler = userRunt.getPassword();
        com.heinsohn.runt.general.consultas.DetalleAutomotorOutDTO detalleAutomotorOut = consultasService.consultarVehiculosMCSV(automotor,userRunt.getCodigo(),userRunt.getPassword());
        if(detalleAutomotorOut!=null){
            com.heinsohn.runt.general.identificaciones.StatusDTO status = detalleAutomotorOut.getStatus().getValue();
            if(status.getStatusCode().equals("1")){
                java.util.List<com.heinsohn.runt.general.consultas.DetalleAutomotorDTO> listaAutomotor = detalleAutomotorOut.getAutomotores();
                if(listaAutomotor!=null){
                    for(int i=0;i<listaAutomotor.size();i++){
                        com.heinsohn.runt.general.consultas.DetalleAutomotorDTO detalleAutomotor = listaAutomotor.get(i);
                        if(detalleAutomotor!=null){
                            modelo.Preasignacion preasignacion = new modelo.Preasignacion();
                            preasignacion.setPlaca(request.getParameter("placa").toUpperCase());
                            if(detalleAutomotor.getIdentificador().getNumeroMotor()!=null)
                                preasignacion.setMotor(detalleAutomotor.getIdentificador().getNumeroMotor());
                            if(detalleAutomotor.getIdentificador().getNumeroChasis()!=null)
                                preasignacion.setChasis(detalleAutomotor.getIdentificador().getNumeroChasis());
                            if(detalleAutomotor.getIdentificador().getNumeroSerie()!=null)
                                preasignacion.setSerie(detalleAutomotor.getIdentificador().getNumeroSerie());
                            if(detalleAutomotor.getIdentificador().getNumeroVIN()!=null)
                                preasignacion.setVin(detalleAutomotor.getIdentificador().getNumeroVIN());
                            if(request.getParameter("servicio")!=null)
                                preasignacion.setServicio(Integer.parseInt(request.getParameter("servicio")));
                            else
                                preasignacion.setServicio(1);
                            if(request.getParameter("persona")!=null){
                                modelo.Persona persona = model.consultarPersona(1, request.getParameter("persona"));
                                if(persona!=null)
                                    preasignacion.setFk_persona(persona.getId_persona());
                                else{
                                    persona = model.consultarPersona(2, request.getParameter("persona"));
                                    if(persona!=null)
                                        preasignacion.setFk_persona(persona.getId_persona());
                                }
                            }
                            preasignacion.setOrigenRegistro(1);
                            preasignacion.setTipo(2);
                            preasignacion.setEstado(1);
                            preasignacion.setFk_usuario(usuario.getId_usuario());
                            preasignacion.setFecha(new java.sql.Timestamp(new java.util.Date().getTime()));
                            if(detalleAutomotor.getClase()!=null)
                                preasignacion.setClase(Integer.parseInt(detalleAutomotor.getClase()));
                            if(detalleAutomotor.getMarca()!=null)
                                preasignacion.setMarca(Integer.parseInt(detalleAutomotor.getMarca()));
                            if(detalleAutomotor.getLinea()!=null)
                                preasignacion.setLinea(Integer.parseInt(detalleAutomotor.getLinea()));
                            if(detalleAutomotor.getModelo()!=null)
                                preasignacion.setModelo(Integer.parseInt(detalleAutomotor.getModelo()));
                            if(detalleAutomotor.getNumeroActaImportacion()!=null)
                                preasignacion.setActaImportacion(detalleAutomotor.getNumeroActaImportacion());
                            if(detalleAutomotor.getEstado()!=null)
                                preasignacion.setEstadoAutomotor(detalleAutomotor.getEstado());
                            preasignacion.setEstadoSolicitud("APROBADA");
                            model.adicionarPreasignacion(preasignacion);
                            model.actualizarEstadoVenal(venal.getId_venal(), 3,usuario.getId_usuario());
                            model.getCon().commit();
                            out.print("Placa ha sido preasignada");
                        }
                    }
                }
            }else{
                mensajeRunt = "No existe vehiculos con los datos enviados";
                out.println("Alerta: "+mensajeRunt);
            }
        }else{
            mensajeRunt = "No se pudo acceder al servicio WEB";
            out.println("Alerta: "+mensajeRunt);
        }
     }else{
        mensajeRunt = "No existe la placa en Venales";
        out.println("Alerta: "+mensajeRunt);
     }
   }
          }
 }catch(Exception exc){
     exc.printStackTrace();
     mensajeRunt = "Se ha producido una excepcion :"+exc.getMessage();
     out.println(mensajeRunt);
 } %>


