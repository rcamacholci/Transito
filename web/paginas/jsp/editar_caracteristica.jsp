

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="modelo.*"%>
<%
    Model modelo= (Model)session.getAttribute("model"); 
    try{
        modelo.getCon().setAutoCommit(false);
		int  id_dato         =       Integer.parseInt(request.getParameter("idv")) ;
        int  caracteristica         =       Integer.parseInt(request.getParameter("caracteristica")) ;
        int parametro    =     Integer.parseInt(request.getParameter("parametro"));
        java.sql.Date  fecha_inicial = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha_inicial")).getTime());
		java.sql.Date  fecha_final = null;
		if(request.getParameter("fecha_final")!=null){
			if(request.getParameter("fecha_final").trim().length()>0){
				fecha_final = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha_final")).getTime());
			}	
		}	
		long vehiculo = Long.parseLong(request.getParameter("vehiculo"));
		int grupo = 0;
		switch(caracteristica){
			case 1:grupo = 1;break;
			case 2:grupo = 75;break;
			case 3:grupo = 3;break;
			case 4:grupo = 324;break;
			case 5:grupo = 0;break;
			case 6:grupo = 2;break;
			case 7:grupo = 0;break;
                        case 8:grupo = 362;break;
		}
        DatosVehiculo datos_vehiculo = new DatosVehiculo();
		datos_vehiculo.setFecha_ini(fecha_inicial);
		if(fecha_final!=null){
			datos_vehiculo.setFecha_fin(fecha_final);
		}
		datos_vehiculo.setFecha_sistema(new java.sql.Date(new java.util.Date().getTime()));
		Usuario user = (Usuario)session.getAttribute("usuario");
		datos_vehiculo.setFk_usuario(user.getId_usuario());
		datos_vehiculo.setFk_vehiculo(vehiculo);
		datos_vehiculo.setGrupo_codigo(1);
		datos_vehiculo.setParam_codigo(0);
		datos_vehiculo.setSub_grupo_codigo(grupo);
		datos_vehiculo.setValor(parametro+"");
		modelo.registrarDatosVehiculos(datos_vehiculo,1);
        modelo.getCon().commit(); %>
        <script language="javascript" type="text/javascript">document.location.href = "verCaracteristicas.jsp?id=1";</script>
<%  }catch(Exception ecx){
        modelo.getCon().rollback();
        ecx.printStackTrace();        %>
        <script language="javascript" type="text/javascript">
			alert("Caracteristica no pudo ser ingresada");
			document.location.href = "adicionarCaracteristica.jsp?id=1";
		</script>		
<%  }
%>