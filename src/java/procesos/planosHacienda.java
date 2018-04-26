 /*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package procesos;

import java.io.DataOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.sql.SQLException;
import modelo.Auditoria_Detalle;
import modelo.DatosVehiculo;
import modelo.Divipo;
import modelo.Empresa;
import modelo.Formulario;
import modelo.Historico_Color;
import modelo.Model;
import modelo.Persona;
import modelo.Propietario;
import modelo.Radicacion;
import modelo.Radicacion_Alerta;
import modelo.Sede;
import modelo.Usuario;
import modelo.Vehiculo;

/**
 *
 * @author Administrador
 */
public class planosHacienda {

    public planosHacienda(Model model,Usuario usuario,String fechaI,String fechaF){
        try{
            File f = new File("C:/Civitrans/transito/build/web/paginas/data/externs/ATLANTICO_"+fechaI.replaceAll("/", "")+"-"+fechaF.replaceAll("/", "")+".txt");
            FileOutputStream fos = new FileOutputStream(f);
            DataOutputStream dos = new DataOutputStream(fos);
            java.util.HashMap<Long,String> tramites = getTramites();
            java.util.List<Radicacion> radicaciones = model.consultarRadicaciones(fechaI, fechaF, usuario.getFk_sede());
            for(Radicacion radicacion:radicaciones){
                java.util.List formularios =  model.consultarFormularios(radicacion.getId_radicacion());
                for(int i=0;i<formularios.size();i++){
                    Formulario formulario = (Formulario)formularios.get(i);
                    Vehiculo vehiculo = model.consultarVehiculo(formulario.getPlaca());
                    if(vehiculo!=null&&formulario!=null){
                        if(tramites.containsKey(formulario.getFk_tramite())){
                            String registro = new java.text.SimpleDateFormat("dd/MM/yyyy").format(radicacion.getFecha())+"|"+tramites.get(formulario.getFk_tramite())+"|"+formulario.getPlaca()+"|";
                            switch((int)formulario.getFk_tramite()){
                                case 5:registro += ultimoColor(model, formulario.getPlaca())+"|"+model.consultarRadicacionColor(formulario.getId_formulario());break;
                                case 17:registro += ultimoMotor(model, vehiculo.getId_vehiculo())+"|"+formulario.getMotor();break;
                                case 6:registro += letraServicio(ultimoServicio(model, formulario.getPlaca()))+"|"+letraServicio(Integer.parseInt(vehiculo.getServicio()+""));break;
                                case 15:registro += "|"+new java.text.SimpleDateFormat("dd/MM/yyyy").format(radicacion.getFecha());break;
                                case 25:registro += ultimoChasis(model, vehiculo.getId_vehiculo())+"|"+formulario.getChasis();break;
                                case 24:registro += ultimoMotor(model, vehiculo.getId_vehiculo())+"|"+formulario.getMotor();break;
                                case 13:registro += "|"+new java.text.SimpleDateFormat("dd/MM/yyyy").format(radicacion.getFecha())+"|";
                                        Radicacion_Alerta ra = model.consultarRadicacionAlerta(formulario.getId_formulario());
                                        if(ra!=null){
                                            Persona pa = model.consultarPersona(ra.getFk_persona());
                                            String td = model.crearHashParametrosAbreviatura(5).get(pa.getTipo_documento()+"").toString();
                                            registro += td+"|"+pa.getDocumento()+"|";
                                            if(pa.getTipo_documento()==2){
                                                Empresa empresa = model.consultarEmpresa(pa.getTipo_documento(), pa.getDocumento());
                                                if(empresa!=null){
                                                    registro += empresa.getRazon_social();
                                                }else{
                                                   registro += eval(eval(pa.getNombre_1())+" "+eval(pa.getApellido_1())+" "+eval(pa.getApellido_2()));
                                                }
                                            }else{
                                               registro += eval(eval(pa.getNombre_1())+" "+eval(pa.getApellido_1())+" "+eval(pa.getApellido_2()));
                                            }
                                        }
                                        ;break;
                                case 1:registro = new java.text.SimpleDateFormat("dd/MM/yyyy").format(radicacion.getFecha())+"|"+tramites.get(formulario.getFk_tramite())+"||"+formulario.getPlaca()+"|"+formulario.getMotor();break;
                                case 4:registro += "|"+new java.text.SimpleDateFormat("dd/MM/yyyy").format(radicacion.getFecha())+"|";
                                        Sede sede = model.consultarSede(formulario.getSede_movimiento());
                                        if(sede!=null){
                                            Divipo dv = model.getDivipobyCodigo(sede.getCodigo());
                                            if(dv!=null){
                                                registro += dv.getNombre_municipio()+"|"+dv.getNombre_depto();
                                            }
                                        }
                                        ;break;
                                case 3:registro += "|"+new java.text.SimpleDateFormat("dd/MM/yyyy").format(radicacion.getFecha())+"|";
                                        sede = model.consultarSede(formulario.getSede_movimiento());
                                        if(sede!=null){
                                            Divipo dv = model.getDivipobyCodigo(sede.getCodigo());
                                            if(dv!=null){
                                                registro += dv.getNombre_municipio()+"|"+dv.getNombre_depto();
                                            }
                                        }
                                        ;break;
                                case 2: long fkPersona = ultimoPropietario(model,vehiculo.getId_vehiculo());
                                        if(fkPersona!=0){
                                            Persona pa = model.consultarPersona(fkPersona);
                                            String td = model.crearHashParametrosAbreviatura(5).get(pa.getTipo_documento()+"").toString();
                                            registro += td+"|"+pa.getDocumento()+"|";
                                            if(pa.getTipo_documento()==2){
                                                Empresa empresa = model.consultarEmpresa(pa.getTipo_documento(), pa.getDocumento());
                                                if(empresa!=null){
                                                    registro += empresa.getRazon_social();
                                                }else{
                                                   registro += eval(eval(pa.getNombre_1())+" "+eval(pa.getApellido_1())+" "+eval(pa.getApellido_2()));
                                                }
                                            }else{
                                               registro += eval(eval(pa.getNombre_1())+" "+eval(pa.getApellido_1())+" "+eval(pa.getApellido_2()));
                                            }
                                            registro += "|"+new java.text.SimpleDateFormat("dd/MM/yyyy").format(radicacion.getFecha())+"|";
                                            Propietario prop = model.getUnicoPropietarioVehiculo(vehiculo.getId_vehiculo());
                                            if(prop!=null){
                                                pa = model.consultarPersona(prop.getFk_persona());
                                                td = model.crearHashParametrosAbreviatura(5).get(pa.getTipo_documento()+"").toString();
                                                registro += td+"|"+pa.getDocumento()+"|";
                                                if(pa.getTipo_documento()==2){
                                                    Empresa empresa = model.consultarEmpresa(pa.getTipo_documento(), pa.getDocumento());
                                                    if(empresa!=null){
                                                        registro += empresa.getRazon_social();
                                                    }else{
                                                       registro += eval(eval(pa.getNombre_1())+" "+eval(pa.getApellido_1())+" "+eval(pa.getApellido_2()));
                                                    }
                                                }else{
                                                   registro += eval(eval(pa.getNombre_1())+" "+eval(pa.getApellido_1())+" "+eval(pa.getApellido_2()));
                                                }
                                            }
                                        };break;
                                case 8: registro += "|"+model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 4, 42);
                            }
                            dos.writeBytes(registro);
                            dos.writeBytes("\n");
                        }
                    }
                }
            }
            dos.flush();
            dos.close();
            fos.close();
        }catch(Exception exc){
            exc.printStackTrace();
        }
    }

    public java.util.HashMap<Long,String> getTramites(){
        java.util.HashMap<Long,String> tramites = new java.util.HashMap<Long,String>();
        tramites.put((long)5, "01");
        tramites.put((long)17, "02");
        tramites.put((long)(long)6, "03");
        tramites.put((long)15, "04");
        tramites.put((long)25, "05");
        tramites.put((long)24, "06");
        tramites.put((long)13, "07");
        tramites.put((long)1, "08");
        tramites.put((long)4, "09");
        tramites.put((long)3, "10");
        tramites.put((long)2, "11");
        tramites.put((long)8, "12");
        return tramites;
    }

    public long ultimoColor(Model model,String placa){
        try {
            java.util.List lista = model.consultarColoresPlaca(placa);
            for(int i=lista.size()-1;i>=0;i--){
                Historico_Color color = (Historico_Color)lista.get(i);
                if(color.getFecha_fin()!=null)
                    return color.getFk_color();
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    public String ultimoMotor(Model model,long idVehiculo){
        try {
            java.util.List lista = model.listarDatosVehiculoByTipo(idVehiculo,40,19);
            if (lista.size() > 0) {
                return ((DatosVehiculo) lista.get(lista.size()-1)).getValor();
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return "";
    }

    public String ultimoChasis(Model model,long idVehiculo){
        try {
            java.util.List lista = model.listarDatosVehiculoByTipo(idVehiculo,40,20);
            if (lista.size() > 0) {
                return ((DatosVehiculo) lista.get(lista.size()-1)).getValor();
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return "";
    }

    public int ultimoServicio(Model model,String placa){
        try {
            Vehiculo vehiculo = model.consultarVehiculo(placa);
            if (vehiculo != null) {
                java.util.List lista = model.listarDetalleAuditoria(vehiculo.getId_vehiculo(),"VEHICULOS","SERVICIO");
                if (lista.size() > 0) {
                    return Integer.parseInt(((Auditoria_Detalle) lista.get(lista.size()-1)).getValor_anterior());
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    public long ultimoPropietario(Model model,long idVehiculo){
        try {
            java.util.List lista = model.crear_Lista_Propietarios(idVehiculo);
            for(int i=0;i<lista.size();i++){
                Propietario propietario = (Propietario)lista.get(i);
                if(propietario.getFecha_final()!=null)
                    return propietario.getFk_persona();
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    public String letraServicio(int servicio){
        return (servicio==1)?"PA":(servicio==2?"PU":"");
    }

    public String eval(String v){
        if(v==null)
            return "";
        if(v.equals("."))
            return "";
        return v.trim();
    }
}
