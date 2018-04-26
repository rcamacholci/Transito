package modelo;
import java.io.*;
import java.sql.*;

public class Detalle_Respuesta implements Serializable {

    private long ID_DETALLE, FK_RESPUESTA;
    private String REFERENCIA, RESPUESTA, VEHICULO, NOMBRE;
   

    public long getID_DETALLE() {
        return ID_DETALLE;
    }

    public void setID_DETALLE(long ID_DETALLE) {
        this.ID_DETALLE = ID_DETALLE;
    }
    
     public long getFK_RESPUESTA() {
        return FK_RESPUESTA;
    }

    public void setFK_RESPUESTA(long FK_RESPUESTA) {
        this.FK_RESPUESTA = FK_RESPUESTA;
    }

    public String getREFERENCIA() {
        return REFERENCIA;
    }

    public void setREFERENCIA(String REFERENCIA) {
        this.REFERENCIA = REFERENCIA;
    }
    
    public String getRESPUESTA() {
        return RESPUESTA;
    }

    public void setRESPUESTA(String RESPUESTA) {
        this.RESPUESTA = RESPUESTA;
    }
    
    public String getVEHICULO() {
        return VEHICULO;
    }

    public void setVEHICULO(String VEHICULO) {
        this.VEHICULO = VEHICULO;
    }

    public String getNOMBRE() {
        return NOMBRE;
    }

    public void setNOMBRE(String NOMBRE) {
        this.NOMBRE = NOMBRE;
    }
    
   public static Detalle_Respuesta load(java.sql.ResultSet rs)throws Exception{
        Detalle_Respuesta DetalleR = new Detalle_Respuesta();
        DetalleR.setID_DETALLE(rs.getLong(1));
        DetalleR.setFK_RESPUESTA(rs.getLong(2));
        DetalleR.setREFERENCIA(rs.getString(3));
        DetalleR.setRESPUESTA(rs.getString(4));
        DetalleR.setVEHICULO(rs.getString(5));
        DetalleR.setNOMBRE(rs.getString(6));
        return DetalleR;
    }


}
