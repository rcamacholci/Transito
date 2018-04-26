<%@ page  import="modelo.Vehiculo" import="modelo.Model" import = "java.util.HashMap"%>
<%
 Model model = null;
 String mensajeRunt = "";
 try{
     model = (Model)session.getAttribute("model");
     modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
     modelo.UsuarioRunt userRunt = model.consultarUsuarioRunt(usuario.getId_usuario());

     session.removeAttribute("preasignacion");
     System.out.println("Verificar Preasignacion");
     if(model!=null){
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

        if(request.getParameter("serie")!=null)
            if(request.getParameter("serie").trim().length()>0)
                automotor.setNumeroSerie(request.getParameter("serie"));

        if(request.getParameter("vin")!=null)
            if(request.getParameter("vin").trim().length()>0)
                automotor.setNumeroVIN(request.getParameter("vin"));

        com.heinsohn.runt.general.consultas.DetalleAutomotorOutDTO detalleAutomotorOut = consultasService.consultarVehiculosMCSV(automotor,userRunt.getCodigo(),userRunt.getPassword());
        if(detalleAutomotorOut!=null){
            com.heinsohn.runt.general.identificaciones.StatusDTO status = detalleAutomotorOut.getStatus().getValue();
            if(status.getStatusCode().equals("1")){
                java.util.List<com.heinsohn.runt.general.consultas.DetalleAutomotorDTO> listaAutomotor = detalleAutomotorOut.getAutomotores();
                if(listaAutomotor!=null){
                    if(listaAutomotor.size()==1){
                        for(int i=0;i<listaAutomotor.size();i++){
                            com.heinsohn.runt.general.consultas.DetalleAutomotorDTO detalleAutomotor = listaAutomotor.get(i);
                            if(detalleAutomotor!=null){
                                boolean paso = true;
                                if(detalleAutomotor.getIdentificador().getNumeroPlaca()!=null)
                                    if(detalleAutomotor.getIdentificador().getNumeroPlaca().trim().length()>0)
                                        paso = false;
                                if(paso){
                                    int estado = 1;
                                    System.out.println("Verificar: "+Integer.parseInt(request.getParameter("tipoD"))+" "+request.getParameter("documento").trim());
                                    modelo.Persona solicitante = model.consultarPersona(Integer.parseInt(request.getParameter("tipoD")),request.getParameter("documento"));
                                    String tipoDocumento = model.consultarParametro((int)solicitante.getTipo_documento(),5).getNombreCorto();
                                    System.out.println("Ingreso: "+tipoDocumento);
                                    int tipoD = (int)solicitante.getTipo_documento();
                                    String numeroDocumento = solicitante.getDocumento();
                                    com.heinsohn.runt.general.consultas.ConsultarTokenValidacionBiometricaOutDTO templateOut = null;
                                    webservices.common.CommonServicesClient commonService = new webservices.common.CommonServicesClient();
                                    commonService.setTokenHuellaDigital("1ng3n13r0J0h4nnGt13rr3zZ4mb4no");
                                    commonService.setUser(userRunt.getCodigo());
                                    templateOut = commonService.consultarParametroValidacionBiometrica(tipoDocumento, numeroDocumento, "2");
                                    if(templateOut!=null){
                                        if(templateOut.getStatus()!=null){
                                            if(templateOut.getStatus().getStatusCode().equals("1")){
                                                if(templateOut.getRespuestaAutorizacion().size()>0){
                                                     com.heinsohn.runt.general.consultas.ValidacionCentralizadaOutDTO validacionCentralizada = null;
                                                     java.util.List<com.heinsohn.runt.general.consultas.ValidacionCentralizadaOutDTO> list = templateOut.getRespuestaAutorizacion();
                                                     java.util.Iterator it = list.iterator();
                                                      while (it.hasNext()) {
                                                          validacionCentralizada = (com.heinsohn.runt.general.consultas.ValidacionCentralizadaOutDTO)it.next();
                                                          session.setAttribute("tokenP", validacionCentralizada.getTrama());
                                                          session.setAttribute("preasignacion", detalleAutomotor);
                                                      }
                                                }else{                                 
                                                    estado = 0;
                                                }
                                            }else{
                                                    estado = 0;
                                            }
                                        }else{
                                            estado = 0;
                                        }
                                        
                                     }else{
                                        estado = 0;
                                    }
                                    
                                    if(estado != 1){
                                        mensajeRunt = "Solicitante no se puede autenticar";
                                        out.println("Alerta: "+mensajeRunt);
                                    }
                                    
                                    
                                    String revision = "";
                                    if(detalleAutomotor.getIdentificador().getNumeroMotor()!=null)
                                        revision += detalleAutomotor.getIdentificador().getNumeroMotor().equals(request.getParameter("motor"))?"2":"1";
                                    else
                                        revision += "1";
                                    if(detalleAutomotor.getIdentificador().getNumeroChasis()!=null)
                                        revision += detalleAutomotor.getIdentificador().getNumeroChasis().equals(request.getParameter("chasis"))?"2":"1";
                                    else
                                        revision += "1";
                                    if(detalleAutomotor.getIdentificador().getNumeroSerie()!=null)
                                        revision += detalleAutomotor.getIdentificador().getNumeroSerie().equals(request.getParameter("serie"))?"2":"1";
                                    else
                                        revision += "1";
                                    if(detalleAutomotor.getIdentificador().getNumeroVIN()!=null)
                                        revision += detalleAutomotor.getIdentificador().getNumeroVIN().equals(request.getParameter("vin"))?"2":"1";
                                    else
                                        revision += "1";
                                    out.println(revision);
                                }else{
                                    mensajeRunt = "EL acta de importacion ya sido utilizada para el vehiculo de placas : "+detalleAutomotor.getIdentificador().getNumeroPlaca();
                                    out.println("Alerta: "+mensajeRunt);
                                }
                            }
                        }
                    }else{
                        mensajeRunt = "Hay mas de un vehiculo resgistrado, ingreso datos adicionales";
                    out.println("Alerta: "+mensajeRunt);
                    }
                }else{
                    mensajeRunt = "No se arrojaron resultados";
                    out.println("Alerta: "+mensajeRunt);
                }
            }else{
                mensajeRunt = "No existe vehiculos con los datos enviados";
                out.println("Alerta: "+mensajeRunt);
            }
        }else{
            mensajeRunt = "No se pudo acceder al servicio WEB";
            out.println("Alerta: "+mensajeRunt);
        }
     }
 }catch(Exception exc){
     exc.printStackTrace();
     mensajeRunt = "Se ha producido una excepcion :"+exc.getMessage();
     out.println(mensajeRunt);
 } %>


