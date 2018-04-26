<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage=""%>
<%@page import="modelo.*"%>
<%@page import="Cifrado.*"%>
<%@page import="java.util.*"%>
<%
            try {
                if (session.getAttribute("model") != null) {
                        Model model = (Model) session.getAttribute("model");
                        Usuario usuario = (Usuario)session.getAttribute("usuario");
                        model.getCon().setAutoCommit(false);

%>
<html>
     <head>
        <title>Vericicacion</title>
        <style type="text/css">
            .label {font-size: 11px; color:#666666; text-align:left ; font-family:Arial; font-weight:bold ; width:110px}
            .text {font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold ; width:120px; text-transform:uppercase}
            .date {font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold; width:100px }
            .bdate {font-size: 10px; color:#666666; text-align:left ; font-family:Arial; font-weight:bold; width:20px }
            .select {font-size: 11px; color:#003366; text-align:left ; font-family:Arial; font-weight:bold; width:120px }
            .input { width:130px }
            .check { font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold; }
        </style>
        <link title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <script type="text/javascript" src="../html/scripts/motorAjax.js"></script>
        <script type="text/javascript" src="../html/scripts/adicionarComparendo.js"></script>
        <script type="text/javascript" src="../html/scripts/consultasGenerales.js"></script>
        <script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
        <script language="javascript" type="text/javascript">
	function paso(){
		if(document.form.user.value.length>0){
			if(document.form.password.value.length>0){
				document.form.action="Verificar_anulacion.jsp?id_tiquete="+document.getElementById('id_tiquete').value+"&anular=1&motivo="+document.getElementById('motivo').value+"&user="+document.getElementById('user').value+"&password="+document.getElementById('password').value;
				document.form.submit();
			}else{
				alert("Digite password de usuario");
			}
		}else{
			alert("Digite nombre de usuario");
		}
	}
        </script>

        <%
                        Parametro parametro = new Parametro();
                        Sede sede = new Sede();
                        String user="";
                        String idt = request.getParameter("id_tiquete");
                        String anu = request.getParameter("anular");
                        String motivo = request.getParameter("motivo");
                        String password = request.getParameter("password");
                        user=request.getParameter("user").toUpperCase();
                        boolean sw =false;
                        boolean sww=false;
                        Usuario usu =null;
                        if(!user.equals("1") && !password.equals("1")){
                        System.out.println("/*prefil->");
                        sw = model.ConsultarUsuario(user,KeyStore.Encriptar(password));
                        usu =model.consultarUsuario(user,KeyStore.Encriptar(password));
                        }
                        if(sw==true){
                            %>
                            <script>
                               if(confirm("Confirmar")){
          <%                           long id_tiquete = 0;

         Perfil perfil = new Perfil();
         List listPerfil;
         listPerfil = model.listarPerfil();
         Iterator itt = listPerfil.iterator();
         long prfl =0;
         while (itt.hasNext()) {
         perfil = (Perfil)itt.next();
         Usuario us = model.consultarUsuario(perfil.getfk_usuario());
            if(us.getId_usuario()==usu.getId_usuario()){
                prfl = perfil.getId_perfil();
                break;
            }
          }
         int recurso=0;
         System.out.println("prefil->"+prfl);
          java.util.List perfilrecursos = model.listarConfRecursos(prfl);
          for(int i =0;i<perfilrecursos.size();i++){
              Recurso_Perfil Rperfil = (Recurso_Perfil)perfilrecursos.get(i);
              if(Rperfil.getFk_recurso()==209){
                  recurso=209;
                  break;
              }
          }

    if (recurso==209){
        if(request.getParameter("id_tiquete")!=null){
            java.util.List<Detalle_Tiquete> dett = model.consultarDetalleTiquete(Integer.parseInt(request.getParameter("id_tiquete")));

            for(int x =0;x<dett.size();x++){
                Detalle_Tiquete tmp = dett.get(x);
                if(tmp.getEstado()==2){
                    sww=true;
                    System.out.println("/*Recivo estado Dos (2)*/");
                    break;
                }
            }//next
          if(sww==false){
              System.out.println("/*Valido*/");
            id_tiquete=Long.parseLong(request.getParameter("id_tiquete"));
            Persona persona = new Persona();
            Parametro param = new Parametro();
            Parametro pmetro = new Parametro();
            java.util.HashMap listaTipos = model.crearHashParametrosAbreviatura(5);
            String nombre="";
            String observacion = "";
            boolean permisoAnularPago = true;
    	    Tiquete tiq = model.consultarTiquetePorID(id_tiquete);
            Taquilla taq = model.consultarTaquillaActivaByUsuario(usuario.getId_usuario());
            if(request.getParameter("anular")!=null){
                if(request.getParameter("anular").equals("1")){
                    observacion = request.getParameter("motivo");
                    if((tiq.getEstado()==3&&taq.getEstado()==1)||(tiq.getEstado()==3&&usuario.getId_usuario()==1)){
                        try{
                            Pago pago = model.consultarPagoByTiquete(tiq.getId_tiquete());
                            if(pago!=null){
                                model.getCon().setAutoCommit(false);
                                java.util.List listat = model.consultarDetalleTiquete(tiq.getId_tiquete());
                                for(int i= 0; i < listat.size(); i++){
                                    Detalle_Tiquete dt = (Detalle_Tiquete)listat.get(i);
                                    if(dt.getFk_concepto()!=0||dt.getFk_tramite()!=0){
                                        for(int d=1;d<=dt.getCantidad();d++){
                                            model.actualizarEstadoDetalleTiqueteConcepto(dt.getId_det_tiquete(), 2, d);
                                        }
                                    }
                                    if(dt.getFk_cartera()!=0){
                                        Cartera cartera = model.consultarCartera(dt.getFk_cartera());
                                        if(cartera!=null){
                                            model.renovarCartera(cartera.getId_cartera(),pago.getId_pago());
                                            model.actualizarComparendo(cartera.getId_cartera(),1);
                                            model.eliminarPagoDetalleCartera(cartera.getId_cartera(),pago.getId_pago()+"");
                                            model.actualizarValoresCartera(cartera.getId_cartera());
                                            if(cartera.getTipo()==3){
                                                model.actualizarDetalleFinanciacion(cartera.getId_cartera(),1);
                                                boolean cuotasCanceladas = model.consultarCuotasCanceladas(cartera.getId_cartera());
                                                if(!cuotasCanceladas){
                                                    model.actualizarComparendoFinanciacion(cartera.getId_cartera(), 1);
                                                    model.actualizarFinanciacion(cartera.getId_cartera(), 1);
                                                }
                                            }
                                        }
                                    }
                                    model.actualizarEstadoDetalleTiquete(dt.getId_det_tiquete(), 2);
                                }
                                tiq.setEstado(2);
                                tiq.setFk_taquilla(taq.getId_taquilla());
                                tiq.setFk_usuario(usuario.getId_usuario());
                                model.actualizarEstadoTiquete(tiq);
                                model.actualizarEstadoPago(pago.getId_pago(),2,observacion,taq.getId_taquilla(),usuario.getId_usuario());
                                model.actualizarSaldosAFavorxReferencia(1,tiq.getId_tiquete()+"");
                                model.getCon().commit();
                            }

                        }catch(Exception exc){
                            model.getCon().rollback();
                            exc.printStackTrace();
                        }
                      }
                    }
                }
            }else{
                System.out.println("/*no se pudo anular*/");
            %>
                    alert("No se puede anular, recibo utilizado");
            <%
            }
                    %>
        window.parent.close();
                                    }


                            </script>
                            <%
        }

                        }else {%>
<jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="1"></jsp:param>
</jsp:forward>
<% }
 }else{
 if(!user.equals("1") && !password.equals("1")){
 %>
 <script>
                    alert("Error en Usuario o Contraseña");
 </script>
 <%
}
 }
        %>
    </head>
    <input type="hidden" name="id_tiquete" id="id_tiquete" value="<%=idt%>" />
    <input type="hidden" name="anular" id="anular" value="<%=anu%>" />
    <input type="hidden" name="motivo" id="motivo" value="<%=motivo%>" />
    <body>
        <div align="center">
            <div align="center" style="width:560px">
                <form name="form" action="javascript:paso()" method="post">
                    <fieldset>
                      <legend></legend>
                      <table border="0" align="center" width="265" cellpadding="1" cellspacing="1">
                            <tr>
                                <td width="261" align="center" class="text">Atentificacion</td>
                            </tr>
                            <tr>
                                <td>

                                    <table border="0" align="center" width="238" cellpadding="1" cellspacing="2" style="border:none">

                                        <tr>
                                            <td width="232" colspan="5">
                                                <table width="50%" border="0" cellspacing="1" cellpadding="1">
                                                    <tr>
                                                        <td width="110" class="label">&nbsp;Usuario</td>
                                                        <td width="337"><input type="text" name="user" id="user" class="text"/></td>

                                                    </tr>
                                                    <tr>
                                                      <td class="label">Contraseña</td>
                                                    <td>
                                                        <input type="password" id="password" name="password"  class="pass"/>
                                                    </td>

                                                    </tr>
                                                   <tr>
                                                   <td align="center" colspan="2">
                                                       <button type="submit" name="aceptar" id="aceptar" ><span class="text">Verificar</span></button>
                                        			</td>
                                                   </tr>
                                                </table></td>

                                        </tr>

                              </table></td>
                            </tr>
                            <tr>
                                <td colspan="5" align="center"><iframe src="#" name="proceso" id="proceso" style="display:none"></iframe>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </form>
            </div>
        </div>
    </body>
</html>
<%
} else {%>
<script>
    window.parent.document.location.href = "../../index.jsp";
</script>  <%            }
} catch (Exception mexe) {%>
<jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="2"></jsp:param>
    <jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param>
</jsp:forward>
<%  }%>