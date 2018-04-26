<%--
    Document   : procesarRecaudoExterno
    Created on : 09-jun-2011, 23:54:06
    Author     : Civitrans
--%>
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
    if(session.getAttribute("usuario")!=null){
        modelo.Model model = (modelo.Model)session.getAttribute("model");
        modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");

        if(model!=null&&usuario!=null){
            new procesos.procesarRecaudoExterno(request,model,usuario);
            /*java.sql.Date fechaPago = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha")).getTime());
            model.getCon().setAutoCommit(false);
            modelo.Taquilla taquilla = model.consultarTaquillaByFecha(4, 234, 3,fechaPago);
            if(taquilla==null){
                taquilla = new modelo.Taquilla();
                taquilla.setEstado(3);
                taquilla.setFecha_ini(new java.sql.Timestamp(fechaPago.getTime()));
                taquilla.setFk_caja(4);
                taquilla.setFk_sede(usuario.getFk_sede());
                taquilla.setFk_usuario(usuario.getId_usuario());
                taquilla.setValor_nota_debito(0);
                taquilla.setValor_taquilla(0);
                taquilla.setFecha_fin(new java.sql.Timestamp(fechaPago.getTime()));
                taquilla.setId_taquilla(model.adicionarTaquilla(taquilla));
            }
            String referencia = request.getParameter("referencia");
            referencia = referencia.substring(referencia.length() - 6, referencia.length());
            long v = Long.parseLong(referencia);
            referencia = request.getParameter("referencia");
            referencia = referencia.substring(referencia.length() - 8, referencia.length());
            float valor = Float.parseFloat(request.getParameter("valor"));
            modelo.Vehiculo vehiculo = model.consultarVehiculoById(v);
            if (vehiculo != null) {
                long idPersona = 146149;
                modelo.Propietario propietario = model.getUnicoPropietarioVehiculo(vehiculo.getId_vehiculo());
                if (propietario != null) {
                    idPersona = propietario.getFk_persona();
                }
                procesos.aplicarPago aplicarPago = new procesos.aplicarPago();
                aplicado = aplicarPago.adicionarPagoBanco(model, taquilla.getId_taquilla(), usuario.getFk_sede(), usuario.getId_usuario(), fechaPago, idPersona, v, valor, referencia, fechaPago, 23);
            }
            float valor_taquilla = model.consultarValorTaquilla(taquilla.getId_taquilla());
            taquilla.setValor_nota_debito(valor_taquilla);
            taquilla.setValor_taquilla(valor_taquilla);
            model.actualizarTaquilla(taquilla,taquilla.getId_taquilla());model.getCon().commit();
            model.getCon().commit();
            */
        }
    } %>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Archivos Planos</title>
        <style type="text/css">
<!--
.style1 {
	color: #FFFFFF;
	font-weight: bold;
}
.style2 {color: #FFFFFF}
.style3 {
	color: #006699;
	font-weight: bold;
}
-->
        </style>
</head>
    <body>
        <table border="0" width="50%" align="center">
            <tr>
                <td height="40" align="center" bgcolor="#CCCCCC"><span class="style3">PAGOS APLICADO</span></td>
            </tr>
    </table>
<%
response.setContentType ("application/vnd.ms-excel"); //Tipo de fichero.
response.setHeader ("Content-Disposition", "attachment;filename=\"AcuerdosDePagoFecha.xls\"");
    /*String ar = request.getParameter("archivo");
    System.out.println("esto tiene ar="+ar);*/

%>
        <table border="1" align="center">
            <tr><th colspan="6">Pagos Aplicados Hoy</th></tr>
            <tr>
            <td>Nº</td>
            <td>Referencia</td>
            <td>Placa</td>
            <td>Estado</td>
            <td>Fecha pago</td>
            <td>Fecha Cargue</td>
            </tr>
<%
modelo.Model model = (modelo.Model)session.getAttribute("model");
//String fechac = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.sql.Date(cartera.getFecha_creacion().getTime()));

java.sql.Date fecha_actual = new java.sql.Date(new java.util.Date().getTime());
String fecha = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());
java.util.List<modelo.Pagos_externos> temp = model.listado_Pago_ex(fecha);

for(int i =0 ;i<temp.size();i++){
modelo.Pagos_externos pe = temp.get(i);
modelo.Vehiculo ve = model.consultarVehiculoById(pe.getFk_vehiculo());
%>
<tr>
    <td><%=i+1%></td>
    <td><%=pe.getReferencia()%></td>
    <td><%=ve.getPlaca()%></td>
    <td><%= pe.getAplico()==1?"Aplico":"No Aplico"%></td>
    <td><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(pe.getFecha_inicio())%></td>
    <td><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(pe.getFecha_proceso())%></td>

</tr>
<%
}

%>
        </table>
    </body>
<%
}catch(Exception mexe){
    mexe.printStackTrace();
} %>