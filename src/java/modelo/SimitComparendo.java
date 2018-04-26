/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.sql.*;
import java.io.Serializable;

/**
 *
 * @author Administrador
 */
public class SimitComparendo implements Serializable {

    private long ID_SIMIT_COMPARENDO;
    private int ESTADO;
    private Timestamp FECHA_REGISTRO;
    private Date FECHA_REPORTE;
    private String COMCONSECUTIVO;
    private String COMNUMERO;
    private String COMFECHA;
    private String COMHORA;
    private String COMDIR;
    private String COMDIVIPOMUNI;
    private String COMLOCALIDADCOMUNA;
    private String COMPLACA;
    private String COMDIVIPOMATRI;
    private String COMTIPOVEHI;
    private String COMTIPOSER;
    private String COMCODIGORADIO;
    private String COMCODIGOMODALIDAD;
    private String COMCODIGOPASAJEROS;
    private String COMINFRACTOR;
    private String COMTIPODOC;
    private String COMNOMBE;
    private String COMAPELLIDO;
    private String COMEDADINFRACTOR;
    private String COMDIRINFRACTOR;
    private String COMEMAIL;
    private String COMTELEINFRACTOR;
    private String COMIDCIUDAD;
    private String COMLICENCIA;
    private String COMCATEGORIA;
    private String COMSECREEXPIDE;
    private String COMFECHAVENCE;
    private String COMTIPOINFRAC;
    private String COMPLICTRANSITO;
    private String COMDIVIPOLICEN;
    private String COMIDENTIFICACION;
    private String COMIDTIPODOCPROP;
    private String COMNOMBREPROP;
    private String COMNOMBREEMPRESA;
    private String COMNITEMPRESA;
    private String COMTARJETAOPERACION;
    private String COMPPLACAAGENTE;
    private String COMOBSERVA;
    private String COMFUGA;
    private String COMACCI;
    private String COMINMOV;
    private String COMPATIOINMOVILIZA;
    private String COMDIRPATIOINMOVI;
    private String COMGRUANUMERO;
    private String COMPLACAGRUA;
    private String COMCONSECUTIINMOVI;
    private String COMIDENTIFICACIONTEST;
    private String COMNOMBRETESTI;
    private String COMDIRECRESTESTI;
    private String COMTELETESTIGO;
    private String COMVALOR;
    private String COMVALAD;
    private String COMORGANISMO;
    private String COMESTADOCOM;
    private String COMPOLCA;
    private String COMINFRACCION;
    private String COMVALINFRA;
    private long fkSimitPlano;

    public long getFkSimitPlano() {
        return fkSimitPlano;
    }

    public void setFkSimitPlano(long fkSimitPlano) {
        this.fkSimitPlano = fkSimitPlano;
    }

    public String getCOMACCI() {
        return COMACCI;
    }

    public void setCOMACCI(String COMACCI) {
        this.COMACCI = COMACCI;
    }

    public String getCOMAPELLIDO() {
        return COMAPELLIDO;
    }

    public void setCOMAPELLIDO(String COMAPELLIDO) {
        this.COMAPELLIDO = COMAPELLIDO;
    }

    public String getCOMCATEGORIA() {
        return COMCATEGORIA;
    }

    public void setCOMCATEGORIA(String COMCATEGORIA) {
        this.COMCATEGORIA = COMCATEGORIA;
    }

    public String getCOMCODIGOMODALIDAD() {
        return COMCODIGOMODALIDAD;
    }

    public void setCOMCODIGOMODALIDAD(String COMCODIGOMODALIDAD) {
        this.COMCODIGOMODALIDAD = COMCODIGOMODALIDAD;
    }

    public String getCOMCODIGOPASAJEROS() {
        return COMCODIGOPASAJEROS;
    }

    public void setCOMCODIGOPASAJEROS(String COMCODIGOPASAJEROS) {
        this.COMCODIGOPASAJEROS = COMCODIGOPASAJEROS;
    }

    public String getCOMCODIGORADIO() {
        return COMCODIGORADIO;
    }

    public void setCOMCODIGORADIO(String COMCODIGORADIO) {
        this.COMCODIGORADIO = COMCODIGORADIO;
    }

    public String getCOMCONSECUTIINMOVI() {
        return COMCONSECUTIINMOVI;
    }

