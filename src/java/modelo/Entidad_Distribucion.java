package modelo ;
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Civitrans
 */
import java.io.* ;
import java.sql.* ;

public class Entidad_Distribucion implements Serializable{
    
    private long id_entidad_distribucion ;
    private long fk_banco ;
    private long fk_persona ;
    private String cuenta ;
    private int defecto ;

    public long getId_entidad_distribucion() {
        return id_entidad_distribucion;
    }

    public void setId_entidad_distribucion(long id_entidad_distribucion) {
        this.id_entidad_distribucion = id_entidad_distribucion;
    }

   

    public long getFk_banco() {
        return fk_banco;
    }

    public void setFk_banco(long fk_banco) {
        this.fk_banco = fk_banco;
    }

    public long getFk_persona() {
        return fk_persona;
    }

    public void setFk_persona(long fk_persona) {
        this.fk_persona = fk_persona;
    }
     public String getCuenta() {
        return cuenta;
    }

    public void setCuenta(String cuenta) {
        this.cuenta = cuenta;
    }
     public int getDefecto() {
        return defecto;
    }

    public void setDefecto(int defecto) {
        this.defecto = defecto;
    }
    
    protected static Entidad_Distribucion load(ResultSet rst)throws SQLException{
        Entidad_Distribucion entidad_distribucion = new Entidad_Distribucion() ; 
        entidad_distribucion.setId_entidad_distribucion(rst.getLong(1)) ;
        entidad_distribucion.setFk_persona(rst.getLong(2)) ;
        entidad_distribucion.setFk_banco(rst.getLong(3)) ;
        entidad_distribucion.setDefecto(rst.getInt(4)) ;
        entidad_distribucion.setCuenta(rst.getString(5 ));
        return entidad_distribucion ;
    }
}

 