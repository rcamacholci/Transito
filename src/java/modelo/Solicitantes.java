/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

/**
 *
 * @author Jefrey
 */
public class Solicitantes {
    
    private String tipodocumento;
    private String documento;
    private String cupltransversal;
    private String token;

    public Solicitantes(String tipodocumento, String documento, String token) {
        this.tipodocumento = tipodocumento;
        this.documento = documento;
        this.token = token;
    }

    public String getTipodocumento() {
        return tipodocumento;
    }

    public void setTipodocumento(String tipodocumento) {
        this.tipodocumento = tipodocumento;
    }

    public String getDocumento() {
        return documento;
    }

    public void setDocumento(String documento) {
        this.documento = documento;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getCupltransversal() {
        return cupltransversal;
    }

    public void setCupltransversal(String cupltransversal) {
        this.cupltransversal = cupltransversal;
    }
    
}
