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
public class SimitRecaudo {

    private long ID_SIMIT_RECAUDO;
    private int ESTADO;
    private Timestamp FECHA_REGISTRO;
    private Date FECHA_REPORTE;
    private String RECCONSECUTIVO;
    private String RECFAPL;
    private String RECHORA;
    private String RECFTRAN;
    private String RECCANAL;
    private String RECORIGEN;
    private String RECEFECTIVO;
    private String RECCHEQUE;
    private String RECTOTAL;
    private String RECDOCUMENTO;
    private String RECPOLCA;
    private String RECNIP;
    private String RECTIPOREC;
    private String RECSECRET;
    private String RECNUM;
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

    public long getID_SIMIT_RECAUDO() {
        return ID_SIMIT_RECAUDO;
    }

    public void setID_SIMIT_RECAUDO(long ID_SIMIT_RECAUDO) {
        this.ID_SIMIT_RECAUDO = ID_SIMIT_RECAUDO;
    }

    public String getRECCANAL() {
        return RECCANAL;
    }

    public void setRECCANAL(String RECCANAL) {
        this.RECCANAL = RECCANAL;
    }

    public String getRECCHEQUE() {
        return RECCHEQUE;
    }

    public void setRECCHEQUE(String RECCHEQUE) {
        this.RECCHEQUE = RECCHEQUE;
    }

    public String getRECCONSECUTIVO() {
        return RECCONSECUTIVO;
    }

    public void setRECCONSECUTIVO(String RECCONSECUTIVO) {
        this.RECCONSECUTIVO = RECCONSECUTIVO;
    }

    public String getRECDOCUMENTO() {
        return RECDOCUMENTO;
    }

    public void setRECDOCUMENTO(String RECDOCUMENTO) {
        this.RECDOCUMENTO = RECDOCUMENTO;
    }

    public String getRECEFECTIVO() {
        return RECEFECTIVO;
    }

    public void setRECEFECTIVO(String RECEFECTIVO) {
        this.RECEFECTIVO = RECEFECTIVO;
    }

    public String getRECFAPL() {
        return RECFAPL;
    }

    public void setRECFAPL(String RECFAPL) {
        this.RECFAPL = RECFAPL;
    }

    public String getRECFTRAN() {
        return RECFTRAN;
    }

    public void setRECFTRAN(String RECFTRAN) {
        this.RECFTRAN = RECFTRAN;
    }

    public String getRECHORA() {
        return RECHORA;
    }

    public void setRECHORA(String RECHORA) {
        this.RECHORA = RECHORA;
    }

    public String getRECNIP() {
        return RECNIP;
    }

    public void setRECNIP(String RECNIP) {
        this.RECNIP = RECNIP;
    }

    public String getRECNUM() {
        return RECNUM;
    }

    public void setRECNUM(String RECNUM) {
        this.RECNUM = RECNUM;
    }

    public String getRECORIGEN() {
        return RECORIGEN;
    }

    public void setRECORIGEN(String RECORIGEN) {
        this.RECORIGEN = RECORIGEN;
    }

    public String getRECPOLCA() {
        return RECPOLCA;
    }

    public void setRECPOLCA(String RECPOLCA) {
        this.RECPOLCA = RECPOLCA;
    }

    public String getRECSECRET() {
        return RECSECRET;
    }

    public void setRECSECRET(String RECSECRET) {
        this.RECSECRET = RECSECRET;
    }

    public String getRECTIPOREC() {
        return RECTIPOREC;
    }

    public void setRECTIPOREC(String RECTIPOREC) {
        this.RECTIPOREC = RECTIPOREC;
    }

    public String getRECTOTAL() {
        return RECTOTAL;
    }

    public void setRECTOTAL(String RECTOTAL) {
        this.RECTOTAL = RECTOTAL;
    }

    public static SimitRecaudo load(ResultSet rs)throws SQLException{
        SimitRecaudo simitRecaudo = new SimitRecaudo();
        simitRecaudo.setID_SIMIT_RECAUDO(rs.getLong(1));
        simitRecaudo.setESTADO(rs.getInt(2));
        simitRecaudo.setFECHA_REGISTRO(rs.getTimestamp(3));
        simitRecaudo.setFECHA_REPORTE(rs.getDate(4));
        simitRecaudo.setRECCONSECUTIVO(rs.getString(5));
        simitRecaudo.setRECFAPL(rs.getString(6));
        simitRecaudo.setRECHORA(rs.getString(7));
        simitRecaudo.setRECFTRAN(rs.getString(8));
        simitRecaudo.setRECCANAL(rs.getString(9));
        simitRecaudo.setRECORIGEN(rs.getString(10));
        simitRecaudo.setRECEFECTIVO(rs.getString(11));
        simitRecaudo.setRECCHEQUE(rs.getString(12));
        simitRecaudo.setRECTOTAL(rs.getString(13));
        simitRecaudo.setRECDOCUMENTO(rs.getString(14));
        simitRecaudo.setRECPOLCA(rs.getString(15));
        simitRecaudo.setRECNIP(rs.getString(16));
        simitRecaudo.setRECTIPOREC(rs.getString(17));
        simitRecaudo.setRECSECRET(rs.getString(18));
        simitRecaudo.setRECNUM(rs.getString(19));
        simitRecaudo.setFkSimitPlano(rs.getLong(20));
        return simitRecaudo;
    }

}