    public void setCOMCONSECUTIINMOVI(String COMCONSECUTIINMOVI) {
        this.COMCONSECUTIINMOVI = COMCONSECUTIINMOVI;
    }

    public String getCOMCONSECUTIVO() {
        return COMCONSECUTIVO;
    }

    public void setCOMCONSECUTIVO(String COMCONSECUTIVO) {
        this.COMCONSECUTIVO = COMCONSECUTIVO;
    }

    public String getCOMDIR() {
        return COMDIR;
    }

    public void setCOMDIR(String COMDIR) {
        this.COMDIR = COMDIR;
    }

    public String getCOMDIRECRESTESTI() {
        return COMDIRECRESTESTI;
    }

    public void setCOMDIRECRESTESTI(String COMDIRECRESTESTI) {
        this.COMDIRECRESTESTI = COMDIRECRESTESTI;
    }

    public String getCOMDIRINFRACTOR() {
        return COMDIRINFRACTOR;
    }

    public void setCOMDIRINFRACTOR(String COMDIRINFRACTOR) {
        this.COMDIRINFRACTOR = COMDIRINFRACTOR;
    }

    public String getCOMDIRPATIOINMOVI() {
        return COMDIRPATIOINMOVI;
    }

    public void setCOMDIRPATIOINMOVI(String COMDIRPATIOINMOVI) {
        this.COMDIRPATIOINMOVI = COMDIRPATIOINMOVI;
    }

    public String getCOMDIVIPOLICEN() {
        return COMDIVIPOLICEN;
    }

    public void setCOMDIVIPOLICEN(String COMDIVIPOLICEN) {
        this.COMDIVIPOLICEN = COMDIVIPOLICEN;
    }

    public String getCOMDIVIPOMATRI() {
        return COMDIVIPOMATRI;
    }

    public void setCOMDIVIPOMATRI(String COMDIVIPOMATRI) {
        this.COMDIVIPOMATRI = COMDIVIPOMATRI;
    }

    public String getCOMDIVIPOMUNI() {
        return COMDIVIPOMUNI;
    }

    public void setCOMDIVIPOMUNI(String COMDIVIPOMUNI) {
        this.COMDIVIPOMUNI = COMDIVIPOMUNI;
    }

    public String getCOMEDADINFRACTOR() {
        return COMEDADINFRACTOR;
    }

    public void setCOMEDADINFRACTOR(String COMEDADINFRACTOR) {
        this.COMEDADINFRACTOR = COMEDADINFRACTOR;
    }

    public String getCOMEMAIL() {
        return COMEMAIL;
    }

    public void setCOMEMAIL(String COMEMAIL) {
        this.COMEMAIL = COMEMAIL;
    }

    public String getCOMESTADOCOM() {
        return COMESTADOCOM;
    }

    public void setCOMESTADOCOM(String COMESTADOCOM) {
        this.COMESTADOCOM = COMESTADOCOM;
    }

    public String getCOMFECHA() {
        return COMFECHA;
    }

    public void setCOMFECHA(String COMFECHA) {
        this.COMFECHA = COMFECHA;
    }

    public String getCOMFECHAVENCE() {
        return COMFECHAVENCE;
    }

    public void setCOMFECHAVENCE(String COMFECHAVENCE) {
        this.COMFECHAVENCE = COMFECHAVENCE;
    }

    public String getCOMFUGA() {
        return COMFUGA;
    }

    public void setCOMFUGA(String COMFUGA) {
        this.COMFUGA = COMFUGA;
    }

    public String getCOMGRUANUMERO() {
        return COMGRUANUMERO;
    }

    public void setCOMGRUANUMERO(String COMGRUANUMERO) {
        this.COMGRUANUMERO = COMGRUANUMERO;
    }

    public String getCOMHORA() {
        return COMHORA;
    }

    public void setCOMHORA(String COMHORA) {
        this.COMHORA = COMHORA;
    }

    public String getCOMIDCIUDAD() {
        return COMIDCIUDAD;
    }

    public void setCOMIDCIUDAD(String COMIDCIUDAD) {
        this.COMIDCIUDAD = COMIDCIUDAD;
    }

    public String getCOMIDENTIFICACION() {
        return COMIDENTIFICACION;
    }

    public void setCOMIDENTIFICACION(String COMIDENTIFICACION) {
        this.COMIDENTIFICACION = COMIDENTIFICACION;
    }

    public String getCOMIDENTIFICACIONTEST() {
        return COMIDENTIFICACIONTEST;
    }

