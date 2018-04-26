<%-- 
    Document   : verArchivosPlanos
    Created on : 25/03/2011, 11:26:40 AM
    Author     : Administrador
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
  try{
     if(session.getAttribute("model") != null) {
        if (true ||((java.util.LinkedList) session.getAttribute("permisosU")).contains("generarArchivosPlanos.jsp")) {
            if(request.getParameter("plano")!=null&&request.getParameter("estado")!=null){
            modelo.Model model = (modelo.Model) session.getAttribute("model");
            int plano = Integer.parseInt(request.getParameter("plano"));
            int estado = Integer.parseInt(request.getParameter("estado"));
            java.util.List lista = model.listarSimitRegistros(plano,estado);
            %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lista Planos</title>
        <style type="text/css">
            .label{font-size:11px;font-weight:bold;font-family:Arial;color:#FFFFFF;text-align:center}
            .text{font-size:10px;font-weight:bold;font-family:Arial;color:#003366;text-align:center}
            .button{font-size:12px;font-weight:bold;font-family:Arial;color:#003366;}
        </style>
    </head>
    <body>
        <div>
            <div>
                <form action="procesarArchivosPlanos.jsp" method="post" name="form">
                    <input type="hidden" name="plano" value="<%=plano%>">
                    <input type="hidden" name="estado" value="<%=estado%>">
                <% if(plano==1){ %>
                    <table align="center" width="720px" border="1" cellpadding="1" cellspacing="0">
                        <thead >
                            <tr bgcolor="#003366">
                                <th width="37px" class="label">
                                    <label>N°</label>
                                </th>
                                <th width="90px" class="label">
                                    <label>COMPARENDO</label>
                                </th>
                                <th width="90px" class="label">
                                    <label>FECHA</label>
                                </th>
                                <th width="100px" class="label">
                                    <label>DOCUMENTO</label>
                                </th>
                                <th width="275px" class="label">
                                    <label>NOMBRES</label>
                                </th>
                                <th width="37px" class="label">
                                    <label>INFRA.</label>
                                </th>
                                <th width="90px" class="label">
                                    <label>VALOR</label>
                                </th>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                                <td colspan="7" align="center">
                                    <% if(lista.size()>0){ %>
                                            <input type="submit" class="button" name="generar" value="Generar Plano"/>
                                    <% }  %>
                                </td>
                            </tr>
                        </tfoot>
                        <tbody>
                         <% for(int i=0;i<lista.size();i++){
                                modelo.SimitComparendo simitComparendo = (modelo.SimitComparendo)lista.get(i); %>
                                <tr>
                                    <td width="37px" class="text">
                                        <label><%=i+1%></label>
                                    </td>
                                    <td width="90px" class="text">
                                        <label><%=simitComparendo.getCOMNUMERO()%></label>
                                    </td>
                                    <td width="90px" class="text">
                                        <label><%=simitComparendo.getCOMFECHA()%></label>
                                    </td>
                                    <td width="100px" class="text">
                                        <label><%=simitComparendo.getCOMINFRACTOR()%></label>
                                    </td>
                                    <td width="275px" class="text">
                                        <label><%=simitComparendo.getCOMNOMBE()+" "+simitComparendo.getCOMAPELLIDO()%></label>
                                    </td>
                                    <td width="37px" class="text">
                                        <label><%=simitComparendo.getCOMINFRACCION()%></label>
                                    </td>
                                    <td width="90px" class="text" align="right">
                                        <label><%=java.text.NumberFormat.getInstance().format(Double.parseDouble(simitComparendo.getCOMVALOR().replace(',', '.')))%></label>
                                    </td>
                                </tr>
                         <% } %>
                        </tbody>
                    </table>
                <% }
                   if(plano==2){ %>
                    <table align="center" width="720px" border="1" cellpadding="1" cellspacing="0">
                        <thead>
                            <tr bgcolor="#003366">
                                <th width="40px" class="label">
                                    <label>N°</label>
                                </th>
                                <th width="113px" class="label">
                                    <label>REFERENCIA</label>
                                </th>
                                <th width="112px" class="label">
                                    <label>FECHA PAGO</label>
                                </th>
                                <th width="113px" class="label">
                                    <label>DOCUMENTO</label>
                                </th>
                                <th width="112px" class="label">
                                    <label>TIPO RECAUDO</label>
                                </th>
                                <th width="112px" class="label">
                                    <label>FACTURA</label>
                                </th>
                                <th width="113px" class="label">
                                    <label>VALOR</label>
                                </th>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                                <td colspan="7" align="center">
                                    <% if(lista.size()>0){ %>
                                            <input type="submit" class="button" name="generar" value="Generar Plano"/>
                                    <% }  %>
                                </td>
                            </tr>
                        </tfoot>
                        <tbody>
                         <% for(int i=0;i<lista.size();i++){
                                modelo.SimitRecaudo simitRecaudo = (modelo.SimitRecaudo)lista.get(i); %>
                                <tr>
                                    <td width="40px" class="text">
                                        <label><%=i+1%></label>
                                    </td>
                                    <td width="113px" class="text">
                                        <label><%=simitRecaudo.getRECDOCUMENTO()%></label>
                                    </td>
                                    <td width="112px" class="text">
                                        <label><%=simitRecaudo.getRECFAPL()%></label>
                                    </td>
                                    <td width="113px" class="text">
                                        <label><%=simitRecaudo.getRECNIP()%></label>
                                    </td>
                                    <td width="112px" class="text">
                                        <label><%=model.consultarParametroName(8, Integer.parseInt(simitRecaudo.getRECTIPOREC()))%></label>
                                    </td>
                                    <td width="112px" class="text">
                                        <label><%=simitRecaudo.getRECNUM()%></label>
                                    </td>
                                    <td width="113px" class="text">
                                        <label><%=java.text.NumberFormat.getInstance().format(Double.parseDouble(simitRecaudo.getRECTOTAL().replace(',', '.')))%></label>
                                    </td>
                                </tr>
                         <% } %>
                        </tbody>
                    </table>
                <% }
                   if(plano==3){ %>
                    <table align="center" width="720px" border="1" cellpadding="1" cellspacing="0">
                        <thead>
                            <tr bgcolor="#003366">
                                <th width="37px" class="label">
                                    <label>N°</label>
                                </th>
                                <th width="87px" class="label">
                                    <label>RESOLUCION</label>
                                </th>
                                <th width="75px" class="label">
                                    <label>FECHA</label>
                                </th>
                                 <th width="75px" class="label">
                                    <label>COMPARENDO</label>
                                </th>
                                <th width="75px" class="label">
                                    <label>DOCUMENTO</label>
                                </th>
                                <th width="259px" class="label">
                                    <label>NOMBRES</label>
                                </th>
                                <th width="37px" class="label">
                                    <label>TIPO</label>
                                </th>
                                <th width="75px" class="label">
                                    <label>VALOR</label>
                                </th>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                                <td colspan="8" align="center">
                                    <% if(lista.size()>0){ %>
                                            <input type="submit" class="button" name="generar" value="Generar Plano"/>
                                    <% }  %>
                                </td>
                            </tr>
                        </tfoot>
                        <tbody>
                         <% for(int i=0;i<lista.size();i++){
                                modelo.SimitResolucion simitResolucion = (modelo.SimitResolucion)lista.get(i); %>
                                <tr>
                                    <td width="37px" class="text">
                                        <label><%=i+1%></label>
                                    </td>
                                    <td width="87px" class="text">
                                        <label><%=simitResolucion.getRESNUMERO()%></label>
                                    </td>
                                    <td width="75px" class="text">
                                        <label><%=simitResolucion.getRESFECHA()%></label>
                                    </td>
                                    <td width="75px" class="text">
                                        <label><%=simitResolucion.getRESCOMP()%></label>
                                    </td>
                                    <td width="75px" class="text">
                                        <label><%=simitResolucion.getRESNIPINFRAC()%></label>
                                    </td>
                                    <td width="259px" class="text">
                                        <label><%=simitResolucion.getRESNOMBE()+" "+simitResolucion.getRESAPELLIDO()%></label>
                                    </td>
                                    <td width="37px" class="text">
                                        <label><%=simitResolucion.getRESTIPORES()%></label>
                                    </td>
                                    <td width="87px" class="text">
                                        <label><%=java.text.NumberFormat.getInstance().format(Double.parseDouble(simitResolucion.getRESVALPAG().replace(',', '.')))%></label>
                                    </td>
                                </tr>
                         <% } %>
                        </tbody>
                    </table>
                <% } %>
                </form>
            </div>
        </div>
    </body>
</html>
        <%      }
                } else {%>
                    <jsp:forward page="../no_access.jsp">
                        <jsp:param name="tipo" value="1"></jsp:param>
                    </jsp:forward>
            <% }
           } else {%>
              <script>
                   window.parent.document.location.href = "../../../index.jsp";
              </script>
  <%        }
      } catch (Exception mexe) {
        mexe.printStackTrace(); %>
        <jsp:forward page="../no_access.jsp">
            <jsp:param name="tipo" value="2"></jsp:param>
            <jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param>
        </jsp:forward>
<%  }%>