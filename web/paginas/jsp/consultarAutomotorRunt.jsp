<%@ page import="modelo.* "%>
<%
    try{
             Model model = (Model)session.getAttribute("model");
             Usuario usuario = (Usuario)session.getAttribute("usuario");



             //System.out.println("lunes :"+Encrypt.getSecurityCode(new java.text.SimpleDateFormat("dd/MM/yyyy").parse("12/03/2012")));
         //   System.out.println("martes :"+Encrypt.getSecurityCode(new java.text.SimpleDateFormat("dd/MM/yyyy").parse("22/05/2012")));
          //  System.out.println("miercolesc :"+Encrypt.getSecurityCode(new java.text.SimpleDateFormat("dd/MM/yyyy").parse("23/05/2012")));
           // System.out.println("jueves :"+Encrypt.getSecurityCode(new java.text.SimpleDateFormat("dd/MM/yyyy").parse("24/05/2012")));
           // System.out.println("viernes :"+Encrypt.getSecurityCode(new java.text.SimpleDateFormat("dd/MM/yyyy").parse("27/08/2012")));
            // System.out.println(Encrypt.getSecurityCode(new java.text.SimpleDateFormat("dd/MM/yyyy").parse("12/08/2011")));

             //inscripcion.registrarPersonaRunt registro = new inscripcion.registrarPersonaRunt(model);
             //registro.inscribirPersona(1, request.getParameter("doc"));
             //procesos.procesoContravencional proceso = new procesos.procesoContravencional()
             //proceso.generarPlanos(model, usuario, 1);
             /*Object[] obs = model.consultarPagoComparendos();
             java.util.LinkedList<Tiquete> tiquetes =(java.util.LinkedList<Tiquete>)obs[0];
             java.util.List<Cartera> carteras = (java.util.LinkedList<Cartera>)obs[1];*/
             //procesos.procesoContravencional procesoContravencional = new procesos.procesoContravencional();
             //procesoContravencional.generarPlanos(model, usuario, 1);
             /*System.out.println("Lista de Tiquetes  :"+tiquetes.size());
             for(int i=0;i<tiquetes.size();i++){
                 Tiquete tiquete = tiquetes.get(i);
                 Cartera cartera = carteras.get(i);
                 boolean respuesta = procesoContravencional.adicionarRecaudoPago(model, usuario, tiquete,cartera,0);
             }*/

           /*procesos.calcularIntereses calcularI = new procesos.calcularIntereses();
                int s = model.consultarMaxCodigo();
                String tasas[][] = model.getIntereses();
                calcularI.setTasas("c", s, tasas);
                java.util.Date inicio = new java.text.SimpleDateFormat("dd/MM/yyyy").parse("31/08/2010");
                java.util.Date fin = new java.text.SimpleDateFormat("dd/MM/yyyy").parse("10/03/2011");
                float valor = calcularI.getValor(inicio, fin, 257500);
                out.print(valor);
             webservices.bancos.BancosServicesClient bancosService = new webservices.bancos.BancosServicesClient();
             bancosService.setTokenHuellaDigital(Model.userToken);
             bancosService.setUser(Model.userHandler);
             bancosService.consultarLiquidacionCUPL("");
             System.out.println(bancosService.consultarLiquidacionCUPL("600000000004164952"));
             webservices.liquidacion.LiquidacionServicesClient liquidacion = new webservices.liquidacion.LiquidacionServicesClient();
             liquidacion.setTokenHuellaDigital(Model.userToken);
             liquidacion.setUser(Model.userHandler);
             com.heinsohn.runt.general.solicitudes.LiquidacionOutDTO liq = liquidacion.consultarDatosLiquidacion("");

             // model.ajustarInteresesCostasVehiculos(97960, 1, new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse("27/07/2010").getTime()));*/
             /*webservices.common.CommonServicesClient commonService = new webservices.common.CommonServicesClient();
             commonService.setTokenHuellaDigital(Model.userToken);
             commonService.setUser(Model.userHandler);
             com.heinsohn.runt.general.consultas.ConsultarTemplateHuellaDigitalOutDTO template =  commonService.consultarTemplateHuellaDigital("C", request.getParameter("cedula"));
             System.out.println("template para :"+request.getParameter("cedula"));
             System.out.println(template.getTemplate());
             System.out.println(template.getStatus());
             System.out.println(template.getStatus().getStatusCode());*/

             //model.calcularInteresesXServicio(1);
             System.out.println("ok");

               java.io.FileInputStream fs = new java.io.FileInputStream("C:/Squid/in2.txt");
               java.io.DataInputStream en = new java.io.DataInputStream(fs);
               java.io.BufferedReader bf = new java.io.BufferedReader(new java.io.InputStreamReader(en));

               String linea ;
               String ok = "";
               while((linea = bf.readLine())!= null){
                ok = linea;
               }

             webservices.consultas.ServicioConsultaRUNTClient consultaService = new webservices.consultas.ServicioConsultaRUNTClient();
             consultaService.setTokenHuellaDigital(ok);
             consultaService.setUser("8631168");
             String us = "8631168";
             String pss = "jesusg123";
             int cont = 0;
             String respuesta = "";
             String placa ;
              java.io.File archivo = new java.io.File("C:\\Civitrans\\placas2.txt");
             java.io.FileInputStream fis = new java.io.FileInputStream(archivo);
             java.io.DataInputStream dis = new java.io.DataInputStream(fis);
             while((placa=dis.readLine())!=null){
                 while(cont<3){
                     com.heinsohn.runt.general.consultas.AutomotorOutDTO automotor = consultaService.consultarDatosAutomotor(placa.toUpperCase(), null, null,null, null,us,pss);
                     if(automotor!=null){
                        if(automotor.getStatus()!=null){
                            if(automotor.getStatus().getStatusCode().equals("1")){
                                System.out.println("SI EXISTE : "+automotor.getAutomotor().getValue().getIdentificador().getValue().getNumeroPlaca());
                                break;
                            }else{
                                respuesta = "NO EXISTE : "+placa.toUpperCase();
                                break;
                            }
                     }else{
                         respuesta = "NO_ACCESO";
                         cont++;
                     }
                 }else{
                     respuesta = "NO_ACCESO";
                     cont++;
                 }
             }
             out.print(respuesta);
        }

              
    }catch(Exception ecx){
            ecx.printStackTrace();
            //REJ254
    }  %>
