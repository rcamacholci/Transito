/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

/**
 *
 * @author Sistemas
 */

import java.io.*;
import java.sql.*;
public class FacturaDomiciliaria {

      
    private String  factura, organismo, placa, nombre_propietario, direccion, telefono, celular, motor, chasis, serial , marca, linea, clase, servicio, ciudad_envio, periodo_de_pago, fecha_expedicion, fecha_lim_periodo_pago ;
    private long  saldo_actual, obligaciones_vencidas, comparendos, saldos_a_favor, saldos_en_contra, total_a_cancelar;
    private int  modelo ;
    
    public String getfactura() {
        return factura;
    }

    public void setfactura(String factura) {
        this.factura = factura;
    }

    public String getorganismo() {
        return organismo;
    }

    public void setorganismo(String organismo) {
        this.organismo  = organismo;
    }

    public String getplaca() {
        return placa;
    }

    public void setplaca(String placa) {
        this.placa = placa;
    }

     public String getnombre_propietario() {
        return nombre_propietario;
    }

    public void setnombre_propietario(String nombre_propietario) {
        this.nombre_propietario = nombre_propietario;
    }

        public String getdireccion() {
        return direccion;
    }

    public void setdireccion(String direccion) {
        this.direccion = direccion;
    }

       public String gettelefono() {
        return telefono;
    }

    public void settelefono(String telefono) {
        this.telefono = telefono;
    }

       public String getcelular() {
        return celular;
    }

    public void setcelular(String celular) {
        this.celular = celular;
    }

       public String getmotor() {
        return motor;
    }

    public void setmotor(String motor) {
        this.motor  = motor;
    }

        public String getchasis() {
        return chasis;
    }

    public void setchasis(String chasis) {
        this.chasis  = chasis;
    }

        public String getserial() {
        return serial;
    }

    public void setserial(String serial) {
        this.serial  = serial;
    }

        public String getmarca() {
        return marca;
    }

    public void setmarca(String marca) {
        this.marca  = marca;
    }

      public String getlinea() {
        return linea;
    }

    public void setlinea(String linea) {
        this.linea  = linea;
    }

        public String getclase() {
        return clase;
    }

    public void setclase(String clase) {
        this.clase  = clase;
    }

        public String getservicio() {
        return servicio;
    }

    public void setservicio(String servicio) {
        this.servicio  = servicio;
    }

       public int getmodelo() {
        return modelo;
    }

    public void setmodelo(int modelo) {
        this.modelo  = modelo;
    }

    public String getfecha_expedicion() {
        return fecha_expedicion;
    }

    public void setfecha_expedicion(String fecha_expedicion) {
        this.fecha_expedicion  = fecha_expedicion;
    }

        public long getsaldo_actual() {
        return saldo_actual;
    }

    public void setsaldo_actual(long saldo_actual) {
        this.saldo_actual  = saldo_actual;
    }

   public String getfecha_lim_periodo_pago() {
        return fecha_lim_periodo_pago;
    }

    public void setfecha_lim_periodo_pago(String fecha_lim_periodo_pago) {
        this.fecha_lim_periodo_pago  = fecha_lim_periodo_pago;
    }

    public long getobligaciones_vencidas() {
        return obligaciones_vencidas;
    }

    public void setobligaciones_vencidas(long obligaciones_vencidas) {
        this.obligaciones_vencidas  = obligaciones_vencidas;
    }

     public long getcomparendos() {
        return comparendos;
    }

    public void setcomparendos(long comparendos) {
        this.comparendos  = comparendos;
    }

      public long getsaldos_a_favor() {
        return saldos_a_favor;
    }

    public void setsaldos_a_favor(long saldos_a_favor) {
        this.saldos_a_favor  = saldos_a_favor;
    }

     public long getsaldos_en_contra() {
        return saldos_en_contra;
    }

    public void setsaldos_en_contra(long saldos_en_contra) {
        this.saldos_en_contra  = saldos_en_contra;
    }

    public long gettotal_a_cancelar() {
        return total_a_cancelar;
    }

    public void settotal_a_cancelar(long total_a_cancelar) {
        this.total_a_cancelar  = total_a_cancelar;
    }
    
    public String getciudad_envio() {
        return ciudad_envio;
    }

    public void setciudad_envio(String ciudad_envio) {
        this.ciudad_envio  = ciudad_envio;
    }

       public String getperiodo_de_pago() {
        return periodo_de_pago;
    }

    public void setperiodo_de_pago(String periodo_de_pago) {
        this.periodo_de_pago  = periodo_de_pago;
    }


    public static FacturaDomiciliaria load(ResultSet rs)throws SQLException{
        
        FacturaDomiciliaria facturaDomiciliaria= new FacturaDomiciliaria();
        
        facturaDomiciliaria.setfactura(rs.getString(1));
        facturaDomiciliaria.setorganismo(rs.getString(2));
        facturaDomiciliaria.setplaca(rs.getString(3));
        facturaDomiciliaria.setnombre_propietario(rs.getString(4));
        facturaDomiciliaria.setdireccion(rs.getString(5));
        facturaDomiciliaria.settelefono(rs.getString(6));
        facturaDomiciliaria.setcelular(rs.getString(7));
        facturaDomiciliaria.setmotor(rs.getString(8));
        facturaDomiciliaria.setchasis(rs.getString(9));
        facturaDomiciliaria.setserial(rs.getString(10));
        facturaDomiciliaria.setmarca(rs.getString(11));
        facturaDomiciliaria.setlinea(rs.getString(12));
        facturaDomiciliaria.setclase(rs.getString(13));
        facturaDomiciliaria.setservicio(rs.getString(14));
        facturaDomiciliaria.setmodelo(rs.getInt(15));
        facturaDomiciliaria.setfecha_expedicion(rs.getString(16));
        facturaDomiciliaria.setsaldo_actual(rs.getLong(17));
        facturaDomiciliaria.setfecha_lim_periodo_pago(rs.getString(18));
        facturaDomiciliaria.setobligaciones_vencidas(rs.getLong(19));
        facturaDomiciliaria.setcomparendos(rs.getLong(20));
        facturaDomiciliaria.setsaldos_a_favor(rs.getLong(21));
        facturaDomiciliaria.setsaldos_en_contra(rs.getLong(22));
        facturaDomiciliaria.settotal_a_cancelar(rs.getLong(23));
        facturaDomiciliaria.setciudad_envio(rs.getString(24));
        facturaDomiciliaria.setperiodo_de_pago(rs.getString(25));

        return facturaDomiciliaria;
    
    }

}
