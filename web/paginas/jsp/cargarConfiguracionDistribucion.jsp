<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="modelo.*"%>
<%@page import="java.util.*"%>

<% 
if (!request.getParameter("sede").equals("")&&!request.getParameter("concepto").equals("")&&!request.getParameter("entidad").equals("")&&!request.getParameter("valor").equals("")){ 
	String sede = request.getParameter("sede");
	String concepto = request.getParameter("concepto");
	String entidad = request.getParameter("entidad");
	String valor = request.getParameter("valor");
	if(session.getAttribute("confDistribucion")!=null){
		java.util.HashMap lista = (java.util.HashMap)session.getAttribute("confDistribucion");
                if(lista.get(sede+"|"+concepto+"|"+entidad)!=null){
			if(Double.parseDouble(lista.get(sede+"|"+concepto+"|"+entidad).toString())!=Double.parseDouble(valor)){
                            lista.put(sede+"|"+concepto+"|"+entidad,valor);
                            session.setAttribute("confDistribucion",lista);
			}
		}else{
			lista.put(sede+"|"+concepto+"|"+entidad,valor);
			session.setAttribute("confDistribucion",lista);
		}	
	}else{
		java.util.HashMap lista = new java.util.HashMap();
		lista.put(sede+"|"+concepto+"|"+entidad,valor);
		session.setAttribute("confDistribucion",lista);
	}
	java.util.HashMap lista = (java.util.HashMap)session.getAttribute("confDistribucion");
	Iterator ite = lista.keySet().iterator();
	while(ite.hasNext()){
		Object elem = ite.next();
	}
}
%>