    public void setCOMIDENTIFICACIONTEST(String COMIDENTIFICACIONTEST) {
        this.COMIDENTIFICACIONTEST = COMIDENTIFICACIONTEST;
    }

    public String getCOMIDTIPODOCPROP() {
        return COMIDTIPODOCPROP;
    }

    public void setCOMIDTIPODOCPROP(String COMIDTIPODOCPROP) {
        this.COMIDTIPODOCPROP = COMIDTIPODOCPROP;
    }

    public String getCOMINFRACCION() {
        return COMINFRACCION;
    }

    public void setCOMINFRACCION(String COMINFRACCION) {
        this.COMINFRACCION = COMINFRACCION;
    }

    public String getCOMINFRACTOR() {
        return COMINFRACTOR;
    }

    public void setCOMINFRACTOR(String COMINFRACTOR) {
        this.COMINFRACTOR = COMINFRACTOR;
    }

    public String getCOMINMOV() {
        return COMINMOV;
    }

    public void setCOMINMOV(String COMINMOV) {
        this.COMINMOV = COMINMOV;
    }

    public String getCOMLICENCIA() {
        return COMLICENCIA;
    }

    public void setCOMLICENCIA(String COMLICENCIA) {
        this.COMLICENCIA = COMLICENCIA;
    }

    public String getCOMLOCALIDADCOMUNA() {
        return COMLOCALIDADCOMUNA;
    }

    public void setCOMLOCALIDADCOMUNA(String COMLOCALIDADCOMUNA) {
        this.COMLOCALIDADCOMUNA = COMLOCALIDADCOMUNA;
    }

    public String getCOMNITEMPRESA() {
        return COMNITEMPRESA;
    }

    public void setCOMNITEMPRESA(String COMNITEMPRESA) {
        this.COMNITEMPRESA = COMNITEMPRESA;
    }

    public String getCOMNOMBE() {
        return COMNOMBE;
    }

    public void setCOMNOMBE(String COMNOMBE) {
        this.COMNOMBE = COMNOMBE;
    }

    public String getCOMNOMBREEMPRESA() {
        return COMNOMBREEMPRESA;
    }

    public void setCOMNOMBREEMPRESA(String COMNOMBREEMPRESA) {
        this.COMNOMBREEMPRESA = COMNOMBREEMPRESA;
    }

    public String getCOMNOMBREPROP() {
        return COMNOMBREPROP;
    }

    public void setCOMNOMBREPROP(String COMNOMBREPROP) {
        this.COMNOMBREPROP = COMNOMBREPROP;
    }

    public String getCOMNOMBRETESTI() {
        return COMNOMBRETESTI;
    }

    public void setCOMNOMBRETESTI(String COMNOMBRETESTI) {
        this.COMNOMBRETESTI = COMNOMBRETESTI;
    }

    public String getCOMNUMERO() {
        return COMNUMERO;
    }

    public void setCOMNUMERO(String COMNUMERO) {
        this.COMNUMERO = COMNUMERO;
    }

    public String getCOMOBSERVA() {
        return COMOBSERVA;
    }

    public void setCOMOBSERVA(String COMOBSERVA) {
        this.COMOBSERVA = COMOBSERVA;
    }

    public String getCOMORGANISMO() {
        return COMORGANISMO;
    }

    public void setCOMORGANISMO(String COMORGANISMO) {
        this.COMORGANISMO = COMORGANISMO;
    }

    public String getCOMPATIOINMOVILIZA() {
        return COMPATIOINMOVILIZA;
    }

    public void setCOMPATIOINMOVILIZA(String COMPATIOINMOVILIZA) {
        this.COMPATIOINMOVILIZA = COMPATIOINMOVILIZA;
    }

    public String getCOMPLACA() {
        return COMPLACA;
    }

    public void setCOMPLACA(String COMPLACA) {
        this.COMPLACA = COMPLACA;
    }

    public String getCOMPLACAGRUA() {
        return COMPLACAGRUA;
    }

    public void setCOMPLACAGRUA(String COMPLACAGRUA) {
        this.COMPLACAGRUA = COMPLACAGRUA;
    }

    public String getCOMPLICTRANSITO() {
        return COMPLICTRANSITO;
    }

    public void setCOMPLICTRANSITO(String COMPLICTRANSITO) {
        this.COMPLICTRANSITO = COMPLICTRANSITO;
    }

