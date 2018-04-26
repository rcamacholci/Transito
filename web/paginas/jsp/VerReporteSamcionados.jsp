
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="java.util.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("consultarRadicacion.jsp")){
                    modelo.Model model = (modelo.Model)session.getAttribute("model");
                    modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
                    String usu = usuario.getNombre();
   
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style type="text/css">
<!--
.Estilo3 {font-size: 12px; color: #FFFFFF; }
.Estilo4 {
	color: #333333;
	font-weight: bold;
	font-size: 12px;
}
-->
        </style>


		<script language="javascript" type="text/javascript">
                   function verR2(inf,imp){
                           //alert(inf+"-"+imp)
                           window.location.href ="ImprimirSancion.jsp?ind="+inf+"&imp="+imp;//"ImprimirSancion.jsp?&imp="+inf+"&ind="+imp;

			}

                       function verR(){
                                ancho = 789;
				alto = 250;
				barra = 0;
				izquierda = (document.width) ? (document.width-ancho)/2 : 100;
				arriba = (document.height) ? (document.height-alto)/2 : 100;
				opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
				var dir = "comparendos/comparendo.jasper";
			        var nombre = "Comparendos_por_Dias";
				url = "verReportes.jsp?nombreReporte="+nombre+"&dirReporte="+dir;
				window.open(url, 'popUp', opciones);
			}
			function sombrear(tr,color){
				tr.style.backgroundColor = color;
			}
			function renovar(tr){
				tr.style.backgroundColor = "#FFFFFF";
			}

                      

                        function verI(td){
                            var comparendo = td.id;
                            alert(comparendo);
                                ancho = 789;
				alto = 250;
				barra = 0;
				izquierda = (document.width) ? (document.width-ancho)/2 : 100;
				arriba = (document.height) ? (document.height-alto)/2 : 100;
				opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
				
			        var nombre = document.form.hidden.value;
                                alert(nombre);
				url = "consultarComparendo.jsp?id=0&comparendo="+comparendo;
				window.open(url, 'popUp', opciones);


                        }
		</script>
		
</head>
    <body>
            <table width="100%" border="1" cellpadding="1" cellspacing="0">
              <tr style="border:none;background:url(../html/images/inicio_3.png)">
                <th width="2%" scope="col"><span class="Estilo3">N°</span></th>
                <th width="17%" scope="col"><span class="Estilo3">NUMERO</span></th>
                <th width="8%" scope="col"><span class="Estilo3">FECHA COMPARENDO</span></th>
                <th width="8%" scope="col"><span class="Estilo3">FECHA SANCION</span></th>
                <th width="20%" scope="col"><span class="Estilo3">INFRACTOR</span></th>
                <th width="20%" scope="col"><span class="Estilo3">DOCUMENTO</span></th>
                <th width="8%" scope="col"><span class="Estilo3">ESTADO</span></th>
		<th width=15%" scope="col"><span class="Estilo3">IMPRESO</span></th>
                <th width="8%" scope="col"><span class="Estilo3">IMPRIMIR</span></th>
               </tr>
              <%
      try{
        java.util.List<Sancion> temp = model.ListarSancionados();
System.out.println("ok?");
int x =0;
               if(temp!=null){
            for(int i =0;i<temp.size();i++){
                Sancion san = temp.get(i);
                Comparendo comp = model.consultarComparendoById(san.getFk_comparendo());
                Persona per = model.consultarPersona(comp.getFk_persona());
                //int idc = cartera.getTipo() == 1 ? 318 : cartera.getTipo() == 2 ? 249 : 319;
                String SN  = san.getImpreso()==1? "si" : "no";
                Parametro pa = model.consultarParametro(comp.getEstado(),67);               
               if(comp.getEstado()==8 || comp.getEstado()==8 ){
                    x++;
  %>
                <tr>
                                     <th width="17%" scope="col"><span class="Estilo4"><%=x%></span></th>
                                    <th width="17%" scope="col"><span class="Estilo4"><%=comp.getNumero()%></span></th>
                                    <th width="17%" scope="col"><span class="Estilo4"><%=new java.text.SimpleDateFormat("dd/MM/yyyy").format(comp.getFecha())%></span></th>
                                    <th width="17%" scope="col"><span class="Estilo4"><%=new java.text.SimpleDateFormat("dd/MM/yyyy").format(san.getFecha_sancion())%></span></th>
                                    <th width="17%" scope="col"><span class="Estilo4"><%=per.getNombre_1()%> <%=per.getApellido_1()%></span></th>
                                    <th width="17%" scope="col"><span class="Estilo4"><%=per.getDocumento()%></span></th>
                                    <th width="17%" scope="col"><span class="Estilo4"><%=pa.getNombre()%></span></th>
                                    <th width="17%" scope="col"><span class="Estilo4"><%=SN%></span></th>
                                    <th onMouseOver="sombrear(this,'#FFFFFF')" onMouseOut="renovar(this)"><div align="center"><img src="../html/images/reporte.png" height="25" width="25" onClick="verR2('<%=san.getId_sancion()%>','<%=san.getImpreso()%>')" style="cursor:pointer"/></div></th>
                </tr>
               <%
               }//if
            }//netx
        }//endif

      }catch(Exception exc){
       exc.printStackTrace();
   }  %>
          </table>
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