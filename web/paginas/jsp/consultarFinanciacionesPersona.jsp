<%-- 
    Document   : consultar_financiacion_persona
    Created on : 03-mar-2010, 15:41:27
    Author     : Jorge Lopez
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8" import="modelo.*,java.util.LinkedList "%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
try{
    if(session.getAttribute("model")!=null){
           if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
                modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
                Model modelo = (Model)session.getAttribute("model");

long fk_persona =0;

        if(!request.getParameter("id_persona").isEmpty()){
            fk_persona = Long.parseLong(request.getParameter("id_persona"));
        }else if(session.getAttribute("id_persona")!=null){
            fk_persona = Long.parseLong(session.getAttribute("id_persona")+"");
        }


LinkedList<Financiacion> Financiaciones = modelo.consultarFinanciacionesPersona(fk_persona) ;



%>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style type="text/css">
<!--
.style4 {font-family: Tahoma; font-weight: bold; font-size: 12px; }
.style5 {font-family: Tahoma; font-weight: bold; font-size: 12px; color: #333333; }
.style6 {color: #FFFFFF}
-->
        </style>
        <script type="text/javascript">
            function verFinanciacion(idF){
                window.location.href = "verFinanciacion.jsp?idFinanciacion="+idF;
            }
        </script>
</head>
    <body>
        <%
        if(Financiaciones.size()<=0){
            %>
             <script type="text/javascript">
           		alert("No se encontraron financiaciones para esta persona");
             </script>
           <%  }%>
<p align="center"><label class="style5">LISTADO DE FINANCIACIONES</label>
</p>
        <table border="1" cellpadding="1" cellspacing="0" align="center" width="100%">
            <thead>
			
                <tr bgcolor="#CCCCCC" class="style5" style="border:none;background:url(../html/images/inicio_3.png)">
                    <th  width="10%"style="border:none"><span class="style6">NUMERO</span></th>
                    <th  width="20%"style="border:none"><span class="style6">FECHA</span></th>
                    <th width="15%" style="border:none"><span class="style6">VALOR</span></th>
                    <th  width="10%"style="border:none"><span class="style6">Nº&nbsp;CUOTAS </span></th>
                    <th  width="15%"style="border:none"><span class="style6">CUOTA&nbsp;INICIAL </span></th>
                    <th  width="15%"style="border:none"><span class="style6">ESTADO</span></th>
                    <th  width="15%"style="border:none"><span class="style6">USUARIO</span></th>
              </tr>
            </thead>
            <tbody>
                <%
                for(Financiacion finan : Financiaciones){
                    java.util.List tiposimportaciones = modelo.listadoParametros(59);
                    String Estado = "";
                    
		    for (int i = 0; i < tiposimportaciones.size(); i++) {
                        Parametro parametro = (Parametro) tiposimportaciones.get(i);
                        if(finan.getEstado() == parametro.getCodigo()){
                            Estado=parametro.getNombre();
                            break;
                        }
                          
                        
                    }

                    usuario = modelo.consultarUsuario(finan.getFk_usuario());

%>
                <tr class="style5" id="<%=finan.getId_financiacion()%>" ondblclick="verFinanciacion('<%=finan.getId_financiacion()%>')" style="cursor:pointer">
                    <td align="center"><span class="style5"><%=finan.getNumero()%></span></td>
                    <td align="center"><span class="style4"><%=new java.text.SimpleDateFormat("dd/MM/yyyy").format(finan.getFecha()) %></span></td>
                    <td align="right"><span class="style4"><%=finan.getValor()%></span></td>
                    <td align="center"><span class="style4"><%=finan.getCuotas()%></span></td>
                    <td align="right"><span class="style4"><%=finan.getCuota_inicial()%></span></td>
                    <td align="center"><span class="style4"><%=Estado%></span></td>
                    <td align="center"><span class="style4"><%=usuario.getNombre() %></span></td>
                </tr>
                   <%     }%>
            </tbody>
    </table>
           s

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