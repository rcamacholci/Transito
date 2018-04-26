
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
linkTarget="persona";
linkAlign="left";
linkHeight="30";
barBGColor="#006AD5";
barFontFamily="Tahoma";
barFontSize="2px";
barFontColor="#FFFFFF";
barVAlign="center";
barWidth=15;// no quotes!!
barText="PERSONAS"; // <IMG> tag supported. Put exact html for an image to show.

///////////////////////////			#FF7E28

// ssmItems[...]=[name, link, target, colspan, endrow?] - deje 'link' y 'target' vacios para crear titulo
ssmItems[0]=["MENU PRINCIPAL"] //crea titulo
ssmItems[1]=["DATOS GENERALES", "consultarPersonaRUNT.jsp?paso=1", ""]
ssmItems[2]=["CARTERAS", "consultarCarteraPersona.jsp?id=1", ""]
ssmItems[3]=["VEHICULOS", "consultarVehiculosPersona.jsp?id=1", ""]
ssmItems[4]=["COMPARENDOS", "consultarComparendosPersona.jsp?id=1", ""]
ssmItems[5]=["FINANCIACIONES", "consultarFinanciacionesPersona.jsp?id_persona=", ""]
ssmItems[6]=["PAGOS", "consultarPagosPersona.jsp", ""]
ssmItems[7]=["SALDOS A FAVOR", "consultarSaldosFavor.jsp", ""]

buildMenu();

//-->