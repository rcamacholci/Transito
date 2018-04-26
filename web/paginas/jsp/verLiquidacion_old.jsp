<%--
    Document   : verCarteraLiquidacion
    Created on : 03-ene-2009, 16:12:36
    Author     : WALTER E
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Concepto"  import="modelo.Liquidacion"   import="modelo.Cartera" import="modelo.Tramite" import="modelo.Detalle_Cartera" import="modelo.Valor" import="modelo.Sede" import="modelo.Vehiculo" errorPage="" %>
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
        <link title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <script type="text/javascript" src="../html/scripts/motorAjax.js"></script>
        <script type="text/javascript" src="../html/scripts/adicionarComparendo.js"></script>
        <script type="text/javascript" src="../html/scripts/consultasGenerales.js"></script>
        <script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
    <title>Liquidacion</title>
	<script language="javascript" type="text/javascript">
function nuevoAjax(){
	var xmlhttp= false;
	try{
		xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
	}catch(e){
		try {
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}catch(E){
			xmlhttp = false;
		}
	}

	if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
		xmlhttp = new XMLHttpRequest();
	}

	return xmlhttp;
}

                function adicionar(id){
			window.location.href = "verLiquidacion.jsp?id="+id+"&tipo=4";
			window.parent.frames[0].location.href = window.parent.frames[0].location.href;
			window.parent.frames[1].location.href = window.parent.frames[1].location.href;
			window.parent.frames[2].location.href = window.parent.frames[2].location.href;
			window.parent.frames[3].location.href = window.parent.frames[3].location.href;
		}

                function agregarTimbre(nplaca){
                    var ancho = 689;
                    var alto = 150;
                    var barra = 0;
                    var izquierda = (screen.width) ? (screen.width-ancho)/2 : 100;
                    var arriba = (screen.height) ? (screen.height-alto)/2 : 100;
                    var opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars='+barra+',resizable=0,width='+ancho+',height='+alto+',left='+izquierda+',top='+ arriba;
                    var url = "adicionarValorTimbre.jsp?placa="+nplaca;
                    window.open(url, 'popUp', opciones);
                }

                function agregarSubServicio(nplaca){
                    var ancho = 689;
                    var alto = 150;
                    var barra = 0;
                    var izquierda = (screen.width) ? (screen.width-ancho)/2 : 100;
                    var arriba = (screen.height) ? (screen.height-alto)/2 : 100;
                    var opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars='+barra+',resizable=0,width='+ancho+',height='+alto+',left='+izquierda+',top='+ arriba;
                    var url = "adicionarSubservicio.jsp?placa="+nplaca;
                    window.open(url, 'popUp', opciones);
                }


                function agregarTipoPersona(idpersona,nplaca){
                    var ancho = 689;
                    var alto = 150;
                    var barra = 0;
                    var izquierda = (screen.width) ? (screen.width-ancho)/2 : 100;
                    var arriba = (screen.height) ? (screen.height-alto)/2 : 100;
                    var opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars='+barra+',resizable=0,width='+ancho+',height='+alto+',left='+izquierda+',top='+ arriba;
                    var url = "adicionarTipoPersona.jsp?id_persona="+idpersona+"&placa="+nplaca;
                    window.open(url, 'popUps', opciones);
                }

		function change(txt1,txt2,cant,id){
			document.getElementById(txt1+id).style.display = 'none';
			document.getElementById(txt2+id).style.display = 'block';
			document.getElementById(txt2+id).value = cant;
			document.getElementById(txt2+id).focus();
		}

		function change2(txt1,txt2,pag,e,id){
			if(e.keyCode==13||e.keyCode==9){
				document.getElementById(txt1+id).style.display = 'block';
				document.getElementById(txt2+id).style.display = 'none';
				document.getElementById(txt1+id).innerHTML = "<b><font size='2'>"+document.getElementById(txt2+id).value+"</font></b>";
				window.location.href = "verLiquidacion.jsp?id="+id+"&tipo="+pag+"&valor1="+document.getElementById(txt2+id).value;
			}
		}

                function change3(txt1,txt2,pag,e,id){
			if(e.keyCode==13||e.keyCode==9){
				document.getElementById(txt1+id).style.display = 'block';
				document.getElementById(txt2+id).style.display = 'none';
                                var campo = document.getElementById(txt2+id).value;
                                var total = campo*0.01;
                                document.getElementById(txt1+id).innerHTML = "<b><font size='2'>"+total+"</font></b>";
				window.location.href = "verLiquidacion.jsp?id="+id+"&tipo="+pag+"&valor1="+total;
			}
		}

		function verDetalle(id){
				if(document.getElementById('detalle'+id).style.display=='none'){
					if(navigator.appName=="Microsoft Internet Explorer"){
						document.getElementById('detalle'+id).style.display = 'block';
					}else{
						document.getElementById('detalle'+id).style.display = 'table-row';
					}
				}
				else
					document.getElementById('detalle'+id).style.display = 'none';
		}

		function sombrear(tr){
			tr.style.backgroundColor="#CCCCCC";
		}
		function renovar(tr){
			tr.style.backgroundColor="#FFFFFF";
		}



