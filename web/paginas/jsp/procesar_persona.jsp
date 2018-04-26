<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="modelo.Persona, modelo.Empresa, modelo.Direccion, modelo.Model, modelo.Divipo"%>
 <%
try{
if(session.getAttribute("usuario")!=null){
    modelo.Model model = (modelo.Model)session.getAttribute("model");
    if(model!=null){
        modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
        
    Model modelo= (Model)session.getAttribute("model");
    try{
        modelo.getCon().setAutoCommit(false);
        java.sql.Date fechaSystem = new java.sql.Date(new java.util.Date().getTime());
        Direccion direccion=new Direccion();
        java.text.SimpleDateFormat formato = new java.text.SimpleDateFormat("dd/MM/yyyy");

        int  tipo =  Integer.parseInt(request.getParameter("tipo")) ;
        String primer_nombre    = request.getParameter("primer_nombre");
        String segundo_nombre   = request.getParameter("segundo_nombre");
        String primer_apellido  =  request.getParameter("primer_apellido");
        String segundo_apellido = request.getParameter("segundo_apellido");
        String documento    	= request.getParameter("documento");
        String dir_departamento   =  request.getParameter("dir_departamento");
        String dir_municipios     =  request.getParameter("dir_municipio");
        String direccion_pers     =  request.getParameter("direccion");
        String telefono_pers     =  request.getParameter("telefono");
        Persona persona=  modelo.consultarPersona(tipo, documento);
        if(persona==null){
            persona = new Persona();
            if(tipo!=2){
                primer_nombre    =    primer_nombre.toUpperCase();
                segundo_nombre   =    segundo_nombre.toUpperCase();
                primer_apellido  =    primer_apellido.toUpperCase();
                segundo_apellido =    segundo_apellido.toUpperCase();

                persona.setNombre_1(primer_nombre);
                if(segundo_nombre.trim().length()>0)
                    persona.setNombre_2(segundo_nombre);
                persona.setApellido_1(primer_apellido);
                if(segundo_nombre.trim().length()>0)
                    persona.setApellido_2(segundo_apellido);
                persona.setTipo_documento(tipo);
                persona.setDocumento(documento);
                long idPersona = modelo.adicionarPersona(persona);
                persona.setId_persona(idPersona);
            }else{
                Empresa e = modelo.consultarEmpresa(tipo,documento);
                if(e==null){
                    Empresa empresa = new Empresa();
                    empresa.setRazon_social(primer_nombre);
                    empresa.setSigla(primer_apellido);
                    empresa.setNit(documento);
                    empresa.setTipo_documento(tipo);
                    modelo.registrarEmpresa(empresa);

                    persona = new Persona();
                    persona.setTipo_documento(tipo);
                    persona.setDocumento(documento);
                    persona.setNombre_1(empresa.getRazon_social());
                    persona.setApellido_1(".");
                    long idPersona = modelo.adicionarPersona(persona);
                    persona.setId_persona(idPersona);
                }
            }
            if(persona.getId_persona()!=0){
                if(direccion_pers!=null&&dir_departamento!=null&&dir_municipios!=null){
                    if(direccion_pers.trim().length()>0&&dir_departamento.trim().length()>0&&dir_municipios.trim().length()>0){
                        long id_dpto  = Long.parseLong(dir_departamento);
                        long id_munp  = Long.parseLong(dir_municipios);
                        Divipo div = modelo.consultarDvipo(id_dpto, id_munp);
                        if(div!=null){
                            direccion.setDescripcion(direccion_pers);
                            direccion.setUbicacion(1);
                            direccion.setFecha(fechaSystem);
                            direccion.setEstado(1);
                            direccion.setFk_persona(persona.getId_persona());
                            direccion.setFk_divipo(div.getId_divipo());
                            if(telefono_pers.trim().length()>0)
                                direccion.setTelefono(telefono_pers);
                                modelo.adicionarDireccion(direccion);
                        }
                    }
                 }
            }
            modelo.getCon().commit();
            %>
            <script language="javascript" type="text/javascript">
				alert("La persona fue ingresada satisfactoriamente.");
                                window.close();
			</script>
            <%
        }
    }catch(Exception exc){
        exc.printStackTrace();
        modelo.getCon().rollback();
		%>
		<script language="javascript" type="text/javascript">
			alert("La persona no pudo ser registrada");
		</script>
		<%
    }
      
     }else{ %>
        <script>window.parent.document.location.href = "../../index.jsp";</script>
<%  }
 }else{ %>
     <script>window.parent.document.location.href = "../../index.jsp";</script>
<% }
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<% } %>
