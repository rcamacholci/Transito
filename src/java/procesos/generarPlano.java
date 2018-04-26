/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package procesos;

import modelo.Model;

/**
 *
 * @author Administrador
 */
import java.util.HashMap;
import java.util.List;
import java.io.File;
import java.io.FileOutputStream;
import java.io.DataOutputStream;

public class generarPlano {

  Model conexion = null;
  java.util.List listaLicencias = new java.util.LinkedList();

  public generarPlano(Model conexion) throws Exception {
    this.conexion = conexion;
    generarPlanoVehiculos();
    generarPlanoPropietarios();
    listaLicencias.clear();
    generarPlanoTramites();
    generarPlanoPrendas();
  }

  public void generarPlanoVehiculos() throws Exception {

    File f = new File("C:/Civitrans/transito/build/web/paginas/data/planes/TTAMVEHI.txt");
    FileOutputStream fos = new FileOutputStream(f);
    DataOutputStream dos = new DataOutputStream(fos);

    List listaVehiculos = conexion.consultarVehiculosTTAMVEHI();
    for (int i = 0; i < listaVehiculos.size(); i++) {
      HashMap vehiculo = (HashMap) listaVehiculos.get(i);
      String organismo = vehiculo.get("ORGANISMO").toString();
      String placa = autocompletar(vehiculo.get("PLACA"), 6, 1, 1);
      String marca = autocompletar(vehiculo.get("MARCA"), 30, 1, 1);
      String linea = autocompletar(vehiculo.get("LINEA"), 50, 1, 1);
      String clase = autocompletar(vehiculo.get("CLASE"), 2, 0, 0);//Revisar los casos clase 0 = 10
      String color = autocompletar(vehiculo.get("COLOR"), 60, 1, 1);
      String servicio = autocompletar(vehiculo.get("SERVICIO"), 2, 0, 0);
      String carroceria = autocompletar(vehiculo.get("CARROCERIA"), 3, 0, 0);
      String modalidad = autocompletar(vehiculo.get("MODALIDAD"), 1, 0, 0);
      String cilindraje = autocompletar(vehiculo.get("CILINDRAJE"), 5, 0, 0);
      String modelo = autocompletar(vehiculo.get("MODELO"), 4, 0, 0);
      if (Integer.parseInt(modelo) < 1901) {
        modelo = "1901";
      }
      String motor = autocompletar(vehiculo.get("NRO_MOTOR"), 25, 1, 1);
      motor = getMCS(motor);
      String chasis = autocompletar(vehiculo.get("NRO_CHASIS"), 25, 1, 1);
      chasis = getMCS(chasis);
      String serie = autocompletar(vehiculo.get("NRO_SERIE"), 25, 1, 1);
      serie = getMCS(serie);
      if (motor.equals(chasis)) {
        chasis = autocompletar(chasis + "", 25, 1, 1);
      }
      if (motor.equals(serie)) {
        serie = autocompletar(serie + "", 25, 1, 1);
      }
      String toneladas = autocompletar(vehiculo.get("CAP_TONELADAS"), 5, 0, 0);
      toneladas = toneladas.replaceAll(",", ".");
      String pasajeros = autocompletar(vehiculo.get("CAP_PASAJEROS"), 3, 0, 0);
      String fechamatricula = autocompletar(vehiculo.get("FECHA_MATRICULA"), 8, 1, 1);
      String licencia = autocompletar(vehiculo.get("NRO_LIC_TTO"), 10, 1, 1);//licencia transito <= 10
      licencia = getMCS(licencia);
      if (listaLicencias.contains(licencia) || licencia.trim().length() == 0) {
        licencia = autocompletar(placa, 10, 1, 1);
      } else {
        listaLicencias.add(licencia);
      }
      String sirev = autocompletar(vehiculo.get("NRO_FACTURA_SIREV"), 16, 0, 0);
      String combustible = autocompletar(vehiculo.get("TIPO_COMBUSTIBLE"), 1, 0, 0);
      String estado = autocompletar(vehiculo.get("ESTADO"), 1, 0, 0);
      int c = Integer.parseInt(carroceria);
      switch (Integer.parseInt(clase)) {
        case 1:
          if (Integer.parseInt(cilindraje) < 599) {
            cilindraje = "599";
          } else if (Integer.parseInt(cilindraje) > 7000) {
            cilindraje = "7000";
          }
          if (Integer.parseInt(pasajeros) < 2) {
            pasajeros = "2";
          } else if (Integer.parseInt(pasajeros) > 10) {
            pasajeros = "10";
          }
          toneladas = "0";
          break;

        case 2:
          if (Integer.parseInt(cilindraje) < 2150) {
            cilindraje = "2150";
          } else if (Integer.parseInt(cilindraje) > 12500) {
            cilindraje = "12500";
          }
          if (Integer.parseInt(pasajeros) < 16) {
            pasajeros = "16";
          } else if (Integer.parseInt(pasajeros) > 163) {
            pasajeros = "163";
          }
          toneladas = "0";
          break;
        case 3:
          if (Integer.parseInt(cilindraje) < 2150) {
            cilindraje = "2150";
          } else if (Integer.parseInt(cilindraje) > 8500) {
            cilindraje = "8500";
          }
          if (Integer.parseInt(pasajeros) < 12) {
            pasajeros = "12";
          } else if (Integer.parseInt(pasajeros) > 35) {
            pasajeros = "35";
          }
          toneladas = "0";
          break;
        case 4:
          if (Integer.parseInt(cilindraje) < 2271) {
            cilindraje = "2271";
          } else if (Integer.parseInt(cilindraje) > 14945) {
            cilindraje = "14945";
          }
          if (Integer.parseInt(pasajeros) < 2) {
            pasajeros = "2";
          } else if (Integer.parseInt(pasajeros) > 9) {
            pasajeros = "9";
          }
          if (Double.parseDouble(toneladas) < 1300) {
            toneladas = "1300";
          } else if (Double.parseDouble(toneladas) > 30000) {
            toneladas = "30000";
          }
          ;
          break;
        case 5:
          if (Integer.parseInt(cilindraje) < 796) {
            cilindraje = "796";
          } else if (Integer.parseInt(cilindraje) > 7500) {
            cilindraje = "7500";
          }
          if (Integer.parseInt(pasajeros) < 2) {
            pasajeros = "2";
          } else if (Integer.parseInt(pasajeros) > 20) {
            pasajeros = "20";
          }

          if (Double.parseDouble(toneladas) > 3500) {
            toneladas = "3500";
          } else if (Double.parseDouble(toneladas) < 0) {
            toneladas = "0";
          }
          ;
          break;
        case 6:
          if (Integer.parseInt(cilindraje) < 535) {
            cilindraje = "535";
          } else if (Integer.parseInt(cilindraje) > 7400) {
            cilindraje = "7400";
          }
          if (Integer.parseInt(pasajeros) < 3) {
            pasajeros = "3";
          } else if (Integer.parseInt(pasajeros) > 13) {
            pasajeros = "13";
          }
          if (Double.parseDouble(toneladas) < 0) {
            toneladas = "0";
          } else if (Double.parseDouble(toneladas) > 2000) {
            toneladas = "2000";
          }
          ;
          break;
        case 7:
          if (Integer.parseInt(cilindraje) < 720) {
            cilindraje = "720";
          } else if (Integer.parseInt(cilindraje) > 6000) {
            cilindraje = "6000";
          }
          if (Integer.parseInt(pasajeros) < 6) {
            pasajeros = "6";
          } else if (Integer.parseInt(pasajeros) > 20) {
            pasajeros = "20";
          }
          toneladas = "0";
          break;
        case 8:
          if (Integer.parseInt(cilindraje) < 6000) {
            cilindraje = "6000";
          } else if (Integer.parseInt(cilindraje) > 19200) {
            cilindraje = "19200";
          }
          if (Integer.parseInt(pasajeros) < 2) {
            pasajeros = "2";
          } else if (Integer.parseInt(pasajeros) > 3) {
            pasajeros = "3";
          }
          toneladas = "0";
          break;
        case 10:
          if (Integer.parseInt(cilindraje) < 45) {
            cilindraje = "45";
          } else if (Integer.parseInt(cilindraje) > 1854) {
            cilindraje = "1854";
          }
          if (Integer.parseInt(pasajeros) < 1) {
            pasajeros = "1";
          } else if (Integer.parseInt(pasajeros) > 2) {
            pasajeros = "2";
          }
          toneladas = "0";
          break;
        case 11:
          if (Integer.parseInt(cilindraje) < 249) {
            cilindraje = "249";
          } else if (Integer.parseInt(cilindraje) > 8000) {
            cilindraje = "8000";
          }
          if (Integer.parseInt(pasajeros) < 1) {
            pasajeros = "1";
          } else if (Integer.parseInt(pasajeros) > 2) {
            pasajeros = "2";
          }
          if (Double.parseDouble(toneladas) < 0) {
            toneladas = "0";
          } else if (Double.parseDouble(toneladas) > 10000) {
            toneladas = "10000";
          }
          ;
          break;
        case 12:
          if (Integer.parseInt(cilindraje) < 0) {
            cilindraje = "0";
          } else if (Integer.parseInt(cilindraje) > 8000) {
            cilindraje = "8000";
          }
          if (Integer.parseInt(pasajeros) < 1) {
            pasajeros = "1";
          } else if (Integer.parseInt(pasajeros) > 2) {
            pasajeros = "2";
          }
          if (Double.parseDouble(toneladas) < 0) {
            toneladas = "0";
          } else if (Double.parseDouble(toneladas) > 15000) {
            toneladas = "15000";
          }
          ;
          break;
        case 14:
          if (Integer.parseInt(cilindraje) < 100) {
            cilindraje = "100";
          } else if (Integer.parseInt(cilindraje) > 1200) {
            cilindraje = "1200";
          }
          if (Integer.parseInt(pasajeros) < 1) {
            pasajeros = "1";
          } else if (Integer.parseInt(pasajeros) > 4) {
            pasajeros = "4";
          }
          if (Double.parseDouble(toneladas) < 500) {
            toneladas = "500";
          } else if (Double.parseDouble(toneladas) > 1000) {
            toneladas = "1000";
          }
          ;
          break;
        case 17:
          if (Integer.parseInt(cilindraje) < 100) {
            cilindraje = "100";
          } else if (Integer.parseInt(cilindraje) > 500) {
            cilindraje = "500";
          }
          if (Integer.parseInt(pasajeros) < 1) {
            pasajeros = "1";
          } else if (Integer.parseInt(pasajeros) > 2) {
            pasajeros = "2";
          }
          toneladas = "0";
          break;
        case 19:
          if (Integer.parseInt(cilindraje) < 50) {
            cilindraje = "50";
          } else if (Integer.parseInt(cilindraje) > 1200) {
            cilindraje = "1200";
          }
          if (Integer.parseInt(pasajeros) < 0) {
            pasajeros = "0";
          } else if (Integer.parseInt(pasajeros) > 2) {
            pasajeros = "2";
          }
          toneladas = "0";
          break;
        case 42:
          if (Integer.parseInt(cilindraje) < 0) {
            cilindraje = "0";
          } else if (Integer.parseInt(cilindraje) > 14000) {
            cilindraje = "14000";
          }
          pasajeros = "2";
          if (Double.parseDouble(toneladas) < 0) {
            toneladas = "0";
          } else if (Double.parseDouble(toneladas) > 35000) {
            toneladas = "35000";
          }
          ;
          break;

      }

      cilindraje = autocompletar(cilindraje, 5, 0, 0);
      if (modalidad.equals("1")) {
        toneladas = autocompletar(Math.round(Float.parseFloat(toneladas.replaceAll("-", ""))), 5, 0, 0);
        pasajeros = "000";
      }
      if (modalidad.equals("2")) {
        pasajeros = autocompletar(pasajeros, 3, 0, 0);
        toneladas = "00000";
      }
      if (modalidad.equals("3")) {
        pasajeros = autocompletar(pasajeros, 3, 0, 0);
        toneladas = autocompletar(Math.round(Float.parseFloat(toneladas.replaceAll("-", ""))), 5, 0, 0);
      }

      servicio = autocompletar(servicio, 2, 0, 0);

      dos.writeBytes(organismo + "" + placa + "" + marca + "" + linea + "" + clase + "" + color + "" + servicio + "" + carroceria + "" + modalidad + "" + cilindraje + "" + modelo + "" + motor + "" + chasis + "" + serie + "" + toneladas + "" + pasajeros + "" + fechamatricula + "" + licencia + "" + sirev + "" + combustible + "" + estado);
      dos.writeBytes("\n");
      //System.out.println ("Print : "+(i+1)+"  \r");
    }

  }

