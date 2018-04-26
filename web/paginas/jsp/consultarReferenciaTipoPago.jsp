<?xml version="1.0" encoding="ISO-8859-1"?>
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" %>
<root>
<%
modelo.Model model= (modelo.Model)session.getAttribute("model");
String valor = "0";
String fecha = "-";
String estado = "";
try{
    if (!request.getParameter("tipoPago").isEmpty()&&!request.getParameter("referencia").isEmpty()){
        int tipoP = Integer.parseInt(request.getParameter("tipoPago"));
        String referencia = request.getParameter("referencia").trim();
        modelo.Titulo_Valor tituloValor = model.consultarTituloValor(referencia.toUpperCase());
        if(tituloValor!=null){
            if(tituloValor.getEstado()==1){
                valor = tituloValor.getValorDeposito()+"";
                fecha = new java.text.SimpleDateFormat("dd/MM/yyyy").format(tituloValor.getFechaTitulo());
                estado = tituloValor.getEstado()+"";
            }else{
                estado = tituloValor.getEstado()+"";
            }
        }else{
            estado = "-1";
        }
    }
}catch(Exception exc){
    exc.printStackTrace();
}
%>
<respuesta>
    <estado><%=estado%></estado>
    <valor><%=valor%></valor>
    <fecha><%=fecha%></fecha>
</respuesta>
</root>