/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package inscripcion;

/**
 * @(#)Inscripcion.java
 *
 *
 * @author
 * @version 1.00 2010/12/29
 */

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Inscripcion implements java.io.Serializable {

	  private static final long serialVersionUID = 8799656478674716638L;

	  public long id_inscripcion,fk_divipo,fk_lugar_nacimiento;
	  public Date  fecha_nac,fecha_exp;
	  public String grupo_sanguineo,rh,sexo;
	  public String nombre_1,nombre_2,apellido_1,apellido_2;
	  public int tipo_documento;
	  public String  documento,email,celular;
	  public java.sql.Timestamp fecha_reg;
	  public int ubicacion,estado;
  	  public String descripcion,telefono,fax;
  	  public long fk_divipo_direccion;
  	  public Date fecha;
  	  public byte[] bidimensional;
      public byte[] firma;
      public byte[] foto;
      public int dedo1;
      public int dedo2;
      public byte[] huella1;
      public byte[] huella2;
      public byte[] template;
      public int motivoRechazo;

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

    public long getId_inscripcion() {
        return id_inscripcion;
    }

    public void setId_inscripcion(long id_inscripcion) {
        this.id_inscripcion = id_inscripcion;
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

    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }


    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public long getFk_divipo_direccion() {
        return fk_divipo_direccion;
    }

    public void setFk_divipo_direccion(long fk_divipo_direccion) {
        this.fk_divipo_direccion = fk_divipo_direccion;
    }

	public int getUbicacion() {
        return ubicacion;
    }

    public void setUbicacion(int ubicacion) {
        this.ubicacion = ubicacion;
    }

    public byte[] getBidimensional() {
        return bidimensional;
    }

    public void setBidimensional(byte[] bidimensional) {
        this.bidimensional = bidimensional;
    }

    public int getDedo1() {
        return dedo1;
    }

    public void setDedo1(int dedo1) {
        this.dedo1 = dedo1;
    }

    public int getDedo2() {
        return dedo2;
    }

    public void setDedo2(int dedo2) {
        this.dedo2 = dedo2;
    }

    public byte[] getFirma() {
        return firma;
    }

    public void setFirma(byte[] firma) {
        this.firma = firma;
    }

    public byte[] getFoto() {
        return foto;
    }

    public void setFoto(byte[] foto) {
        this.foto = foto;
    }

    public byte[] getHuella1() {
        return huella1;
    }

    public void setHuella1(byte[] huella1) {
        this.huella1 = huella1;
    }

    public byte[] getHuella2() {
        return huella2;
    }

    public void setHuella2(byte[] huella2) {
        this.huella2 = huella2;
    }

    public int getMotivoRechazo() {
        return motivoRechazo;
    }

    public void setMotivoRechazo(int motivoRechazo) {
        this.motivoRechazo = motivoRechazo;
    }

    public byte[] getTemplate() {
        return template;
    }

    public void setTemplate(byte[] template) {
        this.template = template;
    }

  public static Inscripcion load(ResultSet rs)throws SQLException{
           Inscripcion inscripcion =new Inscripcion();
          /* inscripcion.setId_inscripcion(rs.getLong(1));
           inscripcion.setFecha_nac(rs.getDate(2));
           inscripcion.setGrupo_sanguineo(rs.getString(3));
           inscripcion.setRh(rs.getString(4));
           inscripcion.setSexo(rs.getString(5));
           inscripcion.setNombre_1(rs.getString(6));
           inscripcion.setNombre_2(rs.getString(7));
           inscripcion.setApellido_1(rs.getString(8));
           inscripcion.setApellido_2(rs.getString(9));
           inscripcion.setTipo_documento(rs.getInt(10));
           inscripcion.setDocumento(rs.getString(11));
           inscripcion.setFk_divipo(rs.getLong(12));
           inscripcion.setEmail(rs.getString(13));
           inscripcion.setCelular(rs.getString(14));
           inscripcion.setFk_lugar_nacimiento(rs.getLong(15));
           inscripcion.setFecha_exp(rs.getDate(16));
           inscripcion.setFecha_reg(rs.getTimestamp(26));
           inscripcion.setDescripcion(rs.getString(2));
	       inscripcion.setUbicacion(rs.getInt(3));
	       inscripcion.setFecha(rs.getDate(4));
	       inscripcion.setEstado(rs.getInt(5));
	       inscripcion.setFk_divipo_direccion(rs.getLong(7));
	       inscripcion.setTelefono(rs.getString(8));
	       inscripcion.setBidimensional(consultarBiometricoTipoByte(id_persona,"BIDIMENSIONAL"));
    	   inscripcion.setFirma(consultarBiometricoTipoByte(id_persona,"FIRMA"));
    	   inscripcion.setFoto(consultarBiometricoTipoByte(id_persona,"FOTO"));
    	   inscripcion.setDedo1(rst.getInt(1));
    	   inscripcion.setDedo2(rst.getInt(2));
           inscripcion.setHuella1(consultarBiometricoTipoByte(id_persona,"HUELLA1"));
	       inscripcion.setHuella2(consultarBiometricoTipoByte(id_persona,"HUELLA2"));
           inscripcion.setTemplate(consultarBiometricoTipoByte(id_persona,"TEMPLATE"));
    	   inscripcion.setMotivoRechazo(rst.getInt(3));*/
           return inscripcion;
   }


}