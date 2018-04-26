<?xml version="1.0" encoding="UTF-8"?>
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" import="java.util.*,modelo.*" %>
<root>
<%
    Model model = (Model)session.getAttribute("model");
    Sede sede = (Sede)session.getAttribute("sede");
    int anoactual = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
    double vrete = 0;
    String valrete = "0";
    String timbre = "";
    long modelo_veh = 0;
    int sw = 0;
    String show = "";
    String Subservicio = "";

    if(request.getParameter("varete")!=null){
        String valor = request.getParameter("varete");
        vrete = Long.parseLong(valor)*0.01;
    }
    String valorAvaluo = null;
    long valorAvaluoVeh = 0;
    int anonuevo = (anoactual+1);
    int oldyear = (anoactual-1);

if(request.getParameter("placa")!=null){
    String numplaca = request.getParameter("placa");
    Vehiculo vehiculo = model.consultarVehiculo(request.getParameter("placa"));
    if(vehiculo!=null){
        long idvehiculo = vehiculo.getId_vehiculo();
            //VERIFICAR EL MODELO
            if(vehiculo.getModelo()>0){
                modelo_veh = vehiculo.getModelo();
                if(modelo_veh<1990){
                    modelo_veh = 1990;
                }
                //VERIFICAR CILINDRAJE
                DatosVehiculo datoCilindraje = model.consultarDatosVehiculoRete(idvehiculo, 11, 40);
                if(datoCilindraje!=null && datoCilindraje.getValor()!=null){
                    //VERIFICAR LINEA Y MARCA
                    Linea line = model.consultaLinea(request.getParameter("placa"));
                    if(!line.getNombre().equals("SIN LINEA")){
                        if(vehiculo.getModelo()!=anoactual && vehiculo.getModelo()!=anonuevo){
                            //VERIFICAR LA CLASE DEL VEHICULO
                            if(vehiculo.getClase_vehiculo()==10 || vehiculo.getClase_vehiculo()==14 || vehiculo.getClase_vehiculo()==19){
                                //CONSULTAR GRUPO DE MOTOS
                                String grupo = model.consultarDatosMotos(request.getParameter("placa"));
                                if(grupo!=null){
                                    //CONSULTAR AVALUO MOTO
                                    valorAvaluo = model.consultarAvaluoMotos(grupo, modelo_veh);
                                    if(valorAvaluo!=null){
                                        vrete = (Long.parseLong(valorAvaluo)*1000)*0.01;
                                        valrete= ""+Math.round(vrete);
                                    }else{
                                        sw=1;
                                    }
                                }else{
                                    sw=1;
                                }
                            }else{
                                //VERIFICAR CARROCERIA
                                DatosVehiculo datoCarroceria = model.consultarDatosVehiculo(idvehiculo, 1, 2);
                                if(datoCarroceria!=null && !datoCarroceria.getValor().equals("0")){
                                //CONSULTAR LA MODALIDAD
                                DatosVehiculo datoModalidad = model.consultarDatosVehiculo(idvehiculo, 1, 324);
                                if(datoModalidad!=null && datoModalidad.getValor()!=null){
                                if(datoModalidad.getValor().equals("1") || datoModalidad.getValor().equals("3")){
                                    if(vehiculo.getServicio()==1){
                                        if(vehiculo.getClase_vehiculo()==1 || vehiculo.getClase_vehiculo()==5 || vehiculo.getClase_vehiculo()==6){
                                            Marca marc = model.consultaMarca(request.getParameter("placa"));
                                            //Linea line = model.consultaLinea(request.getParameter("placa"));
                                            long idlinea = line.getId_linea();
                                            long codmarca = marc.getCodigo();
                                            long cilindraje = Long.parseLong(datoCilindraje.getValor());
                                            valorAvaluoVeh = model.consultarAvaluoVehiculos(modelo_veh, codmarca, idlinea, cilindraje);
                                            if(valorAvaluoVeh!=0){
                                                vrete = (valorAvaluoVeh*1000)*0.01;
                                                valrete= ""+Math.round(vrete);
                                            }else{
                                                sw = 1;
                                            }
                                        }else{
                                            sw=1;
                                        }
                                    }else{
                                        if(vehiculo.getServicio()==2){
                                            String codCategoria = null;
                                           if(vehiculo.getClase_vehiculo()==1 || vehiculo.getClase_vehiculo()==2 || vehiculo.getClase_vehiculo()==3
                                               || vehiculo.getClase_vehiculo()==4 || vehiculo.getClase_vehiculo()==5 || vehiculo.getClase_vehiculo()==7){
                                               //VERIFICAR SUB-SERVICIO
                                               DatosVehiculo datoSubServicio = model.consultarDatosVehiculo(idvehiculo, 1, 362);
                                               if(datoSubServicio!=null && !datoSubServicio.getValor().equals("0")){
                                                    Subservicio = datoSubServicio.getValor();
                                                    //AQUI VERIFICAR CANTIDAD DE PASAJEROS
                                                    if(Subservicio.equals("2") || Subservicio.equals("5")){
                                                            codCategoria = model.consultarCategoriaMarca(line.getFk_marca(),1);
                                                            if(codCategoria!=null){
                                                                valorAvaluo = model.consultarAvaluoVehPasajero(vehiculo.getPlaca(), modelo_veh, Integer.parseInt(codCategoria));
                                                                if(valorAvaluo!=null){
                                                                    vrete = (Long.parseLong(valorAvaluo)*1000)*0.01;
                                                                    valrete= ""+Math.round(vrete);
                                                                }else{
                                                                    sw=1;
                                                                }
                                                            }else{
                                                                System.out.println("huy zonaron");
                                                                sw = 1;
                                                            }
                                                    }else{
                                                        if(Subservicio.equals("1") || Subservicio.equals("6")){
                                                            codCategoria = model.consultarCategoriaMarca(line.getFk_marca(),2);
                                                            if(!codCategoria.equals("")){
                                                                System.out.println("CodCateg: "+Integer.parseInt(codCategoria));
                                                                System.out.println("Modelo: "+modelo_veh);
                                                                valorAvaluo = model.consultarAvaluoVehPasajero(vehiculo.getPlaca(), modelo_veh, Integer.parseInt(codCategoria));
                                                                if(valorAvaluo!=null){
                                                                    vrete = (Long.parseLong(valorAvaluo)*1000)*0.01;
                                                                    valrete= ""+Math.round(vrete);
                                                                }else{
                                                                    sw=1;
                                                                }
                                                            }else{
                                                                sw = 1;
                                                            }
                                                        }else{
                                                            if(Subservicio.equals("3")){
                                                                codCategoria = model.consultarCategoriaMarca(line.getFk_marca(),3);
                                                                if(!codCategoria.equals("")){
                                                                    valorAvaluo = model.consultarAvaluoVehPasajero(vehiculo.getPlaca(), modelo_veh, Integer.parseInt(codCategoria));
                                                                    if(valorAvaluo!=null){
                                                                        vrete = (Long.parseLong(valorAvaluo)*1000)*0.01;
                                                                        valrete= ""+Math.round(vrete);
                                                                    }else{
                                                                        sw=1;
                                                                    }
                                                                }else{
                                                                    sw = 1;
                                                                }
                                                            }else{
                                                                if(Subservicio.equals("4")){
                                                                    sw = 1;
                                                                }
                                                            }
                                                        }
                                                    }
                                               }else{
                                                    show = "2";
                                                     %>
                                                <show><%=show %></show>
                                                    <%
                                               }
                                            }else{
                                                sw=1;
                                            }
                                        }else{
                                            sw=1;
                                        }
                                    }
                                }else{
                                    if(datoModalidad.getValor().equals("2")){
                                        //VERIFICAR EL TONELAJE DEL VEHICULO
                                        DatosVehiculo datoTonelaje = model.consultarDatosVehiculoRete(idvehiculo, 2, 40);
                                        if(datoTonelaje!=null && !datoTonelaje.getValor().equals("0")){
                                            if(vehiculo.getClase_vehiculo()==4 || vehiculo.getClase_vehiculo()==5 || vehiculo.getClase_vehiculo()==8){
                                               //CARROCERIA PICK UP
                                               if(datoCarroceria.getValor()=="12" || datoCarroceria.getValor()=="388"){
                                                   //CONSULTAR AVALUO VEH CARROCERIA PICK UP
                                                   valorAvaluo = model.consultarAvaluoVehCargaPico(vehiculo.getPlaca(), modelo_veh);
                                                     if(valorAvaluo!=null){
                                                        vrete = (Long.parseLong(valorAvaluo)*1000)*0.01;
                                                        valrete= ""+Math.round(vrete);
                                                     }else{
                                                        sw=1;
                                                     }
                                               }else{
                                                    //LOS DEMAS VEH DE CARGA
                                                   valorAvaluo = model.consultarAvaluoVehCarga(vehiculo.getPlaca(), modelo_veh);
                                                   if(valorAvaluo!=null){
                                                        vrete = (Long.parseLong(valorAvaluo)*1000)*0.01;
                                                        valrete= ""+Math.round(vrete);
                                                   }else{
                                                        sw=1;
                                                   }
                                               }
                                              }else{
                                                sw=1;
                                                 }
                                        //TONELAJE
                                        }else{
                                            show = "Digite la Capacidad de Tonelaje del Vehiculo !!!";
                                            %>
                                           <show><%=show %></show>
                                            <%
                                        }
                                    }else{
                                        sw=1;
                                    }
                                }
                                }else{
                                    show = "Escoja la Modalidad del Vehiculo !!!";
                                    %>
                                   <show><%=show %></show>
                                    <%
                                }//MODALIDAD

                              }else{
                                    show = "Registre la Carroceria del Vehiculo !!!";
                                %>
                                <show><%=show %></show>
                                <%
                                }//CARROCERIA
                            }
                        }else{
                            //VEHICULOS NUEVOS
                            valorAvaluo = model.consultarAvaluoVehiculosAct(vehiculo.getPlaca());
                            if(valorAvaluo!=null){
                                vrete = Long.parseLong(valorAvaluo)*0.01;
                                valrete= ""+Math.round(vrete);
                            }else{
                                sw=1;
                            }
                        }
                        sw=1;vrete=0;
    if(sw==1){
        if(vrete<=0){
            String valt =model.consultarValorTimbre(vehiculo.getId_vehiculo(), anoactual);
            if(valt.equals("")){
                show = "1";
%>
                <show><%=show %></show>
<%
            }else{
                vrete = Long.parseLong(valt)*0.01;
                valrete= ""+Math.round(vrete);
            }
        }
    }

                    }else{
                         show = "Seleccione la Marca y la Linea del Vehiculo !!!";
                                %>
                                <show><%=show %></show>
                                <%
                    }
                }else{
                    show = "Registre el Cilindraje del Vehiculo !!!";
                   %>
                                <show><%=show %></show>
                    <%
                }
            }else{
                show = "Registre el Modelo del Vehiculo !!!";
            %>
            <show><%=show %></show>
            <%
            }
        }else{
            show = "El Vehiculo no se encuentra registrado !!!";
            %>
            <show><%=show %></show>
<%
        }
}
    //valrete="0";
%>
<valrete><%=valrete %></valrete>
</root>
