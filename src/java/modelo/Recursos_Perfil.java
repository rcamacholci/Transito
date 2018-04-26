package modelo;
/* @author EOA */
import java.sql.*;
public class Recursos_Perfil {

private String CRNOMBRE;
      public void setRPNOMBRE(String CRNOMBRE) {
        this.CRNOMBRE = CRNOMBRE;
    }
    public String getRPNOMBRE() {
        return CRNOMBRE;
    }
    public static Recursos_Perfil load(ResultSet rs)throws SQLException{
        Recursos_Perfil recuro_perfil= new Recursos_Perfil();
        recuro_perfil.setRPNOMBRE(rs.getString(1)) ;

        return recuro_perfil;
    }

}
