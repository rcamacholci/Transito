/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;
import java.sql.* ;
import java.io.* ;

/**
 *
 * @author Project
 */
public class DatosVehiculo implements Serializable{
    
    private long id_datoVehiculo ;
    private long fk_vehiculo ;
    private int grupo_codigo ;
    private int param_codigo ;
    private String valor  ;
    private Date fecha_ini ;
    private Date fecha_fin ;
    private Date fecha_sistema ;
    private long fk_usuario ;
    private int sub_grupo_codigo ;

    public long getId_datoVehiculo() {
        return id_datoVehiculo;
    }

    public void setId_datoVehiculo(long id_datoVehiculo) {
        this.id_datoVehiculo = id_datoVehiculo;
    }

    public long getFk_vehiculo() {
        return fk_vehiculo;
    }

    public void setFk_vehiculo(long fk_vehiculo) {
        this.fk_vehiculo = fk_vehiculo;
    }

    public int getGrupo_codigo() {
        return grupo_codigo;
    }

    public void setGrupo_codigo(int grupo_codigo) {
        this.grupo_codigo = grupo_codigo;
    }

    public int getParam_codigo() {
        return param_codigo;
    }

    public void setParam_codigo(int param_codigo) {
        this.param_codigo = param_codigo;
    }

    public String getValor() {
        return valor;
    }

    public void setValor(String valor) {
        this.valor = valor;
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

    public Date getFecha_sistema() {
        return fecha_sistema;
    }

    public void setFecha_sistema(Date fecha_sistema) {
        this.fecha_sistema = fecha_sistema;
    }

    public long getFk_usuario() {
        return fk_usuario;
    }

    public void setFk_usuario(long usuario) {
        this.fk_usuario = usuario;
    }

    public int getSub_grupo_codigo() {
        return sub_grupo_codigo;
    }

    public void setSub_grupo_codigo(int sub_grupo_codigo) {
        this.sub_grupo_codigo = sub_grupo_codigo;
    }
    
    protected static DatosVehiculo load(ResultSet rst)throws SQLException{
        
        DatosVehiculo datos = new DatosVehiculo() ;
        
        datos.setId_datoVehiculo(rst.getLong(1)) ;
        datos.setFk_vehiculo(rst.getLong(2)) ;
        datos.setGrupo_codigo(rst.getInt(3)) ;
        datos.setParam_codigo(rst.getInt(4)) ;
        datos.setValor(rst.getString(5)) ;
        datos.setFecha_ini(rst.getDate(6)) ;
        datos.setFecha_fin(rst.getDate(7)) ;
        datos.setFecha_sistema(rst.getDate(8));
        datos.setFk_usuario(rst.getLong(9)) ;
        datos.setSub_grupo_codigo(rst.getInt(10)) ;
         
        return datos ;
    }
    
    

}