    public String getCOMPOLCA() {
        return COMPOLCA;
    }

    public void setCOMPOLCA(String COMPOLCA) {
        this.COMPOLCA = COMPOLCA;
    }

    public String getCOMPPLACAAGENTE() {
        return COMPPLACAAGENTE;
    }

    public void setCOMPPLACAAGENTE(String COMPPLACAAGENTE) {
        this.COMPPLACAAGENTE = COMPPLACAAGENTE;
    }

    public String getCOMSECREEXPIDE() {
        return COMSECREEXPIDE;
    }

    public void setCOMSECREEXPIDE(String COMSECREEXPIDE) {
        this.COMSECREEXPIDE = COMSECREEXPIDE;
    }

    public String getCOMTARJETAOPERACION() {
        return COMTARJETAOPERACION;
    }

    public void setCOMTARJETAOPERACION(String COMTARJETAOPERACION) {
        this.COMTARJETAOPERACION = COMTARJETAOPERACION;
    }

    public String getCOMTELEINFRACTOR() {
        return COMTELEINFRACTOR;
    }

    public void setCOMTELEINFRACTOR(String COMTELEINFRACTOR) {
        this.COMTELEINFRACTOR = COMTELEINFRACTOR;
    }

    public String getCOMTELETESTIGO() {
        return COMTELETESTIGO;
    }

    public void setCOMTELETESTIGO(String COMTELETESTIGO) {
        this.COMTELETESTIGO = COMTELETESTIGO;
    }

    public String getCOMTIPODOC() {
        return COMTIPODOC;
    }

    public void setCOMTIPODOC(String COMTIPODOC) {
        this.COMTIPODOC = COMTIPODOC;
    }

    public String getCOMTIPOINFRAC() {
        return COMTIPOINFRAC;
    }

    public void setCOMTIPOINFRAC(String COMTIPOINFRAC) {
        this.COMTIPOINFRAC = COMTIPOINFRAC;
    }

    public String getCOMTIPOSER() {
        return COMTIPOSER;
    }

    public void setCOMTIPOSER(String COMTIPOSER) {
        this.COMTIPOSER = COMTIPOSER;
    }

    public String getCOMTIPOVEHI() {
        return COMTIPOVEHI;
    }

    public void setCOMTIPOVEHI(String COMTIPOVEHI) {
        this.COMTIPOVEHI = COMTIPOVEHI;
    }

    public String getCOMVALAD() {
        return COMVALAD;
    }

    public void setCOMVALAD(String COMVALAD) {
        this.COMVALAD = COMVALAD;
    }

    public String getCOMVALINFRA() {
        return COMVALINFRA;
    }

    public void setCOMVALINFRA(String COMVALINFRA) {
        this.COMVALINFRA = COMVALINFRA;
    }

    public String getCOMVALOR() {
        return COMVALOR;
    }

    public void setCOMVALOR(String COMVALOR) {
        this.COMVALOR = COMVALOR;
    }

    public int getESTADO() {
        return ESTADO;
    }

    public void setESTADO(int ESTADO) {
        this.ESTADO = ESTADO;
    }

    public Timestamp getFECHA_REGISTRO() {
        return FECHA_REGISTRO;
    }

    public void setFECHA_REGISTRO(Timestamp FECHA_REGISTRO) {
        this.FECHA_REGISTRO = FECHA_REGISTRO;
    }

    public Date getFECHA_REPORTE() {
        return FECHA_REPORTE;
    }

    public void setFECHA_REPORTE(Date FECHA_REPORTE) {
        this.FECHA_REPORTE = FECHA_REPORTE;
    }

    public long getID_SIMIT_COMPARENDO() {
        return ID_SIMIT_COMPARENDO;
    }

    public void setID_SIMIT_COMPARENDO(long ID_SIMIT_COMPARENDO) {
        this.ID_SIMIT_COMPARENDO = ID_SIMIT_COMPARENDO;
    }
    
