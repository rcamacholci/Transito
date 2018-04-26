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
import java.util.Calendar;

// Referenced classes of package com.movillife.bussiness.financiaciones:
//            Amortizacion, Cuota

public class PagoIntCuotaFinal extends Amortizacion
{

    public PagoIntCuotaFinal(double valor, double cuotaInicial, double interes, int cuotas,
            int valPeriodo, Date f_inicio)
    {
        m_valor = valor;
        m_cuotaInicial = cuotaInicial;
        m_interes = interes;
        m_cuotas = cuotas;
        m_longCuotas = cuotas + 1;
        m_calendario = Calendar.getInstance();
        m_calendario.setTimeInMillis(f_inicio.getTime());
        m_valPeriodo = valPeriodo;
        m_listaCuotasAmor = new Cuota[m_longCuotas];
        calcularAmortizacion();
    }

    protected void calcularAmortizacion()
    {
        m_fecha = new Date(m_calendario.getTimeInMillis());
        m_fechaLim = m_fecha;
        if(m_cuotaInicial > 0.0D)
            m_listaCuotasAmor[0] = calcularPrimeraCuota(m_fecha, m_fechaLim);
        else
            m_listaCuotasAmor[0] = calcularPrimeraCuota(null, null);
        if(m_listaCuotasAmor.length > 1)
        {
            m_calendario.set(m_calendario.get(1), m_calendario.get(2) + m_valPeriodo, m_calendario.get(5));
            m_fecha = new Date(m_calendario.getTimeInMillis());
            m_fechaLim = m_fecha;
            m_listaCuotasAmor[1] = calcularCuota(1, m_fecha, m_fechaLim);
        }
        for(int i = 2; i < m_listaCuotasAmor.length - 1; i++)
        {
            m_calendario.set(m_calendario.get(1), m_calendario.get(2) + m_valPeriodo, m_calendario.get(5));
            m_fecha = new Date(m_calendario.getTimeInMillis());
            m_fechaLim = m_fecha;
            m_listaCuotasAmor[i] = calcularCuota(i, m_fecha, m_fechaLim);
        }

        m_calendario.set(m_calendario.get(1), m_calendario.get(2) + m_valPeriodo, m_calendario.get(5));
        m_fecha = new Date(m_calendario.getTimeInMillis());
        m_fechaLim = m_fecha;
        m_listaCuotasAmor[m_longCuotas - 1] = calcularUltimaCuota(m_longCuotas - 1, m_fecha, m_fechaLim);
    }

    protected Cuota calcularCuota(int periodo, Date f, Date fl)
    {
        double saldo = m_valor - m_cuotaInicial;
        double intGenerados = saldo * (m_interes / 100D);
        double intPagados = intGenerados;
        double valorCuota = intGenerados;
        Cuota c = new Cuota(periodo, saldo, 0.0D, intGenerados, intPagados, valorCuota, f, fl);
        return c;
    }

    protected Cuota calcularUltimaCuota(int periodo, Date f, Date fl)
    {
        double saldo = m_valor - m_cuotaInicial;
        double abonoCapital = m_valor;
        double intGenerados = saldo * (m_interes / 100D);
        double valorCuota = saldo + intGenerados;
        double intPagados = intGenerados;
        Cuota c = new Cuota(periodo, saldo, abonoCapital, intGenerados, intPagados, valorCuota, f, fl);
        return c;
    }

    public Cuota[] obtenerCuotas()
    {
        if(m_cuotaInicial > 0.0D)
            return m_listaCuotasAmor;
        m_listaCuotas = new Cuota[m_cuotas];
        for(int i = 1; i < m_listaCuotasAmor.length; i++)
            m_listaCuotas[i - 1] = m_listaCuotasAmor[i];

        return m_listaCuotas;
    }

    private Cuota m_listaCuotas[];
    private int m_longCuotas;
    private final int CUOTA_INICIAL = 1;
}

