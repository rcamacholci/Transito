package modelo;
/* @author EOA */
import java.sql.*;
public class Perfil_Recurso {

private String CRNOMBRE;
      public void setCRNOMBRE(String CRNOMBRE) {
        this.CRNOMBRE = CRNOMBRE;
    }
    public String getCRNOMBRE() {
        return CRNOMBRE;
    }
    public static Perfil_Recurso load(ResultSet rs)throws SQLException{
        Perfil_Recurso perfil_recurso= new Perfil_Recurso();
        perfil_recurso.setCRNOMBRE(rs.getString(1)) ;

        return perfil_recurso;
    }

}
