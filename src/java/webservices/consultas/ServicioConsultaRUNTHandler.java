package webservices.consultas;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.StringWriter;
import java.util.HashSet;
import java.util.Set;

import java.util.logging.Level;
import java.util.logging.Logger;
import javax.xml.namespace.QName;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.soap.SOAPException;
import javax.xml.soap.SOAPMessage;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import javax.xml.ws.handler.MessageContext;
import javax.xml.ws.handler.soap.SOAPHandler;
import javax.xml.ws.handler.soap.SOAPMessageContext;
import org.w3c.dom.Document;
import org.xml.sax.SAXException;
import webservices.security.WSSecurityClient;
/**
 *
 * @author Civitrans
 */
public class ServicioConsultaRUNTHandler implements SOAPHandler<SOAPMessageContext> {
    final String HANDLER_NAME = "ServicioConsultaRUNTHandler";
    public Set<QName> getHeaders() {
        QName securityHeader = new QName("http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd", "Security", "");
        HashSet<QName> headers = new HashSet<QName>();
        headers.add(securityHeader);
        return headers;
    }

    public boolean handleMessage(SOAPMessageContext smc) {


        Boolean outboundProperty = (Boolean)smc.get(MessageContext.MESSAGE_OUTBOUND_PROPERTY);
        if (outboundProperty) {
            try {

                SOAPMessage message = smc.getMessage();
                
                WSSecurityClient securityClient = new WSSecurityClient();

                Document UserTokenDoc = securityClient.addUserTokens(toDocument(message));

                Document SignDoc = securityClient.signSOAPEnvelope(UserTokenDoc);

                String finalDocument = DocumentToString(SignDoc);
                ByteArrayInputStream stream = new ByteArrayInputStream(finalDocument.getBytes());
                StreamSource source = new StreamSource(stream);
                message.getSOAPPart().setContent(source);
                smc.setMessage(message);
                String fecha = new java.text.SimpleDateFormat("dd-MM-yyyy hh-mm-ss").format(new java.util.Date());
                java.io.File f = new java.io.File("C:/Civitrans/soapIn/Consulta "+fecha+".xml");
                java.io.FileOutputStream fos = new java.io.FileOutputStream(f);
                fos.write(finalDocument.getBytes());
            } catch (Exception ex) {
                ex.printStackTrace();
               
            }
        } else {
            try{
                SOAPMessage message = smc.getMessage();
                String finalDocument = DocumentToString(toDocument(message));
                String fecha = new java.text.SimpleDateFormat("dd-MM-yyyy hh-mm-ss").format(new java.util.Date());
                java.io.File f = new java.io.File("C:/Civitrans/soapIn/Consultas In "+fecha+".xml");
                java.io.FileOutputStream fos = new java.io.FileOutputStream(f);
                fos.write(finalDocument.getBytes());
            }catch(Exception sd){
                sd.printStackTrace();
            }
        }
        return true;
    }

    public boolean handleFault(SOAPMessageContext smc) {
        return true;
    }

    // nothing to clean up
    public void close(MessageContext messageContext) {
    }

    public Document toDocument(SOAPMessage soapMsg) throws ParserConfigurationException, SAXException, SOAPException, IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        soapMsg.writeTo(baos);
        ByteArrayInputStream bais = new ByteArrayInputStream(baos.toByteArray());
        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        dbf.setNamespaceAware(true);
        DocumentBuilder db = dbf.newDocumentBuilder();
        Document doc = db.parse(bais);
        return doc;
    }

    public String DocumentToString(Document doc)throws Exception{
        TransformerFactory tFactory = TransformerFactory.newInstance();
        Transformer transformer = tFactory.newTransformer();
        DOMSource source = new DOMSource(doc);
        StringWriter sw=new StringWriter();
        StreamResult result = new StreamResult(sw);
        transformer.transform(source, result);
        String xmlString=sw.toString();
        return xmlString;

    }

}
