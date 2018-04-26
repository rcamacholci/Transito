<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%
modelo.Model model= (modelo.Model)session.getAttribute("model");
int estado = 0;
String dir = "";
try{
    if (!request.getParameter("foto").isEmpty()){
         int tipoD = Integer.parseInt(request.getParameter("tdoc"));
         String tipoDocumento = model.consultarParametro(tipoD,5).getNombreCorto();
         String numeroDocumento = request.getParameter("ndoc").trim();
         modelo.Persona persona = model.consultarPersona(tipoD,numeroDocumento);
         if(persona!=null){
             java.io.File file = new java.io.File("C:\\Civitrans\\transito\\web\\paginas\\data\\fotosLicencias\\Foto"+persona.getId_persona()+".jpg");
             java.io.FileOutputStream fos = new java.io.FileOutputStream(file);
             fos.write(modelo.Base64Coder.decode(new String(request.getParameter("foto"))));
             fos.flush();
             fos.close();
             file = new java.io.File("C:\\Civitrans\\transito\\build\\web\\paginas\\data\\fotosLicencias\\Foto"+persona.getId_persona()+".jpg");
             fos = new java.io.FileOutputStream(file);
             fos.write(modelo.Base64Coder.decode(new String(request.getParameter("foto"))));
             fos.flush();
             fos.close();
             estado = 1;
             dir = "../data/fotosLicencias/Foto"+persona.getId_persona()+".jpg";
         }
    }
}catch(Exception exc){
    exc.printStackTrace();
}
%>
 <script language="javascript" type="text/javascript">
     alert("<img src='"+dir+"' width='83' height='100'/>");
     window.parent.document.getElementById("imagen").innerHTML = "<img src='"+dir+"' width='83' height='100'/>";
     //window.parent.document.form.foto.value = obj.FOTO;
     window.parent.document.form.bfoto.value = "OK";
     window.parent.alert("Foto ha sido capturada!!");
  </script>
