package modelo;
/**
 * @author EderOrtegaAchury
 */
import java.sql.*;
public class HIS_PAS_USUARIO {
private long CONSECUTIVO, FK_ID_USUARIO;
private String PASSWORD1;
private Date FECHA;

public long getCONSECUTIVO() {
    return CONSECUTIVO;
}
public void setCONSECUTIVO(long CONSECUTIVO) {
    this.CONSECUTIVO = CONSECUTIVO;
}

public long getFK_ID_USUARIO() {
    return FK_ID_USUARIO;
}
public void setFK_ID_USUARIO(long FK_ID_USUARIO) {
    this.FK_ID_USUARIO = FK_ID_USUARIO;
}

public String getPASSWORD1() {
    return PASSWORD1;
}
public void setPASSWORD1(String PASSWORD1) {
    this.PASSWORD1 = PASSWORD1;
}

public Date getFECHA() {
        return FECHA;
}
public void setFECHA(Date FECHA) {
        this.FECHA = FECHA;
}

 public static HIS_PAS_USUARIO load(ResultSet rs)throws SQLException{
        HIS_PAS_USUARIO his_pas_usuario= new HIS_PAS_USUARIO();
        his_pas_usuario.setCONSECUTIVO(rs.getLong(1));
        his_pas_usuario.setFK_ID_USUARIO(rs.getLong(2));
        his_pas_usuario.setPASSWORD1(rs.getString(3));
        his_pas_usuario.setFECHA(rs.getDate(4));
        return his_pas_usuario;
    }
}
