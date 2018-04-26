<%--
    Document   : procesarEditarFormulario
    Created on : 30/04/2010, 06:18:18 PM
    Author     : Administrador
--%>

<%@ page  import = "modelo.*" import = "java.util.*" import = "java.sql.*"    %>
<%
	Model model = (Model) session.getAttribute("model");
    try{
        model.getCon().setAutoCommit(false);
        Formulario formulario = model.consultarFormulario(Long.parseLong(request.getParameter("formulario")));
        if(formulario!=null){
            Radicacion radicacion = model.consultar_Radicacion(formulario.getFk_radicacion());
            if(radicacion!=null){
                Persona persona = model.consultarPersona(Integer.parseInt(request.getParameter("tipoDocumento")), request.getParameter("numeroDocumento"));
                if(persona!=null){
                    model.actualizarSolicitanteRadicacion(radicacion.getId_radicacion(),persona.getId_persona());
                } 
                formulario.setRunt(request.getParameter("runt"));
                formulario.setRunt2(request.getParameter("runt2"));
                if(request.getParameter("motor")!=null)
                    formulario.setMotor(request.getParameter("motor"));
                if(request.getParameter("chasis")!=null)
                    formulario.setChasis(request.getParameter("chasis"));
                if(request.getParameter("serie")!=null)
                    formulario.setSerie(request.getParameter("serie"));
                if(request.getParameter("valorFactura")!=null)
                    formulario.setSimit(request.getParameter("valorFactura"));
                  if(request.getParameter("nitConc")!=null)
                    formulario.setObservaciones(request.getParameter("nitConc"));
                    model.editarFormularioTramite(formulario.getId_formulario(), formulario.getRunt(),formulario.getRunt2() ,formulario.getMotor(), formulario.getChasis(), formulario.getSerie(),formulario.getSimit(),formulario.getObservaciones());
                int tramite = (int)formulario.getFk_tramite();
                if(tramite==1||tramite==2||tramite==4){
                    java.util.List lista =(java.util.List)session.getAttribute("editarPropietarios");
                    model.eliminarRadicacionesPropietariosApoderados(formulario.getId_formulario());
                    for(int j = 0; j < lista.size(); j++){
                        Radicacion_Propietario rp  = (Radicacion_Propietario) lista.get(j) ;
                        rp.setFk_formulario(formulario.getId_formulario());
                        model.adicionarRadicacionPropietarios(rp);
                        Radicacion_Apoderado ra =(Radicacion_Apoderado)session.getAttribute("editarApoderados"+rp.getFk_persona());
                        if(ra!=null){
                            ra.setFk_formulario(formulario.getId_formulario());
                            ra.setFecha_inicio(new java.sql.Date(new java.util.Date().getTime()));
                            model.adicionarRadicacionApoderados(ra);
                        }
                    }
                }
                if(tramite==1||tramite==4){
                    java.util.HashMap mapaEspecificaciones =(java.util.HashMap)session.getAttribute("editarEspecificaciones");
                    Iterator ite = mapaEspecificaciones.keySet().iterator();
                    while(ite.hasNext()){
                        String llave = ite.next().toString();
                        Object valor = mapaEspecificaciones.get(llave);
                        model.editarRadicacionesEspecificaciones(formulario.getId_formulario(),2,Integer.parseInt(llave),valor!=null?valor.toString():"");
                    }
                }
                if(tramite==1||tramite==2||tramite==3||tramite==4||tramite==5||tramite==7||tramite==8||tramite==13||tramite==15||tramite==16||tramite==17||tramite==18||tramite==20||tramite==23||tramite==24||tramite==25||tramite==26||tramite==27||tramite==32){
                    java.util.List lista = model.consultarConfiguracionTramitesRUNT(tramite);
                    model.eliminarRuntRadicacionesTramite(formulario.getId_formulario());
                    for(int j = 0; j < lista.size(); j++){
                        int dupla[] = (int[])lista.get(j);
                        if(request.getParameter((dupla[0]==1?"caracteristica":"especificacion")+dupla[1])!=null){
                            if(!request.getParameter((dupla[0]==1?"caracteristica":"especificacion")+dupla[1]).trim().equals("")){
                                if(request.getParameter((dupla[0]==1?"caracteristica":"especificacion")+dupla[1]).equals("0")){
                                    if(dupla[0]==2){
                                        String datoRunt = request.getParameter((dupla[0]==1?"caracteristica":"especificacion")+dupla[1]);
                                        model.registrarRadicacionTramiteRUNT(formulario.getId_formulario(),dupla[0],dupla[1],datoRunt);
                                    }
                                }else{
                                    String datoRunt = request.getParameter((dupla[0]==1?"caracteristica":"especificacion")+dupla[1]);
                                    model.registrarRadicacionTramiteRUNT(formulario.getId_formulario(),dupla[0],dupla[1],datoRunt);
                                }
                            }
                        }
                    }

                    if(request.getParameter("fichaT")!=null){
                        model.registrarRadicacionTramiteRUNT(formulario.getId_formulario(),2,3,request.getParameter("fichaT"));
                    }
                }

                model.getCon().commit(); %>
                <script>
                        alert("El formulario ha sido editado correctamente..");
                        document.location.href = "formularioTramite.jsp?id_radicacion=<%=formulario.getFk_radicacion()%>"
                </script>
<%          }
        }
    }catch(Exception exc){
        model.getCon().rollback();
        exc.printStackTrace();%>
        <script>
                alert("El formulario no pudo ser editado");
        </script>
        <%
    }
%>

