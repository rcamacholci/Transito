<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Documento sin t&iacute;tulo</title>
</head>

<body>
<table border="0" cellpadding="0" cellspacing="0" width="40%" align="center">
	<tr>
		<td>
			<fieldset style="border-color:#0066CC">
				<legend style="color: #2544AE;font-weight: bold;font-style: italic;font-size: 14px;">Civitrans</legend>
				<table width="100%%" border="0" align="center" cellpadding="0" cellspacing="0">
					<% if(request.getParameter("tipo").equals("1")){ %>
						 <tr>
							 <th scope="row" width="10%"><img src="../../paginas/html/images/info.png" width="47" height="48" /></th>
							 <td width="90%" valign="middle">
								<span style="color:#2745B2;font-weight:bold;font-size:14px;font-family:'Palatino Linotype';font-style:italic">
									*Su perfil no tiene permisos suficientes para acceder a este recurso!. 
								</span>
							  </td>
						 </tr>
  				   <% } %>
                                   <% if(request.getParameter("tipo").equals("2")){
                                            String msg = request.getParameter("msgError");
                                            msg = msg!=null?(msg.equals("NULL")?"Error Interno":msg):""; 
                                            
                                   %>
						 <tr>
							 <th scope="row" width="10%"><img src="../../paginas/html/images/info.png" width="47" height="48" /></th>
							 <td width="90%" valign="middle">
								<span style="color:#2745B2;font-weight:bold;font-size:14px;font-family:'Palatino Linotype';font-style:italic">
									*<%=msg%>
								</span>
							  </td>
						 </tr>
  				   <% } %>
                                   <% if(request.getParameter("tipo").equals("3")){
                                            String msg = request.getParameter("msgError");
                                            msg = msg!=null?msg:""; %>
						 <tr>
							 <th scope="row" width="10%"><img src="../../paginas/html/images/info.png" width="47" height="48" /></th>
							 <td width="90%" valign="middle">
								<span style="color:#2745B2;font-weight:bold;font-size:14px;font-family:'Palatino Linotype';font-style:italic">
                                                                    Se ha vencido la session de click <a href="https://192.168.66.110:9090/transito">Aqui</a> para regresar a Civitrans
								</span>
							  </td>
						 </tr>
  				   <% } %>
				</table>
			</fieldset>
		</td>
	</tr>
</table>
</body>
</html>