  public void generarPlanoPropietarios() throws Exception {

    File f = new File("C:/Civitrans/transito/build/web/paginas/data/planes/TTAHPROP.txt");
    FileOutputStream fos = new FileOutputStream(f);
    DataOutputStream dos = new DataOutputStream(fos);

    List listaPropietarios = conexion.consultarPropietariosTTAHPROP();
    for (int i = 0; i < listaPropietarios.size(); i++) {
      HashMap propietario = (HashMap) listaPropietarios.get(i);
      String organismo = propietario.get("ORGANISMO").toString();
      String placa = autocompletar(propietario.get("PLACA"), 6, 1, 1);
      String tipo_documento = autocompletar(propietario.get("TIPO_DOCUMENTO"), 1, 0, 1);
      String nro_documento = autocompletar(propietario.get("NRO_DOCUMENTO"), 11, 0, 0);
      String pro_indiviso = autocompletar(propietario.get("PROINDIVISO"), 1, 0, 1);//Revisar los casos clase 0 = 10
      String fecha_propiedad = autocompletar(propietario.get("FECHAPROPIEDAD"), 8, 0, 1);
      String apellido_1 = autocompletar(propietario.get("APELLIDO_1"), 25, 1, 1);
      String apellido_2 = autocompletar(propietario.get("APELLIDO_2"), 25, 1, 1);
      String nombre_1 = autocompletar(propietario.get("NOMBRE_1"), 25, 1, 1);
      String nombre_2 = autocompletar(propietario.get("NOMBRE_2"), 25, 1, 1);
      if (tipo_documento.equals("N")) {
        nombre_1 = autocompletar(nombre_1.trim() + " " + nombre_2.trim() + " " + apellido_1.trim() + " " + apellido_2.trim(), 25, 1, 1);
        nombre_2 = autocompletar("", 25, 1, 1);
        apellido_1 = autocompletar("", 25, 1, 1);
        ;
        apellido_2 = autocompletar("", 25, 1, 1);
        ;
      }

      String ciudad = autocompletar(propietario.get("CIUDAD"), 8, 0, 0);
      String direccion = autocompletar(propietario.get("DIRECCION"), 20, 1, 1);
      String telefono = autocompletar(propietario.get("TELEFONO"), 10, 1, 1);

      dos.writeBytes(organismo + "" + placa + "" + tipo_documento + "" + nro_documento + "" + pro_indiviso + "" + fecha_propiedad + "" + apellido_1 + "" + apellido_2 + "" + nombre_1 + "" + nombre_2 + "" + ciudad + "" + direccion + "" + telefono);
      dos.writeBytes("\n");
      //System.out.println ("Print : "+(i+1)+"  \r");
    }

  }

