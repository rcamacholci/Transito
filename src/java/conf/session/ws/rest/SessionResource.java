/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package conf.session.ws.rest;

import java.net.URI;
import java.net.URL;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.Produces;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PUT;
import javax.ws.rs.PathParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 * REST Web Service
 *
 * @author Jcarreno
 */
@Path("restSession")
public class SessionResource {

    @Context
    private UriInfo context;

    /**
     * Creates a new instance of SessionResource
     */
    public SessionResource() {
    }

    /**
     * Retrieves representation of an instance of
     * conf.session.ws.rest.SessionResource
     *
     * @return an instance of java.lang.String
     */
    @GET
    @Produces(MediaType.APPLICATION_XML)
    public String getXml() {
        //TODO return proper representation object
        throw new UnsupportedOperationException();
    }

    /**
     * PUT method for updating or creating an instance of SessionResource
     *
     * @param content representation for the resource
     */
    @PUT
    @Consumes(MediaType.APPLICATION_XML)
    public void putXml(String content) {
    }

    @GET
    @Path("user/{user}/{pass}/{rec}")
    public Response setSessiont(
            @PathParam("user") String User,
            @PathParam("pass") String pass,
            @PathParam("rec") String recurso) {
        try {
            if (User.isEmpty() || pass.isEmpty() || recurso.isEmpty()) {
                return Response.status(Response.Status.NOT_ACCEPTABLE).build();
            }
            Response.Status statu = Response.Status.TEMPORARY_REDIRECT;
            URL url = getURL(User, pass, recurso);
            URI uri = new URI(url.getProtocol(), url.getAuthority(), url.getPath(), url.getQuery(), null);
            return Response.status(statu).location(uri).build();
        } catch (Exception e) {
            return Response.status(Response.Status.HTTP_VERSION_NOT_SUPPORTED).build();
        }
    }

    public URL getURL(String user, String pass, String rec) {
        try {
            return new URL("https://localhost/transito/rest/validar_restsession?user=" + user + "&pass=" + pass + "&rec=" + rec);
        } catch (Exception e) {
            return null;
        }
    }

}
