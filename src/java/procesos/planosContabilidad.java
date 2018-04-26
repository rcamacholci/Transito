 /*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package procesos;

import java.io.DataOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.sql.SQLException;
import modelo.Usuario;
import java.util.*;
import java.util.Date;
import java.text.*;
import modelo.*;
import procesos.*;

/** @nuevas 
import modelo.Pago;
import modelo.Distribucion;
import modelo.Taquilla;
/** @author EOA */
public class planosContabilidad{

    public planosContabilidad(String fechaI,String fechaF){
            Model model = new Model();
            try{
            File f = new File("C:/Civitrans/transito/build/web/paginas/data/contabilidad/CONTABILIDAD_"+fechaI.replaceAll("/", "")+"-"+fechaF.replaceAll("/", "")+".txt");
            FileOutputStream fos = new FileOutputStream(f);
            DataOutputStream dos = new DataOutputStream(fos);
            String registro ="";
        for(int j=0;j<10;j++){
            dos.writeBytes(registro);
            dos.writeBytes("\n");
        }
        java.util.List planoContabilidad = null;
        java.util.List lsec = new java.util.LinkedList();
    if(planoContabilidad.size()>0){
        lsec = model.planoContabilidad(fechaI, fechaF);
        for(int j=0;j<lsec.size();j++){
            registro +=lsec.get(j);
            dos.writeBytes(registro);
            dos.writeBytes("\n");
    }
   }
            dos.writeBytes(registro);
            dos.writeBytes("\n");
            dos.flush();
            dos.close();
            fos.close();
        }catch(Exception exc){
            exc.printStackTrace();
        }
    }

}
