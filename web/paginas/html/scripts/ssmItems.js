
/*
Configure el estilo del menu
NOTA: Para editar el color de los links, modifique en el STYLE tags y edite el ssm2Items colors
*/
YOffset=100; // no quotes!!
XOffset=0;
staticYOffset=30; // no quotes!!
slideSpeed=20 // no quotes!!
waitTime=100; // no quotes!! this sets the time the menu stays out for after the mouse goes off it.
menuBGColor="#CCCCCC";
menuIsStatic="not"; //this sets whether menu should stay static on the screen
menuWidth=170; // Tiene que ser multiplo de 10! no quotes!!
menuCols=2;
hdrFontFamily="Tahoma";
hdrFontSize="2px";
hdrFontColor="#333333";
hdrBGColor="#CCCCCC";
hdrAlign="center";
hdrVAlign="center";
hdrHeight="23";
linkFontFamily="Tahoma";
linkFontSize="2px";
linkBGColor="#FFFFFF";
linkOverBGColor="#006AD5";
linkTarget="vehiculo";
linkAlign="left";
linkHeight="30";
barBGColor="#006AD5";
barFontFamily="Tahoma";
barFontSize="2px";
barFontColor="#FFFFFF";
barVAlign="center";
barWidth=25;// no quotes!!
barText="VEHICULOS"; // <IMG> tag supported. Put exact html for an image to show.

///////////////////////////			#FF7E28

// ssmItems[...]=[name, link, target, colspan, endrow?] - deje 'link' y 'target' vacios para crear titulo
ssmItems[0]=["MENU PRINCIPAL"] //crea titulo
ssmItems[1]=["DATOS GENERALES", "verDatosVehiculo.jsp?id=1", ""]
ssmItems[2]=["CARACTERISTICAS", "consultarCEVehiculo.jsp?id=1",""]
ssmItems[3]=["DETALLE CARTERA", "consultarCarteraVehiculo.jsp?id=1", ""]
ssmItems[4]=["PROPIETARIOS", "consultarPropietariosVehiculo.jsp?id=1", ""]
ssmItems[5]=["COLORES", "consultarColoresVehiculo.jsp?id=1", ""]
ssmItems[6]=["EMBARGOS - PLEITOS", "consultarEmbargosVehiculo.jsp?id=1", ""]
ssmItems[7]=["ALERTAS", "consultarAlertasVehiculo.jsp?id=1", ""]
ssmItems[8]=["TRAMITES", "consultarTramitesVehiculo.jsp?id=1", ""]
ssmItems[9]=["PAGOS GENERALES", "consultarPagosVehiculo.jsp?id=1", ""]
ssmItems[10]=["NOTAS CREDITO", "consultarNotasCredito.jsp?id=1", ""]
ssmItems[11]=["EMPRESA VINCULADORA", "consultarEmpresaVinculadora.jsp?id=1", ""]
ssmItems[12]=["IMAGENES", "visualizarCarpeta.jsp", ""]
ssmItems[13]=["ACTOS ADMINISTRATIVOS", "consultarActosVehiculo.jsp?id=1", ""]
ssmItems[14]=["PRESCRIPCION", "verPrescripcion.jsp?num=1", ""]
/*
ssmItems[7]=["FAQ", "http://www.htmldynamico.cjb.net", "", 1, "no"] //crea linea de dos columnas
ssmItems[8]=["Email", "mailto: mundohtml@yahoo.com.ar", "",1]

ssmItems[9]=["External Links", "", ""] //crea titulo
ssmItems[10]=["DeArriba Sponsor", "http://www.dearriba.com/default.asp?reff=VNW982", ""]
ssmItems[11]=["Web.Net", "http://web.net.ar", ""]
ssmItems[12]=["Dynamic Fx", "http://absolutegb.com/maximus/", ""]
*/
buildMenu();

//-->