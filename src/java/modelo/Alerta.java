/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;
import java.sql.* ;
/**
 *
 * @author Project
 */
public class Alerta {
    
    private long id_alerta ;
    private long fk_persona;
    private long fk_vehiculo ;
    private int tipo ;
    private Date fecha_ini ;
    private Date fecha_fin ;
    private String observaciones ;
    private long usuario ;
    private int grado;

    public int getGrado() {
        return grado;
    }

    public void setGrado(int grado) {
        this.grado = grado;
    }

    public long getId_alerta() {
        return id_alerta;
    }

    public void setId_alerta(long id_alerta) {
        this.id_alerta = id_alerta;
    }

    public long getFk_persona() {
        return fk_persona;
    }

    public void setFk_persona(long fk_persona) {
        this.fk_persona = fk_persona;
    }

    public long getFk_vehiculo() {
        return fk_vehiculo;
    }

    public void setFk_vehiculo(long fk_vehiculo) {
        this.fk_vehiculo = fk_vehiculo;
    }

    public int getTipo() {
        return tipo;
    }

    public void setTipo(int tipo) {
        this.tipo = tipo;
    }

    public Date getFecha_ini() {
        return fecha_ini;
    }

    public void setFecha_ini(Date fecha_ini) {
        this.fecha_ini = fecha_ini;
    }

    public Date getFecha_fin() {
        return fecha_fin;
    }

    public void setFecha_fin(Date fecha_fin) {
        this.fecha_fin = fecha_fin;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public long getUsuario() {
        return usuario;
    }

    public void setUsuario(long usuario) {
        this.usuario = usuario;
    }
    
    protected static Alerta load(ResultSet rst)throws SQLException{
        Alerta alerta = new Alerta() ;
        alerta.setId_alerta(rst.getLong(1)); 
        alerta.setFk_persona(rst.getLong(2));
        alerta.setFk_vehiculo(rst.getLong(3));
        alerta.setTipo(rst.getInt(4));
        alerta.setFecha_ini(rst.getDate(5));
        alerta.setFecha_fin(rst.getDate(6));
        alerta.setObservaciones(rst.getString(7));
        alerta.setUsuario(rst.getLong(8)) ;
        alerta.setGrado(rst.getInt(9));
        return alerta ;
    }

}
