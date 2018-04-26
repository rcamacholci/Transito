
<%@page  import="modelo.Encrypt" %>

<h4>

    
    
    <%= "martes :"+ Encrypt.getSecurityCode(new java.text.SimpleDateFormat("dd/MM/yyyy").parse("11/09/2012")) %>

</h4>