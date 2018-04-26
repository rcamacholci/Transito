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

public class CuotasUniformes extends Amortizacion
{

    public CuotasUniformes(double valor, double cuotaInicial, double interes, int cuotas,
            int periodosDeGracia, int ajuste, int valPeriodo, Date f_inicio)
    {
        CUOTA_INICIAL = 1;
        m_valor = valor;
        m_cuotaInicial = cuotaInicial;
        m_interes = interes;
        m_cuotas = cuotas;
        m_longCuotas = cuotas + CUOTA_INICIAL;
        m_periodosDeGracia = periodosDeGracia;
        m_valPeriodo = valPeriodo;
        m_listaCuotasAmor = new Cuota[m_longCuotas + m_periodosDeGracia];
        m_calendario = Calendar.getInstance();
        m_calendario.setTimeInMillis(f_inicio.getTime());
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
        for(int i = 1; i <= m_periodosDeGracia; i++)
            m_listaCuotasAmor[i] = calcularPeriodoDeGracia(i);

        m_valorCuotaP = calcularValorCuotaP(m_periodosDeGracia);
        m_calendario.set(m_calendario.get(1), m_calendario.get(2) + (m_periodosDeGracia * m_valPeriodo + m_valPeriodo), m_calendario.get(5));
        m_fecha = new Date(m_calendario.getTimeInMillis());
        m_fechaLim = m_fecha;
        m_listaCuotasAmor[m_periodosDeGracia + 1] = calcularCuota(m_periodosDeGracia + 1, m_fecha, m_fechaLim);
        for(int i = m_periodosDeGracia + 2; i < m_listaCuotasAmor.length - 1; i++)
        {
            m_calendario.set(m_calendario.get(1), m_calendario.get(2) + m_valPeriodo, m_calendario.get(5));
            m_fecha = new Date(m_calendario.getTimeInMillis());
            m_fechaLim = m_fecha;
            m_listaCuotasAmor[i] = calcularCuota(i, m_fecha, m_fechaLim);
        }

        m_calendario.set(m_calendario.get(1), m_calendario.get(2) + m_valPeriodo, m_calendario.get(5));
        m_fecha = new Date(m_calendario.getTimeInMillis());
        m_fechaLim = m_fecha;
        int pos = (m_longCuotas + m_periodosDeGracia) - 1;
        m_listaCuotasAmor[pos] = calcularUltimaCuota(pos, m_fecha, m_fechaLim);
    }

    protected Cuota calcularCuota(int periodo, Date f, Date fl)
    {
        double saldo = m_listaCuotasAmor[periodo - 1].obtenerSaldo() - m_listaCuotasAmor[periodo - 1].obtenerAbonoCapital();
        double intGenerados = saldo * (m_interes / 100D);
        double intPagados = intGenerados;
        double valorCuota = m_valorCuotaP;
        double abonoCapital = valorCuota - intGenerados;
        Cuota c = new Cuota(periodo, saldo, abonoCapital, intGenerados, intPagados, valorCuota, f, fl);
        return c;
    }

    protected Cuota calcularUltimaCuota(int periodo, Date f, Date fl)
    {
        double saldo = m_listaCuotasAmor[periodo - 1].obtenerSaldo() - m_listaCuotasAmor[periodo - 1].obtenerAbonoCapital();
        double intGenerados = saldo * (m_interes / 100D);
        double intPagados = intGenerados;
        double valorCuota = saldo + intGenerados;
        double abonoCapital = saldo;
        Cuota c = new Cuota(periodo, saldo, abonoCapital, intGenerados, intPagados, valorCuota, f, fl);
        return c;
    }

    private double calcularValorCuotaP(int periodo)
    {
        double saldo = m_listaCuotasAmor[periodo].obtenerSaldo() - m_listaCuotasAmor[periodo].obtenerAbonoCapital();
        double dividendo = (m_interes / 100D) * Math.pow(1.0D + m_interes / 100D, m_cuotas);
        double divisor = Math.pow(1.0D + m_interes / 100D, m_cuotas - 1);
        double resultado = saldo * (dividendo / divisor);
        return resultado;
    }

    public Cuota[] obtenerCuotas()
    {
        if(m_cuotaInicial > 0.0D)
        {
            m_listaCuotas = new Cuota[m_longCuotas];
            m_listaCuotas[0] = m_listaCuotasAmor[0];
            for(int i = 1; i < m_listaCuotas.length; i++)
                m_listaCuotas[i] = m_listaCuotasAmor[i + m_periodosDeGracia];

            return m_listaCuotas;
        }
        m_listaCuotas = new Cuota[m_cuotas];
        for(int i = 0; i < m_listaCuotas.length; i++)
            m_listaCuotas[i] = m_listaCuotasAmor[i + (m_periodosDeGracia + 1)];

        return m_listaCuotas;
    }

    private double m_valorCuotaP;
    private int m_cuotas;
    private int m_longCuotas;
    private int m_periodosDeGracia;
    private Cuota m_listaCuotas[];
    private int CUOTA_INICIAL;
}

