/*
 *Tochangethistemplate,chooseTools|Templates
 *andopenthetemplateintheeditor.
 */
package modelo;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 *@authordell
 */
public class VehiculoRunt {

    private String placa;
    private String clase;
    private String cilindraje;
    private String marca;
    private String modelo;
    private String tipo_servicio;
    private String tipo_vehiculo;
    private String antiguo_clasico;
    private String capacidad_carga;
    private String color;
    private String declaracion_simplificada;
    private String enseñanza;
    private String importado;
    private String es_reposicion;
    private String blindado;
    private String repotenciado;
    private String estado;
    private String grupo;
    private String id_carroceria;
    private String linea;
    private String marca_automotor_migrado;
    private String modalidad_servicio;
    private String motivo_cancelacion;
    private String nivel_blindaje;
    private String nivel_servicio;
    private String numero_acta;
    private String numero_ficha_tecnica;
    private String numero_licencia_vigente;
    private String numero_plaqueta;
    private String numero_puertas;
    private String numero_regrabacion_chasis;
    private String numero_regrabacion_motor;
    private String numero_regrabacion_serie;
    private String origen_registro;
    private String pais_origen;
    private String peso_bruto;
    private String potencia;
    private String regrabacion_plaqueta;
    private String tipo_acta_importacion_remate;
    private String tipo_motor;
    private String ano_fabricacion;
    private String capacidad_pasajeros;
    private String numero_ejes;
    private String fecha_cancelacion;
    private String fecha_declaracion;
    private String fecha_expedicion_licencia;
    private String fecha_registro;

    /**
     * @return the placa
     */
    public String getPlaca() {
        return placa;
    }

    /**
     * @return the clase
     */
    public String getClase() {
        return clase;
    }

    /**
     * @return the cilindraje
     */
    public String getCilindraje() {
        return cilindraje;
    }

    /**
     * @return the marca
     */
    public String getMarca() {
        return marca;
    }

    /**
     * @return the modelo
     */
    public String getModelo() {
        return modelo;
    }

    /**
     * @return the tipo_servicio
     */
    public String getTipo_servicio() {
        return tipo_servicio;
    }

    /**
     * @return the tipo_vehiculo
     */
    public String getTipo_vehiculo() {
        return tipo_vehiculo;
    }

    /**
     * @return the antiguo_clasico
     */
    public String getAntiguo_clasico() {
        return antiguo_clasico;
    }

    /**
     * @return the capacidad_carga
     */
    public String getCapacidad_carga() {
        return capacidad_carga;
    }

    /**
     * @return the color
     */
    public String getColor() {
        return color;
    }

    /**
     * @return the declaracion_simplificada
     */
    public String getDeclaracion_simplificada() {
        return declaracion_simplificada;
    }

    /**
     * @return the enseñanza
     */
    public String getEnseñanza() {
        return enseñanza;
    }

    /**
     * @return the importado
     */
    public String getImportado() {
        return importado;
    }

    /**
     * @return the es_reposicion
     */
    public String getEs_reposicion() {
        return es_reposicion;
    }

    /**
     * @return the blindado
     */
    public String getBlindado() {
        return blindado;
    }

    /**
     * @return the repotenciado
     */
    public String getRepotenciado() {
        return repotenciado;
    }

    /**
     * @return the estado
     */
    public String getEstado() {
        return estado;
    }

    /**
     * @return the grupo
     */
    public String getGrupo() {
        return grupo;
    }

    /**
     * @return the id_carroceria
     */
    public String getId_carroceria() {
        return id_carroceria;
    }

    /**
     * @return the linea
     */
    public String getLinea() {
        return linea;
    }

    /**
     * @return the marca_automotor_migrado
     */
    public String getMarca_automotor_migrado() {
        return marca_automotor_migrado;
    }

    /**
     * @return the modalidad_servicio
     */
    public String getModalidad_servicio() {
        return modalidad_servicio;
    }

