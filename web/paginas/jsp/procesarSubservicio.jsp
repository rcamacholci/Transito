<?xml version="1.0" encoding="UTF-8"?>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" import="java.util.*,modelo.*" %>

<root>
<%
Model modelo = (Model)session.getAttribute("model");

String sw = "0";

    try{
        modelo.getCon().setAutoCommit(false);
        int caracteristica = Integer.parseInt(request.getParameter("caracteristica"));
        int parametro = Integer.parseInt(request.getParameter("parametro"));
        java.sql.Date  fecha_inicial = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha_inicial")).getTime());
		java.sql.Date  fecha_final = null;
		if(request.getParameter("fecha_final")!=null){
			if(request.getParameter("fecha_final").trim().length()>0){
				fecha_final = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha_final")).getTime());
			}
		}
		long vehiculo = Long.parseLong(request.getParameter("idvehi"));
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
                if(request.getParameter("id").equals("2")){
                    long id_vehiculo =Long.parseLong(request.getParameter("idvehi"));
                    datos_vehiculo.setId_datoVehiculo(id_vehiculo);
                    modelo.editarDatosVehiculos(datos_vehiculo,1);
                    modelo.getCon().commit();

                }else{
                    modelo.finalizarEspecificaciones(datos_vehiculo.getFk_vehiculo(), datos_vehiculo.getFecha_ini(), datos_vehiculo.getGrupo_codigo(), datos_vehiculo.getParam_codigo(), datos_vehiculo.getSub_grupo_codigo(),datos_vehiculo.getFk_usuario(),1);
                    modelo.registrarDatosVehiculos(datos_vehiculo,1);
                    modelo.getCon().commit();
                    sw="1";
                }
         %>
<%  }catch(Exception ecx){
        modelo.getCon().rollback();
        ecx.printStackTrace();
        sw="2";
                }
%>
<sw><%=sw %></sw>

</root>