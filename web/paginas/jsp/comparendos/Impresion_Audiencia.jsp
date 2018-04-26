<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="modelo.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <link href="../../html/css/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />
        <link href="../../html/css/lineaVertical.css" rel="stylesheet" type="text/css" media="screen" />
        <link href="../../html/css/3pestanas.css" rel="stylesheet" type="text/css" media="screen" />
        <script type="text/javascript" src="../../html/scripts/tablecloth.js"></script>
        <link href="../../html/css/page2Colum.css" rel="stylesheet" type="text/css" media="screen" />
<title>Documento sin t&iacute;tulo</title>
</head>

		<script language="javascript" type="text/javascript">
                   function verR2(inf){
                            //alert(inf+"-");
                            window.location.href ="../Descarga.jsp?archivo="+inf+"&op=0";
                           //window.location.href ="comparendos/AdicionarAudiencia.jsp?ind="+inf+"&imp="+imp;//"ImprimirSancion.jsp?&imp="+inf+"&ind="+imp;

			}
                        </script>
<body>
<table width="200" border="0">
                                        <tr class="label">
                                            <th>#</th>
                                            <th>Fecha</th>
                                            <th>Hora</th>
                                            <th>Inspector</th>
                                            <th>Comparendo</th>
                                            <th>Agente</th>
                                            <th>Estado</th>
                                            <th>Descargar</th>
                                        </tr>
                                        <%
                                        try{
                                            Model model =(Model)session.getAttribute("model");
                                            //java.sql.Date inicio = new java.sql.Date(new java.util.Date().getTime());
                                           // java.sql.Date fin = new java.sql.Date(new java.util.Date("12/12/2012").getTime());
                                            //java.util.List<modelo.Horario_Curso> horarios = model.consultarHorariosCursos(inicio,fin);
                                            //java.util.HashMap estados = model.crearHashParametros(351);
                                            long op =2;
                                                    long fk_comparendo=0;
                                                    Comparendo comp=null;
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
                                            java.util.List<modelo.Audiencias> aud = model.listadoAudiencia(op, fk_comparendo);
                                            int i = 0;
                                            for(modelo.Audiencias Aud:aud){
                                            comp = model.consultarComparendoById(Aud.getFk_comparendo());
                                            modelo.Agente Age = model.consultar_Agente_PorId(Aud.getFk_agente());
                                            String nombre ="";
                                            if(Age!=null){
                                                nombre = Age.getNombre();
                                            }else{
                                                nombre ="No Agente";
                                            }
                                            i++;
                                            %>
                                            <tr id="<%=comp.getNumero()%>" class="text" ondblclick="VerR2(this)" onMouseOver="sombrear(this)" onMouseOut="renovar(this)" style="cursor:pointer">
                                                    <th scope="row"><%=i%></th>
                                                    <td><%=new java.text.SimpleDateFormat("dd/MM/yyyy").format(Aud.getFecha()) %></td>
                                                    <td><%=Aud.getHora()%></td>
                                                    <td><%=Aud.getFk_inspector()%></td>
                                                    <td><%=comp.getNumero()%></td>
                                                    <td><%=nombre%></td>
                                                    <td><%=Aud.getEstado()%></td>
                                                    <td>&nbsp;<img  src="../../html/images/detalle.png" height="25" width="25" onClick="verR2('<%=comp.getNumero()%>','<%=i%>')" style="cursor:pointer"/></td>
                                                </tr>
                                       <%   }
                                        %>
</table>
</body>
</html>
<%}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>