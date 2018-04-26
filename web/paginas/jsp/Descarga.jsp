<%@ page import="java.util.*,java.io.*,modelo.*"%>
<%
     procesos.procesoContravencional procesoContravencional = new procesos.procesoContravencional();
     try{
            modelo.Model model = (modelo.Model)session.getAttribute("model");
            modelo.Usuario usuario=(modelo.Usuario)session.getAttribute("usuario");
            if(1==1){
            //SimitPlano simitplano = model.consultarPlanoSimitById(Long.parseLong(request.getParameter("id_plano_simit")));
           // String fecha_reporte = new java.text.SimpleDateFormat("yyyyMMdd").format(simitplano.getFechaReporte());

            String archivo1=request.getParameter("archivo");
            String nFile="";
            String op= request.getParameter("op");
            if(op.equals("1")){
            nFile = "C:/Civitrans/transito/build/web/paginas/data/planes/" + archivo1+".pdf";
            }else{
            nFile = "C:/Comparendos/Fisico/"+archivo1+".pdf";
            }
            File file = new File(nFile);
            FileInputStream archivo = new FileInputStream(file);
            int longitud = archivo.available();
            byte[] datos = new byte[longitud];
            archivo.read(datos);
            archivo.close();

            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition","attachment;filename="+archivo1);

            ServletOutputStream ouputStream = response.getOutputStream();
            ouputStream.write(datos);
            ouputStream.flush();
            ouputStream.close();
            }
     }catch(Exception e){
            e.printStackTrace();
     }
%>