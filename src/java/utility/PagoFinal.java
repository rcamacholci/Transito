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

public class PagoFinal extends Amortizacion
{

    public PagoFinal(double valor, double cuotaInicial, double interes, int cuotas,
            int valPeriodo, Date f_inicio)
    {
        m_valor = valor;
        m_cuotaInicial = cuotaInicial;
        m_interes = interes;
        m_cuotas = cuotas;
        m_longCuotas = cuotas + 1;
        m_listaCuotasAmor = new Cuota[m_longCuotas];
        m_calendario = Calendar.getInstance();
        m_calendario.setTimeInMillis(f_inicio.getTime());
        m_valPeriodo = valPeriodo;
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
        for(int i = 1; i < m_listaCuotasAmor.length - 1; i++)
            m_listaCuotasAmor[i] = calcularCuota(i, null, null);

        m_calendario.set(m_calendario.get(1), m_calendario.get(2) + m_cuotas * m_valPeriodo, m_calendario.get(5));
        m_fecha = new Date(m_calendario.getTimeInMillis());
        m_fechaLim = m_fecha;
        m_listaCuotasAmor[m_longCuotas - 1] = calcularUltimaCuota(m_longCuotas - 1, m_fecha, m_fechaLim);
    }

    protected Cuota calcularCuota(int periodo, Date f, Date fl)
    {
        double saldo = (m_listaCuotasAmor[periodo - 1].obtenerSaldo() + m_listaCuotasAmor[periodo - 1].obtenerIntGenerados()) - m_listaCuotasAmor[periodo - 1].obtenerAbonoCapital();
        double intGenerados = saldo * (m_interes / 100D);
        Cuota c = new Cuota(periodo, saldo, 0.0D, intGenerados, 0.0D, 0.0D, f, fl);
        return c;
    }

    protected Cuota calcularUltimaCuota(int periodo, Date f, Date fl)
    {
        double saldo = (m_listaCuotasAmor[periodo - 1].obtenerSaldo() + m_listaCuotasAmor[periodo - 1].obtenerIntGenerados()) - m_listaCuotasAmor[periodo - 1].obtenerAbonoCapital();
        double abonoC = m_valor;
        double intGenerados = saldo * (m_interes / 100D);
        double valorCuota = saldo + intGenerados;
        double intPagados = valorCuota - abonoC;
        Cuota c = new Cuota(periodo, saldo, m_valor, intGenerados, intPagados, valorCuota, f, fl);
        return c;
    }

    public Cuota[] obtenerCuotas()
    {
        if(m_cuotaInicial > 0.0D)
        {
            m_listaCuotas = new Cuota[2];
            m_listaCuotas[0] = m_listaCuotasAmor[0];
            m_listaCuotas[1] = m_listaCuotasAmor[m_longCuotas - 1];
        } else
        {
            m_listaCuotas = new Cuota[1];
            m_listaCuotas[0] = m_listaCuotasAmor[m_longCuotas - 1];
        }
        return m_listaCuotas;
    }

    private Cuota m_listaCuotas[];
    private int m_longCuotas;
    private final int CUOTA_INICIAL = 1;
}

