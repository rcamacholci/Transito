<%@page import="java.util.*"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Documento sin t&iacute;tulo</title>
<script type="text/javascript" src="../../html/scripts/motorAjax.js"></script>
</head>    
    <script type="text/javascript">
        function Agregar(){
            var cupl = document.getElementById("txtcupl").value;
            document.form.HCupl.value=cupl;
            document.form.Nuevo.value="Agregar";
            document.form.accion="CargarCupl.jsp";
            document.form.submit();              
        }
        function view(){
            document.getElementById('trnuevo').style.display = 'block';
            document.getElementById('txtcupl').focus();
        }
        function unview(){
            document.getElementById('trnuevo').style.display = 'none';
        }
        function Eliminar(tr){
            document.form.HCupl.value = tr;
            document.form.Nuevo.value="Eliminar";
            
                if(confirm("Desea eliminar de la lista el Cupl "+tr)){
                document.form.accion="CargarCupl.jsp";
                document.form.submit();
                }else{
                    return false;
                }
            }


/***************/
function revisarL(lq){
                lq.style.color = "#006699";
                lq.value = '600000000000000000'.substr(0, 18-lq.value.length)+lq.value;
                if(lq.value.length==18){
                    if(isNaN(lq.value)){
                        alert("Digite solo valores numericos.");
                    }else{
                        ajax2=new nuevoAjax();
                        ajax2.open("POST", "verificarLiquidacion.jsp",true);
                        ajax2.onreadystatechange=function() {
                            if (ajax2.readyState==4) {
                                var respuesta = ajax2.responseText;
                                if(respuesta.indexOf("PAGADO")!=-1||respuesta.indexOf("NO_ACCESO")!=-1)
                                    lq.style.color = "#006699";
                                else
                                    lq.style.color = "#FF0000";
                            }
                        }
                        ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                        ajax2.send("runt="+lq.value);
                    }
                }else{
                    lq.style.color = "#FF0000";
                }
            }
    </script>
    <%
    if(request.getParameter("Nuevo")!=null){ 
    if(request.getParameter("Nuevo").equals("Agregar")){
        List<String> list = new LinkedList<String>();
        if(session.getAttribute("listcupl")!=null){
        list = (List<String>)session.getAttribute("listcupl");
        }
        if(request.getParameter("txtcupl")!=null){
            list.add(request.getParameter("txtcupl").toString().trim());
            session.setAttribute("listcupl", list);
        }
    }else if(request.getParameter("Nuevo").equals("Eliminar")){    
        List<String> list = new LinkedList<String>();
        list =(List<String>)session.getAttribute("listcupl");
        if(request.getParameter("HCupl")!=null){
            list.remove(request.getParameter("HCupl").toString().trim());
            session.setAttribute("listcupl", list);
            if(list.size()==0){
            session.removeAttribute("listcupl");
            }
        }else{
        session.removeAttribute("listcupl");
        }
    }
    }else{
        session.removeAttribute("listcupl");
        }
    %>
<body>
    <form id="form" name="form" method="post">
        <input type="hidden" value="" id="HCupl" name="HCupl" />
        <input type="hidden" value="" id="Nuevo" name="Nuevo"/>
        <table border="0" align="char">
<%//if(!request.getParameter("Nuevo").equals("S") || request==null){
if((List<String>)session.getAttribute("listcupl")!=null){
List<String> cupl =(List<String>)session.getAttribute("listcupl");
for(int i =0;i<cupl.size();i++){%>
<tr style="vertical-align: top" id="<%=cupl.get(i).toString()%>">
<td><input type="text" readonly disabled="disabled" value="<%=cupl.get(i).toString()%>"/></td>
<td><img src="../../html/images/adicionar.gif" alt="Nuevo Cuple" width="16" height="16" style="cursor:pointer" onclick="view()"/></td>
<td><img src="../../html/images/cortar.gif" alt="Eliminar Cuple" width="16" height="16" style="cursor:pointer" onclick="Eliminar('<%=cupl.get(i).toString()%>')" /></td>
</tr><%}//next
}
%>
<tr style="vertical-align: top">
<td colspan="4">
    <table style="display:<%=session.getAttribute("listcupl")!=null?"none":"block"%>"  id="trnuevo">
<tr style="vertical-align: top">
    <td><input type="txt" name="txtcupl" id="txtcupl"  onblur="revisarL(this)" /></td>
    <td><img src="../../html/images/adicionar.gif" alt="Nuevo Cuple" width="16" height="16" style="cursor:pointer" onclick="Agregar()"/></td> 
    <td><img src="../../html/images/cortar.gif"      alt="Eliminar Cupl" width="16" height="16" onclick="unview()" /></td>
</tr>
</table>
</td>
</tr>

</table>
</form>
</body>
</html>
