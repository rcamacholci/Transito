<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java"  import="java.sql.*" import="modelo.Model"  import="modelo.Usuario" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%
try{
        String token = request.getParameter("token");
        if(session.getAttribute("model")==null){
            if(token!=null){
                if(token.length()>5){
                    Model waitmodel = (Model)session.getAttribute("waitmodel");
                    session.setAttribute("model", waitmodel);
                    session.removeAttribute("waitmodel");
                }
            }
        }
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
                    Model modelo= (Model)session.getAttribute("model");
                    modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
                    if(usuario.getId_usuario()==0){
                        Model.userToken = token;
                        modelo.userToken = token;
                        modelo.editarToken(usuario.getId_usuario(), token);
                    }
                    modelo.Persona persona = modelo.consultarPersona(usuario.getFk_persona());
                    String nombreU = persona.getNombre_1()+" "+persona.getApellido_1()+" "+(persona.getApellido_2()!=null?persona.getApellido_2():"");
%>



<html>
	<head>
		<title>
			::: CIVI Trans :::
		</title>
		<link rel="stylesheet" type="text/css" href='./css/style.css' />

		<link rel="stylesheet" href="./css/jquery.ui.all.css"/>
		<script src="./js/jquery-1.4.2.min.js"></script>
		<script src="./js/jquery.ui.core.js"></script>
		<script src="./js/jquery.ui.widget.js"></script>
		<script src="./js/jquery.ui.accordion.js"></script>

		<script>
			function tabHigtlightOver(elem){
				elem.className="neotabsover";
			}
			function tabHigtlightOut(elem){
				elem.className="neotabs";
			}
		</script>

		<script>
			$(function() {
				$( "#accordion" ).accordion({ collapsible: true });
			});
		</script>
	</head>
	<body>

		<div class="header">
			<div class="cabezote">
				<div class="cabezotelogo">
					<img src="./img/transmilenio.png"   style="position:absolute; top:0; right:0;"/>
					<img src="./img/header_images.png"  style="position:absolute; top:10; left:59%;"/>
					<!--img src="./img/logogralletras.png" style="position:absolute; top:10; left:30;z-index:0;"/-->
					<div id="titulo">
						NEO-TRANS.
					</div>
					<div id="slogan">
						APLICACION WEB PARA EL CONTROL DE LOS PROCESOS
						<br />
						MISIONALES DE LOS ORGANISMOS DE TRANSITO
					</div>
				</div>
			</div>

			<div id="userloged">
				<div id="userlogedmessaje">
					USUARIO CONECTADO
				</div>
				<div id="userlogedwho">
					Bienvenido: Jhoseph Silva.
				</div>
				<a href="#">
					<img src="./img/usuario.png"   style=""/>
					Cerrar Sesi&oacute;n
				</a>
			</div>
			<div class="menuhorizontal">
				<div class="menuhorizontal_rayas" >
					<div class="menuh">
						<ul>
							<li><a href="#">Loren Ipsum</a></li>
							<li><a href="#">Loren Ipsum</a></li>
							<li><a href="#">Loren Ipsum</a></li>
							<li><a href="#">Loren Ipsum</a></li>
							<li><a href="#">Loren Ipsum</a></li>
							<li><a href="#">Loren Ipsum</a></li>
							<li></li>
						</ul>
						<div class="clb"></div>
					</div>
				</div>
			</div>
		</div>


		<div class="pagecontent">

			<table cellpadding="0" cellspacing="0" border="0" class="maintable">
				<tr>
					<td class="side">

						<div class="pagecontentoscuro">
						<div class="pagecontentoscurotopleft">
							<div class="menuvertical">
								<div id="accordion">
                                                                    <h3><a href="#">Menu Civitrans</a></h3>
                                                                    <div>
                                                                            <!--<p>
                                                                            Mauris mauris ante, blandit et, ultrices a, suscipit eget, quam. Integer
                                                                            ut neque. Vivamus nisi metus, molestie vel, gravida in, condimentum sit
                                                                            amet, nunc. Nam a nibh. Donec suscipit eros. Nam mi. Proin viverra leo ut
                                                                            odio. Curabitur malesuada. Vestibulum a velit eu ante scelerisque vulputate.
                                                                            </p>!-->
                                                                            <table border="none" align="left">
                                                                                    <tr>
                                                                                            <td>
                                                                                                    <a href="#">Inicio</a>
                                                                                            </td>
                                                                                    </tr>
                                                                            </table>
                                                                    </div>
                                                                    <h3><a href="#">Section 2</a></h3>
                                                                    <div>
                                                                            <p>
                                                                            Sed non urna. Donec et ante. Phasellus eu ligula. Vestibulum sit amet
                                                                            purus. Vivamus hendrerit, dolor at aliquet laoreet, mauris turpis porttitor
                                                                            velit, faucibus interdum tellus libero ac justo. Vivamus non quam. In
                                                                            suscipit faucibus urna.
                                                                            </p>
                                                                    </div>
                                                                    <h3><a href="#">Section 3</a></h3>
                                                                    <div>
                                                                            <p>
                                                                            Nam enim risus, molestie et, porta ac, aliquam ac, risus. Quisque lobortis.
                                                                            Phasellus pellentesque purus in massa. Aenean in pede. Phasellus ac libero
                                                                            ac tellus pellentesque semper. Sed ac felis. Sed commodo, magna quis
                                                                            lacinia ornare, quam ante aliquam nisi, eu iaculis leo purus venenatis dui.
                                                                            </p>
                                                                            <ul>
                                                                                    <li>List item one</li>
                                                                                    <li>List item two</li>
                                                                                    <li>List item three</li>
                                                                            </ul>
                                                                    </div>
                                                                    <h3><a href="#">Section 4</a></h3>
                                                                    <div>
                                                                            <p>
                                                                            Cras dictum. Pellentesque habitant morbi tristique senectus et netus
                                                                            et malesuada fames ac turpis egestas. Vestibulum ante ipsum primis in
                                                                            faucibus orci luctus et ultrices posuere cubilia Curae; Aenean lacinia
                                                                            mauris vel est.
                                                                            </p>
                                                                            <p>
                                                                            Suspendisse eu nisl. Nullam ut libero. Integer dignissim consequat lectus.
                                                                            Class aptent taciti sociosqu ad litora torquent per conubia nostra, per
                                                                            inceptos himenaeos.
                                                                            </p>
                                                                    </div>
								</div>
							</div>

						</div>
						</div>

					</td>

					<td class="main">
						<div class="content">

							<!--div class="neotabs">
							<div class="neotabsmiddle">
							<div class="neotabsleft">
							<div class="neotabsright">
								Tab 1
							</div>
							</div>
							</div>
							</div-->



							<div class="neotabs" onmouseover="tabHigtlightOver(this);" onmouseout="tabHigtlightOut(this)">
								<div>
								<div>
								<div>
									Tab 1
								</div>
								</div>
								</div>
							</div>

							<div class="neotabs"  onmouseover="tabHigtlightOver(this);" onmouseout="tabHigtlightOut(this)">
								<div>
								<div>
								<div>
									Tab 2
								</div>
								</div>
								</div>
							</div>

							<div class="neotabs" onmouseover="tabHigtlightOver(this);" onmouseout="tabHigtlightOut(this)">
								<div>
								<div>
								<div>
									Tab 3
								</div>
								</div>
								</div>
							</div>



						</div>
					</td>
				</tr>
			</table>

		</div>

		<div class="footer">
			<div class="footer_rayas">
				&copy; 2011 - 2012, CIVI-Trans Todos los derechos reservados. Prohibida la reproduccion total o parcial.
			</div>
		</div>

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
}catch(Exception mexe){ System.out.println("ERROR EN NEW INICIO " + mexe);%>

    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>