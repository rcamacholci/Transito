package modelo;
/**
 * @author EderOrtegaAchury
 */
import java.sql.*;
public class HUsuario {
private long fk_id_usuario, flag;
private String password1, password2, password3;
private Date fecha;

public long getFKId_usuario() {
    return fk_id_usuario;
}

public void setFKId_usuario(long fk_id_usuario) {
    this.fk_id_usuario = fk_id_usuario;
}

public String getPassword1() {
    return password1;
}

public void setPassword1(String password1) {
    this.password1 = password1;
}

public String getPassword2() {
    return password2;
}

public void setPassword2(String password2) {
    this.password2 = password2;
}

public String getPassword3() {
    return password3;
}

public void setPassword3(String password3) {
    this.password3 = password3;
}

public long getFlag() {
    return flag;
}

public void setFlag(long flag) {
    this.flag = flag;
}

public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }
 public static HUsuario load(ResultSet rs)throws SQLException{
        HUsuario husuario= new HUsuario();
        husuario.setFKId_usuario(rs.getLong(1));
        husuario.setPassword1(rs.getString(2));
        husuario.setPassword2(rs.getString(3));
        husuario.setPassword3(rs.getString(4));
        husuario.setFlag(rs.getLong(5));
        husuario.setFecha(rs.getDate(6));

        return husuario;
    }
}