  public void generarPlanoTramites() throws Exception {
    File f = new File("C:/Civitrans/transito/build/web/paginas/data/planes/TTAHTRVE.txt");
    FileOutputStream fos = new FileOutputStream(f);
    DataOutputStream dos = new DataOutputStream(fos);
    List listaTramites = conexion.consultarTramitesTTAHTRVE();
    for (int i = 0; i < listaTramites.size(); i++) {
      HashMap tramite = (HashMap) listaTramites.get(i);
      String tipo = autocompletar(tramite.get("TRVTIPO"), 2, 0, 0);
      String placa = autocompletar(tramite.get("TRVPLACA"), 6, 1, 1);
      String fecha = autocompletar(tramite.get("TRVFECHA"), 8, 0, 1);
      String organismo = tramite.get("TRVOFIEX").toString();
      String licencia = autocompletar(tramite.get("TRVNUMERO"), 10, 1, 1);//licencia transito <= 10
      licencia = getMCS(licencia);
      if (listaLicencias.contains(licencia) || licencia.trim().length() == 0) {
        licencia = autocompletar(placa, 10, 1, 1);
      } else {
        listaLicencias.add(licencia);
      }
      String sirev = autocompletar(tramite.get("TRVFACT"), 16, 0, 0);
      dos.writeBytes(tipo + "" + placa + "" + fecha + "" + organismo + "" + licencia + "" + sirev);
      dos.writeBytes("\n");
    }
  }

