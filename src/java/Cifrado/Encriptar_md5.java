/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Cifrado;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 *
 * @author PCSISTEMAS1
 */
public class Encriptar_md5 {
    
     public String get_md5(String var){ 
         
         String md5=""; 
         
         try { 
             if (!var.equalsIgnoreCase("")) { 
                 MessageDigest md = MessageDigest.getInstance("MD5"); 
                 md.reset(); 
                 md.update(var.getBytes()); 
                 byte bytes[] = md.digest(); 
                 StringBuilder sb = new StringBuilder(); 
                 
                 for (int i = 0; i < bytes.length; i++) { 
                     String hex = Integer.toHexString(0xff & bytes[i] >> 4); 
                     
                     if (hex.length() == 1) { 
                         sb.append('0'); 
                     } sb.append(hex); 
                 } md5 = sb.toString(); 
             } } catch (NoSuchAlgorithmException e) { 
                 md5 = "Error inesperado"; 
             } 
         return md5; 
     }
    
}
