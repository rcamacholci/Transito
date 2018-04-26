/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.io.*;
import java.sql.*;
import java.sql.*;
import oracle.sql.*;

/**
 *
 * @author Administrador
 */
public class Titulo_Valor implements Serializable{

    private Date fechaTitulo;
    private long id_titulo,divipo,estado,fk_usuario,codigoJuzgado;
    private String NroTitulo,oficinaPagadora,NombreJuzgado,tituloJudicial,nombreConsignante,claseDeposito;
    private int numeroExpediente,valorDeposito;
    private long demandante,demandado;
    private Timestamp  fecha_Proceso;

    public String getNombreJuzgado() {
        return NombreJuzgado;
    }

    public long getId_titulo() {
        return id_titulo;
    }

    public String getClaseDeposito() {
        return claseDeposito;
    }

    public void setClaseDeposito(String claseDeposito) {
        this.claseDeposito = claseDeposito;
    }

    public void setId_titulo(long id_titulo) {
        this.id_titulo = id_titulo;
    }

    public void setNombreJuzgado(String NombreJuzgado) {
        this.NombreJuzgado = NombreJuzgado;
    }

   

    public String getNroTitulo() {
        return NroTitulo;
    }

    public void setNroTitulo(String NroTitulo) {
        this.NroTitulo = NroTitulo;
    }

    public long getCodigoJuzgado() {
        return codigoJuzgado;
    }

    public Timestamp getFecha_Proceso() {
        return fecha_Proceso;
    }

    public void setFecha_Proceso(Timestamp fecha_Proceso) {
        this.fecha_Proceso = fecha_Proceso;
    }


    public void setCodigoJuzgado(long codigoJuzgado) {
        this.codigoJuzgado = codigoJuzgado;
    }

   

    public long getFk_usuario() {
        return fk_usuario;
    }

    public void setFk_usuario(long fk_usuario) {
        this.fk_usuario = fk_usuario;
    }

    public long getDemandado() {
        return demandado;
    }

    public void setDemandado(long demandado) {
        this.demandado = demandado;
    }

    public long getDemandante() {
        return demandante;
    }

    public void setDemandante(long demandante) {
        this.demandante = demandante;
    }

    public long getDivipo() {
        return divipo;
    }

    public void setDivipo(long divipo) {
        this.divipo = divipo;
    }

    public long getEstado() {
        return estado;
    }

    public void setEstado(long estado) {
        this.estado = estado;
    }

  

    public Date getFechaTitulo() {
        return fechaTitulo;
    }

    public void setFechaTitulo(Date fechaTitulo) {
        this.fechaTitulo = fechaTitulo;
    }



   

    public String getNombreConsignante() {
        return nombreConsignante;
    }

    public void setNombreConsignante(String nombreConsignante) {
        this.nombreConsignante = nombreConsignante;
    }

    public int getNumeroExpediente() {
        return numeroExpediente;
    }

    public void setNumeroExpediente(int numeroExpediente) {
        this.numeroExpediente = numeroExpediente;
    }

  

    public String getOficinaPagadora() {
        return oficinaPagadora;
    }

    public void setOficinaPagadora(String oficinaPagadora) {
        this.oficinaPagadora = oficinaPagadora;
    }

 

    public String getTituloJudicial() {
        return tituloJudicial;
    }

    public void setTituloJudicial(String tituloJudicial) {
        this.tituloJudicial = tituloJudicial;
    }

    public int getValorDeposito() {
        return valorDeposito;
    }

    public void setValorDeposito(int valorDeposito) {
        this.valorDeposito = valorDeposito;
    }





    public static Titulo_Valor load(java.sql.ResultSet rs)throws java.sql.SQLException{
        Titulo_Valor tituloV = new Titulo_Valor();

        tituloV.setId_titulo(rs.getLong(1));
        tituloV.setNroTitulo(rs.getString(2));
        tituloV.setFechaTitulo(rs.getDate(3));
        tituloV.setDivipo(rs.getLong(4));
        tituloV.setOficinaPagadora(rs.getString(5));
        tituloV.setTituloJudicial(rs.getString(6));
        tituloV.setNombreJuzgado(rs.getString(7));
        tituloV.setCodigoJuzgado(rs.getLong(8));
        tituloV.setNombreConsignante(rs.getString(9));
        tituloV.setNumeroExpediente(rs.getInt(10));
        tituloV.setValorDeposito(rs.getInt(11));
        tituloV.setDemandante(rs.getLong(12));
        tituloV.setDemandado(rs.getLong(13));
        tituloV.setFecha_Proceso(rs.getTimestamp(14));
        tituloV.setEstado(rs.getLong(15));
        tituloV.setFk_usuario(rs.getLong(16));
        tituloV.setClaseDeposito(rs.getString(17));
        return tituloV;
    }


}
