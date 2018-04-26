<?xml version="1.0" encoding="UTF-8"?>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" import="java.util.*,modelo.*" %>


<root>
<%

Model modelo = (Model)session.getAttribute("model");

String sw = "0";
String vigencia = "";
try{

    Cartera new_Cartera = new Cartera();

    modelo.getCon().setAutoCommit(false);
    Usuario usuario = (Usuario)session.getAttribute("usuario");
    if(request.getParameter("idveh")!=null){        
            long id_veh = Long.parseLong(request.getParameter("idveh"));
            int anoactual = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);

    java.util.List lista = modelo.consultarCarteraVehiculo(id_veh);
    if(lista==null){
	 	lista = new java.util.LinkedList();
    }
    
    long id_cart = 0;
        modelo.actualizarInteresesCostasVehiculos(id_veh, usuario.getId_usuario());
        for(int v=0;v<lista.size();v++){
            Cartera cart = (Cartera)lista.get(v);
            id_cart = cart.getId_cartera();
            vigencia = cart.getReferencia();
            long vigenciaA = Long.parseLong(vigencia);
        System.out.println("ID_CARTERA: "+id_cart+" VIGENCIA: "+cart.getReferencia());
        if(vigenciaA<=2010){
            modelo.Detalle_Cartera detalle_cartera = new modelo.Detalle_Cartera();
            Detalle_Cartera dtcartera = modelo.consultarDetalleCartera(cart.getId_cartera(), 249);
            float valor_interes = dtcartera.getValor();
            int interesD =(int)((valor_interes*80)/100);
            int valinteres = (int)valor_interes-interesD;
            int valdescontado = valinteres-(int)valor_interes;

            System.out.println("Interes sin descuento: "+(int)valor_interes);
            System.out.println("Interes con descuento: "+valinteres);
            System.out.println("Valor descontado: "+valdescontado);

            detalle_cartera.setFk_cartera(cart.getId_cartera());
            detalle_cartera.setEstado(1);
            detalle_cartera.setFecha(cart.getFecha_creacion());
            detalle_cartera.setFecha_sistema(new java.sql.Timestamp(new java.util.Date().getTime()));
            detalle_cartera.setFk_concepto(1093);
            detalle_cartera.setFk_usuario(usuario.getId_usuario());
            detalle_cartera.setReferencia(cart.getReferencia());
            detalle_cartera.setValor(Math.round(valdescontado));
            modelo.adicionarDetalleCartera(detalle_cartera);
            modelo.InsertarValorDescuento(id_veh, id_cart, cart.getReferencia(), valdescontado, 1, valinteres);
        }/*else{
            //CUANDO ES ACUERDO DE PAGO SEA EL 50%
            modelo.Detalle_Cartera detalle_cartera = new modelo.Detalle_Cartera();
            Detalle_Cartera dtcartera = modelo.consultarDetalleCartera(cart.getId_cartera(), 1087);
            float valor_impuesto = dtcartera.getValor();
            int DescImpuesto =(int)((valor_impuesto*15)/100);
            int valimpuesto = (int)valor_impuesto-DescImpuesto;
            int valdescontado = valimpuesto-(int)valor_impuesto;

            System.out.println("Impuesto sin descuento: "+(int)valor_impuesto);
            System.out.println("Impuesto con descuento: "+valimpuesto);
            System.out.println("Valor descontado: "+valdescontado);
            
            detalle_cartera.setFk_cartera(cart.getId_cartera());
            detalle_cartera.setEstado(1);
            detalle_cartera.setFecha(cart.getFecha_creacion());
            detalle_cartera.setFecha_sistema(new java.sql.Timestamp(new java.util.Date().getTime()));
            detalle_cartera.setFk_concepto(1093);
            detalle_cartera.setFk_usuario(usuario.getId_usuario());
            detalle_cartera.setReferencia(cart.getReferencia());
            detalle_cartera.setValor(Math.round(valdescontado));
            modelo.adicionarDetalleCartera(detalle_cartera);
            modelo.InsertarValorDescuento(id_veh, id_cart, cart.getReferencia(), valdescontado, 1, valimpuesto);
        }*/
    }
        modelo.actualizarInteresesCostasVehiculos(id_veh, usuario.getId_usuario());
        sw = "1";
        
  }
    modelo.getCon().commit();
    
}catch(Exception ex){
    modelo.getCon().rollback();
    System.out.println("/*-"+ex+"*/");
}
%>
<sw><%=sw %></sw>
</root>
