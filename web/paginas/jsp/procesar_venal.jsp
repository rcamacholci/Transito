<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Adicionar Color</title>
</head>

<body>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<%

Model modelo= (Model)session.getAttribute("model");
Usuario usuario = (Usuario)session.getAttribute("usuario");
long rango = 0;
try{
        if((request.getParameter("estado")!=null)&&(request.getParameter("idVenal")!=null)){
            modelo.getCon().setAutoCommit(false);
                long id_venal =  Integer.parseInt(request.getParameter("idVenal"));
                int estado =   Integer.parseInt(request.getParameter("estado"));
                Venal venal = modelo.consultar_Venal(id_venal);
                Preasignacion preasig = modelo.consultarPreasignacion(venal.getNumero());
                if(preasig!=null&&estado==1&&venal.getEstado()!=1){
                    modelo.actualizarPreasignacion(preasig.getId_preasignacion(),2);
                }
                rango = venal.getFk_rango();
                if(estado==3){
                    Venal_preasignacion venalP = new Venal_preasignacion();
                    venalP.setFk_venal(id_venal);
                    venalP.setFk_usuario(usuario.getId_usuario());

                    java.util.List lista = modelo.listarVenalPreasignacion(id_venal);
                    if(lista.size()>0){
                        for(int i=0;i<lista.size();i++){
                        Venal_preasignacion v = (Venal_preasignacion)lista.get(i);
                            modelo.actualizarVenalPreasignacion(venalP);
                        }
                        modelo.adicionarVenalPreasignacion(venalP);
                    }else{
                        modelo.adicionarVenalPreasignacion(venalP);
                    }

                }

                modelo.actualizarEstadoVenal(id_venal, estado, usuario.getId_usuario());
                modelo.getCon().commit(); %>
                 <script language="javascript" type="text/javascript">
			alert("Venal Actualizado con exito");
                 </script>
      <%  }else{ %>
                <script language="javascript" type="text/javascript">
			alert("Venal no pudo ser actualizada");
                 </script>

       <% } %>
     <script language="javascript" type="text/javascript">window.location.href="listar_rangos.jsp?rango="+<%=rango%>+"&id=0&n=1";</script>


    <%
	}catch(Exception ecx){
		modelo.getCon().rollback();
		ecx.printStackTrace();        %>
		<script language="javascript" type="text/javascript">
			alert("Venal no puedo ser Actualizada");
			window.location.href="listar_venales.jsp?rango="+<%=rango%>+"&id=0&n=1";
		</script>
<%  }
%>
</body>
</html>
