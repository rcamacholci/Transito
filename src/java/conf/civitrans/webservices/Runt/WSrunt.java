/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package conf.civitrans.webservices.Runt;

import com.heinsohn.runt.general.consultas.PrevalidarTokenBiometricoOutDTO;
import modelo.Model;
import modelo.Persona;
import modelo.Usuario;
import modelo.UsuarioRunt;

/**
 *
 * @author Jefrey
 */
public class WSrunt {

    private String mensaje = "", token = "";

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public boolean AutenticarFuncionario(javax.servlet.http.HttpServletRequest request) {

        try {
            if (request.getParameter("Validacion") != null) {

                Model model = (Model) request.getSession().getAttribute("model");

                Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");
                UsuarioRunt userRunt = (UsuarioRunt) request.getSession().getAttribute("usuarioRunt");

                modelo.Persona solicitante = model.consultarPersona(usuario.getFk_persona());
                String tipoDocumento = model.consultarParametro((int) solicitante.getTipo_documento(), 5).getNombreCorto();
                String numeroDocumento = solicitante.getDocumento();

                com.heinsohn.runt.general.consultas.ConsultarTokenValidacionBiometricaOutDTO validacionTokenOut = new com.heinsohn.runt.general.consultas.ConsultarTokenValidacionBiometricaOutDTO();
                webservices.common.CommonServicesClient commonService = new webservices.common.CommonServicesClient();
                commonService.setTokenHuellaDigital("");
                commonService.setUser(userRunt.getCodigo());
                Model.userHandler = userRunt.getCodigo();
                Model.passUserHandler = userRunt.getPassword();

                validacionTokenOut = commonService.consultarParametroValidacionBiometrica(tipoDocumento, numeroDocumento, "1");
                if (validacionTokenOut != null) {
                    if (validacionTokenOut.getStatus() != null) {
                        if (validacionTokenOut.getStatus().getStatusCode().equals("1") || validacionTokenOut.getStatus().getStatusCode().equals("2")) {
                            if (validacionTokenOut.getRespuestaAutorizacion().size() > 0) {
                                com.heinsohn.runt.general.consultas.ValidacionCentralizadaOutDTO validacionCentralizada = null;
                                java.util.List<com.heinsohn.runt.general.consultas.ValidacionCentralizadaOutDTO> list = validacionTokenOut.getRespuestaAutorizacion();
                                java.util.Iterator it = list.iterator();
                                while (it.hasNext()) {
                                    validacionCentralizada = (com.heinsohn.runt.general.consultas.ValidacionCentralizadaOutDTO) it.next();
                                }
                                if (validacionCentralizada != null) {
                                    request.getSession().setAttribute("token", validacionCentralizada.getTrama());
                                    mensaje = "Validacion Realizada con exito";
                                    token = validacionCentralizada.getTrama() + "";
                                    return true;
                                }
                            }
                        } else {
                            mensaje = "Codigo Error: " + validacionTokenOut.getStatus().getStatusCode() + " Descripcion Error: " + validacionTokenOut.getStatus().getStatusDesc();
                        }
                    }
                }
            }
        } catch (Exception e) {
            mensaje = "Error al autenticar usuario: +" + e.getMessage();
            e.printStackTrace();
        }
        mensaje = "El token no puedo ser generado, verifique conexion con Web Service Runt";
        return false;
    }

    public boolean PrevalidarFuncionario(javax.servlet.http.HttpServletRequest request) {

        try {
            Model model = (Model) request.getSession().getAttribute("model");
            UsuarioRunt userRunt = (UsuarioRunt) request.getSession().getAttribute("usuarioRunt");
            if (model != null) {
                if (request.getSession().getAttribute("token") != null) {

                    webservices.common.CommonServicesClient commonService = new webservices.common.CommonServicesClient();
                    commonService.setUser(userRunt.getCodigo());
                    commonService.setTokenHuellaDigital(request.getSession().getAttribute("token").toString());
                    com.heinsohn.runt.general.identificaciones.StatusDTO status = new com.heinsohn.runt.general.identificaciones.StatusDTO();

                    Model.userHandler = userRunt.getCodigo();
                    Model.passUserHandler = userRunt.getPassword();
                    request.getSession().setAttribute("token2", request.getParameter("token"));
                    return true;

//                    PrevalidarTokenBiometricoOutDTO prevalida = commonService.prevalidarTokenBiometrico("C", userRunt.getCodigo(), "WS_FUNCIONARIO", request.getParameter("token"));
//
//                    status = prevalida.getStatus();
//                    if (status != null) {
//                        if (status.getStatusCode().equals("1")) {
//                            request.getSession().setAttribute("token2", request.getParameter("token"));
//                            return true;
//                        } else {
//                            mensaje = "Error en la autenticación - Runt: Codigo: " + status.getStatusCode() + " - Descripcion: " + status.getStatusDesc();
//                        }
//                    }
                } else {
                    mensaje = "Error al recuperar token de autenticacion";
                }
            } else {
                mensaje = "Sesion inactiva";
            }
        } catch (Exception e) {
            mensaje = "Error al prevalidar usuario: +" + e.getMessage();
            e.printStackTrace();
        }
        return false;
    }
}
