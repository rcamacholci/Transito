<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model" import="java.util.*" import="modelo.Parametro"  errorPage="" %>
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>

<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("AdministrarCajas.jsp")){
                    modelo.Model modelo = (modelo.Model)session.getAttribute("model");
%>


<script language="javascript" type="text/javascript">

        function edit(tr){
		document.location.href = "AsignarCaja.jsp?&fk_usu="+tr.id;
	}
        function sombrear(tr){
		tr.style.backgroundColor="#CCCCCC";
	}
	function renovar(tr){
		tr.style.backgroundColor="#FFFFFF";
	}




</script>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Ver prendas por beneficiario</title>
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


        <STYLE>


<!--
A.ssmItems:link		{color:black;text-decoration:none}
A.ssmItems:hover	{color:black;text-decoration:none}
A.ssmItems:active	{color:black;text-decoration:none}
A.ssmItems:visited	{color:black;text-decoration:none}
.style3 {font-size: 12px; font-family: Tahoma; }
.style6 {color: #333333; font-size: 12px; font-weight: bold; }
.Estilo32 {
	color: #FFFFFF;
	font-weight: bold;
	font-size: 12px;
}
-->
        </STYLE>
</head>
    <body>
        <table width="100%" border="1" align="center"  cellpadding="1" cellspacing="0">
 <tr style="border:none; background:url(../html/images/inicio_3.png)">
    <td width="10%"  style="border:none"><div align="center" class="style9">USUARIO</div></td>
    <td width="10%" style="border:none"><div align="center" class="style9">DOCUMENTO</div></td>
    <td width="35%" style="border:none"><div align="center" class="style9">NOMBRE </div></td>
	<td width="15%" style="border:none"><div align="center" class="style9">ESTADO</div></td>
    <td width="15%" style="border:none"><div align="center" class="style9">CAJA</div></td>
    <td width="15%" style="border:none"><div align="center" class="style9">RUNT</div></td>

  </tr>
  <%

   java.util.List lista   =  modelo.listarUsuarios(234);

   for(int i=0;i<lista.size();i++){
    Usuario usuario = (Usuario)lista.get(i);
    Persona persona = modelo.consultarPersona(usuario.getFk_persona());
    UsuarioCaja usu_caja = modelo.consultarCajaUsuario(usuario.getId_usuario());
    UsuarioRunt usu_runt = modelo.consultarUsuarioRunt(usuario.getId_usuario());
    String caja = "";
    String runt = "";
    if(usu_caja!=null){
       int si=0;      
        java.util.List lista2 = modelo.listarCaja();

        String fecha ="";
        Persona per =null;
        UsuarioCaja cinfo=null;
        java.util.List<UsuarioCaja> uc = modelo.ListarUsuarioCajas(usuario.getId_usuario());
        System.out.println("size "+uc.size());
        if(uc.size()<=1){
           cinfo = modelo.consultarCajaUsuario(usuario.getId_usuario());
        }
        int con=0;
        for(int x=0;x<lista2.size();x++){
            Caja info = (Caja)lista2.get(x);
            //javax.swing.JOptionPane.showMessageDialog(null,usu);

           for(int j=0;j<uc.size();j++){
            cinfo = uc.get(j);
                if(info.getId_caja()==cinfo.getFk_caja() && cinfo.getFechaFin()==null){
                      si++;
                }
           }
    }//next
        if(si>0){
            caja="SI";
        }else{
            caja="NO";
        }
    }else{
        caja = "NO";
    }

    if(usu_runt!=null){
        runt = "SI";
    }else{
        runt = "NO";
    }

  if(usuario.getFechaFin()==null){
%>
                <tr bgcolor="#FFFFFF" id="<%= usuario.getId_usuario() %>"   ondblclick="edit(this)" onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= usuario.getNombre() %></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style17" ><%= persona.getDocumento()%></span></td>
		<td align="center" style=" border-color:#CCCCCC"><span class="style17" ><%= persona.getNombre_1()+" "+persona.getApellido_1() %></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= usuario.getFechaFin()==null?"ACTIVO":"INACTIVO" %></span></td>
		<td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= caja %></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= runt %></span></td>

  </tr>

     <%
     }
   }
   %>

</table>

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
}catch(Exception mexe){
mexe.printStackTrace();
%>

    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>
