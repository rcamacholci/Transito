<%@page import= "org.apache.commons.fileupload.FileItem"
        import= "org.apache.commons.fileupload.disk.DiskFileItemFactory"
        import= "org.apache.commons.fileupload.servlet.ServletFileUpload"
        import="modelo.*"
        import="java.util.*"
        import="java.io.*"%>



<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    Model model = (Model) session.getAttribute("model");

    long fkAudiencia = (request.getParameter("fk_audiencia") != null) ? Long.parseLong(request.getParameter("fk_audiencia")) : -1;

    System.out.println("AUD " + fkAudiencia);

    LinkedList<DocumentoComparendo> listD = model.listarDocumentosComparendos(fkAudiencia);
%>

<style >

    .tableI{
        font-size: 10px;
        color: #000;
        border-color: #000;
        border: solid 1px #000;
        border-style: solid ;
        font-weight: bold ;
    }

</style>


<div style="width:100%;">
    <table name="tHeader" id="table" border="1" width="100%"  class="tableI" >

        <tr>
            <td align="center" width="5%"> Numero </td>
            <td align="center" width="35%"> Tipo </td>
            <td align="center" width="50%"> Identificador </td>
            <td align="center" width="10%"> Archivo </td>
        </tr>
    </table> 

    <table name="tBody" border="1" width="100%" class="tableI">
        <% for (DocumentoComparendo documentoC : listD) {
                Parametro p = model.consultarParametro(documentoC.getTipo(), 360);
        %>

        <tr>
            <td align="center" width="5%"> <%= documentoC.getIdDocumentoComparendo()%> </td>
            <td align="center" width="35%"> <%= p.getNombre()%> </td>
            <td align="left"   width="50%"> <%= documentoC.getIdentificador()%> </td>
            <td width="10%"> <a target="_blank" href="<%= request.getContextPath() + "/paginas/data/comparendos/proceso/audiencias/" + documentoC.getRuta() %>"> Ver Archivo </a> </td>
        </tr>


        <%       }%>

    </table>

</div>