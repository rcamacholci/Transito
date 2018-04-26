package webservices.security;

import java.util.Properties;
import org.apache.axis.MessageContext;
import org.apache.axis.client.AxisClient;
import org.apache.axis.configuration.NullProvider;
import org.apache.ws.security.WSConstants;
import org.apache.ws.security.WSSecurityEngine;
import org.apache.ws.security.components.crypto.Crypto;
import org.apache.ws.security.components.crypto.CryptoFactory;
import org.apache.ws.security.message.WSSecEncrypt;
import org.apache.ws.security.message.WSSecHeader;
import org.apache.ws.security.message.WSSecSignature;
import org.apache.ws.security.message.WSSecUsernameToken;
import org.apache.ws.security.message.token.Reference;
import org.apache.ws.security.message.token.SecurityTokenReference;
import org.apache.ws.security.util.WSSecurityUtil;
import org.apache.xml.security.signature.XMLSignature;
import org.w3c.dom.Document;

public class WSSecurityClient{

   private static final WSSecurityEngine secEngine = new WSSecurityEngine();
   private static final Crypto crypto = CryptoFactory.getInstance(getProperties());
   private AxisClient engine = null;
   private MessageContext msgContext = null;
   public static String aliasCert = null;

   public WSSecurityClient() throws Exception{
         engine = new AxisClient(new NullProvider());
         msgContext = new MessageContext(engine);
         if(!modelo.Model.keyStoreType.equals("jks"))
            aliasCert = crypto.getKeyStore().aliases().nextElement();
         else
            aliasCert = modelo.Model.aliasHandler;
   }

   public Document addUserTokens(Document doc)throws Exception{

      WSSecUsernameToken builder =  new WSSecUsernameToken();
      builder.setPasswordType(WSConstants.PASSWORD_TEXT);
      builder.setUserInfo(modelo.Model.userHandler, modelo.Model.passUserHandler);
      builder.addCreated();
      builder.addNonce();
      builder.prepare(doc);

      WSSecHeader secHeader = new WSSecHeader("",true);
      secHeader.insertSecurityHeader(doc);
      Document tokenDoc = builder.build(doc, secHeader);
      builder.appendToHeader(secHeader);
      
      
      Reference ref = new Reference(doc);
      ref.setValueType("UsernameToken");
      SecurityTokenReference secRef =  new SecurityTokenReference(doc);
      secRef.setReference(ref);

      WSSecurityUtil.setNamespace(secRef.getElement(),WSConstants.WSSE_NS,WSConstants.WSSE_PREFIX);
      return tokenDoc;

   }

   public Document signSOAPEnvelope(Document doc)throws Exception{

      WSSecSignature signer = new WSSecSignature();
      signer.setUserInfo(aliasCert, modelo.Model.passAliasHandler);
      signer.setSignatureAlgorithm(XMLSignature.ALGO_ID_SIGNATURE_RSA_SHA1);
      signer.setKeyIdentifierType (WSConstants.BST_DIRECT_REFERENCE);

      WSSecHeader secHeader = new WSSecHeader();
      secHeader.insertSecurityHeader(doc);
      Document signedDoc = signer.build(doc, crypto,secHeader);
      return signedDoc;

   }

   public Document encryptSOAPEnvelope(Document doc)throws Exception{

      WSSecEncrypt encrypt = new WSSecEncrypt();
      encrypt.setUserInfo(aliasCert,modelo.Model.passAliasHandler);

      WSSecHeader secHeader = new WSSecHeader();
      secHeader.insertSecurityHeader(doc);

      Document encryptedDoc = encrypt.build(doc, crypto,secHeader);
      return encryptedDoc;

   }

   public static Properties getProperties(){
       Properties property = new Properties();
       property.setProperty("org.apache.ws.security.crypto.provider", "org.apache.ws.security.components.crypto.Merlin");
       property.setProperty("org.apache.ws.security.crypto.merlin.keystore.type", modelo.Model.keyStoreType);
       property.setProperty("org.apache.ws.security.crypto.merlin.keystore.password", modelo.Model.keyStorePass);
       property.setProperty("org.apache.ws.security.crypto.merlin.keystore.alias", modelo.Model.aliasHandler);
       property.setProperty("org.apache.ws.security.crypto.merlin.file",modelo.Model.keyStoreFile);
       return property;
   }

}
