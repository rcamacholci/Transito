<%-- 
    Document   : procesararchivoplanocomparendos
    Created on : 16/07/2012, 10:18:05 AM
    Author     : digitalizacion
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="procesos.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="procesos.*" import="java.io.*"%>
<%

            try {

                 Model model = new Model();
                 model.conectar();
                 String fechaI = request.getParameter("date");
                 String fechaF = request.getParameter("date2");
                 System.out.println(fechaF+"_"+fechaI);
            try{


            File f = new File("C:/Civitrans/transito/build/web/paginas/data/contabilidad/CONTABILIDAD_"+fechaI.replaceAll("/", "")+"-"+fechaF.replaceAll("/", "")+".txt");
            FileOutputStream fos = new FileOutputStream(f);
            DataOutputStream dos = new DataOutputStream(fos);
            String registro ="";

            java.util.List<planosconta> planos = null;
            planos  = model.planoContabilidad(fechaI, fechaF);


            if(planos.size()>0){

        for(int j=0;j<planos.size();j++){
            planosconta info= planos.get(j);
            registro = info.getplano();
            dos.writeBytes(registro);
            dos.writeBytes("\n");
            }


            }else{
                %>
                <script language="javascript" type="text/javascript">
                    alert("No hay Registros");
                </script>
                <%
            }
            dos.flush();
            dos.close();
            fos.close();
        }catch(Exception exc){
           System.out.println("Error al consultar del archivo plano: " + exc);
        }

%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Archivos Planos</title>
        <style type="text/css">
            <!--
            .style1 {
                color: #FFFFFF;
                font-weight: bold;
            }
            .style2 {color: #FFFFFF}
            .style3 {
                color: #006699;
                font-weight: bold;
            }
            -->una461 
        </style>
    </head>
    <body>
        <table border="0" width="50%" align="center">
            <tr>
                <td height="40" align="center" bgcolor="#CCCCCC"><span class="style3">ARCHIVO PLANO COMPARENDOS SIMIT</span></td>
            </tr>
            <tr>
                <td height="40" align="center" bgcolor="#006699"><a href="../../data/contabilidad/CONTABILIDAD_<%=fechaI.replaceAll("/", "")+"-"+fechaF.replaceAll("/", "")%>.txt" name="ttahtrve" class="style1" target="_blank"><%="CONTABILIDAD_"+fechaI.replaceAll("/", "")+"-"+fechaF.replaceAll("/", "")%></a></td>
            </tr>
        </table>
    </body>
    <%
            } catch (Exception mexe) {
                mexe.printStackTrace();
            }%>
</html>