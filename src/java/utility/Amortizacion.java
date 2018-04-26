/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package utility;

/**
 *
 * @author Administrador
 */
import java.io.PrintStream;
import java.sql.Date;
import java.util.Calendar;

// Referenced classes of package com.movillife.bussiness.financiaciones:
//            Cuota

public abstract class Amortizacion
{

    public Amortizacion()
    {
    }

    protected Cuota calcularPrimeraCuota(Date f, Date fLim)
    {
        Cuota c = new Cuota(0, m_valor, m_cuotaInicial, 0.0D, 0.0D, m_cuotaInicial, f, fLim);
        return c;
    }

    protected Cuota calcularPeriodoDeGracia(int periodo)
    {
        double saldo = (m_listaCuotasAmor[periodo - 1].obtenerSaldo() + m_listaCuotasAmor[periodo - 1].obtenerIntGenerados()) - m_listaCuotasAmor[periodo - 1].obtenerAbonoCapital();
        double intGenerados = saldo * (m_interes / 100D);
        Cuota c = new Cuota(periodo, saldo, 0.0D, intGenerados, 0.0D, 0.0D, null, null);
        return c;
    }

    public Cuota[] obtenerAmortizacion()
    {
        return m_listaCuotasAmor;
    }

    public void mostrarAmortizacion()
    {
        for(int i = 0; i < m_listaCuotasAmor.length; i++)
        {
            System.out.println("Periodo        " + m_listaCuotasAmor[i].obtenerPeriodo());
            System.out.println("Saldo          " + m_listaCuotasAmor[i].obtenerSaldo());
            System.out.println("Abono          " + m_listaCuotasAmor[i].obtenerAbonoCapital());
            System.out.println("Intereses Gem  " + m_listaCuotasAmor[i].obtenerIntGenerados());
            System.out.println("Intereses Pag  " + m_listaCuotasAmor[i].obtenerIntPagados());
            System.out.println("Valor Cuota    " + m_listaCuotasAmor[i].obtenerValorCuota());
            System.out.println("Fecha\t       " + m_listaCuotasAmor[i].obtenerFecha());
            System.out.println("Fecha Limite   " + m_listaCuotasAmor[i].obtenerFLimite());
            System.out.println("");
        }

    }

    public int ajuste(int tipo, double num)
    {
        int valorAjustado = -1;
        switch(tipo)
        {
        case 1: // '\001'
            valorAjustado = (int)(num / 10D) * 10;
            break;

        case 2: // '\002'
            valorAjustado = (int)(num / 100D) * 100;
            break;

        case 3: // '\003'
            valorAjustado = (int)(num / 1000D) * 1000;
            break;

        default:
            valorAjustado = (int)(num / 10D) * 10;
            break;
        }
        return valorAjustado;
    }

    protected abstract void calcularAmortizacion();

    protected abstract Cuota calcularCuota(int i, Date date, Date date1);

    protected abstract Cuota calcularUltimaCuota(int i, Date date, Date date1);

    protected Cuota m_listaCuotasAmor[];
    protected Date m_fecha;
    protected Date m_fechaLim;
    protected double m_valor;
    protected double m_cuotaInicial;
    protected double m_interes;
    protected int m_cuotas;
    protected Calendar m_calendario;
    protected int m_valPeriodo;
    private static int DIAS_LIMITE = 5;

}
