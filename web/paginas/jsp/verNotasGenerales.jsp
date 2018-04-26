<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.util.*" import="modelo.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Notas Credito</title>
	<script language="javascript" type="text/javascript">
		function edit(opcion){
			window.location.href = "editarPrestamo.jsp?idpc="+opcion.id;
		}
		function sombrear(tr){
			tr.style.backgroundColor="#CCCCCC";
		}
		function renovar(tr){
			tr.style.backgroundColor="#FFFFFF";
		}
	</script>
	        <style type="text/css">
<!--
.style1 {
	font-family: Arial;
	font-size: 11px;
	color: #003366;
	font-weight: bold;
	text-align:center;
}
.style4 {
	font-family: Arial;
	font-size: 10px;
	color:#006633;
	font-weight: bold;
	text-align:center;
	width:20px;
}
.style5 {
	font-family: Arial;
	font-size: 10px;
	color:#006633;
	font-weight: bold;
	text-align:center;
	width:80px;
}

-->
        </style>
</head>
<%
Model model= (Model)session.getAttribute("model");
if(model!=null){ 
    if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("consultarNotasGenerales.jsp")){ %>
    <body>
            <table width="100%" border="1" cellpadding="1" cellspacing="0" bordercolor="#CCCCCC">
               <tr class="style1">
                    <td width="7%">NUMERO</td>
					<td width="8%">FECHA</td>
					<td width="7%">VEHICULO</td>
					<td width="28%">NOMBRE SOLICITANTE</td>
					<td width="8%">VALOR</td>
					<td width="12%">REFERENCIA</td>
					<td width="8%">ESTADO</td>
					<td width="14%">FECHA PROCESO</td>
					<td width="8%">USUARIO</td>																																			
              </tr>
      <%   java.sql.Timestamp  fechaI = null;
           java.sql.Timestamp  fechaF = null;
           modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
           if((request.getParameter("fechaI")!=null)&&(request.getParameter("fechaF")!=null)){
                fechaI = new java.sql.Timestamp(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fechaI")).getTime());
                fechaF = new java.sql.Timestamp(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fechaF")).getTime());
                fechaF.setTime(fechaF.getTime()+86400000);
                java.util.List lista = model.consultarNotasCredito(fechaI, fechaF);
                HashMap parameters = new java.util.HashMap();
                parameters.put("USUARIO", usuario.getNombre());
                parameters.put("FECHA_INI",request.getParameter("fechaI"));
                parameters.put("FECHA_FIN",request.getParameter("fechaF"));
                session.setAttribute("notascredito", parameters);
                for(int i=0;i<lista.size();i++){
                    Nota_Credito nota = (Nota_Credito)lista.get(i);
                    String fecha = new java.text.SimpleDateFormat("dd/MM/yyyy").format(nota.getFecha());
                    String proceso = new java.text.SimpleDateFormat("dd/MM/yyyy hh:mm:ss aa").format(nota.getFecha_proceso());
                    Persona persona = model.consultarPersona(nota.getFk_persona());
                    Vehiculo vehiculo = model.consultarVehiculoById(nota.getFk_registro());
                    String estado = model.consultarParametroName(350, nota.getEstado());
                    Usuario usuarioNota = model.consultarUsuario(nota.getFk_usuario());
                    String nombres = persona.getNombre_1()+" "+persona.getApellido_1()+" "+(persona.getApellido_2()!=null?persona.getApellido_2():""); %>
                    <tr id="<%= nota.getId_nota_credito()%>"   onMouseOver="sombrear(this)" onMouseOut="renovar(this)" class="style4">
                        <td><%= nota.getNumero() %></td>
                        <td><%= fecha %></td>
                        <td><%= vehiculo.getPlaca() %></td>
                        <td><%= nombres %></td>
                        <td><%= nota.getValor() %></td>
                        <td><%= nota.getReferencia() %></td>
                        <td><%= estado %></td>
                        <td><%= proceso %></td>
                        <td><%= usuarioNota.getNombre() %></td>
                    </tr>
            <%  }
            }  %>
       </table>
    </body>
    <%  }else{ %>
       <jsp:forward page="no_access.jsp">
             <jsp:param name="tipo" value="1"></jsp:param>
       </jsp:forward>
<%  }
} %>
</html>
