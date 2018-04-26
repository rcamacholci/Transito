/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

/**
 *
 * @author Civitrans
 */
public class Concepto {
    private long id_concepto;
    private String nombre;
    private String descripcion;
    private int tipo;
    private int clase;
    private int prioridad;

    public int getClase() {
        return clase;
    }

    public void setClase(int clase) {
        this.clase = clase;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public long getId_concepto() {
        return id_concepto;
    }

    public void setId_concepto(long id_concepto) {
        this.id_concepto = id_concepto;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getPrioridad() {
        return prioridad;
    }

    public void setPrioridad(int prioridad) {
        this.prioridad = prioridad;
    }

    public int getTipo() {
        return tipo;
    }

    public void setTipo(int tipo) {
        this.tipo = tipo;
    }
    
    public static Concepto load(java.sql.ResultSet rs)throws java.sql.SQLException{
        Concepto concepto = new Concepto();
        concepto.setId_concepto(rs.getLong(1));
        concepto.setNombre(rs.getString(2));
        concepto.setDescripcion(rs.getString(3));
        concepto.setTipo(rs.getInt(4));
        concepto.setClase(rs.getInt(5));
        concepto.setPrioridad(rs.getInt(6));
        return concepto;
    }
}