    /**
     * @return the motivo_cancelacion
     */
    public String getMotivo_cancelacion() {
        return motivo_cancelacion;
    }

    /**
     * @return the nivel_blindaje
     */
    public String getNivel_blindaje() {
        return nivel_blindaje;
    }

    /**
     * @return the nivel_servicio
     */
    public String getNivel_servicio() {
        return nivel_servicio;
    }

    /**
     * @return the numero_acta
     */
    public String getNumero_acta() {
        return numero_acta;
    }

    /**
     * @return the numero_ficha_tecnica
     */
    public String getNumero_ficha_tecnica() {
        return numero_ficha_tecnica;
    }

    /**
     * @return the numero_licencia_vigente
     */
    public String getNumero_licencia_vigente() {
        return numero_licencia_vigente;
    }

    /**
     * @return the numero_plaqueta
     */
    public String getNumero_plaqueta() {
        return numero_plaqueta;
    }

    /**
     * @return the numero_puertas
     */
    public String getNumero_puertas() {
        return numero_puertas;
    }

    /**
     * @return the numero_regrabacion_chasis
     */
    public String getNumero_regrabacion_chasis() {
        return numero_regrabacion_chasis;
    }

    /**
     * @return the numero_regrabacion_motor
     */
    public String getNumero_regrabacion_motor() {
        return numero_regrabacion_motor;
    }

    /**
     * @return the numero_regrabacion_serie
     */
    public String getNumero_regrabacion_serie() {
        return numero_regrabacion_serie;
    }

    /**
     * @return the origen_registro
     */
    public String getOrigen_registro() {
        return origen_registro;
    }

    /**
     * @return the pais_origen
     */
    public String getPais_origen() {
        return pais_origen;
    }

    /**
     * @return the peso_bruto
     */
    public String getPeso_bruto() {
        return peso_bruto;
    }

    /**
     * @return the potencia
     */
    public String getPotencia() {
        return potencia;
    }

    /**
     * @return the potencia_plaqueta
     */
    public String getRegrabacion_plaqueta() {
        return regrabacion_plaqueta;
    }

    /**
     * @return the tipo_acta_importacion_remate
     */
    public String getTipo_acta_importacion_remate() {
        return tipo_acta_importacion_remate;
    }

    /**
     * @return the tipo_motor
     */
    public String getTipo_motor() {
        return tipo_motor;
    }

    /**
     * @return the ano_fabricacion
     */
    public String getAno_fabricacion() {
        return ano_fabricacion;
    }

    /**
     * @return the capacidad_pasajeros
     */
    public String getCapacidad_pasajeros() {
        return capacidad_pasajeros;
    }

    /**
     * @return the numero_ejes
     */
    public String getNumero_ejes() {
        return numero_ejes;
    }

    /**
     * @return the fecha_cancelacion
     */
    public String getFecha_cancelacion() {
        return fecha_cancelacion;
    }

    /**
     * @return the fecha_declaracion
     */
    public String getFecha_declaracion() {
        return fecha_declaracion;
    }

    /**
     * @return the fecha_expedicion_licencia
     */
    public String getFecha_expedicion_licencia() {
        return fecha_expedicion_licencia;
    }

    /**
     * @return the fecha_registro
     */
    public String getFecha_registro() {
        return fecha_registro;
    }

    /**
     * @param placa the placa to set
     */
    public void setPlaca(String placa) {
        this.placa = placa;
    }

    /**
     * @param clase the clase to set
     */
    public void setClase(String clase) {
        this.clase = clase;
    }

    /**
     * @param cilindraje the cilindraje to set
     */
    public void setCilindraje(String cilindraje) {
        this.cilindraje = cilindraje;
    }

    /**
     * @param marca the marca to set
     */
    public void setMarca(String marca) {
        this.marca = marca;
    }

    /**
     * @param modelo the modelo to set
     */
    public void setModelo(String modelo) {
        this.modelo = modelo;
    }

