/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package utility;

/**
 *
 * @author Administrador
 */
import java.sql.Date;

public class Cuota
{

    public Cuota(int per, double sal, double abono, double intG,
            double intP, double valor, Date f, Date f_limite)
    {
        m_periodo = per;
        m_saldo = sal;
        m_abono_capital = abono;
        m_int_generados = intG;
        m_int_pagados = intP;
        m_valor_cuota = valor;
        m_fecha = f;
        m_fechaLimite = f_limite;
    }

    public Date obtenerFecha()
    {
        return m_fecha;
    }

    public Date obtenerFLimite()
    {
        return m_fechaLimite;
    }

    public int obtenerPeriodo()
    {
        return m_periodo;
    }

    public double obtenerSaldo()
    {
        return formatoDecimal(m_saldo);
    }

    public double obtenerAbonoCapital()
    {
        return formatoDecimal(m_abono_capital);
    }

    public double obtenerIntGenerados()
    {
        return formatoDecimal(m_int_generados);
    }

    public double obtenerIntPagados()
    {
        return formatoDecimal(m_int_pagados);
    }

    public double obtenerValorCuota()
    {
        return formatoDecimal(m_valor_cuota);
    }

    private double formatoDecimal(double valor)
    {
        return (double)(int)(valor * 100D) / 100D;
    }

    private int m_periodo;
    private double m_saldo;
    private double m_abono_capital;
    private double m_int_generados;
    private double m_int_pagados;
    private double m_valor_cuota;
    private Date m_fecha;
    private Date m_fechaLimite;
}

