<%--
    Document   : pantallazo
    Created on : 18/02/2011, 05:15:09 PM
    Author     : Administrador
--%>

<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="procesos.PlanosInfotic"%>
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java"  import="java.sql.*" import="modelo.Model"  import="modelo.Usuario" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
    <style>
         .date {font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold; width:100px }
    </style>
    <head>
        <title>Inicio</title>
    </head>
    <body>
        <table>
            <%
                try{
            Model model = (Model)session.getAttribute("model");
            Usuario usuario = (Usuario)session.getAttribute("usuario");
            model.getCon();
            procesos.PlanosInfotic P = new PlanosInfotic();

            int Servicio = Integer.parseInt(request.getParameter("Servicio"));
            int Fi = Integer.parseInt(request.getParameter("vinicial"));
            int Ff = Integer.parseInt(request.getParameter("vfinal"));
            boolean sw =P.generarPlanos(model, usuario, Servicio, Fi, Ff);
            if(sw){
                    System.out.println("exito");
            }else{
                            %>
        <script>
                    alert("Error en el Proceso.")
        </script>
            <%
            }
    try{
            if(sw){
            //SimitPlano simitplano = model.consultarPlanoSimitById(Long.parseLong(request.getParameter("id_plano_simit")));
           // String fecha_reporte = new java.text.SimpleDateFormat("yyyyMMdd").format(simitplano.getFechaReporte());

            String archivo1="CarteraParticular";//request.getParameter("archivo");
            String nombre = Servicio==1?"CarteraParticular":Servicio==2?"CarteraPublico":Servicio==3?"CarteraDiplomatico":Servicio==4?"CarteraOficial":Servicio==5?"CarteraOtros":"CarteraEspecial";
            String nFile="";
            String op="1" ;//request.getParameter("op");
            if(op.equals("1")){
                String fecha = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
                System.out.println("FECHA: "+fecha);
                System.out.println("DIR "+P.archivo);
                String dir = "C:/Civitrans/transito/build/web/paginas/data/Infotic/"+fecha+"/";
            //  nFile = dir + archivo1+".txt";
                nFile = P.archivo+".txt";
            }else{
            nFile = "C:/Comparendos/Fisico/"+archivo1+".txt";
            }
            File file = new File(nFile);
            FileInputStream archivo = new FileInputStream(file);
            int longitud = archivo.available();
            byte[] datos = new byte[longitud];
            archivo.read(datos);
            archivo.close();

            response.setContentType("text/plain");
            response.setHeader("Content-Disposition","attachment;filename="+nombre+".txt");

            ServletOutputStream ouputStream = response.getOutputStream();
            ouputStream.write(datos);
            ouputStream.flush();
            ouputStream.close();
            %>
            <script>
                parent.document.getElementById("btndescargar").disabled = false;
                parent.document.getElementById("btndescargar").value = "Descargar";
                parent.document.getElementById('info').style.display = 'none';
            </script>
            <%
            }
     }catch(Exception e){
            e.printStackTrace();
            %>
        <script>
                    alert("Error: \n <%=e%>")
        </script>
            <%
     }
                }catch(Exception Ex ){
                    Ex.printStackTrace();
            %>
        <script>
                    alert("Error: \n <%=Ex%>")
        </script>
            <%
                }
                %>

        </table>

    </body>
</html>
