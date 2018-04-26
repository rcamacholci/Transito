<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro" import="modelo.Vehiculo" import="modelo.Concepto" import="modelo.Valor"  import="modelo.Liquidacion" errorPage="" %>
<%
try{
if(session.getAttribute("usuario")!=null){
    modelo.Model model = (modelo.Model)session.getAttribute("model");
    if(model!=null){
        modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
        if(model.tienePermiso(usuario.getId_usuario(), 57)){
%>
<html>
<head>
    <title>cargarConceptos</title>
<!--<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">
var nome;
do {
nome = prompt ("Qual é o seu nome?");
} while (nome == null || nome == "");
alert ("Seu nome é "+nome);
</SCRIPT>-->
<script language="javascript" type="text/javascript">
         function adicionar(id){
             window.parent.frames[4].location.href = "verLiquidacion.jsp?id="+id+"&tipo=3&placa="+document.form.placa.value;
                tabla = document.getElementById('tabla');
                var trs = tabla.getElementsByTagName('tr');
                for(var i = 0; i<trs.length ; i++){
                        if(trs[i].id == id){
                               tabla.deleteRow(i);
                        }
                }
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
.Estilo5 {color: #FFFFFF; font-size: 13px; }
.Estilo10 {color: #333333; font-weight: bold; font-size: 11px; }
-->
</style>
</head>
    <body>
        <form name="form" method="post" action="" >
<% try{
        if (!request.getParameter("parametro").equals("")) {%>
        <%
            String like = request.getParameter("like")!=null?request.getParameter("like").toString():"";
            java.util.List lista = model.crearListaConceptos(Long.parseLong(request.getParameter("parametro")),like);
            if (lista.size()>0) {%>
                <table width="100%" border="1" id="tabla" cellpadding="1" cellspacing="0">
                      <tr style="border:none; background:url(../html/images/inicio_3.png)">
                            <th width="4%" scope="col" style="border:none"><span class="Estilo5">
                              <label>X</label>
                        </span></th>
                            <th width="13%" scope="col" style="border:none"><span class="Estilo5">
                              <label>CODIGO</label>
                        </span></th>
                            <th width="70%" scope="col"  style="border:none"> <span class="Estilo5">
                              <label id="nombreConcepto">NOMBRE CONCEPTO </label>
                        </span> </th>
                            <th width="13%" scope="col" style="border:none"><span class="Estilo5">
                              <label>VALOR</label>
                        </span></th>
                  </tr>

              <%    java.util.List listaLiquidacion = (java.util.List)session.getAttribute("listaLiquidacion");
  			  		for(int i=0;i<lista.size();i++){
                        Concepto concepto = (Concepto)lista.get(i);
						boolean posible = true;
                        if(listaLiquidacion!=null){
                            for(int j=0;j<listaLiquidacion.size();j++){
                                Liquidacion liquidacion = (Liquidacion)listaLiquidacion.get(j);
                                if(liquidacion.getTipo()==3&&liquidacion.getFk_concepto()==concepto.getId_concepto()){
                                    posible = false;
                                    break;
                                }
                           }
                        }
                        if(posible){
                            Valor valor = model.consultarValor(concepto.getId_concepto(),Long.parseLong(request.getParameter("parametro")), 0);%>
                            <tr id="<%=valor.getId_valor()%>" onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
                                    <td align="center" style="cursor:pointer;">
                                            <img src="../html/images/adicionar.png" width="19" height="19" onClick="adicionar(<%=valor.getId_valor()%>)"/></td>
                                    <td align="center"><span class="Estilo10"><font face="Arial, Helvetica, sans-serif"><%=concepto.getId_concepto()%></font></span></td>
                                    <td align="left"><span class="Estilo10"><font face="Arial, Helvetica, sans-serif"><%=concepto.getNombre()%></font></span></td>
                                    <td align="right"><span class="Estilo10"><font face="Arial, Helvetica, sans-serif"><%="$ "+valor.getValor()%></font></span></td>
                              </tr>
               <%
			   		}
			      } %>
                              <input type="hidden" id="placa" value="<%=request.getParameter("placa")%>"/>
    </table>
          <%  }
        }
   }catch(Exception exc){
      exc.printStackTrace();
      out.println(exc.getMessage());
   }
   %>
        </form>
    </body>
</html>
    <%
        }else{  %>
           <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="1"></jsp:param></jsp:forward>
<%        }
     }else{ %>
        <script>window.parent.document.location.href = "../../index.jsp";</script>
<%  }
 }else{ %>
     <script>window.parent.document.location.href = "../../index.jsp";</script>
<% }
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<% } %>