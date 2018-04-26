<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="modelo.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <link href="../html/css/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />
        <link href="../html/css/lineaVertical.css" rel="stylesheet" type="text/css" media="screen" />
        <link href="../html/css/3pestanas.css" rel="stylesheet" type="text/css" media="screen" />
        <script type="text/javascript" src="../html/scripts/tablecloth.js"></script>
        <link href="../html/css/page2Colum.css" rel="stylesheet" type="text/css" media="screen" />
<title>Documento sin t&iacute;tulo</title>
</head>

		<script language="javascript" type="text/javascript">
                   function verR2(inf,imp){
                            //alert(inf+"-"+imp);
                           window.location.href ="comparendos/AdicionarAudiencia.jsp?ind="+inf+"&imp="+imp;//"ImprimirSancion.jsp?&imp="+inf+"&ind="+imp;

			}
                        </script>
<body>
<table width="200" border="0">
  <tr>
    <th scope="col">&nbsp;ID</th>
    <th scope="col">&nbsp;RADICADO</th>
    <th scope="col">&nbsp;TIPO</th>
    <th scope="col">&nbsp;DOCUMENTO</th>
    <th scope="col">&nbsp;NOMBRES</th>
    <th scope="col">&nbsp;COMPARENDO</th>
    <th scope="col">&nbsp;||--||</th>
  </tr>
<%
try{
        long fk_comparendo=0;
Comparendo comp=null;
Model model = (Model)session.getAttribute("model");
if(request.getParameter("comparendo")!=null){
    String comparendo = request.getParameter("comparendo");
    comp = model.consultar_Comparendo(comparendo);
    if(comp!=null){
        fk_comparendo=comp.getId_comparendo();
     }else{
        fk_comparendo=0;
     }

}else{
    fk_comparendo = 0;
}
long op=1;
java.util.List<Solicitud_Audiencia> temp =model.listarSA(fk_comparendo,op);
for(int i = 0;i<temp.size();i++){
    Solicitud_Audiencia aud = temp.get(i);
    Persona per = model.consultarPersona(aud.getFk_persoan());
    comp=model.consultarComparendoById(aud.getFk_comaprendo());


%>
<tr>
    <th scope="row">&nbsp;<%=aud.getId_solicitud()%></th>
    <td>&nbsp;<%=aud.getConsecutivo()%></td>
    <td>&nbsp;<%=per.getCelular()%></td>
    <td>&nbsp;<%=per.getCelular()%></td>
    <td>&nbsp;<%=per.getNombre_1()%> <%=per.getApellido_1()%></td>
    <td>&nbsp;<%=comp.getNumero()%></td>
    <td>&nbsp;<img  src="../html/images/detalle.png" height="25" width="25" onClick="verR2('<%=comp.getId_comparendo()%>','<%=i%>')" style="cursor:pointer"/></td>
  </tr>

<%
}
%>
</table>
</body>
</html>
<%
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>