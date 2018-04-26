/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

/**
 *
 * @author Flia. Aguas Macias
 */
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.view.JasperViewer;
import net.sf.jasperreports.engine.JasperRunManager;
import org.apache.commons.logging.Log;

/**
* @ version 1.0
* @ author José Pacheco
*/
public class Reports implements Serializable{

    public Reports(Model model,Map parameters,String dir,javax.servlet.http.HttpServletResponse response)throws Exception{
            JasperPrint jasperPrint = JasperFillManager.fillReport(dir, parameters, model.getCon());
            byte[] bytes = JasperRunManager.runReportToPdf(dir, parameters,model.getCon()); 
            ServletOutputStream outputStream = response.getOutputStream();
            response.setContentType("application/pdf");
            response.setContentLength(bytes.length);
            response.addHeader("Content-Disposition","inline;");
            response.setBufferSize(1024 * 15);
            outputStream.write(bytes);
            outputStream.flush();
            outputStream.close(); 
    }

    public Reports(byte[] content,javax.servlet.http.HttpServletResponse response)throws Exception{
            ServletOutputStream outputStream = response.getOutputStream();
            response.setContentType("application/pdf");
            response.setContentLength(content.length);
            response.addHeader("Content-Disposition","inline;");
            response.setBufferSize(1024 * 15);
            outputStream.write(content);
            outputStream.flush();
            outputStream.close();
    }
}



