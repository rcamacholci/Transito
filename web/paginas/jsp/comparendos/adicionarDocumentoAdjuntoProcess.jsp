


<%@page import= "org.apache.commons.fileupload.FileItem"
        import= "org.apache.commons.fileupload.disk.DiskFileItemFactory"
        import= "org.apache.commons.fileupload.servlet.ServletFileUpload"
        import="modelo.*"
        import="java.util.*"
        import="java.io.*"%>



<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    Model model = (Model) session.getAttribute("model");

    String archivo = "";
    String fileName = "";
    String urlFile = "";
    String identificador = "";

    int tipo = -1;

    long idComparendo = -1;

    Comparendo comparendo = null;

    long fkAudiencia = -1;

    try {

        if (ServletFileUpload.isMultipartContent(request)) {
            ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
            List fileItemsList = servletFileUpload.parseRequest(request);
            org.apache.commons.fileupload.FileItem fileItem = null;
            Iterator it = fileItemsList.iterator();
            while (it.hasNext()) {
                FileItem fileItemTemp = (FileItem) it.next();
                if (fileItemTemp.isFormField()) {

                    //System.out.println(fileItemTemp.getFieldName() + " ::: " + fileItemTemp.getString()) ;
                    if (fileItemTemp.getFieldName().equals("id_comparendo")) {
                        try {
                            idComparendo = Long.parseLong(fileItemTemp.getString());
                            comparendo = model.consultarComparendoById(idComparendo);
                        } catch (Exception e) {
                            System.out.println("eeee " + e);
                            comparendo = null;
                        }
                    } else if (fileItemTemp.getFieldName().equals("identificador")) {
                        identificador = fileItemTemp.getString();
                    } else if (fileItemTemp.getFieldName().equals("tipo")) {
                        tipo = Integer.parseInt(fileItemTemp.getString());
                    }

                } else {
                    fileItemTemp.getFieldName();
                    fileItem = fileItemTemp;
                }


                System.out.println("comparendo  " + idComparendo);

                if (comparendo != null) {


                    Audiencia audiencia = model.consultarAudienciaXComparendo(idComparendo, 1) ;

                    if (audiencia != null) {

                        fkAudiencia = audiencia.getIdAudiencia();

                        fileItem:
                        if (fileItem != null) {
                            if (fileItem.getSize() > 0) {

                                urlFile = "C:/Civitrans/transito/build/web/paginas/data/comparendos/proceso/audiencias/" + idComparendo;
                                fileName = "C:/Civitrans/transito/build/web/paginas/data/comparendos/proceso/audiencias/" + idComparendo + "/" + fileItem.getName();
                                
                                
                                
                                
                                //fileName = request.getContextPath() + "/build/web/paginas/data/comparendos/proceso/audiencias/" + idComparendo + "/" + fileItem.getName();

                                File mkdir = new File(urlFile);
                                if (!mkdir.exists()) {
                                    mkdir.mkdirs();
                                }

                                File saveTo = new File(fileName);

                                if (!saveTo.exists()) {
                                    fileItem.write(saveTo);
                                }

                                DocumentoComparendo documentoC = new DocumentoComparendo();
                                documentoC.setFkAudiencia(audiencia.getIdAudiencia());
                                documentoC.setIdentificador(identificador);
                                documentoC.setTipo(tipo);
                                documentoC.setFkUsuario(usuario.getId_usuario());
                                documentoC.setFkSede(usuario.getFk_sede());
                                documentoC.setRuta(idComparendo + "/" +fileItem.getName());

                                model.getCon().setAutoCommit(false);
                                model.adicionarDocumentoComparendo(documentoC);
                                model.getCon().commit();

                            }
                        }
                    }
                }
            }
        }
    } catch (Exception exc) {
        model.getCon().rollback();
        exc.printStackTrace();
    }

    LinkedList<DocumentoComparendo> listD = new LinkedList<DocumentoComparendo>();

%>


<jsp:forward page="listadoDocumentosComparendos.jsp?">
    <jsp:param name="fk_audiencia" value="<%= fkAudiencia%>"/>
    <jsp:param name="idC" value="<%= comparendo.getId_comparendo()%>"/>
</jsp:forward> 