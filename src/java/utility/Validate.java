/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package utility;
import modelo.Usuario;
import modelo.Model;

/**
 *
 * @author Administrador
 */
public class Validate {

    public Usuario usuario = null;
    public Model model = null;
    public boolean answer = false;
    public String dirOut = "";
    
    public Validate(javax.servlet.http.HttpSession session,javax.servlet.http.HttpServletRequest request){
        String page = request.getServletPath();
        for(int i=1;i<page.length();i++)
            if(page.charAt(i)=='/')
                dirOut += "../";
        if(session.getAttribute("model")!=null){
            if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(page)){
                model = (Model)session.getAttribute("model");
                usuario = (Usuario)session.getAttribute("usuario");
                answer = true;
            }else{
                answer = false;
                dirOut += "no_access.jsp";
            }
        }else{
            answer = false;
            dirOut += "index.jsp";
        }
    }



}
