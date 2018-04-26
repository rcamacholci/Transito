/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

/**
 *
 * @author Flia. Aguas Macias
 */
public class Biometrico {
    private long id_persona;
    private byte[] bidimensional;
    private byte[] firma;
    private byte[] foto;
    private int dedo1;
    private int dedo2;
    private byte[] huella1;
    private byte[] huella2;
    private byte[] template;
    private int motivoRechazo;

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

    public long getId_persona() {
        return id_persona;
    }

    public void setId_persona(long id_persona) {
        this.id_persona = id_persona;
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

    public static Biometrico load(java.sql.ResultSet rs) throws Exception{
        Biometrico biometrico = new Biometrico();
        if(rs.getString(1)!=null)
            biometrico.setBidimensional(rs.getString(1).getBytes());
        if(rs.getString(2)!=null)
            biometrico.setFirma(rs.getString(2).getBytes());
        if(rs.getString(3)!=null)
            biometrico.setFoto(rs.getString(3).getBytes());
        biometrico.setDedo1(rs.getInt(4));
        biometrico.setDedo2(rs.getInt(5));
        if(rs.getString(6)!=null)
            biometrico.setHuella1(rs.getString(6).getBytes());
        if(rs.getString(7)!=null)
            biometrico.setHuella2(rs.getString(7).getBytes());
        if(rs.getString(8)!=null)
            biometrico.setTemplate(rs.getString(8).getBytes());
        biometrico.setMotivoRechazo(rs.getInt(9));
        return biometrico;
    }
}
