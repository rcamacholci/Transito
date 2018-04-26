<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@page import="modelo.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%
    Model model = new Model();
    model.getCon();
    try{
        System.out.println("/*MODEL*/");
    if(model!=null){
        System.out.println("/*SI*/");
        String comp = request.getParameter("id");
        System.out.println("/*--->"+comp+"*/");
        /*Comparendo temp = model.consultar_Comparendo(comp);
        if(temp!=null){
        System.out.println("/*"+temp.getNumero()+"");
        String name = temp.getNumero()+".txt";
        System.out.println("/*"+name+"
            }*/
    %>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Documento sin t&iacute;tulo</title>
</head>
<body>
        <div align="center">
            <div align="center" style="width:800px">
                <form name="form" method="post" action="ProcesarAplicarAudiencia.jsp" enctype="multipart/form-data" >
                    <fieldset>
                        <legend></legend>
                        <input type="hidden" name="filename" value="<%=comp%>.pdf" />
                        <table border="0" align="center" width="790px" cellpadding="1" cellspacing="1">
                            <tr>
                                <td align="center" class="title">AUDIENCIA</td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td>
                                    <table border="0" align="center" width="790px" cellpadding="0" cellspacing="0">
										<tr>
                                                                                    
                                                                                    <td colspan="7" align="center">Cargar Archivo&nbsp;<input type="file" name="archivo" size="80"/></td>
										</tr>
										<tr>
											<td align="center"><input type="radio" name="fallo" id="fallo" value="1"/>Exoneracion&nbsp;&nbsp;
                                                                                            <input type="radio" name="fallo" id="fallo" value="2"/>Sancion
                                                                                            &nbsp;<input type="radio" name="fallo" id="fallo" value="3"/>Aplasar&nbsp</td>
										</tr>
										<tr>
											<td align="center"><input type="submit" value="Guardar"/></td>
										</tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </form>
            </div>
        </div>

</body>
</html>
<%}
}catch(Exception e){
System.out.println("/*"+e+"*/");
}
  %>