    /**
     * @param tipo_servicio the tipo_servicio to set
     */
    public void setTipo_servicio(String tipo_servicio) {
        this.tipo_servicio = tipo_servicio;
    }

    /**
     * @param tipo_vehiculo the tipo_vehiculo to set
     */
    public void setTipo_vehiculo(String tipo_vehiculo) {
        this.tipo_vehiculo = tipo_vehiculo;
    }

    /**
     * @param antiguo_clasico the antiguo_clasico to set
     */
    public void setAntiguo_clasico(String antiguo_clasico) {
        this.antiguo_clasico = antiguo_clasico;
    }

    /**
     * @param capacidad_carga the capacidad_carga to set
     */
    public void setCapacidad_carga(String capacidad_carga) {
        this.capacidad_carga = capacidad_carga;
    }

    /**
     * @param color the color to set
     */
    public void setColor(String color) {
        this.color = color;
    }

    /**
     * @param declaracion_simplificada the declaracion_simplificada to set
     */
    public void setDeclaracion_simplificada(String declaracion_simplificada) {
        this.declaracion_simplificada = declaracion_simplificada;
    }

    /**
     * @param enseñanza the enseñanza to set
     */
    public void setEnseñanza(String enseñanza) {
        this.enseñanza = enseñanza;
    }

    /**
     * @param importado the importado to set
     */
    public void setImportado(String importado) {
        this.importado = importado;
    }

    /**
     * @param es_reposicion the es_reposicion to set
     */
    public void setEs_reposicion(String es_reposicion) {
        this.es_reposicion = es_reposicion;
    }

    /**
     * @param blindado the blindado to set
     */
    public void setBlindado(String blindado) {
        this.blindado = blindado;
    }

    /**
     * @param repotenciado the repotenciado to set
     */
    public void setRepotenciado(String repotenciado) {
        this.repotenciado = repotenciado;
    }

    /**
     * @param estado the estado to set
     */
    public void setEstado(String estado) {
        this.estado = estado;
    }

    /**
     * @param grupo the grupo to set
     */
    public void setGrupo(String grupo) {
        this.grupo = grupo;
    }

    /**
     * @param id_carroceria the id_carroceria to set
     */
    public void setId_carroceria(String id_carroceria) {
        this.id_carroceria = id_carroceria;
    }

    /**
     * @param linea the linea to set
     */
    public void setLinea(String linea) {
        this.linea = linea;
    }

    /**
     * @param marca_automotor_migrado the marca_automotor_migrado to set
     */
    public void setMarca_automotor_migrado(String marca_automotor_migrado) {
        this.marca_automotor_migrado = marca_automotor_migrado;
    }

    /**
     * @param modalidad_servicio the modalidad_servicio to set
     */
    public void setModalidad_servicio(String modalidad_servicio) {
        this.modalidad_servicio = modalidad_servicio;
    }

    /**
     * @param motivo_cancelacion the motivo_cancelacion to set
     */
    public void setMotivo_cancelacion(String motivo_cancelacion) {
        this.motivo_cancelacion = motivo_cancelacion;
    }

    /**
     * @param nivel_blindaje the nivel_blindaje to set
     */
    public void setNivel_blindaje(String nivel_blindaje) {
        this.nivel_blindaje = nivel_blindaje;
    }

    /**
     * @param nivel_servicio the nivel_servicio to set
     */
    public void setNivel_servicio(String nivel_servicio) {
        this.nivel_servicio = nivel_servicio;
    }

    /**
     * @param numero_acta the numero_acta to set
     */
    public void setNumero_acta(String numero_acta) {
        this.numero_acta = numero_acta;
    }

    /**
     * @param numero_ficha_tecnica the numero_ficha_tecnica to set
     */
    public void setNumero_ficha_tecnica(String numero_ficha_tecnica) {
        this.numero_ficha_tecnica = numero_ficha_tecnica;
    }