function RetencionF(numplaca){
    ajax = nuevoAjax();
    ajax.open("POST", "Retencion.jsp",true);
    ajax.onreadystatechange=function() {
        if (ajax.readyState==4) {
            var docxml = ajax.responseXML;
            var valrete = docxml.getElementsByTagName('valrete')[0].childNodes[0].nodeValue;
            if(valrete=="0"){
                var show = docxml.getElementsByTagName('show')[0].childNodes[0].nodeValue;
                if(show=="1"){
                    agregarTimbre(numplaca);
                }else{
                    if(show=="2"){
                        agregarSubServicio(numplaca);
                    }else{
                        alert(show);
                    }
                }
            }else{
                document.location.href = "verLiquidacion.jsp?id=204&tipo=3&varete="+valrete+"&placa="+numplaca;
            }
        }
    }
    ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    ajax.send("placa="+numplaca);
}
	</script>
    <style type="text/css">
<!--
.Estilo4 {
	color: #333333;
	font-size: 12px;
}
.Estilo11 {
	font-size: 12px;
	font-weight: bold;
}
.Estilo12 {font-size: 12px; color:#333333}
.Estilo14 {font-size: 10px; font-weight: bold; }
.Estilo15 {font-size: 10px;color:#333333}
.Estilo17 {color: #FFFFFF; font-size: 11px; }
-->
    </style>
</head>
<body style="border:none">
    <form method="post" name="form" action="" >
	<table width="100%" border="1" cellpadding="1" cellspacing="0">

          <tr style="border:none; background:url(../html/images/inicio_3.png)">
            <th width="2%" scope="col"><span class="Estilo17">
              <label>X</label>
            </span></th>
            <th width="50%" scope="col"><span class="Estilo17">
              <label>CONCEPTO</label>
            </span></th>
            <th width="10%" scope="col"><span class="Estilo17">
              <label>REF.</label>
            </span></th>
            <th width="15%" scope="col"><span class="Estilo17">
              <label>VALOR</label>
            </span></th>
            <th width="3%" scope="col"><span class="Estilo17">
              <label>UNID.</label>
            </span></th>
            <th width="20%" scope="col"><span class="Estilo17">
              <label>TOTAL</label>
            </span></th>
      </tr>
<%
     try{
         Model model = (Model)session.getAttribute("model");
         Sede sede = (Sede)session.getAttribute("sede");
         int anoactual = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
         double vrete = 0;
         if(request.getParameter("varete")!=null){
            String valor = request.getParameter("varete");
            vrete = Long.parseLong(valor);
         }
         String valorAvaluo = null;
         int anonuevo = (anoactual+1);
         int oldyear = (anoactual-1);
         if(request.getParameter("id")!=null&&request.getParameter("tipo")!=null&&model!=null){
             if (!request.getParameter("id").equals("")&&!request.getParameter("tipo").equals("")) {
                java.util.List listaLiquidacion = null;
                if (session.getAttribute("listaLiquidacion") == null) {
                    listaLiquidacion = new java.util.LinkedList();
                }else{
                    listaLiquidacion = (java.util.List) session.getAttribute("listaLiquidacion");
                }
                Liquidacion liquidacion = new Liquidacion();
				if(!model.liquidacionExiste(listaLiquidacion,Long.parseLong(request.getParameter("id")),Integer.parseInt(request.getParameter("tipo")))){
                if (request.getParameter("tipo").equals("1")) {
                    Cartera cartera = model.getCartera(Long.parseLong(request.getParameter("id")));
                    float saldo = (float)cartera.getSaldo();
                    System.out.println("Saldo antes= "+saldo);
                    String numplaca = request.getParameter("placa");
                    Vehiculo veh = model.consultarVehiculo(numplaca);
                    java.util.Date fechaActual =(new java.util.Date());
                        if((new java.text.SimpleDateFormat("dd/MM/yyyy").parse(new java.text.SimpleDateFormat("dd/MM/yyyy").format(fechaActual)).getTime() <= new java.text.SimpleDateFormat("dd/MM/yyyy").parse("26/09/2013").getTime()) &&
                                (cartera.getTipo()==2) && (veh.getEstado()==1||veh.getEstado()==5) && (!cartera.getReferencia().equals("2011") && !cartera.getReferencia().equals("2012") && !cartera.getReferencia().equals("2013"))){
                            modelo.Detalle_Cartera dc = model.consultarDetalleCartera(cartera.getId_cartera(), 249);
                            if(dc!=null){
                                int interesR = (int)dc.getValor();
                                int interesD =(int)((interesR*80)/100);
                                saldo = saldo-interesD;
                                System.out.println("Saldo desp= "+saldo);
                            }
                            modelo.Detalle_Cartera dcEx = model.consultarDetalleCarteraExtempo(cartera.getId_cartera());
                            if(dcEx!=null){
                            int extempoR = (int)dcEx.getValor();
                            int extempoD =(int)((extempoR*80)/100);
                            saldo = saldo-extempoD;
                            System.out.println("Saldo desp= "+saldo);
                            }
                        }else{
                            saldo = (float)cartera.getSaldo();
                        }

                        liquidacion.setId_liquidacion(cartera.getId_cartera());
                        liquidacion.setTipo(Integer.parseInt(request.getParameter("tipo")));
                        liquidacion.setFk_concepto((int) cartera.getFk_concepto());
                        liquidacion.setReferencia(cartera.getReferencia());
                        liquidacion.setValor(saldo);
                        liquidacion.setCantidad(1);
                        liquidacion.setTotal(saldo);
                        listaLiquidacion.add(liquidacion);
                        session.setAttribute("listaLiquidacion", listaLiquidacion);
                } else {
                    if (request.getParameter("tipo").equals("2")) {
                           Tramite tramite = model.consultarTramite(Long.parseLong(request.getParameter("id")));
                        boolean sw = true;
                        
                        if(request.getParameter("id").equals("1")){
                            if(!request.getParameter("placa").equals("")){
                            Vehiculo veh = model.consultarVehiculo(request.getParameter("placa").toUpperCase());
                            long fk_veh = 0;
                            boolean existeV = false;
                            if(veh!=null){ fk_veh = veh.getId_vehiculo(); existeV = true;}
                            List lista = model.consultarTiqueteByPlaca(request.getParameter("placa"),fk_veh );
                            System.out.println("vehiculo: "+fk_veh);
                            if(!existeV){
                            for(int i=0;i<lista.size();i++){
                            Tiquete tiqu = (Tiquete)lista.get(i);

                                /*if(tiqu!=null){
                                    Pago pagoR = model.consultarPagoByTiquete(tiqu.getId_tiquete());
                                    if(pagoR!=null){
                                        Reclamos_Pagos rp = model.consultarReclamosPagos(pagoR.getId_pago(), 1);
                                            if(rp==null){
                                                if(tiqu.getEstado()==3){
                                                    Detalle_Tiquete dte = model.consultarDetalleTiqueteMatriculaIni(tiqu.getId_tiquete(), 1, 1);
                                                    if(dte!=null){
                                                        sw=false;
                                                        %><script>alert("El vehiculo de placa "+'<%=request.getParameter("placa")%>'+" tiene el recibo No "+'<%=tiqu.getNumero_factura()%>'+" sin utilizar para el tramite de "+'<%=tramite.getNombre() %>');</script> <%
                                                        break;
                                                    }
                                                }
                                            }
                                    }
                                }*/
                            }
                            }else{
                                sw=false;
                                %><script>alert("El vehiculo de placa "+'<%=request.getParameter("placa")%>'+" ya se encuentra matriculado ");</script> <%
                            }
                            }
                        }
                        
                        if(sw){
                        liquidacion.setId_liquidacion(tramite.getId_tramite());
                        liquidacion.setTipo(Integer.parseInt(request.getParameter("tipo")));
                        liquidacion.setFk_concepto((int)tramite.getId_tramite());
                        liquidacion.setReferencia(Long.parseLong(request.getParameter("sede"))+"-"+Integer.parseInt(request.getParameter("valor1"))+"-"+Integer.parseInt(request.getParameter("valor2")));
                        float valor = model.consultarValorTramite(Long.parseLong(request.getParameter("sede")),Integer.parseInt(request.getParameter("id")),Integer.parseInt(request.getParameter("valor1")),Integer.parseInt(request.getParameter("valor2")));
                        liquidacion.setValor(Math.round(valor));
                        liquidacion.setCantidad(1);
                        liquidacion.setTotal(valor);
                        listaLiquidacion.add(liquidacion);
                        session.setAttribute("listaLiquidacion", listaLiquidacion);
                        }
                        
                        if(request.getParameter("id").equals("2")||request.getParameter("id").equals("9")){
                            String numplaca = request.getParameter("placa");
                            Vehiculo veh = model.consultarVehiculo(numplaca);
                            Persona persona = model.consultarPersonaVehiculo(numplaca);
                            if(persona!=null){
                                    String che = request.getParameter("check");
                                    if(request.getParameter("check").equals("1")){
                                        String tipop = model.consultarTipoPersonaR(persona.getId_persona());
                                        if(tipop!=null){
                                            int tipo_p = Integer.parseInt(tipop);
                                            if(tipo_p==2){
%>
                                        <script language="javascript" type="text/javascript">
                                            document.location.href = "verLiquidacion.jsp?id=204&tipo=3&placa="+'<%=request.getParameter("placa")%>';
                                        </script>
<%
                                            }
                                        }else{
                                            long id_persona = persona.getId_persona();
%>
                                    <script language="javascript" type="text/javascript">
                                        agregarTipoPersona('<%=id_persona%>','<%=numplaca%>');
                                    </script>
<%
                                }
                             }
                      }
                }
                    }else{
                        if(request.getParameter("tipo").equals("3")) {
                            if(request.getParameter("id").equals("204")){
                                if(request.getParameter("placa")!=null){
                                    String numplaca = request.getParameter("placa");
                                    if(vrete==0){
%>
                                            <script language="javascript" type="text/javascript">
                                                RetencionF('<%=numplaca%>');
                                            </script>
<%
                                    }else{
                                        long rete= Math.round(vrete);
                                        liquidacion.setId_liquidacion(rete);
                                        liquidacion.setTipo(Integer.parseInt(request.getParameter("tipo")));
                                        liquidacion.setFk_concepto(46);
                                        liquidacion.setReferencia("");
                                        liquidacion.setValor(rete);
                                        liquidacion.setCantidad(1);
                                        liquidacion.setTotal(rete);
                                        listaLiquidacion.add(liquidacion);
                                        session.setAttribute("listaLiquidacion", listaLiquidacion);
                                    }
                                }
                            }else{
                                Valor valor = model.consultarValor(Long.parseLong(request.getParameter("id")));
                                liquidacion.setId_liquidacion(valor.getId_valor());
                                liquidacion.setTipo(Integer.parseInt(request.getParameter("tipo")));
                                liquidacion.setFk_concepto((int)valor.getFk_concepto());
                                liquidacion.setReferencia("");
                                liquidacion.setValor(valor.getValor());
                                liquidacion.setCantidad(1);
                                liquidacion.setTotal(valor.getValor());
                                listaLiquidacion.add(liquidacion);
                                session.setAttribute("listaLiquidacion", listaLiquidacion);
                        }
                        }else{
                            if(request.getParameter("tipo").equals("4")) {
                                for(int i=0;i<listaLiquidacion.size();i++){
                                    liquidacion = (Liquidacion)listaLiquidacion.get(i);
                                    if(liquidacion.getId_liquidacion()==Long.parseLong(request.getParameter("id"))){
                                        int conc = liquidacion.getFk_concepto();
                                        if(liquidacion.getTipo()==1&&(conc==32||conc==33||conc==34||conc==35)){
                                            int maxRefCar = 2000;
                                            for(int i2=0;i2<listaLiquidacion.size();i2++){
                                                 Liquidacion liquidacion2 = (Liquidacion)listaLiquidacion.get(i2);
                                                 conc = liquidacion2.getFk_concepto();
                                                 if(liquidacion2.getTipo()==1&&(conc==32||conc==33||conc==34||conc==35)){
                                                     if(maxRefCar<Integer.parseInt(liquidacion2.getReferencia()))
                                                         maxRefCar = Integer.parseInt(liquidacion2.getReferencia());
                                                 }
                                            }
                                            if(liquidacion.getReferencia().equals(""+maxRefCar)){
                                               listaLiquidacion.remove(i);
                                            }
                                            break;
                                        }else{
                                            listaLiquidacion.remove(i);
                                            break;
                                        }
                                    }
                                }
                                session.setAttribute("listaLiquidacion", listaLiquidacion);
                            }else{
                                    if(request.getParameter("tipo").equals("5")) {
                                            try{
                                                    for(int i=0;i<listaLiquidacion.size();i++){
                                                            liquidacion = (Liquidacion)listaLiquidacion.get(i);
                                                            if(liquidacion.getId_liquidacion()==Long.parseLong(request.getParameter("id"))){
                                                                    liquidacion.setCantidad(Integer.parseInt(request.getParameter("valor1")));
                                                                    liquidacion.setTotal(liquidacion.getValor()*liquidacion.getCantidad());
                                                                    listaLiquidacion.set(i,liquidacion);
                                                                    break;
                                                            }
                                                    }
                                                    session.setAttribute("listaLiquidacion", listaLiquidacion);
                                            }catch(Exception ex){
                                            }
                                    }else{
                                            if(request.getParameter("tipo").equals("6")) {
                                                    try{
                                                            for(int i=0;i<listaLiquidacion.size();i++){
                                                                    liquidacion = (Liquidacion)listaLiquidacion.get(i);
                                                                    if(liquidacion.getId_liquidacion()==Long.parseLong(request.getParameter("id"))){
                                                                            liquidacion.setValor(Float.parseFloat(request.getParameter("valor1")));
                                                                            liquidacion.setTotal(liquidacion.getValor()*liquidacion.getCantidad());
                                                                            listaLiquidacion.set(i,liquidacion);
                                                                            break;
                                                                    }
                                                            }
                                                            session.setAttribute("listaLiquidacion", listaLiquidacion);
                                                    }catch(Exception ex){
                                                    }
                                            }else{
                                                    if(request.getParameter("tipo").equals("7")) {
                                                            session.setAttribute("listaLiquidacion", null);
                                                    }
                                            }
                                    }
                            }
                        }
                    }
                }
            }
		 }
         float sumatoria = 0;
		 float sumatoriaT = 0;
		 if(session.getAttribute("listaLiquidacion")!=null){
			 java.util.List listaLiquidacion = (java.util.List)session.getAttribute("listaLiquidacion");
                         java.util.List no_repetibles = model.consultarConceptosbyAtributos(sede.getId_sede(),2);
                         java.util.List existentes = new java.util.LinkedList();
			 if(listaLiquidacion!=null){
				 for(int i=0;i<listaLiquidacion.size();i++){
					Liquidacion liquidacion = (Liquidacion)listaLiquidacion.get(i);
					String nombre = "";
					if(liquidacion.getTipo()==1||liquidacion.getTipo()==3){
						Concepto concepto = model.consultarConcepto(liquidacion.getFk_concepto());
						nombre = concepto.getNombre().trim().length()>30?concepto.getNombre().trim().substring(0,30):concepto.getNombre().trim();
					}else{
						if(liquidacion.getTipo()==2){
							Tramite tramite = model.consultarTramite(liquidacion.getFk_concepto());
							nombre = tramite.getNombre().trim().length()>30?tramite.getNombre().trim().substring(0,30):tramite.getNombre().trim();
						}
					}
					%>
					<tr style="border:none" onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
						<td align="center" style="cursor:pointer;">
								<img src="../html/images/remover.png" width="19" height="19" onClick="adicionar(<%=liquidacion.getId_liquidacion()%>)"/>                    </td>
					<% if(liquidacion.getTipo()==1||liquidacion.getTipo()==2){	%>
							<td scope="col" align="left" onclick="verDetalle(<%=liquidacion.getId_liquidacion()%>)">
							  <span class="Estilo14">
							  <label><font style="text-decoration:underline; cursor:pointer"><%=nombre%></font><font style="text-decoration:underline; cursor:pointer"></font></label>
						    </span>							  </td>
					<% }else{ %>
							<td scope="col" align="left">
							 <span class="Estilo14">
							  <label><%=nombre%></label>
						    </span></td>
					<% }
					String refer = "";
					if(liquidacion.getTipo()!=2){
						refer = liquidacion.getReferencia();
					}
					 %>
					<td scope="col" align="center"><span class="Estilo11">
					  <label><%=refer%></label>
					</span></td>

					<%  Sede sd = (Sede)session.getAttribute("sede");
						if(model.consultarAtributo(sd.getId_sede(),1,liquidacion.getFk_concepto())&&(liquidacion.getTipo()==1)){
                                        %>
							<td scope="col" align="center" onClick="change('lvalor','valor',<%=liquidacion.getValor()%>,<%=liquidacion.getId_liquidacion()%>)">
								<span class="Estilo12">
								<label id="lvalor<%=liquidacion.getId_liquidacion()%>"><b>
								<%=liquidacion.getValor()%></b></label>
								<input type="text" id="valor<%=liquidacion.getId_liquidacion()%>"
									style="display:none;" onKeyDown="change2('lvalor','valor',6,event,<%=liquidacion.getId_liquidacion()%>)" value="" size="5"/>
								</span></td>
					<%  }else{ %>
							<td scope="col" align="center"><span class="Estilo12">
							  <label><b><%=liquidacion.getValor()%></b></label>
							</span></td>
					<% }
					if(liquidacion.getTipo()!=1){%>
						<td align="center" scope="col" onClick="change('lcantidad','cantidad',<%=liquidacion.getCantidad()%>,<%=liquidacion.getId_liquidacion()%>)">
							<span class="Estilo12">
							<label id="lcantidad<%=liquidacion.getId_liquidacion()%>"><b>
							<%=liquidacion.getCantidad()%></b></label>
							<input type="text" id="cantidad<%=liquidacion.getId_liquidacion()%>"
								style="display:none;" onKeyDown="change2('lcantidad','cantidad',5,event,<%=liquidacion.getId_liquidacion()%>)" value="" size="2"/>
					  </span></td>
					<% }else{ %>
						<td align="center" scope="col">
							<span class="Estilo12">
							<label id="lcantidad<%=liquidacion.getId_liquidacion()%>"><b>
							<%=liquidacion.getCantidad()%></b></label>
					  </span> </td>
					<% } %>
					 <td align="right" scope="col" valign="middle"><span class="Estilo12"><b>
						  <label><div id="sumat<%=liquidacion.getId_liquidacion()%>">&nbsp;<%=liquidacion.getTotal()%></div></label>
					  </b></span></td>
					</tr>
						<tr id="detalle<%=liquidacion.getId_liquidacion()%>">
							<td colspan="6" align="right">
								<table width="90%" border="0" style="table-layout:fixed">
								<% if(liquidacion.getTipo()==1){
									java.util.List listadetalle = model.listarDetalleCartera(liquidacion.getId_liquidacion());
										for(int d = 0; d < listadetalle.size() ; d++){
										  Detalle_Cartera detalle = (Detalle_Cartera)listadetalle.get(d);
										  Concepto concepto = model.consultarConcepto(detalle.getFk_concepto());
										  nombre = concepto.getNombre().trim().length()>50?concepto.getNombre().trim().substring(0,50):concepto.getNombre().trim();%>
										  <tr  style="border:none">
											<td width="6%" style="border:none"><img src="../html/images/detalle.png" width="13" height="13"/></td>
											<td width="69%" align="left" style="border:none"><label><b><span class="Estilo15"><%=nombre%></span></b></label></td>
											<td width="25%" align="right" style="border:none"><label><b><span class="Estilo15">$</span><font size="2">&nbsp;</font><span class="Estilo15"><%=detalle.getValor()%></span></b></label></td>
										  </tr>
									<% }
								 }else{
                                                                     if(liquidacion.getTipo()==2){
                                                                            java.util.StringTokenizer st = new java.util.StringTokenizer(liquidacion.getReferencia(),"-");
                                                                            long v_sede = Long.parseLong(st.nextToken());
                                                                            int valor1 = Integer.parseInt(st.nextToken());
                                                                            int valor2 = Integer.parseInt(st.nextToken());
                                                                            java.util.List listadetalle = model.consultarDetalleTramite(v_sede,Integer.parseInt(liquidacion.getId_liquidacion()+""),valor1,valor2);
                                                                            int month = java.util.Calendar.getInstance().get(java.util.Calendar.MONTH);
                                                                            float sumaTramite = 0;
                                                                            for(int d = 0; d < listadetalle.size() ; d++){
                                                                                Valor detalle = (Valor)listadetalle.get(d);
                                                                                Concepto concepto = model.consultarConcepto(detalle.getFk_concepto());
                                                                                if(!(no_repetibles.contains(concepto.getId_concepto())&&existentes.contains(concepto.getId_concepto()))){
                                                                                    float valorc = detalle.getValor();
                                                                                    if(concepto.getTipo()==2&&concepto.getClase()==2){
                                                                                        float valorc2 = (float)(valorc-((valorc/12.0)*(12-month)));
                                                                                        valorc = valorc - Math.round(valorc2);
                                                                                    }
                                                                                    sumaTramite += valorc;
                                                                                    nombre = concepto.getNombre().trim().length()>32?concepto.getNombre().trim().substring(0,32):concepto.getNombre().trim();%>
                                                                                    <tr  style="color:#333333; border:none">
                                                                                        <td width="6%"><img src="../html/images/detalle.png" width="13" height="13"/></td>
                                                                                        <td width="69%" align="left" style="border:none"><label><b><span class="Estilo15"><%=nombre%></span></b></label></td>
                                                                                        <td width="25%" align="right" style="border:none"><label><b><span class="Estilo15">$</span><font size="2">&nbsp;</font><span class="Estilo15"><%=valorc*liquidacion.getCantidad()%></span></b></label></td>
                                                                                    </tr>
                                                                        <%          existentes.add(concepto.getId_concepto());
                                                                                }else{
                                                                                    existentes.add(concepto.getId_concepto());
                                                                                }
                                                                            }
                                                                            sumaTramite = sumaTramite*liquidacion.getCantidad();
                                                                            liquidacion.setValor(sumaTramite);
                                                                            liquidacion.setTotal(sumaTramite);
                                                                            listaLiquidacion.set(i, liquidacion); %>
                                                                            <script language="javascript" type="text/javascript">
                                                                   document.getElementById('sumat'+<%=liquidacion.getId_liquidacion()%>).innerHTML = <%="'$"+sumaTramite+"'"%>;
                                                                            </script>
                                                                            <%
                                                                       }
								   }%>
							  </table>							</td>
						</tr>
			<script language="javascript" type="text/javascript">
                            document.getElementById('detalle'+<%=liquidacion.getId_liquidacion()%>).style.display = 'none';
                        </script>
			<% 		sumatoria += liquidacion.getTotal();
					if(liquidacion.getTipo()!=1){
						sumatoriaT += liquidacion.getTotal();
					}
				}

				 }
			}
			if(sumatoria>0){%>
				<script language="javascript" type="text/javascript">
                                    if(window.parent.document.getElementById('liquidar')!=null)
					window.parent.document.getElementById('liquidar').disabled = false;
                                    if(window.parent.document.getElementById('aplicar')!=null)
					window.parent.document.getElementById('aplicar').disabled = false;
                                    if(window.parent.document.getElementById('limpiar')!=null)
					window.parent.document.getElementById('limpiar').disabled = false;
			    </script>
        <%	}else{ %>
				<script language="javascript" type="text/javascript">
                                    if(window.parent.document.getElementById('liquidar')!=null)
					window.parent.document.getElementById('liquidar').disabled = true;
                                    if(window.parent.document.getElementById('aplicar')!=null)
					window.parent.document.getElementById('aplicar').disabled = true;
                                    if(window.parent.document.getElementById('limpiar')!=null)
					window.parent.document.getElementById('limpiar').disabled = true;
			    </script>
		<%	} %>
		 <script language="javascript" type="text/javascript">
                     if(window.parent.document.getElementById('total')!=null)
                        window.parent.document.getElementById('total').innerHTML = "<span class='Estilo15'>$&nbsp;"+<%=((float)sumatoria)%>+"</span>";
                      if(window.parent.document.getElementById('totalidad')!=null)
				window.parent.document.getElementById('totalidad').value = <%=((float)sumatoria)%>+"";
                       if(window.parent.document.getElementById('totalidadT')!=null)
				window.parent.document.getElementById('totalidadT').value = <%=((float)sumatoriaT)%>+"";
		   </script>
       <% }
      }catch(Exception exc){
          exc.printStackTrace();
      }%>
</table>
 </form>
</body>
</html>
