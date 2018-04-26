/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

/**
 *
 * @author Administrador
 */
public class SimitResolucion {

    private long ID_SIMIT_RESOLUCION;
    private int ESTADO;
    private Timestamp FECHA_REGISTRO;
    private Date FECHA_REPORTE;
    private String RESCONSECUTIVO;
    private String RESNUMERO;
    private String RESNUMANT;
    private String RESFECHA;
    private String RESTIPORES;
    private String RESFHASTA;
    private String RESCOMP;
    private String RESCOMPF;
    private String RESNIPINFRAC;
    private String RESTIPODOC;
    private String RESNOMBE;
    private String RESAPELLIDO;
    private String RESDIRINFRACTOR;
    private String RESTELEINFRACTOR;
    private String RESIDCIUDAD;
    private String RESVALOR;
    private String RESVALAD;
    private String RESORGANISMO;
    private String RESCOMPOLCA;
    private String RESINFRACCION;
    private String RESVALINF;
    private String RESVALPAG;
    private long fkSimitPlano;

    public long getFkSimitPlano() {
        return fkSimitPlano;
    }

    public void setFkSimitPlano(long fkSimitPlano) {
        this.fkSimitPlano = fkSimitPlano;
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

    public long getID_SIMIT_RESOLUCION() {
        return ID_SIMIT_RESOLUCION;
    }

    public void setID_SIMIT_RESOLUCION(long ID_SIMIT_RESOLUCION) {
        this.ID_SIMIT_RESOLUCION = ID_SIMIT_RESOLUCION;
    }

    public String getRESAPELLIDO() {
        return RESAPELLIDO;
    }

    public void setRESAPELLIDO(String RESAPELLIDO) {
        this.RESAPELLIDO = RESAPELLIDO;
    }

    public String getRESCOMP() {
        return RESCOMP;
    }

    public void setRESCOMP(String RESCOMP) {
        this.RESCOMP = RESCOMP;
    }

    public String getRESCOMPF() {
        return RESCOMPF;
    }

    public void setRESCOMPF(String RESCOMPF) {
        this.RESCOMPF = RESCOMPF;
    }

    public String getRESCOMPOLCA() {
        return RESCOMPOLCA;
    }

    public void setRESCOMPOLCA(String RESCOMPOLCA) {
        this.RESCOMPOLCA = RESCOMPOLCA;
    }

    public String getRESCONSECUTIVO() {
        return RESCONSECUTIVO;
    }

    public void setRESCONSECUTIVO(String RESCONSECUTIVO) {
        this.RESCONSECUTIVO = RESCONSECUTIVO;
    }

    public String getRESDIRINFRACTOR() {
        return RESDIRINFRACTOR;
    }

    public void setRESDIRINFRACTOR(String RESDIRINFRACTOR) {
        this.RESDIRINFRACTOR = RESDIRINFRACTOR;
    }

    public String getRESFECHA() {
        return RESFECHA;
    }

    public void setRESFECHA(String RESFECHA) {
        this.RESFECHA = RESFECHA;
    }

    public String getRESFHASTA() {
        return RESFHASTA;
    }

    public void setRESFHASTA(String RESFHASTA) {
        this.RESFHASTA = RESFHASTA;
    }

    public String getRESIDCIUDAD() {
        return RESIDCIUDAD;
    }

    public void setRESIDCIUDAD(String RESIDCIUDAD) {
        this.RESIDCIUDAD = RESIDCIUDAD;
    }

    public String getRESINFRACCION() {
        return RESINFRACCION;
    }

    public void setRESINFRACCION(String RESINFRACCION) {
        this.RESINFRACCION = RESINFRACCION;
    }

    public String getRESNIPINFRAC() {
        return RESNIPINFRAC;
    }

    public void setRESNIPINFRAC(String RESNIPINFRAC) {
        this.RESNIPINFRAC = RESNIPINFRAC;
    }

    public String getRESNOMBE() {
        return RESNOMBE;
    }

    public void setRESNOMBE(String RESNOMBE) {
        this.RESNOMBE = RESNOMBE;
    }

    public String getRESNUMANT() {
        return RESNUMANT;
    }

    public void setRESNUMANT(String RESNUMANT) {
        this.RESNUMANT = RESNUMANT;
    }

    public String getRESNUMERO() {
        return RESNUMERO;
    }

    public void setRESNUMERO(String RESNUMERO) {
        this.RESNUMERO = RESNUMERO;
    }

    public String getRESORGANISMO() {
        return RESORGANISMO;
    }

    public void setRESORGANISMO(String RESORGANISMO) {
        this.RESORGANISMO = RESORGANISMO;
    }

    public String getRESTELEINFRACTOR() {
        return RESTELEINFRACTOR;
    }

    public void setRESTELEINFRACTOR(String RESTELEINFRACTOR) {
        this.RESTELEINFRACTOR = RESTELEINFRACTOR;
    }

    public String getRESTIPODOC() {
        return RESTIPODOC;
    }

    public void setRESTIPODOC(String RESTIPODOC) {
        this.RESTIPODOC = RESTIPODOC;
    }

    public String getRESTIPORES() {
        return RESTIPORES;
    }

    public void setRESTIPORES(String RESTIPORES) {
        this.RESTIPORES = RESTIPORES;
    }

    public String getRESVALAD() {
        return RESVALAD;
    }

    public void setRESVALAD(String RESVALAD) {
        this.RESVALAD = RESVALAD;
    }

    public String getRESVALINF() {
        return RESVALINF;
    }

    public void setRESVALINF(String RESVALINF) {
        this.RESVALINF = RESVALINF;
    }

    public String getRESVALOR() {
        return RESVALOR;
    }

    public void setRESVALOR(String RESVALOR) {
        this.RESVALOR = RESVALOR;
    }

    public String getRESVALPAG() {
        return RESVALPAG;
    }

    public void setRESVALPAG(String RESVALPAG) {
        this.RESVALPAG = RESVALPAG;
    }

    public static SimitResolucion load(ResultSet rs)throws SQLException{
        SimitResolucion simitResolucion = new SimitResolucion();
        simitResolucion.setID_SIMIT_RESOLUCION(rs.getLong(1));
        simitResolucion.setESTADO(rs.getInt(2));
        simitResolucion.setFECHA_REGISTRO(rs.getTimestamp(3));
        simitResolucion.setFECHA_REPORTE(rs.getDate(4));
        simitResolucion.setRESCONSECUTIVO(rs.getString(5));
        simitResolucion.setRESNUMERO(rs.getString(6));
        simitResolucion.setRESNUMANT(rs.getString(7));
        simitResolucion.setRESFECHA(rs.getString(8));
        simitResolucion.setRESTIPORES(rs.getString(9));
        simitResolucion.setRESFHASTA(rs.getString(10));
        simitResolucion.setRESCOMP(rs.getString(11));
        simitResolucion.setRESCOMPF(rs.getString(12));
        simitResolucion.setRESNIPINFRAC(rs.getString(13));
        simitResolucion.setRESTIPODOC(rs.getString(14));
        simitResolucion.setRESNOMBE(rs.getString(15));
        simitResolucion.setRESAPELLIDO(rs.getString(16));
        simitResolucion.setRESDIRINFRACTOR(rs.getString(17));
        simitResolucion.setRESTELEINFRACTOR(rs.getString(18));
        simitResolucion.setRESIDCIUDAD(rs.getString(19));
        simitResolucion.setRESVALOR(rs.getString(20));
        simitResolucion.setRESVALAD(rs.getString(21));
        simitResolucion.setRESORGANISMO(rs.getString(22));
        simitResolucion.setRESCOMPOLCA(rs.getString(23));
        simitResolucion.setRESINFRACCION(rs.getString(24));
        simitResolucion.setRESVALINF(rs.getString(25));
        simitResolucion.setRESVALPAG(rs.getString(26));
        simitResolucion.setFkSimitPlano(rs.getLong(27));
        return simitResolucion;
    }

}
