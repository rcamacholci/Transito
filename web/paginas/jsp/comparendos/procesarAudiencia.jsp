<%-- 
    Document   : procesarAudiencia
    Created on : 12/12/2012, 01:37:01 PM
    Author     : acer
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

   <% try{
        modelo.Model model = (modelo.Model)session.getAttribute("model");
        modelo.Usuario usuario=(modelo.Usuario)session.getAttribute("usuario");
    	if(model!=null){
           modelo.Comparendo comp = model.consultar_Comparendo(request.getParameter("Comparendo"));
           modelo.Audiencias aud = new modelo.Audiencias();
           //aud.setId_Audiencia(1);//1
           if(comp!=null){
           System.out.println("/*"+comp.getId_comparendo()+"*/");
           aud.SetFk_comparendo(comp.getId_comparendo());//2
            }else{
                System.out.println("NULL");
            }
           if(request.getParameter("Sagente").isEmpty() || request.getParameter("Sagente").equals("NO")){
           System.out.println("NO");
           }else{
           aud.SetFk_agente(comp.getFk_agente());
           }
           String hora =request.getParameter("horas")+":"+request.getParameter("minutos");
           aud.SetHora(hora);//4
           java.sql.Date fecha = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha")).getTime());
           aud.setFecha(fecha);//5
           aud.SetEstado(1);//6
           aud.SetFk_inspector(Long.parseLong(request.getParameter("insp")));
           aud.SetFk_usuario(usuario.getId_usuario());
           model.AdicionarAudiencia(aud);
           model.UpdateSA(aud.getFk_comparendo(),1);
           model.getCon().commit();
        }
        %>
        <script type="text/javascript" language="javascript">
           window.location.href = "ConsultaSolicitudAudiencia.jsp";
        </script>

        <%

    }catch(Exception exe){ %>
        <jsp:forward page="../no_access.jsp">
            <jsp:param name="tipo" value="2"></jsp:param>
            <jsp:param name="msgError" value="<%=exe.getMessage()%>"></jsp:param>
        </jsp:forward>
<%  } %>
