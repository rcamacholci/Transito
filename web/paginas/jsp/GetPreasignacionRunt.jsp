<?xml version="1.0" encoding="UTF-8"?>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" import="java.util.*,modelo.*" %>
<root>
  <%
try{
 modelo.Model model =(modelo.Model) session.getAttribute("model");
  if(request.getParameter("vin")!=null&&request.getParameter("placa")!=null&&!request.getParameter("vin").equals("")&&!request.getParameter("placa").equals("")){
  modelo.Preasignacion vinrunt = model.consultarPreasignacionRNRYS(request.getParameter("vin"));
  modelo.Preasignacion placarunt = model.consultarPreasignacion(request.getParameter("placa"));
    if(vinrunt!=null&&placarunt!=null){
      if(true){
    //if(placarunt.getVin().equals(vinrunt.getVin())&&vinrunt.getPlaca().equals(placarunt.getPlaca())){
  %>
  <result>1</result>
  <msg></msg>
  <%
      }else{%>
            <result>2</result>
            <msg>
                La Placa: <%=placarunt.getPlaca()%> esta utilizado en el Vin:<%=placarunt.getVin()%>
                El Vin:<%=vinrunt.getVin()%> Esta utilizado en la Placa: <%=vinrunt.getPlaca()%>
            </msg>
            <%
      }//error <>
  }else{
      if(vinrunt!=null){
  %>
  <result>2</result>
  <msg>El Vin:<%=vinrunt.getVin()%> Esta utilizado en la Placa: <%=vinrunt.getPlaca()%></msg>
  <%
  }else{
    if(placarunt!=null){
  %>
  <result>2</result>
  <msg>La Placa: <%=placarunt.getPlaca()%> esta utilizado en el Vin:<%=placarunt.getVin()%></msg>
  <%
  }else{
  %>
  <result>1</result>
  <msg></msg>
  <%
  }//placa
  }//vin
  }//vin&&placa
  }else{%>

  <result>2</result>
  <msg>Los parametro Vin y Placa no deben ser vacios</msg>
  <%
  }
}catch(Exception ex){
  %>
  <result>2</result>
  <msg>Error: <%=ex%></msg>
  <%
}
%>
</root>