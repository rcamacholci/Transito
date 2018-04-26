package modelo;

import java.sql.ResultSet;
import java.sql.Timestamp;
import java.sql.SQLException;

/**
 *
 * @author Administrador
 */
public class Auditoria {

    private long id_auditoria;
    private String fk_usuario;
    private String ip;
    private String tabla;
    private long registro;
    private String accion;
    private Timestamp fecha;
    private int flag;
    private long vehiculo;

    public String getAccion() {
        return accion;
    }

    public void setAccion(String accion) {
        this.accion = accion;
    }

    public Timestamp getFecha() {
        return fecha;
    }

    public void setFecha(Timestamp fecha) {
        this.fecha = fecha;
    }

    public String getFk_usuario() {
        return fk_usuario;
    }

    public void setFk_usuario(String fk_usuario) {
        this.fk_usuario = fk_usuario;
    }

    public int getFlag() {
        return flag;
    }

    public void setFlag(int flag) {
        this.flag = flag;
    }

    public long getId_auditoria() {
        return id_auditoria;
    }

    public void setId_auditoria(long id_auditoria) {
        this.id_auditoria = id_auditoria;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public long getRegistro() {
        return registro;
    }

    public void setRegistro(long registro) {
        this.registro = registro;
    }

    public String getTabla() {
        return tabla;
    }

    public void setTabla(String tabla) {
        this.tabla = tabla;
    }

    public long getVehiculo() {
        return vehiculo;
    }

    public void setVehiculo(long vehiculo) {
        this.vehiculo = vehiculo;
    }

    public static Auditoria load(ResultSet rs) throws SQLException{

        Auditoria auditoria = new Auditoria();
        auditoria.setId_auditoria(rs.getLong(1));
        auditoria.setFk_usuario(rs.getString(2));
        auditoria.setIp(rs.getString(3));
        auditoria.setTabla(rs.getString(4));
        auditoria.setRegistro(rs.getLong(5));
        auditoria.setAccion(rs.getString(6));
        auditoria.setFecha(rs.getTimestamp(7));
        auditoria.setFlag(rs.getInt(8));
        auditoria.setVehiculo(rs.getLong(9));
        return auditoria;
        
    }
}