    public static SimitComparendo load(ResultSet rs) throws SQLException {

        SimitComparendo simitComparendo = new SimitComparendo();
        simitComparendo.setID_SIMIT_COMPARENDO(rs.getLong(1));
        simitComparendo.setESTADO(rs.getInt(2));
        simitComparendo.setFECHA_REGISTRO(rs.getTimestamp(3));
        simitComparendo.setFECHA_REPORTE(rs.getDate(4));
        simitComparendo.setCOMCONSECUTIVO(rs.getString(5));
        simitComparendo.setCOMNUMERO(rs.getString(6));
        simitComparendo.setCOMFECHA(rs.getString(7));
        simitComparendo.setCOMHORA(rs.getString(8));
        simitComparendo.setCOMDIR(rs.getString(9));
        simitComparendo.setCOMDIVIPOMUNI(rs.getString(10));
        simitComparendo.setCOMLOCALIDADCOMUNA(rs.getString(11));
        simitComparendo.setCOMPLACA(rs.getString(12));
        simitComparendo.setCOMDIVIPOMATRI(rs.getString(13));
        simitComparendo.setCOMTIPOVEHI(rs.getString(14));
        simitComparendo.setCOMTIPOSER(rs.getString(15));
        simitComparendo.setCOMCODIGORADIO(rs.getString(16));
        simitComparendo.setCOMCODIGOMODALIDAD(rs.getString(17));
        simitComparendo.setCOMCODIGOPASAJEROS(rs.getString(18));
        simitComparendo.setCOMINFRACTOR(rs.getString(19));
        simitComparendo.setCOMTIPODOC(rs.getString(20));
        simitComparendo.setCOMNOMBE(rs.getString(21));
        simitComparendo.setCOMAPELLIDO(rs.getString(22));
        simitComparendo.setCOMEDADINFRACTOR(rs.getString(23));
        simitComparendo.setCOMDIRINFRACTOR(rs.getString(24));
        simitComparendo.setCOMEMAIL(rs.getString(25));
        simitComparendo.setCOMTELEINFRACTOR(rs.getString(26));
        simitComparendo.setCOMIDCIUDAD(rs.getString(27));
        simitComparendo.setCOMLICENCIA(rs.getString(28));
        simitComparendo.setCOMCATEGORIA(rs.getString(29));
        simitComparendo.setCOMSECREEXPIDE(rs.getString(30));
        simitComparendo.setCOMFECHAVENCE(rs.getString(31));
        simitComparendo.setCOMTIPOINFRAC(rs.getString(32));
        simitComparendo.setCOMPLICTRANSITO(rs.getString(33));
        simitComparendo.setCOMDIVIPOLICEN(rs.getString(34));
        simitComparendo.setCOMIDENTIFICACION(rs.getString(35));
        simitComparendo.setCOMIDTIPODOCPROP(rs.getString(36));
        simitComparendo.setCOMNOMBREPROP(rs.getString(37));
        simitComparendo.setCOMNOMBREEMPRESA(rs.getString(38));
        simitComparendo.setCOMNITEMPRESA(rs.getString(39));
        simitComparendo.setCOMTARJETAOPERACION(rs.getString(40));
        simitComparendo.setCOMPPLACAAGENTE(rs.getString(41));
        simitComparendo.setCOMOBSERVA(rs.getString(42));
        simitComparendo.setCOMFUGA(rs.getString(43));
        simitComparendo.setCOMACCI(rs.getString(44));
        simitComparendo.setCOMINMOV(rs.getString(45));
        simitComparendo.setCOMPATIOINMOVILIZA(rs.getString(46));
        simitComparendo.setCOMDIRPATIOINMOVI(rs.getString(47));
        simitComparendo.setCOMGRUANUMERO(rs.getString(48));
        simitComparendo.setCOMPLACAGRUA(rs.getString(49));
        simitComparendo.setCOMCONSECUTIINMOVI(rs.getString(50));
        simitComparendo.setCOMIDENTIFICACIONTEST(rs.getString(51));
        simitComparendo.setCOMNOMBRETESTI(rs.getString(52));
        simitComparendo.setCOMDIRECRESTESTI(rs.getString(53));
        simitComparendo.setCOMTELETESTIGO(rs.getString(54));
        simitComparendo.setCOMVALOR(rs.getString(55));
        simitComparendo.setCOMVALAD(rs.getString(56));
        simitComparendo.setCOMORGANISMO(rs.getString(57));
        simitComparendo.setCOMESTADOCOM(rs.getString(58));
        simitComparendo.setCOMPOLCA(rs.getString(59));
        simitComparendo.setCOMINFRACCION(rs.getString(60));
        simitComparendo.setCOMVALINFRA(rs.getString(61));
        simitComparendo.setFkSimitPlano(rs.getLong(62));
        return simitComparendo;

    }
    
}
