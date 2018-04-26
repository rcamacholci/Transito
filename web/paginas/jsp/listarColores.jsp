<%@ page  import="modelo.Color" import="modelo.Model" %>
<html>
<head>
    <title></title>
<style type="text/css">
<!--
.style1 {
	font-size: 12px;
	font-weight: bold;
	font-style: italic;
	color: #0066CC;
}
-->
</style>
<script language="javascript" type="text/javascript">
	function ver(n,id,c,t,cl){
		if(n==0){
			document.location = "listarColores.jsp?id=0&color="+cl;
		}else{
			if(n==2){
				if((id+c)<t){
					id = id + c;
					document.location = "listarColores.jsp?id="+id+"&color="+cl;
				}
			}else{
				if(n==1){
					if((id-c)>=0){
						id = id - c;
						document.location = "listarColores.jsp?id="+id+"&color="+cl;
					}
				}else{
					id = (t/c)*c-1;
					document.location = "listarColores.jsp?id="+id+"&color="+cl;
				}
			}
		}
	}
	function selC(opt,text){
            if(confirm("Desea adicionar el color ["+text+"]?")){
                window.parent.opener.document.form.r_color.value = opt.id;
                window.parent.opener.document.form.color.value = text;
                window.parent.close();
            }
	}
</script>
</head>
<body>
<%
    try {
        if(request.getParameter("color")!=null&&request.getParameter("id")!=null){
            if(!request.getParameter("color").equals("")){
                Model model = (Model) session.getAttribute("model");
                java.util.List lista = model.listadoColoresByNombre(request.getParameter("color").toUpperCase());
                if(lista.size()>0){
                      String ncolor = request.getParameter("color").toUpperCase();
                      int cr = 10;//Cantidad Registros
                      int id = Integer.parseInt(request.getParameter("id"));
                      int size = lista.size(); %>
                      <table border="0" cellpadding="1" cellspacing="0" width="100%">
                  <%  for(int i=id;i<(id+cr)&&i<lista.size();i++){
                         Color color = (Color)lista.get(i); %>
                         <tr bgcolor="<%=(i%2==0?"#F6F3F0":"#FFFFFF")%>">
                             <td colspan="2" style="cursor:pointer">
                                <div class="style1" id='<%=color.getId_color()%>' onclick="selC(this,'<%=color.getNombre()%>')"><%=color.getNombre()%></div>
                             </td>
                         </tr>
                   <%  } %>
                       <tr>
                    <%   if((id-cr)>=0){ %>
                            <td align="center">
                             <input type="button" id="anterior" value="Anterior" style="width:70px; font-size:11px" onClick="ver(1,<%=id%>,10,<%=size%>,'<%=ncolor%>')"/>
                             </td>
	             <% }else{ %>
				 <td align="center">
				 <input type="button" id="anterior" value="Anterior"  style="width:70px; font-size:11px" disabled="disabled"/>
				 </td>
			<% }
		      if((id+cr)<size){ %>
				 <td align="center">
				 <input type="button" id="siguiente" value="Siguiente" style="width:70px; font-size:11px" onClick="ver(2,<%=id%>,10,<%=size%>,'<%=ncolor%>')"/>
				 </td>
			<% }else{ %>
			    <td align="center">
				<input type="button" id="siguiente" value="Siguiente" style="width:70px; font-size:11px" disabled="disabled"/>
				</td>
			<% } %>
                       </tr>
                      </table>
           <%     }
            }
        }
    } catch (Exception exc) {
        exc.printStackTrace();
    }
%>
</body>
</html>