    /**
     * @param numero_licencia_vigente the numero_licencia_vigente to set
     */
    public void setNumero_licencia_vigente(String numero_licencia_vigente) {
        this.numero_licencia_vigente = numero_licencia_vigente;
    }

    /**
     * @param numero_plaqueta the numero_plaqueta to set
     */
    public void setNumero_plaqueta(String numero_plaqueta) {
        this.numero_plaqueta = numero_plaqueta;
    }

    /**
     * @param numero_puertas the numero_puertas to set
     */
    public void setNumero_puertas(String numero_puertas) {
        this.numero_puertas = numero_puertas;
    }

    /**
     * @param numero_regrabacion_chasis the numero_regrabacion_chasis to set
     */
    public void setNumero_regrabacion_chasis(String numero_regrabacion_chasis) {
        this.numero_regrabacion_chasis = numero_regrabacion_chasis;
    }

    /**
     * @param numero_regrabacion_motor the numero_regrabacion_motor to set
     */
    public void setNumero_regrabacion_motor(String numero_regrabacion_motor) {
        this.numero_regrabacion_motor = numero_regrabacion_motor;
    }

    /**
     * @param numero_regrabacion_serie the numero_regrabacion_serie to set
     */
    public void setNumero_regrabacion_serie(String numero_regrabacion_serie) {
        this.numero_regrabacion_serie = numero_regrabacion_serie;
    }

    /**
     * @param origen_registro the origen_registro to set
     */
    public void setOrigen_registro(String origen_registro) {
        this.origen_registro = origen_registro;
    }

    /**
     * @param pais_origen the pais_origen to set
     */
    public void setPais_origen(String pais_origen) {
        this.pais_origen = pais_origen;
    }

    /**
     * @param peso_bruto the peso_bruto to set
     */
    public void setPeso_bruto(String peso_bruto) {
        this.peso_bruto = peso_bruto;
    }

    /**
     * @param potencia the potencia to set
     */
    public void setPotencia(String potencia) {
        this.potencia = potencia;
    }

    /**
     * @param regrabacion_plaqueta the regrabacion_plaqueta to set
     */
    public void setRegrabacion_plaqueta(String regrabacion_plaqueta) {
        this.regrabacion_plaqueta = regrabacion_plaqueta;
    }

    /**
     * @param tipo_acta_importacion_remate the tipo_acta_importacion_remate to set
     */
    public void setTipo_acta_importacion_remate(String tipo_acta_importacion_remate) {
        this.tipo_acta_importacion_remate = tipo_acta_importacion_remate;
    }

    /**
     * @param tipo_motor the tipo_motor to set
     */
    public void setTipo_motor(String tipo_motor) {
        this.tipo_motor = tipo_motor;
    }

    /**
     * @param ano_fabricacion the ano_fabricacion to set
     */
    public void setAno_fabricacion(String ano_fabricacion) {
        this.ano_fabricacion = ano_fabricacion;
    }

    /**
     * @param capacidad_pasajeros the capacidad_pasajeros to set
     */
    public void setCapacidad_pasajeros(String capacidad_pasajeros) {
        this.capacidad_pasajeros = capacidad_pasajeros;
    }

    /**
     * @param numero_ejes the numero_ejes to set
     */
    public void setNumero_ejes(String numero_ejes) {
        this.numero_ejes = numero_ejes;
    }

    /**
     * @param fecha_cancelacion the fecha_cancelacion to set
     */
    public void setFecha_cancelacion(String fecha_cancelacion) {
        this.fecha_cancelacion = fecha_cancelacion;
    }

    /**
     * @param fecha_declaracion the fecha_declaracion to set
     */
    public void setFecha_declaracion(String fecha_declaracion) {
        this.fecha_declaracion = fecha_declaracion;
    }

