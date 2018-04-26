<?xml version="1.0" encoding="UTF-8"?>
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" import="java.util.*,modelo.*" %>
<root>
<%
    Model model = (Model)session.getAttribute("model");

    int anoactual = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
    int anonuevo = (anoactual+1);
    
    String Mensaje = "";
    
    long claseVeh = 0;
    long servicioVeh = 0;
    String marcaVeh = "";
    String lineaVeh = "";
    long cilindrajeVeh = 0;
    long modeloVeh = 0;
    long modalidadVeh = 0;
    long carroceriaVeh = 0;
    long subServicioVeh = 0;

    int ValidaDatos = 0;
    
    String valorAvaluo = null;
    double valorRetencion = 0;
    String valorRetencionS = "0";

    int codTablaAvaluo = 0;
    
    if(request.getParameter("placa")!=null){
        String placaVeh = request.getParameter("placa");
        Vehiculo vehiculo = model.consultarVehiculo(placaVeh);
        if(vehiculo!=null){
            long idVehiculo = vehiculo.getId_vehiculo();
            
            Parametro parametroclaseVehiculo = model.consultarParametro(Integer.parseInt(""+vehiculo.getClase_vehiculo()), 1);
            if(!parametroclaseVehiculo.getNombreCorto().equals("4") && !parametroclaseVehiculo.getNombreCorto().equals("5")){
                
            //VERIFICAR LA CLASE DEL VEHICULO
            if(vehiculo.getClase_vehiculo()!=0){
                claseVeh = vehiculo.getClase_vehiculo();
            }else{
                Mensaje += "\n Clase";
                ValidaDatos=1;
            }

            //VERIFICAR EL SERVICIO DEL VEHICULO
            if(vehiculo.getServicio()!=0){
                servicioVeh = vehiculo.getServicio();
            }else{
                Mensaje += "\n Servicio";
                ValidaDatos=1;
            }

            //VERIFICAR LINEA Y MARCA
            Linea lineaRunt = model.consultaLinea(request.getParameter("placa"));
            if(!lineaRunt.getNombre().equals("SIN LINEA")){
                Marca MarcaRunt = model.consultaMarcaCodigo(lineaRunt.getFk_marca());
                if(!MarcaRunt.getNombre().equals("SIN MARCA")){
                   marcaVeh = MarcaRunt.getNombre();
                   lineaVeh = lineaRunt.getNombre();
                }else{
                    Mensaje += "\n Marca \n Linea";
                    ValidaDatos=1;
                }
            }else{
                Mensaje += "\n Marca \n Linea";
                ValidaDatos=1;
            }

            //VERIFICAR CILINDRAJE
            DatosVehiculo datoCilindraje = model.consultarDatosVehiculoRete(idVehiculo, 11, 40);
            if(datoCilindraje!=null && datoCilindraje.getValor()!=null){
                cilindrajeVeh = Long.parseLong(datoCilindraje.getValor());
            }else{
                Mensaje += "\n Cilindraje";
                ValidaDatos=1;
            }

            //VERIFICAR EL MODELO
            if(vehiculo.getModelo()>0){
                modeloVeh = vehiculo.getModelo();
                if(modeloVeh<1991){
                    modeloVeh = 1991;
                }
            }else{
                Mensaje += "\n Modelo";
                ValidaDatos=1;
            }

            //VERIFICAR MODALIDAD
            DatosVehiculo datoModalidad = model.consultarDatosVehiculo(idVehiculo, 1, 324);
            if(datoModalidad!=null && datoModalidad.getValor()!=null){
                modalidadVeh = Long.parseLong(datoModalidad.getValor());
            }else{
                Mensaje += "\n Tipo de movilidad";
                ValidaDatos=1;
            }

            //VERIFICAR CARROCERIA
            if(claseVeh!=0 && claseVeh!=10 && claseVeh!=14 && claseVeh!=19){
                if(modalidadVeh==2){
                    DatosVehiculo datoCarroceria = model.consultarDatosVehiculo(idVehiculo, 1, 2);
                    if(datoCarroceria!=null && !datoCarroceria.getValor().equals("0")){
                        carroceriaVeh = Long.parseLong(datoCarroceria.getValor());
                    }else{
                        Mensaje += "\n Carroceria";
                        ValidaDatos=1;
                    }
                }
            }

            //VERIFICAR SUBSERVICIO
            if(servicioVeh==2){
                DatosVehiculo datoSubServicio = model.consultarDatosVehiculo(idVehiculo, 1, 362);
                if(datoSubServicio!=null && !datoSubServicio.getValor().equals("0")){
                    subServicioVeh = Long.parseLong(datoSubServicio.getValor());
                }else{
                    Mensaje += "\n Subservicio";
                    ValidaDatos=1;
                }
            }

            if(ValidaDatos==0){
                if(vehiculo.getModelo()==anoactual || vehiculo.getModelo()==anonuevo){
                    //VEHICULOS MODELO ACTUAL
                    valorAvaluo = model.consultarAvaluoVehiculosAct(placaVeh);
                    if(valorAvaluo!=null && Float.parseFloat(valorAvaluo)>0){
                        valorRetencion = Long.parseLong(valorAvaluo)*0.01;
                        valorRetencionS= ""+Math.round(valorRetencion);
                    }else{
                        %>
                    <sw><%="1"%></sw>
                    <%
                    }
                }else{
                    //CONSULTAR TABLA VALORES_RETENCION
                    float valorRetencionVeh = model.consultarValorRetencionByFkVehiculoVigencia(idVehiculo);
                    if(valorRetencionVeh>0){
                        valorRetencionS= ""+Math.round(valorRetencionVeh);
                    }else{
                    %>
                    <sw><%="2"%></sw>
                    <%
                    }
                }
            }else{
                //VEHICULO CON LOS DATOS INCOMPLETOS
                Mensaje = "Debe completar los siguientes datos del vehiculo: "+ Mensaje;
                %>
                <sw><%=Mensaje %></sw>
                <%
            }

            }else{
            %>
            <sw><%="1"%></sw>
            <%
            }
            
        }else{
            Mensaje = "El Vehiculo no se encuentra registrado !!!";
            %>
            <sw><%=Mensaje %></sw>
<%
        }
    }
%>
<valorRetencion><%=valorRetencionS %></valorRetencion>
</root>