<%@ page import="java.util.*,java.io.*,modelo.*"%>
<%
     procesos.procesoContravencional procesoContravencional = new procesos.procesoContravencional();
     try{
            modelo.Model model = (modelo.Model)session.getAttribute("model");
            modelo.Usuario usuario=(modelo.Usuario)session.getAttribute("usuario");
            if(request.getParameter("id_plano_simit")!=null){
            SimitPlano simitplano = model.consultarPlanoSimitById(Long.parseLong(request.getParameter("id_plano_simit")));
            String fecha_reporte = new java.text.SimpleDateFormat("yyyyMMdd").format(simitplano.getFechaReporte());

            String nFile = "C:/Civitrans/transito/build/web/paginas/data/simit/"+fecha_reporte+"/"+simitplano.getConsecutivo()+"/08000000resol.txt";

            File file = new File(nFile);
            FileInputStream archivo = new FileInputStream(file);
            int longitud = archivo.available();
            byte[] datos = new byte[longitud];
            archivo.read(datos);
            archivo.close();

            response.setContentType("application/msword");
            response.setHeader("Content-Disposition","attachment;filename= 08000000resol.txt");

            ServletOutputStream ouputStream = response.getOutputStream();
            ouputStream.write(datos);
            ouputStream.flush();
            ouputStream.close();
            }
     }catch(Exception e){
            e.printStackTrace();
     }
%>