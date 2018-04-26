<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<%@page import="javax.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("adicionarRangoComparendo.jsp")){
                          Model modelo= (Model)session.getAttribute("model");
                          java.util.List rang = null;
                          rang=modelo.ConsultaRangosComparendos();
                          java.util.List<Detalle_Rango_Comparendo> det =null;
                          Parametro par =null;
                          long max=0;
                          for(int i = 0;i<rang.size();i++){
                          Rangos_Comparendos temp = (Rangos_Comparendos)rang.get(i);
                          
                            //long test = Long.parseLong(temp.GetNum_Final());
                            Long test = Long.parseLong(temp.GetNum_Final());
                            if(test>max){
                                System.out.println("|-|"+max);
                                max=test;
                                System.out.println("|-|"+test);
                            }
                          }
                          System.out.println("bien1");
                          %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Adicionar Caja</title>
        <link href="../html/css/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />
        <script type="text/javascript" src="../html/scripts/tablecloth.js"></script>
        <LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js"ol type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <script src="../html/scripts/validarFecha.js" type="text/javascript"></script>

        <script language="javascript" type="text/javascript">



  
  function regresar(){
    <%System.out.println("bien2");%>
      var num_f = new Number(document.getElementById("num_f").value)
      var max = new Number(document.getElementById("hidden").value);
      var num_i = new Number(document.getElementById("num_i").value);

    if(document.getElementById("num_f").length<20 || document.getElementById("num_i").length<20){
            alert("Los rangos asignados por el RUNT tienen 20 caracteres");
      }else{
        if(num_f<max){
       <%System.out.println("bien"+max);%>
        alert("No se puede adcionar");
      }else{
          if(num_i < max){
            alert("No se puede adcionar un rango menor al maximo");
            <%System.out.println("bien4 funciona");%>
            }else{
                 document.form.submit();
            }//2

      }//1

      }

	}
   
   </script>
</head>
<body>
<center>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>

<form id="form" name="form" method="post" action="ProcesorangosComparendos.jsp" style="width:90%">
  <p>&nbsp;</p>
   <fieldset>
 <div align="center">
   <legend align="center" class="style2"><strong>ADICIONAR&nbsp;RANGO</strong></legend>
 </div>
  <table width="60%" align="center">
  <tr><td width="50%">
	<table width="50%" border="1" align="center" > 
    
    <tr><th colspan="4">Rangos</th>
</tr>
    <tr>
          <td height="" colspan="2" align="center"><span class="style2">Inico:</span></td>
      <td width="" colspan="2" align="center"><label>
              <input type="text" name="num_i" id="num_i" style="width:200px" maxlength="20"/>
      </label></td>
      
    </tr>
	<tr>
	<td colspan="2" align="center"><span class="style2">Final:</span></td>
        <td colspan="2"><input type="text" id="num_f" name="num_f" style="width:200px" maxlength="20" /></td>
    </tr>
    <tr>
    <td colspan="2">Tipo</td>
    <td><select id="vias" name="vias" style="width:130px;" class="select">
 <option value="1">Manual</option>
  <option value="2">Electronico</option>
   <option value="3">Camara</option>
                                                                                  

										  </select></td>
    </tr>
    <tr>
    <input type="hidden" id="hidden" name="hidden" value="<%=max%>">
    </tr>
  </table>  
  </td>
  <td width="50%">
  <table width="50%" border="1" align="center" > 
    
    <tr><th colspan="4">Resolucion</th></tr>
    <tr>
      <td colspan="2" align="center"><span class="style2">Numero:</span></td>
      <td width="50%" colspan="2" align="center"><label>
        <input type="text" id="num_resolucion" name="num_resolucion" style="width:130px" />
      </label></td>      
    </tr>
	<tr>
	<td colspan="2"><span class="style2">Fecha:</span></td>
        <% String fecha_hoy22 = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());%>
        <td width="16%"  scope="col" align="right"><input  id="fechaI" readonly name="fechaI" style="text-align:center;color:#333333;font:bold; width:90px" onKeyUp="mascara(this,'/',true)" maxlength="10" value="<%=fecha_hoy22%>"/>            <input name="bfechaI" type="button" id="bfechaI" value="..." style="width:30px">
								  <SCRIPT type="text/javascript">
														Calendar.setup({
																inputField     :    "fechaI",
																ifFormat       :    "%d/%m/%Y",
																button         :    "bfechaI"
														});
												  </SCRIPT></td>
    </tr>
    <tr>
      
    </tr>
  </table>
  </td>
  </tr>
  <tr><td height="26" colspan="4" align="center"><input type="button" value="GUARDAR" onClick="regresar()"/></td></tr>
  </table>
   </fieldset>
</form>
</center> 
</body>
</html>
<%  }else{ %>
			   <jsp:forward page="no_access.jsp">
				 <jsp:param name="tipo" value="1"></jsp:param>
			   </jsp:forward>
	<%  }
	}else{ %>
		<script>
			window.parent.document.location.href = "../../index.jsp";
		</script>  <%
	}
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>