/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

/**
 *
 * @author Civitrans
 */
import java.io.*;
import java.sql.*;

public class Persona implements Serializable {

  private long id_persona,fk_divipo,fk_lugar_nacimiento;
  private Date  fecha_nac,fecha_exp;
  private String grupo_sanguineo,rh,sexo;
  private String nombre_1,nombre_2,apellido_1,apellido_2;
  private int tipo_documento;
  private String  documento,email,celular;
  private java.sql.Timestamp fecha_reg;

    public Date getFecha_exp() {
        return fecha_exp;
    }

    public void setFecha_exp(Date fecha_exp) {
        this.fecha_exp = fecha_exp;
    }

    public long getFk_lugar_nacimiento() {
        return fk_lugar_nacimiento;
    }

    public void setFk_lugar_nacimiento(long fk_lugar_nacimiento) {
        this.fk_lugar_nacimiento = fk_lugar_nacimiento;
    }

    public String getApellido_1() {
        return apellido_1;
    }

    public void setApellido_1(String apellido_1) {
        this.apellido_1 = apellido_1;
    }

    public String getApellido_2() {
        return apellido_2;
    }

    public void setApellido_2(String apellido_2) {
        this.apellido_2 = apellido_2;
    }

    public String getCelular() {
        return celular;
    }

    public void setCelular(String celular) {
        this.celular = celular;
    }

    public String getDocumento() {
        return documento;
    }

    public void setDocumento(String documento) {
        this.documento = documento;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getFecha_nac() {
        return fecha_nac;
    }

    public void setFecha_nac(Date fecha_nac) {
        this.fecha_nac = fecha_nac;
    }

    public long getFk_divipo() {
        return fk_divipo;
    }

    public void setFk_divipo(long fk_divipo) {
        this.fk_divipo = fk_divipo;
    }

    public String getGrupo_sanguineo() {
        return grupo_sanguineo;
    }

    public void setGrupo_sanguineo(String grupo_sanguineo) {
        this.grupo_sanguineo = grupo_sanguineo;
    }

    public long getId_persona() {
        return id_persona;
    }

    public void setId_persona(long id_persona) {
        this.id_persona = id_persona;
    }

    public String getNombre_1() {
        return nombre_1;
    }

    public void setNombre_1(String nombre_1) {
        this.nombre_1 = nombre_1;
    }

    public String getNombre_2() {
        return nombre_2;
    }

    public void setNombre_2(String nombre_2) {
        this.nombre_2 = nombre_2;
    }

    public String getRh() {
        return rh;
    }

    public void setRh(String rh) {
        this.rh = rh;
    }

    public String getSexo() {
        return sexo;
    }

    public void setSexo(String sexo) {
        this.sexo = sexo;
    }

    public int getTipo_documento() {
        return tipo_documento;
    }

    public void setTipo_documento(int tipo_documento) {
        this.tipo_documento = tipo_documento;
    }

    public java.sql.Timestamp getFecha_reg() {
        return fecha_reg;
    }

    public void setFecha_reg(java.sql.Timestamp fecha_reg) {
        this.fecha_reg = fecha_reg;
    }
 
  public static Persona load(ResultSet rs)throws SQLException{
           Persona persona =new Persona();
           persona.setId_persona(rs.getLong(1));
           persona.setFecha_nac(rs.getDate(2));
           persona.setGrupo_sanguineo(rs.getString(3));
           persona.setRh(rs.getString(4));
           persona.setSexo(rs.getString(5));
           persona.setNombre_1(rs.getString(6));       
           persona.setNombre_2(rs.getString(7));
           persona.setApellido_1(rs.getString(8));
           persona.setApellido_2(rs.getString(9));
           persona.setTipo_documento(rs.getInt(10));
           persona.setDocumento(rs.getString(11));
           persona.setFk_divipo(rs.getLong(12));
           persona.setEmail(rs.getString(13));
           persona.setCelular(rs.getString(14));
           persona.setFk_lugar_nacimiento(rs.getLong(15));
           persona.setFecha_exp(rs.getDate(16));
           persona.setFecha_reg(rs.getTimestamp(26));
           return persona;
   }

}
