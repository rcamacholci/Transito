/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Jefrey
 */
public class Linea_maquinaria {
    
    private long codigo_linea, codigo_marca;
    private String descripcion;

    public long getCodigo_linea() {
        return codigo_linea;
    }

    public void setCodigo_linea(long codigo_linea) {
        this.codigo_linea = codigo_linea;
    }

    public long getCodigo_marca() {
        return codigo_marca;
    }

    public void setCodigo_marca(long codigo_marca) {
        this.codigo_marca = codigo_marca;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    
    protected static Linea_maquinaria load (ResultSet rst)throws SQLException{
        
        Linea_maquinaria m = new Linea_maquinaria() ;
        
        m.setCodigo_linea(rst.getLong(1)) ;
        m.setCodigo_marca(rst.getLong(2)) ;
        m.setDescripcion(rst.getString(3)) ;
        
        return m ;
         
    }
    
}
