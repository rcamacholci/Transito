<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java"  import="java.sql.*" import="modelo.*" import="java.util.*" import="modelo.Usuario" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
    conf.civitrans.webservices.Runt.WSrunt wsr = new conf.civitrans.webservices.Runt.WSrunt();
    if(wsr.PrevalidarFuncionario(request)){
        %><script>document.location.href="inicio.jsp"</script><%
    }else{
        %><script>alert("<%=wsr.getMensaje() %>"); document.location.href="autenticarUsuario.jsp";</script><%
    }

%>