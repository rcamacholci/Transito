<?xml version="1.0" encoding="UTF-8"?>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" import="modelo.*" %>
<root>
    <% Model model = (Model)session.getAttribute("model");
try{
    if(request.getParameter("id_comparendo")!=null){
        long id_comparendo =  Long.parseLong(request.getParameter("id_comparendo"));
        Comparendo comparendo = model.consultarComparendoById(id_comparendo);
        if(comparendo!=null){
            Cartera carteraComparendo = model.consultarCartera(comparendo.getFk_cartera());
            if(carteraComparendo!=null){
                java.sql.Date fecha = new java.sql.Date(new java.util.Date().getTime());

                float descuento = 0;
                java.util.Date fechaLimite = new java.text.SimpleDateFormat("dd/MM/yyyy").parse("15/03/2000");
                if(fechaLimite.getTime()>comparendo.getFecha().getTime()){
                    descuento = (float)0.5;
                }else{
                    Electronico elec = model.consultareElectronico(comparendo.getId_comparendo());
                      if(elec!=null){
                        if(elec.getElectronico().equals("SI")){
                            //int dias = model.consultarDiasHabiles(new java.sql.Date(comparendo.getFecha_notificacion().getTime()));
  /*                          if(dias <=11){
                                descuento =(float)0.5;
                            }else{
                                if(dias < 25){
                                  descuento = (float)0.25;
                                }
                            }*/
                         }
                    }else{
                        int dias = model.consultarDiasHabiles(new java.sql.Date(comparendo.getFecha().getTime()));
                        if(dias <= 5){
                            descuento = (float)0.5;
                        }else{
                            if(dias < 21){
                                descuento = (float)0.25;
                            }
                        }
                    }
                }

                float valorDescuento = (float)(carteraComparendo.getValor()*(1.0-descuento));
                float valorCertificado = 0;

                valorCertificado = (float)(valorDescuento*0.25);
                valorCertificado = Math.round(valorCertificado);

                float valortotal = valorDescuento;
                valorDescuento -= valorCertificado;
                valortotal=valorDescuento+13300;
                %>
                <ValorCertificado><%=valorCertificado%></ValorCertificado>
                <ValorDescuento><%=valorDescuento%></ValorDescuento>
                <ValorTotal><%=valortotal%></ValorTotal>
                <%
             }
        }
    }
}catch(Exception exc){}%>
</root>