  public void generarPlanoPrendas() throws Exception {
    try {
      File f = new File("C:/Civitrans/transito/build/web/paginas/data/planes/TTARUNTPREN.txt");
      FileOutputStream fos = new FileOutputStream(f);
      DataOutputStream dos = new DataOutputStream(fos);
      List listaTramites = conexion.consultarTramitesTTARUNPREN();
      for (Object prenda : listaTramites) {
        HashMap hash = (HashMap) prenda;
        String Organisimo = autocompletar(hash.get("Organisimo"),8, 0, 0);
        String NroPlaca = autocompletar(hash.get("NroPlaca"), 6, 0, 0);
        String TipoDocumento = autocompletar(hash.get("Tipo Documento"), 1, 0, 1);
        String Documento = autocompletar(hash.get("Documento"),11, 0, 0);
        String Nombre_1 = autocompletar(hash.get("Nombre 1"),25, 1, 1);
        String Nombre_2 = autocompletar(hash.get("Nombre 2"),25, 1, 1);
        String Apellido_1 = autocompletar(hash.get("Apellido 1"),25, 1, 1);
        String Apellido_2 = autocompletar(hash.get("Apellido 2"),25, 1, 1);
        String Direccion = autocompletar(hash.get("Dirreccion"),20, 1, 1);
        String Ciudad = autocompletar(hash.get("Ciudad"), 8, 0, 1);
        String Telefono = autocompletar(hash.get("Telefono"),10, 0, 1);
        String Grado = autocompletar(hash.get("Grado de la Prenda"),1, 0, 0);
        String Fecha = autocompletar(hash.get("Fecha del Tramite"),8,1,1);
        String Estado = autocompletar(hash.get("Estado prenda"),1, 0, 0);
        String tipo = autocompletar(hash.get("tipo alerta"), 1, 0, 0);
        String Cadena="";
        Cadena = Organisimo+NroPlaca+TipoDocumento+Documento+Nombre_1+Nombre_2+Apellido_1+Apellido_2+Direccion+Ciudad+Telefono+Grado+Fecha+Estado+tipo;
        System.out.println("-> "+Cadena);
        dos.writeBytes(Cadena);
        dos.writeBytes("\n");
        
      }

    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  public String autocompletar(Object value, int size, int leftrigth, int numbervarchar) {

    String valor = "";
    if (value != null) {
      valor = value.toString();
    }

    if (valor.length() > size) {
      return valor.substring(valor.length() - size, valor.length());
    }

    String cadena = "";
    for (int i = 0; i < size; i++) {
      if (numbervarchar == 0) {
        cadena += "0";
      } else {
        cadena += " ";
      }
    }

    if (leftrigth == 0) {
      return cadena.substring(0, size - valor.length()) + valor;
    } else {
      return valor + cadena.substring(0, size - valor.length());
    }
  }

  public String getMCS(String valor) throws Exception {
    int cant = valor.length();
    String resultado = "";
    for (int i = 0; i < cant; i++) {
      if (Character.isDigit(valor.charAt(i)) || Character.isLetter(valor.charAt(i)) || valor.charAt(i) == '*' || valor.charAt(i) == '-') {
        resultado += valor.charAt(i);
      }
    }
    return autocompletar(resultado, cant, 1, 1);
  }
}
