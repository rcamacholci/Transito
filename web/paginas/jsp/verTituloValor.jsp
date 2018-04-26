<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.DatosVehiculo" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Prestamos</title>
<style type="text/css">
<!--
.Estilo13 {color: #FFFFFF; font-weight: bold; }
.Estilo20 {font-size: 12px; font-weight: bold;  }
.style9 {color: #FFFFFF; font-weight: bold; font-family: Tahoma; font-size: 12px; }
.style17 {color: #333333; font-size: 11px; font-family: Tahoma; font-weight: bold; }
-->
</style>
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
</head>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>

<%
Model modelo= (Model)session.getAttribute("model"); 
 Titulo_Valor tituloV = new Titulo_Valor();

%>
<body>
<table width="100%" border="1" cellpadding="1" cellspacing="0">
   <tr style="border:none; background:url(../html/images/inicio_3.png)">
    <td width="10%"  style="border:none"><div align="center" class="style9">FECHA</div></td>
    <td width="7%" style="border:none"><div align="center" class="style9">N° TITULO</div></td>
    <td width="16%" style="border:none"><div align="center" class="style9">CONSIGNANTE</div></td>
    <td width="6%" style="border:none"><div align="center" class="style9">TITULO JUDICIAL</div></td>
    <td width="10%" style="border:none"><div align="center" class="style9">VALOR</div></td>
    <td width="10%" style="border:none"><div align="center" class="style9">ESTADO</div></td>
    <td width="9%" style="border:none"><div align="center" class="style9">USUARIO</div></td>
  </tr>
  <%
   
  if(request.getParameter("num")!=null){
      
      if(request.getParameter("num").equals("1")){
              if(request.getParameter("numero")!=null&&!request.getParameter("numero").isEmpty()){
                  String num = request.getParameter("numero");
                  tituloV = modelo.consultarTituloValor(num);
                  if(tituloV!=null){
                      Usuario usuario = modelo.consultarUsuario(tituloV.getFk_usuario());%>

                <tr bgcolor="#FFFFFF" id="<%= tituloV.getId_titulo()%>"   onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= tituloV.getFechaTitulo()!=null?tituloV.getFechaTitulo():"" %></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style17" ><%= tituloV.getNroTitulo() %></span></td>
		<td align="center" style=" border-color:#CCCCCC"><span class="style17" ><%= tituloV.getNombreConsignante() %></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= tituloV.getTituloJudicial() %></span></td>
		<td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= tituloV.getValorDeposito() %></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= modelo.consultarParametroName(343, (int)tituloV.getEstado()) %></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%=usuario.getNombre()%></span></td>
                </tr>

<%
                                
                    }
             }
               
      }else{
            if(request.getParameter("num").equals("2")){
                String placa = "";
                if(request.getParameter("placa")!=null){
                    placa = request.getParameter("placa");
                    java.util.List listaT = modelo.consultarTituloValorByPlaca(placa.toUpperCase());
                    for(int i=0;i<listaT.size();i++){
                        tituloV = (Titulo_Valor)listaT.get(i);
                        Usuario usuario = modelo.consultarUsuario(tituloV.getFk_usuario());%>
                        <tr bgcolor="#FFFFFF" id="<%= tituloV.getId_titulo()%>"   onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
                        <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= tituloV.getFechaTitulo()!=null?tituloV.getFechaTitulo():"" %></span></td>
                        <td align="center" style=" border-color:#CCCCCC"><span class="style17" ><%= tituloV.getNroTitulo() %></span></td>
                        <td align="center" style=" border-color:#CCCCCC"><span class="style17" ><%= tituloV.getNombreConsignante() %></span></td>
                        <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= tituloV.getTituloJudicial() %></span></td>
                        <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= tituloV.getValorDeposito() %></span></td>
                        <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= modelo.consultarParametroName(343, (int)tituloV.getEstado()) %></span></td>
                        <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%=usuario.getNombre()%></span></td>
                        </tr>
                 <% }
                }
            }else{
                if(request.getParameter("num").equals("3")){
                    if(request.getParameter("fechaI")!=null&&request.getParameter("fechaF")!=null){
                        java.sql.Date fechaI = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fechaI")).getTime());
                        java.sql.Date fechaF = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fechaF")).getTime());

                        java.util.List listaT = modelo.consultarTituloValorByFecha(fechaI,fechaF);
                        for(int i=0;i<listaT.size();i++){
                            tituloV = (Titulo_Valor)listaT.get(i);
                            Usuario usuario = modelo.consultarUsuario(tituloV.getFk_usuario());%>
                            <tr bgcolor="#FFFFFF" id="<%= tituloV.getId_titulo()%>"   onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
                            <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= tituloV.getFechaTitulo()!=null?tituloV.getFechaTitulo():"" %></span></td>
                            <td align="center" style=" border-color:#CCCCCC"><span class="style17" ><%= tituloV.getNroTitulo() %></span></td>
                            <td align="center" style=" border-color:#CCCCCC"><span class="style17" ><%= tituloV.getNombreConsignante() %></span></td>
                            <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= tituloV.getTituloJudicial() %></span></td>
                            <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= tituloV.getValorDeposito() %></span></td>
                            <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= modelo.consultarParametroName(343, (int)tituloV.getEstado()) %></span></td>
                            <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%=usuario.getNombre()%></span></td>
                            </tr>
                     <% }
                    }
                }
            }
        }
      }
   %>
</table>

</body>
</html>
