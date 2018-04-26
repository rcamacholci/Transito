<%-- 
    Document   : Auditoria_Comparendo
    Created on : 21/02/2013, 08:09:47 AM
    Author     : acer
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="webservices.liquidacion.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%
try{
	if(session.getAttribute("model")!=null){
		//if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
                if(1==1){
                  Model model= (Model)session.getAttribute("model");
                  Usuario usuario = (Usuario)session.getAttribute("usuario");
                    %>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Liquidacion de Carteras</title>
        <style type="text/css">
            <!--
            .Estilo4 {
                font-weight: bold;
                font-family: "Times New Roman", Times, serif;
                color: #FFFF99;
                font-size:12px;
            }

            -->

        </style>
	    <!-- filter: alpha(opacity=85);-moz-opacity:0.85; -->
        <META http-equiv=Content-Type content="text/html; charset=windows-1252">
        <LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <link href="../html/css/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />
        <link href="../html/css/lineaVertical.css" rel="stylesheet" type="text/css" media="screen" />
        <link href="../html/css/3pestanas.css" rel="stylesheet" type="text/css" media="screen" />
        <script type="text/javascript" src="../html/scripts/tablecloth.js"></script>
        <link href="../html/css/page2Colum.css" rel="stylesheet" type="text/css" media="screen" />
        <script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <script type="text/javascript" language="javascript">
            function sombrear(tr){
                tr.style.backgroundColor="#CCCCCC";
            }
            function renovar(tr){
                tr.style.backgroundColor="#FFFFFF";
            }
        </script>
        <style type="text/css">
<!--
.Estilo7 {color: #006699}
.Estilo10 {
	color: #333333;
	font-weight: bold;
	font-size: 14px;
}
.Estilo15 {
	color: #003399;
	font-size: 16px;
}
.Estilo16 {color: #333333}
.Estilo19 {
	font-size: 12px;
	font-weight: bold;
	color: #333333;
}
.Estilo20 {
	font-size: 13px;
	font-weight: bold;
	color: #0066CC;
}
-->
        </style>
</head>
 <body>
 <form name="form" method="post" action="">
 <table width="200" border="1">
     <tr >
    <th >NUMERO</th>
    <th >ESTADO</th>
    <th >FECHA DE PROCESO</th>
    <th >USUARIO</th>
    <th >FECHA INICIO</th>
    <th >FECHA FIN</th>
  </tr>
  <%
  long usu = 0;
  //System.out.println("----");
  long fk_com=0;
  //System.out.println("----");
  Usuario us= null;
 // System.out.println("----");

  java.util.List<auditoria_comparendo> temp =null;
  Comparendo comp =null;
  usu = Long.parseLong(request.getParameter("Usuario"));
  System.out.println("----"+request.getParameter("Numero"));
   java.sql.Date inicio = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fi")).getTime());
   java.sql.Date fin = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("ff")).getTime());
     String fi = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date(inicio.getTime()));
     String ff =new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date(fin.getTime()));
  if(request.getParameter("Numero").equals("0")){
   System.out.println("-"+usu+"-"+fk_com+"-"+fi+"-"+ff);   
    temp=model.listarAC(usu,fk_com,fi, ff);
    System.out.println(temp.size());
  }else{
   System.out.println("----"+usu+"---"+request.getParameter("Numero"));
   comp=model.consultar_Comparendo(request.getParameter("Numero"));
   temp=model.listarAC(usu,comp.getId_comparendo(),fi, ff);
   fk_com=comp.getId_comparendo();
  }
   System.out.println(temp.size());
   for(int i = 0;i<temp.size();i++){
      auditoria_comparendo uac = temp.get(i);
      System.out.println(uac.getEstado());
      comp=model.consultarComparendoById(uac.getFk_comaprendo());
      int codigo = Integer.parseInt(""+uac.getEstado()+"");
      Parametro pa = model.consultarParametro(codigo,357);
      us = model.consultarUsuario(uac.getUsuario());

      System.out.println(comp.getNumero()+"+"+pa.getNombre()+"+"+uac.getFecha_proceso());


%>
<tr onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
    <td scope="rowgroup" ><%=comp.getNumero()%></td>
    <td scope="rowgroup">&nbsp;<%=pa.getNombre()%></td>
    <td scope="rowgroup">&nbsp;<%=uac.getFecha_proceso()%></td>
    <td scope="rowgroup">&nbsp;<%=us.getNombre()%></td>
    <td scope="rowgroup">&nbsp;<%=uac.getFecha_inicio()%></td>
    <td scope="rowgroup">&nbsp;<%=uac.getFecha_fin()==null?"         ":uac.getFecha_fin()%></td>
  </tr>
  <%}

        java.util.HashMap parameters = new java.util.HashMap();
        parameters.put("USUARIO",usuario.getNombre());
        parameters.put("FK_USUARIO",usu);
        parameters.put("FI", new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date(inicio.getTime())));
        parameters.put("FF", new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date(fin.getTime())));
        parameters.put("NUMERO",fk_com);
        session.setAttribute("Auditoria", parameters);

%>
</table>

	   </form>
    </body>
</html>
<%  }else{ %>
			   <jsp:forward page="no_access.jsp">
				 <jsp:param name="tipo" value="1"></jsp:param>
			   </jsp:forward>
	<%  }
	}else{ %>
		<script>
			window.parent.document.location.href = "../../index.jsp";
		</script>  <%
	}
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>
