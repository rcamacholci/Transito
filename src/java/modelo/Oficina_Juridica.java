/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

/**
 *
 * @author Flia. Aguas Macias
 */
public class Oficina_Juridica {
    private long id_oficina,fk_sede,fk_divipo;
    private String nombre,numero;
    private String representante,cargo,direccion;

    public long getFk_sede() {
        return fk_sede;
    }

    public void setFk_sede(long fk_sede) {
        this.fk_sede = fk_sede;
    }

    public long getId_oficina() {
        return id_oficina;
    }

    public void setId_oficina(long id_oficina) {
        this.id_oficina = id_oficina;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public String getCargo() {
        return cargo;
    }

    public void setCargo(String cargo) {
        this.cargo = cargo;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public long getFk_divipo() {
        return fk_divipo;
    }

    public void setFk_divipo(long fk_divipo) {
        this.fk_divipo = fk_divipo;
    }

    public String getRepresentante() {
        return representante;
    }

    public void setRepresentante(String representante) {
        this.representante = representante;
    }
    
    public static Oficina_Juridica load(java.sql.ResultSet rs)throws java.sql.SQLException{
        Oficina_Juridica oficina_juridica = new Oficina_Juridica();
        oficina_juridica.setId_oficina(rs.getLong(1));
        oficina_juridica.setNombre(rs.getString(2));
        oficina_juridica.setNumero(rs.getString(3));
        oficina_juridica.setFk_sede(rs.getLong(4));
        oficina_juridica.setRepresentante(rs.getString(5));
        oficina_juridica.setCargo(rs.getString(6));
        oficina_juridica.setDireccion(rs.getString(7));
        oficina_juridica.setFk_divipo(rs.getLong(8));
        return oficina_juridica;
    }
}
