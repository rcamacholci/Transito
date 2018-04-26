<%@page  import = "modelo.Model,modelo.Preasignacion" import = "java.util.*" import = "java.sql.*"   %>
<%@ page import="modelo.*"%>
<%@ page import="Cifrado.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.io.*"%>

import ;
import java.sql.*;

<%

 Model model = null;
   
     String msg = "";
     int id = 0;
     
try{
  model = (Model)session.getAttribute("model");
 if(model!=null){
    if((request.getParameter("anterior")!=null&&request.getParameter("nuevo")!=null&&request.getParameter("nuevo2")!=null) || (request.getParameter("nuevo")!=request.getParameter("nuevo2"))){
            String pass = "",encript = "";
            FileInputStream fstream = new FileInputStream("C:/Civitrans/transito/civitrans.sys");
            DataInputStream entrada = new DataInputStream(fstream);
            BufferedReader buffer = new BufferedReader(new InputStreamReader(entrada));
            String strLinea, cadena = "",strLinea1;
            int cont = 0;
            while ((strLinea = buffer.readLine()) != null)   {
              //  System.out.println ("LINEA : "+strLinea);
                cont= cont+1;
             }
            entrada.close();
            FileInputStream fstream1 = new FileInputStream("C:/Civitrans/transito/civitrans.sys");
            DataInputStream entrada1 = new DataInputStream(fstream1);
            BufferedReader buffer1 = new BufferedReader(new InputStreamReader(entrada1));

            int a = 0;
            while ((strLinea1 = buffer1.readLine()) != null)   {
              //  System.out.println ("LINEA2 : "+strLinea1);
                pass = strLinea1;
                if(a<(cont-1)){
                    cadena = cadena+""+pass+"\n";
                }else{
                    cadena = cadena+""+pass;
                }
                a++;
            }

        entrada1.close();
       // System.out.println ("contador : "+cont);
      //  System.out.println ("cadena : "+cadena);
            encript = KeyStore.Desencriptar(cadena);
     //   System.out.println ("pass viejo : "+encript);


            if(request.getParameter("anterior").equals(encript)){
               String nv = request.getParameter("nuevo");
       //        System.out.print("pass BD New :  "+nv);
               String sentencia = "ALTER USER TRANSITO IDENTIFIED BY "+nv;
               model.passBD(sentencia);
               msg = "El password ha sido cambiado exitosamente.";
               java.io.File f = new java.io.File("C:/Civitrans/transito/civitrans.sys");
               java.io.FileOutputStream fos = new java.io.FileOutputStream(f);
               java.io.DataOutputStream dos = new java.io.DataOutputStream(fos);
               dos.writeBytes(KeyStore.Encriptar(nv));
               id=1;
               model.getCon().commit();
       }else{
       msg = "el password anterior no coincide";
       }
        
      }else{
            msg = "Digite todos los password correctamente";
      }

 }
}catch(Exception exc){
         exc.printStackTrace();
         model.getCon().rollback();
}
 if(request.getParameter("tipo").equals("1")){
      if(id==0){ %>
            <script>  alert('<%=msg%>'); window.document.location.href = "editarpasswordBD.jsp"; </script>
      <% }else{ %>
            <script>  alert('<%=msg%>'); window.parent.parent.document.location.href = "../../index.jsp"; </script>
      <% }
  }
     if(request.getParameter("tipo").equals("0")){
       if(id==0){ %>
            <script>  alert('<%=msg%>'); document.location.href = "editarPassword.jsp"; </script>
       <%}else{%>
            <script>  alert('<%=msg%>'); window.parent.parent.document.location.href = "../../index.jsp"; </script>
       <%}
}
%>


