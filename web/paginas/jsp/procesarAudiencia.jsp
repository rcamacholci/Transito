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
    String comparendo = request.getParameter("Comparendo");
    System.out.println("1 - >"+comparendo);
    modelo.Comparendo comp = model.consultar_Comparendo(comparendo);
           if(comp!=null){
           modelo.Audiencias aud = new modelo.Audiencias();
           //aud.setId_Audiencia(1);//1
           System.out.println("agente - >"+comp.getFk_agente());
           System.out.println("ID - >"+comp.getId_comparendo());
           aud.SetFk_comparendo(comp.getId_comparendo());//2
           /**/

           /**/
           if(request.getParameter("Sagentes")=="NO"){
           System.out.println("NO");
           }else{
           System.out.println("agente - >"+comp.getFk_agente());
           aud.SetFk_agente(comp.getFk_agente());
           System.out.println("SI");
           }
           String hora =request.getParameter("horas")+":"+request.getParameter("minutos");
           System.out.println("Hora - >"+hora);
           aud.SetHora(hora);//4
           java.sql.Date fecha = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha")).getTime());
           System.out.println("agente - >"+fecha);
           aud.setFecha(fecha);//5
           aud.SetEstado(1);//6
           aud.SetFk_inspector(Long.parseLong(request.getParameter("insp")));
           System.out.println("Inp - >"+comp.getFk_agente());
           aud.SetFk_usuario(usuario.getId_usuario());
           System.out.println("agente - >"+usuario.getId_usuario());
           model.AdicionarAudiencia(aud);
           /**/
           java.sql.Timestamp fechaSystem = new java.sql.Timestamp(new java.util.Date().getTime());
long estado=10;
modelo.auditoria_comparendo com = new modelo.auditoria_comparendo();
//System.out.println("ok vamos hace esto ->"+());
//modelo.Comparendo temp = model.consultar_Comparendo(c.getReferencia());
model.UpdateAditoriaComparendo(fechaSystem,aud.getFk_comparendo());
com.setFk_comparendo(aud.getFk_comparendo());
com.setFk_estado(1);
com.setFecha_proceso(fechaSystem);
com.setUsuario(usuario.getId_usuario());
com.setEstado(estado);
com.setFecha_inicio(fechaSystem);
com.setFecha_fin(null);
model.InsertAuditoriaComparendo(com);

model.UpdateSA(com.getFk_comaprendo(),1);

        }else{
            %>
            <script>
                alert("el comparendo no existe");
            </script>
            <%
          }
           }
        %>
        <script>
            alert("Audiencia programada correctamente");
           window.location.href = "../Detalle_solicitud_Auditoria.jsp?comparendo=0";
        </script>

        <%

    }catch(Exception exe){ %>
        <jsp:forward page="no_access.jsp">
            <jsp:param name="tipo" value="2"></jsp:param>
            <jsp:param name="msgError" value="<%=exe.getMessage()%>"></jsp:param>
        </jsp:forward>
<%  } %>
