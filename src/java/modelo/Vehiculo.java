/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;
import java.util.* ;
import java.sql.* ;
import java.io.*; 
import java.sql.Date ;

/**
 *
 * @author Project
 */
public class Vehiculo implements Serializable {
    
    private long id_vehiculo ;
    private String placa ;
    private long fk_sede ;
    private long modelo ;
    private long clase_vehiculo ;
    private long servicio ;
    private Date fecha_matricula ;
    private long fk_linea ;
    private long fk_divipo ;
    private long tipo_importacion ;
    private String documento_importacion ;
    private long usuario;
    private Date fecha_importacion ;
    private long estado ;
    private long tipo_doc_importacion ;
    private long fk_marca;

    

    public long getId_vehiculo() {
        return id_vehiculo;
    }

    public void setId_vehiculo(long id_vehiculo) {
        this.id_vehiculo = id_vehiculo;
    }

    public String getPlaca() {
        return placa;
    }

    public void setPlaca(String placa) {
        this.placa = placa;
    }

    public long getFk_sede() {
        return fk_sede;
    }

    public void setFk_sede(long fk_sede) {
        this.fk_sede = fk_sede;
    }

    public long getModelo() {
        return modelo;
    }

    public void setModelo(long modelo) {
        this.modelo = modelo;
    }

    public long getClase_vehiculo() {
        return clase_vehiculo;
    }

    public void setClase_vehiculo(long clase_vehiculo) {
        this.clase_vehiculo = clase_vehiculo;
    }

    public long getServicio() {
        return servicio;
    }

    public void setServicio(long servicio) {
        this.servicio = servicio;
    }

    public Date getFecha_matricula() {
        return fecha_matricula;
    }

    public void setFecha_matricula(Date fecha_matricula) {
        this.fecha_matricula = fecha_matricula;
    }

    public long getFk_linea() {
        return fk_linea;
    }

    public void setFk_linea(long fk_linea) {
        this.fk_linea = fk_linea;
    }

    public long getFk_divipo() {
        return fk_divipo;
    }

    public void setFk_divipo(long fk_divipo) {
        this.fk_divipo = fk_divipo;
    }

    public long getTipo_importacion() {
        return tipo_importacion;
    }

    public void setTipo_importacion(long tipo_importacion) {
        this.tipo_importacion = tipo_importacion;
    }

    public String getDocumento_importacion() {
        return documento_importacion;
    }

    public void setDocumento_importacion(String documento_importacion) {
        this.documento_importacion = documento_importacion;
    }

    public long getUsuario() {
        return usuario;
    }

    public void setUsuario(long usuario) {
        this.usuario = usuario;
    }

    public Date getFecha_importacion() {
        return fecha_importacion;
    }

    public void setFecha_importacion(Date fecha_importacion) {
        this.fecha_importacion = fecha_importacion;
    }

    public long getEstado() {
        return estado;
    }

    public void setEstado(long estado) {
        this.estado = estado;
    }

    public long getTipo_doc_importacion() {
        return tipo_doc_importacion;
    }

    public void setTipo_doc_importacion(long tipo_doc_importacion) {
        this.tipo_doc_importacion = tipo_doc_importacion;
    }
    
    public long getFk_marca() {
        return fk_marca;
    }

    public void setFk_marca(long fk_marca) {
        this.fk_marca = fk_marca;
    }

    protected static Vehiculo load(ResultSet rst)throws SQLException{
        
        Vehiculo v = new Vehiculo() ;
        
        v.setId_vehiculo(rst.getLong(1)) ;
        v.setPlaca(rst.getString(2)) ;
        v.setFk_sede(rst.getLong(3)) ;
        v.setModelo(rst.getLong(4)) ;
        v.setClase_vehiculo(rst.getLong(5)) ;
        v.setServicio(rst.getLong(6)) ;
        v.setFecha_matricula(rst.getDate(7)) ;
        v.setFk_linea(rst.getLong(8)) ;
        v.setFk_divipo(rst.getLong(9)) ;
        v.setTipo_importacion(rst.getLong(10)) ;
        v.setDocumento_importacion(rst.getString(11)) ;
        v.setUsuario(rst.getLong(12)) ;
        v.setFecha_importacion(rst.getDate(13)) ;
        v.setEstado(rst.getLong(14)) ;
        v.setTipo_doc_importacion(rst.getLong(15)) ;
        v.setFk_marca(rst.getLong(17));
        
        return v ;
        
    }
}
