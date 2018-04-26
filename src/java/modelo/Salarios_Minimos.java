/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.io.*;

/**
 *
 * @author DESARROLLO
 */
public class Salarios_Minimos implements Serializable {
    private long id_salario_minimo,vigencia,valor;

    public long getId_salario_minimo() {
        return id_salario_minimo;
    }

    public void setId_salario_minimo(long id_salario_minimo) {
        this.id_salario_minimo = id_salario_minimo;
    }

    public long getValor() {
        return valor;
    }

    public void setValor(long valor) {
        this.valor = valor;
    }

    public long getVigencia() {
        return vigencia;
    }

    public void setVigencia(long vigencia) {
        this.vigencia = vigencia;
    }

      public static Salarios_Minimos load(java.sql.ResultSet rs)throws java.sql.SQLException{
        Salarios_Minimos salarioM = new Salarios_Minimos();
        salarioM.setId_salario_minimo(rs.getLong(1));
        salarioM.setVigencia(rs.getLong(2));
        salarioM.setValor(rs.getLong(3));
        return salarioM;
    }

}
