/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

/**
 *
 * @author Civitrans
 */
public class Cursos_cia{

    private Model model;
    private long id_curso;
    private String nombre,telefono,direccion,email,clase,nit,codigo,nombre_corto;

    public String getClase() {
        return clase;
    }

    public void setClase(String clase) {
        this.clase = clase;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public long getId_curso() {
        return id_curso;
    }

    public void setId_curso(long id_curso) {
        this.id_curso = id_curso;
    }

    public String getNit() {
        return nit;
    }

    public void setNit(String nit) {
        this.nit = nit;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getNombre_corto() {
        return nombre_corto;
    }

    public void setNombre_corto(String nombre_corto) {
        this.nombre_corto = nombre_corto;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public Model getModel() {
        return model;
    }

    public void setModel(Model model) {
        this.model = model;
    }

    public static Cursos_cia load(java.sql.ResultSet rs)throws Exception{
        Cursos_cia organismo = new Cursos_cia();
        organismo.setId_curso(rs.getLong(1));
        organismo.setNombre(rs.getString(2));
        organismo.setTelefono(rs.getString(3));
        organismo.setDireccion(rs.getString(4));
        organismo.setEmail(rs.getString(5));
        organismo.setClase(rs.getString(6));
        organismo.setNit(rs.getString(7));
        organismo.setCodigo(rs.getString(8));
        organismo.setNombre_corto(rs.getString(9));
        return organismo;
    }
}

