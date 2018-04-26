/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

/**
 *
 * @author Civitrans
 */
public class Avaluos {

    private int clase = 0;
    private int marca = 0;
    private int linea = 0;
    private int cilindraje = 0;
    private int modelo = 0;
    private int pasajeros = 0;
    private float toneladas = 0;
    private int carroceria = 0;
    private int modalidad = 0;
    private int vigencia = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
    private float avaluo = 0;

    public int getCarroceria() {
        return carroceria;
    }

    public void setCarroceria(int carroceria) {
        this.carroceria = carroceria;
    }

    public int getCilindraje() {
        return cilindraje;
    }

    public void setCilindraje(int cilindraje) {
        this.cilindraje = cilindraje;
    }

    public int getLinea() {
        return linea;
    }

    public void setLinea(int linea) {
        this.linea = linea;
    }

    public int getMarca() {
        return marca;
    }

    public void setMarca(int marca) {
        this.marca = marca;
    }

    public int getModelo() {
        return modelo;
    }

    public void setModelo(int modelo) {
        this.modelo = modelo;
    }

    public int getPasajeros() {
        return pasajeros;
    }

    public void setPasajeros(int pasajeros) {
        this.pasajeros = pasajeros;
    }

    public float getToneladas() {
        return toneladas;
    }

    public void setToneladas(float toneladas) {
        this.toneladas = toneladas;
    }

    public float getAvaluo() {
        return avaluo;
    }

    public void setAvaluo(float avaluo) {
        this.avaluo = avaluo;
    }

    public int getClase() {
        return clase;
    }

    public void setClase(int clase) {
        this.clase = clase;
    }

    public int getModalidad() {
        return modalidad;
    }

    public void setModalidad(int modalidad) {
        this.modalidad = modalidad;
    }
    
    public String getAvaluo(Model model)throws Exception{
        String grupo = "";
        String subGrupo = "";
        String msg = "";
        System.out.println("M:"+modalidad+"/clase:"+clase+"/marca:"+marca+"/cilindraje:"+cilindraje+"/modelo:"+modelo+"/VIGENCIA:"+vigencia);
        if(modalidad!=0){
            if(clase!=0){
                if(marca!=0){
                    if(cilindraje!=0){
                        if(modelo!=0){
                            if(modalidad==1){//PASAJEROS
                                if(clase==10||clase==14||clase==17||clase==18){
                                    grupo = model.consultarConfiguracionAvaluo(1,vigencia,String.valueOf(marca));
                                    System.out.println("Grupo:"+grupo);
                                    if(grupo==null)
                                        grupo = "A";
                                    subGrupo = model.consultarConfiguracionAvaluo(1,vigencia,String.valueOf(cilindraje));
                                    System.out.println("Subgrupo:"+subGrupo);
                                    if(subGrupo==null)
                                        subGrupo = "1";
                                    avaluo = model.consultarAvaluo(1,vigencia,grupo+subGrupo,modelo);
                                    System.out.println("Avaluo:"+avaluo);
                                }else{

                                }
                            }else{

                            }
                        }else{
                            msg = "NO EXISTE MODELO DEL VEHICULO";
                        }
                    }else{
                        msg = "NO EXISTE CILINDRAJE DEL VEHICULO";
                    }
                }else{
                    msg = "NO EXISTE MARCA DEL VEHICULO";
                }
            }else{
                msg = "NO EXISTE CLASE DEL VEHICULO";
            }
        }else{
            msg = "NO EXISTE MODALIDAD DEL VEHICULO";
        }
        return msg;
    }


}
