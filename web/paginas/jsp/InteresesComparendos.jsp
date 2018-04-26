<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  errorPage="" %>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
%>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Intereses Comparendos</title>
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
        <script type="text/javascript" src="../html/scripts/motorAjax.js"></script>
        <script language="javascript" type="text/javascript">
            function AgregarIntereses(){

                if(document.form.comparendo.value.length>=1){
                    if(document.form.intereses.value.length>=1){
                        if(document.form.vradicional.value.length>=1){
                             document.form.action = "AgregarIntereses.jsp";
                             document.form.submit();
                        }else{
                            alert("Digite el valor adicional");
                        }
                    }else{
                        alert("Digite el valor de los intereses");
                    }
                }else{
                    alert("Digite el Numero del comparendo");
                }

            }

        </script>
        <STYLE>
<!--
A.ssmItems:link		{color:black;text-decoration:none}
A.ssmItems:hover	{color:black;text-decoration:none}
A.ssmItems:active	{color:black;text-decoration:none}
A.ssmItems:visited	{color:black;text-decoration:none}
.style3 {font-size: 12px; font-family: Tahoma; }
.style6 {color: #333333; font-size: 12px; font-weight: bold;  }
.Estilo32 {
	color: #FFFFFF;
	font-weight: bold;
	font-size: 12px;
}
-->
        </STYLE>
</head>
    <body>
      <form action="" method="post" name="form" class="style3" id="form">
        <table width="100%" border="0" align="center">


            <tr valign="middle">
                <th height="50" colspan="2" scope="col">

                        <fieldset style="position:absolute; left:25%; width:50%;">
                  <table width="70%" border="0" align="center">

                  <tr style="border:none; background:url(../html/images/inicio_3.png)">
                              <td colspan="11" align="center"><span class="style2 style14 Estilo32">INTERESES COMPARENDOS</span></td>
                  </tr>

                  <tr align="center">
                              <th width="7%" scope="col"><label style="color:#CC0000"><span class="style6">Comparendo</span></label>
                                  <input type="text" name="comparendo" onKeyPress="return soloNumeros(event)" id="comparendo" value=""/>
                              <th width="7%" scope="col"><label style="color:#CC0000"><span class="style6">Intereses</span></label>
                              <input type="text" name="intereses" id="intereses" onKeyPress="return soloNumeros(event)" value=""/>
                              <th width="7%" scope="col"><label style="color:#CC0000"><span class="style6">Valor adicional</span></label>
                              <input type="text" name="vradicional" id="vradicional" onKeyPress="return soloNumeros(event)" value=""/>

                              <th width="17%" scope="col"><input type="button" value="Agregar" onClick="AgregarIntereses()" /></th>
                              <th width="2%" scope="col">&nbsp;</th>
                  </tr>

                  </table>
			</fieldset>
                             </th>
            </tr>

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
}catch(Exception mexe){
mexe.printStackTrace();
%>

    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>