    /**
     * @param fecha_expedicion_licencia the fecha_expedicion_licencia to set
     */
    public void setFecha_expedicion_licencia(String fecha_expedicion_licencia) {
        this.fecha_expedicion_licencia = fecha_expedicion_licencia;
    }

    /**
     * @param fecha_registro the fecha_registro to set
     */
    public void setFecha_registro(String fecha_registro) {
        this.fecha_registro = fecha_registro;
    }

    public static VehiculoRunt load(ResultSet rst) throws SQLException {
        VehiculoRunt vehiculoRunt = new VehiculoRunt();

        vehiculoRunt.setPlaca(rst.getString(1));
        vehiculoRunt.setClase(rst.getString(2));
        vehiculoRunt.setCilindraje(rst.getString(3));
        vehiculoRunt.setMarca(rst.getString(4));
        vehiculoRunt.setModelo(rst.getString(5));
        vehiculoRunt.setTipo_servicio(rst.getString(6));
        vehiculoRunt.setTipo_vehiculo(rst.getString(7));
        vehiculoRunt.setAntiguo_clasico(rst.getString(8));
        vehiculoRunt.setCapacidad_carga(rst.getString(9));
        vehiculoRunt.setColor(rst.getString(10));
        vehiculoRunt.setDeclaracion_simplificada(rst.getString(11));
        vehiculoRunt.setEnseñanza(rst.getString(12));
        vehiculoRunt.setImportado(rst.getString(13));
        vehiculoRunt.setEs_reposicion(rst.getString(14));
        vehiculoRunt.setBlindado(rst.getString(15));
        vehiculoRunt.setRepotenciado(rst.getString(16));
        vehiculoRunt.setEstado(rst.getString(17));
        vehiculoRunt.setGrupo(rst.getString(18));
        vehiculoRunt.setId_carroceria(rst.getString(19));
        vehiculoRunt.setLinea(rst.getString(20));
        vehiculoRunt.setMarca_automotor_migrado(rst.getString(21));
        vehiculoRunt.setModalidad_servicio(rst.getString(22));
        vehiculoRunt.setMotivo_cancelacion(rst.getString(23));
        vehiculoRunt.setNivel_blindaje(rst.getString(24));
        vehiculoRunt.setNivel_servicio(rst.getString(25));
        vehiculoRunt.setNumero_acta(rst.getString(26));
        vehiculoRunt.setNumero_ficha_tecnica(rst.getString(27));
        vehiculoRunt.setNumero_licencia_vigente(rst.getString(28));
        vehiculoRunt.setNumero_plaqueta(rst.getString(29));
        vehiculoRunt.setNumero_puertas(rst.getString(30));
        vehiculoRunt.setNumero_regrabacion_chasis(rst.getString(31));
        vehiculoRunt.setNumero_regrabacion_motor(rst.getString(32));
        vehiculoRunt.setNumero_regrabacion_serie(rst.getString(33));
        vehiculoRunt.setOrigen_registro(rst.getString(34));
        vehiculoRunt.setPais_origen(rst.getString(35));
        vehiculoRunt.setPeso_bruto(rst.getString(36));
        vehiculoRunt.setPotencia(rst.getString(37));
        vehiculoRunt.setRegrabacion_plaqueta(rst.getString(38));
        vehiculoRunt.setTipo_acta_importacion_remate(rst.getString(39));
        vehiculoRunt.setTipo_motor(rst.getString(40));
        vehiculoRunt.setAno_fabricacion(rst.getString(41));
        vehiculoRunt.setCapacidad_pasajeros(rst.getString(42));
        vehiculoRunt.setNumero_ejes(rst.getString(43));
        vehiculoRunt.setFecha_cancelacion(rst.getString(44));
        vehiculoRunt.setFecha_declaracion(rst.getString(45));
        vehiculoRunt.setFecha_expedicion_licencia(rst.getString(46));
        vehiculoRunt.setFecha_registro(rst.getString(47));


        return vehiculoRunt ;
    }
}
