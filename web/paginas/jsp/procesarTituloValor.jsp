<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
</head>

<body>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<%

Model modelo= (Model)session.getAttribute("model");
modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
String mensaje ="";
try{
    modelo.getCon().setAutoCommit(false);
    Titulo_Valor tituloV = new Titulo_Valor();
    // System.out.println("placa : "+request.getParameter("placa"));
    String numero = "";
    java.sql.Date fecha;
    long documentoDo, documentoDt,codigoJuz;
    int municipio , numExp,valor;
    String oficinaP = "",tituloJ = "",nombreJuz = "", consignante = "",claseDeposito = "";
    java.sql.Timestamp fechaSystem= new java.sql.Timestamp(new java.util.Date().getTime());

        if((request.getParameter("numero")!=null)&&(request.getParameter("fecha")!=null)){
            numero =  request.getParameter("numero");
            tituloV.setNroTitulo(numero);
            //fecha = new java.util.Date(request.getParameter("fecha"));
            fecha = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha")).getTime());
            tituloV.setFechaTitulo(fecha);
            municipio = Integer.parseInt(request.getParameter("municipio"));
            tituloV.setDivipo(municipio);
            tituloV.setEstado(1);
            tituloV.setFecha_Proceso(fechaSystem);
            tituloV.setFk_usuario(usuario.getId_usuario());

            if((request.getParameter("oficinaP")!=null)&&(!request.getParameter("oficinaP").isEmpty())){
                oficinaP = request.getParameter("oficinaP");
                tituloV.setOficinaPagadora(oficinaP);
            }

            if((request.getParameter("tituloJ")!=null)&&(!request.getParameter("tituloJ").isEmpty())) {
                tituloJ = request.getParameter("tituloJ");
                tituloV.setTituloJudicial(tituloJ);
            }
            
             if((request.getParameter("nombreJuz")!=null)&&(!request.getParameter("nombreJuz").isEmpty())){
                nombreJuz = request.getParameter("nombreJuz");
                tituloV.setNombreJuzgado(nombreJuz);
            }
            
             if((request.getParameter("codigoJuz")!=null)&&(!request.getParameter("codigoJuz").isEmpty())){
                codigoJuz = Long.parseLong(request.getParameter("codigoJuz"));
                tituloV.setCodigoJuzgado(codigoJuz); 
            }

             if((request.getParameter("consignante")!=null)&&(!request.getParameter("consignante").isEmpty())){
                consignante = request.getParameter("consignante");
                tituloV.setNombreConsignante(consignante);
            }

             if((request.getParameter("numExp")!=null)&&(!request.getParameter("numExp").isEmpty())){
                numExp = Integer.parseInt(request.getParameter("numExp"));
                tituloV.setNumeroExpediente(numExp);
            }

             if((request.getParameter("valor")!=null)&&(!request.getParameter("valor").isEmpty())){
                valor = Integer.parseInt(request.getParameter("valor"));
                tituloV.setValorDeposito(valor);
            }

             if((request.getParameter("claseDeposito")!=null)&&(!request.getParameter("claseDeposito").isEmpty())){
                claseDeposito = request.getParameter("claseDeposito");
                tituloV.setClaseDeposito(claseDeposito);
            }

             if((request.getParameter("documentoDo")!=null)&&(!request.getParameter("documentoDo").isEmpty())){
                documentoDo = Long.parseLong(request.getParameter("documentoDo"));
                tituloV.setDemandado(documentoDo);
            }

             if((request.getParameter("documentoDt")!=null)&&(!request.getParameter("documentoDt").isEmpty())){
                documentoDt = Long.parseLong(request.getParameter("documentoDt"));
                tituloV.setDemandante(documentoDt);
            }

            
            modelo.adicionarTituloValor(tituloV);
            mensaje = "Titulo Valor Ingresado con Exito";
            modelo.getCon().commit();
    }else{
           mensaje= "Titulo valor No pudo ser Ingresado";
    }
%>


    <%
	}catch(Exception ecx){
		modelo.getCon().rollback();
		ecx.printStackTrace();        %>
		<script language="javascript" type="text/javascript">
			alert("Solicitud No pudo Ser Realizada");
			document.location.href = "adicionarTituloValor.jsp";
		</script>
<%  }

    if(!mensaje.equals("")){
        System.out.println(mensaje);
        %>
        <script language="javascript" type="text/javascript">
            alert("Mensaje : <%=mensaje%>");
            document.location.href = "adicionarTituloValor.jsp";
	</script>
   <% }


%>


</body>
</html>
