/*
 * Generated by JasperReports - 26/01/16 04:45 PM
 */
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.fill.*;

import java.util.*;
import java.math.*;
import java.text.*;
import java.io.*;
import java.net.*;

import net.sf.jasperreports.engine.*;
import java.util.*;
import net.sf.jasperreports.engine.data.*;


/**
 *
 */
public class cantidadTramitesAnuales_1453844731649_560072 extends JREvaluator
{


    /**
     *
     */
    private JRFillParameter parameter_REPORT_LOCALE = null;
    private JRFillParameter parameter_REPORT_TIME_ZONE = null;
    private JRFillParameter parameter_REPORT_VIRTUALIZER = null;
    private JRFillParameter parameter_REPORT_FILE_RESOLVER = null;
    private JRFillParameter parameter_REPORT_SCRIPTLET = null;
    private JRFillParameter parameter_REPORT_PARAMETERS_MAP = null;
    private JRFillParameter parameter_ANO = null;
    private JRFillParameter parameter_REPORT_CONNECTION = null;
    private JRFillParameter parameter_REPORT_CLASS_LOADER = null;
    private JRFillParameter parameter_REPORT_DATA_SOURCE = null;
    private JRFillParameter parameter_REPORT_URL_HANDLER_FACTORY = null;
    private JRFillParameter parameter_IS_IGNORE_PAGINATION = null;
    private JRFillParameter parameter_USUARIO = null;
    private JRFillParameter parameter_REPORT_FORMAT_FACTORY = null;
    private JRFillParameter parameter_REPORT_MAX_COUNT = null;
    private JRFillParameter parameter_REPORT_TEMPLATES = null;
    private JRFillParameter parameter_REPORT_RESOURCE_BUNDLE = null;
    private JRFillField field_ABRIL = null;
    private JRFillField field_MARZO = null;
    private JRFillField field_TOTAL = null;
    private JRFillField field_FEBRERO = null;
    private JRFillField field_JULIO = null;
    private JRFillField field_DICIEMBRE = null;
    private JRFillField field_TRAMITE = null;
    private JRFillField field_NOVIEMBRE = null;
    private JRFillField field_JUNIO = null;
    private JRFillField field_AGOSTO = null;
    private JRFillField field_MAYO = null;
    private JRFillField field_ENERO = null;
    private JRFillField field_OCTUBRE = null;
    private JRFillField field_SEPTIEMBRE = null;
    private JRFillVariable variable_PAGE_NUMBER = null;
    private JRFillVariable variable_COLUMN_NUMBER = null;
    private JRFillVariable variable_REPORT_COUNT = null;
    private JRFillVariable variable_PAGE_COUNT = null;
    private JRFillVariable variable_COLUMN_COUNT = null;
    private JRFillVariable variable_T_ENERO = null;
    private JRFillVariable variable_T_FEBRERO = null;
    private JRFillVariable variable_T_MARZO = null;
    private JRFillVariable variable_T_ABRIL = null;
    private JRFillVariable variable_T_MAYO = null;
    private JRFillVariable variable_T_JUNIO = null;
    private JRFillVariable variable_T_JULIO = null;
    private JRFillVariable variable_T_AGOSTO = null;
    private JRFillVariable variable_T_SEPT = null;
    private JRFillVariable variable_T_OCTUBRE = null;
    private JRFillVariable variable_T_NOVIEMBRE = null;
    private JRFillVariable variable_T_DICIEMBRE = null;
    private JRFillVariable variable_T_TOTAL = null;


    /**
     *
     */
    public void customizedInit(
        Map pm,
        Map fm,
        Map vm
        )
    {
        initParams(pm);
        initFields(fm);
        initVars(vm);
    }


    /**
     *
     */
    private void initParams(Map pm)
    {
        parameter_REPORT_LOCALE = (JRFillParameter)pm.get("REPORT_LOCALE");
        parameter_REPORT_TIME_ZONE = (JRFillParameter)pm.get("REPORT_TIME_ZONE");
        parameter_REPORT_VIRTUALIZER = (JRFillParameter)pm.get("REPORT_VIRTUALIZER");
        parameter_REPORT_FILE_RESOLVER = (JRFillParameter)pm.get("REPORT_FILE_RESOLVER");
        parameter_REPORT_SCRIPTLET = (JRFillParameter)pm.get("REPORT_SCRIPTLET");
        parameter_REPORT_PARAMETERS_MAP = (JRFillParameter)pm.get("REPORT_PARAMETERS_MAP");
        parameter_ANO = (JRFillParameter)pm.get("ANO");
        parameter_REPORT_CONNECTION = (JRFillParameter)pm.get("REPORT_CONNECTION");
        parameter_REPORT_CLASS_LOADER = (JRFillParameter)pm.get("REPORT_CLASS_LOADER");
        parameter_REPORT_DATA_SOURCE = (JRFillParameter)pm.get("REPORT_DATA_SOURCE");
        parameter_REPORT_URL_HANDLER_FACTORY = (JRFillParameter)pm.get("REPORT_URL_HANDLER_FACTORY");
        parameter_IS_IGNORE_PAGINATION = (JRFillParameter)pm.get("IS_IGNORE_PAGINATION");
        parameter_USUARIO = (JRFillParameter)pm.get("USUARIO");
        parameter_REPORT_FORMAT_FACTORY = (JRFillParameter)pm.get("REPORT_FORMAT_FACTORY");
        parameter_REPORT_MAX_COUNT = (JRFillParameter)pm.get("REPORT_MAX_COUNT");
        parameter_REPORT_TEMPLATES = (JRFillParameter)pm.get("REPORT_TEMPLATES");
        parameter_REPORT_RESOURCE_BUNDLE = (JRFillParameter)pm.get("REPORT_RESOURCE_BUNDLE");
    }


    /**
     *
     */
    private void initFields(Map fm)
    {
        field_ABRIL = (JRFillField)fm.get("ABRIL");
        field_MARZO = (JRFillField)fm.get("MARZO");
        field_TOTAL = (JRFillField)fm.get("TOTAL");
        field_FEBRERO = (JRFillField)fm.get("FEBRERO");
        field_JULIO = (JRFillField)fm.get("JULIO");
        field_DICIEMBRE = (JRFillField)fm.get("DICIEMBRE");
        field_TRAMITE = (JRFillField)fm.get("TRAMITE");
        field_NOVIEMBRE = (JRFillField)fm.get("NOVIEMBRE");
        field_JUNIO = (JRFillField)fm.get("JUNIO");
        field_AGOSTO = (JRFillField)fm.get("AGOSTO");
        field_MAYO = (JRFillField)fm.get("MAYO");
        field_ENERO = (JRFillField)fm.get("ENERO");
        field_OCTUBRE = (JRFillField)fm.get("OCTUBRE");
        field_SEPTIEMBRE = (JRFillField)fm.get("SEPTIEMBRE");
    }


    /**
     *
     */
    private void initVars(Map vm)
    {
        variable_PAGE_NUMBER = (JRFillVariable)vm.get("PAGE_NUMBER");
        variable_COLUMN_NUMBER = (JRFillVariable)vm.get("COLUMN_NUMBER");
        variable_REPORT_COUNT = (JRFillVariable)vm.get("REPORT_COUNT");
        variable_PAGE_COUNT = (JRFillVariable)vm.get("PAGE_COUNT");
        variable_COLUMN_COUNT = (JRFillVariable)vm.get("COLUMN_COUNT");
        variable_T_ENERO = (JRFillVariable)vm.get("T_ENERO");
        variable_T_FEBRERO = (JRFillVariable)vm.get("T_FEBRERO");
        variable_T_MARZO = (JRFillVariable)vm.get("T_MARZO");
        variable_T_ABRIL = (JRFillVariable)vm.get("T_ABRIL");
        variable_T_MAYO = (JRFillVariable)vm.get("T_MAYO");
        variable_T_JUNIO = (JRFillVariable)vm.get("T_JUNIO");
        variable_T_JULIO = (JRFillVariable)vm.get("T_JULIO");
        variable_T_AGOSTO = (JRFillVariable)vm.get("T_AGOSTO");
        variable_T_SEPT = (JRFillVariable)vm.get("T_SEPT");
        variable_T_OCTUBRE = (JRFillVariable)vm.get("T_OCTUBRE");
        variable_T_NOVIEMBRE = (JRFillVariable)vm.get("T_NOVIEMBRE");
        variable_T_DICIEMBRE = (JRFillVariable)vm.get("T_DICIEMBRE");
        variable_T_TOTAL = (JRFillVariable)vm.get("T_TOTAL");
    }


    /**
     *
     */
    public Object evaluate(int id) throws Throwable
    {
        Object value = null;

        switch (id)
        {
            case 0 : 
            {
                value = (java.lang.Integer)(new Integer(1));//$JR_EXPR_ID=0$
                break;
            }
            case 1 : 
            {
                value = (java.lang.Integer)(new Integer(1));//$JR_EXPR_ID=1$
                break;
            }
            case 2 : 
            {
                value = (java.lang.Integer)(new Integer(1));//$JR_EXPR_ID=2$
                break;
            }
            case 3 : 
            {
                value = (java.lang.Integer)(new Integer(0));//$JR_EXPR_ID=3$
                break;
            }
            case 4 : 
            {
                value = (java.lang.Integer)(new Integer(1));//$JR_EXPR_ID=4$
                break;
            }
            case 5 : 
            {
                value = (java.lang.Integer)(new Integer(0));//$JR_EXPR_ID=5$
                break;
            }
            case 6 : 
            {
                value = (java.lang.Integer)(new Integer(1));//$JR_EXPR_ID=6$
                break;
            }
            case 7 : 
            {
                value = (java.lang.Integer)(new Integer(0));//$JR_EXPR_ID=7$
                break;
            }
            case 8 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_ENERO.getValue()));//$JR_EXPR_ID=8$
                break;
            }
            case 9 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_FEBRERO.getValue()));//$JR_EXPR_ID=9$
                break;
            }
            case 10 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_MARZO.getValue()));//$JR_EXPR_ID=10$
                break;
            }
            case 11 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_ABRIL.getValue()));//$JR_EXPR_ID=11$
                break;
            }
            case 12 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_MAYO.getValue()));//$JR_EXPR_ID=12$
                break;
            }
            case 13 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_JUNIO.getValue()));//$JR_EXPR_ID=13$
                break;
            }
            case 14 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_JULIO.getValue()));//$JR_EXPR_ID=14$
                break;
            }
            case 15 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_AGOSTO.getValue()));//$JR_EXPR_ID=15$
                break;
            }
            case 16 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_SEPTIEMBRE.getValue()));//$JR_EXPR_ID=16$
                break;
            }
            case 17 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_OCTUBRE.getValue()));//$JR_EXPR_ID=17$
                break;
            }
            case 18 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_NOVIEMBRE.getValue()));//$JR_EXPR_ID=18$
                break;
            }
            case 19 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_DICIEMBRE.getValue()));//$JR_EXPR_ID=19$
                break;
            }
            case 20 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_TOTAL.getValue()));//$JR_EXPR_ID=20$
                break;
            }
            case 21 : 
            {
                value = (java.lang.String)("C:\\Civitrans\\transito\\web\\paginas\\reports\\images\\logo_.png");//$JR_EXPR_ID=21$
                break;
            }
            case 22 : 
            {
                value = (java.util.Date)(new java.util.Date());//$JR_EXPR_ID=22$
                break;
            }
            case 23 : 
            {
                value = (java.lang.String)(((java.lang.String)parameter_USUARIO.getValue()));//$JR_EXPR_ID=23$
                break;
            }
            case 24 : 
            {
                value = (java.lang.String)(((java.lang.String)parameter_ANO.getValue()));//$JR_EXPR_ID=24$
                break;
            }
            case 25 : 
            {
                value = (java.lang.String)(((java.lang.String)field_TRAMITE.getValue()));//$JR_EXPR_ID=25$
                break;
            }
            case 26 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_ENERO.getValue()));//$JR_EXPR_ID=26$
                break;
            }
            case 27 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_FEBRERO.getValue()));//$JR_EXPR_ID=27$
                break;
            }
            case 28 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_MARZO.getValue()));//$JR_EXPR_ID=28$
                break;
            }
            case 29 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_ABRIL.getValue()));//$JR_EXPR_ID=29$
                break;
            }
            case 30 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_MAYO.getValue()));//$JR_EXPR_ID=30$
                break;
            }
            case 31 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_JUNIO.getValue()));//$JR_EXPR_ID=31$
                break;
            }
            case 32 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_JULIO.getValue()));//$JR_EXPR_ID=32$
                break;
            }
            case 33 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_AGOSTO.getValue()));//$JR_EXPR_ID=33$
                break;
            }
            case 34 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_SEPTIEMBRE.getValue()));//$JR_EXPR_ID=34$
                break;
            }
            case 35 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_OCTUBRE.getValue()));//$JR_EXPR_ID=35$
                break;
            }
            case 36 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_DICIEMBRE.getValue()));//$JR_EXPR_ID=36$
                break;
            }
            case 37 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_TOTAL.getValue()));//$JR_EXPR_ID=37$
                break;
            }
            case 38 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_NOVIEMBRE.getValue()));//$JR_EXPR_ID=38$
                break;
            }
            case 39 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_ENERO.getValue()));//$JR_EXPR_ID=39$
                break;
            }
            case 40 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_FEBRERO.getValue()));//$JR_EXPR_ID=40$
                break;
            }
            case 41 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_MARZO.getValue()));//$JR_EXPR_ID=41$
                break;
            }
            case 42 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_ABRIL.getValue()));//$JR_EXPR_ID=42$
                break;
            }
            case 43 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_MAYO.getValue()));//$JR_EXPR_ID=43$
                break;
            }
            case 44 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_JUNIO.getValue()));//$JR_EXPR_ID=44$
                break;
            }
            case 45 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_JULIO.getValue()));//$JR_EXPR_ID=45$
                break;
            }
            case 46 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_AGOSTO.getValue()));//$JR_EXPR_ID=46$
                break;
            }
            case 47 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_SEPT.getValue()));//$JR_EXPR_ID=47$
                break;
            }
            case 48 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_OCTUBRE.getValue()));//$JR_EXPR_ID=48$
                break;
            }
            case 49 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_NOVIEMBRE.getValue()));//$JR_EXPR_ID=49$
                break;
            }
            case 50 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_DICIEMBRE.getValue()));//$JR_EXPR_ID=50$
                break;
            }
            case 51 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_TOTAL.getValue()));//$JR_EXPR_ID=51$
                break;
            }
           default :
           {
           }
        }
        
        return value;
    }


    /**
     *
     */
    public Object evaluateOld(int id) throws Throwable
    {
        Object value = null;

        switch (id)
        {
            case 0 : 
            {
                value = (java.lang.Integer)(new Integer(1));//$JR_EXPR_ID=0$
                break;
            }
            case 1 : 
            {
                value = (java.lang.Integer)(new Integer(1));//$JR_EXPR_ID=1$
                break;
            }
            case 2 : 
            {
                value = (java.lang.Integer)(new Integer(1));//$JR_EXPR_ID=2$
                break;
            }
            case 3 : 
            {
                value = (java.lang.Integer)(new Integer(0));//$JR_EXPR_ID=3$
                break;
            }
            case 4 : 
            {
                value = (java.lang.Integer)(new Integer(1));//$JR_EXPR_ID=4$
                break;
            }
            case 5 : 
            {
                value = (java.lang.Integer)(new Integer(0));//$JR_EXPR_ID=5$
                break;
            }
            case 6 : 
            {
                value = (java.lang.Integer)(new Integer(1));//$JR_EXPR_ID=6$
                break;
            }
            case 7 : 
            {
                value = (java.lang.Integer)(new Integer(0));//$JR_EXPR_ID=7$
                break;
            }
            case 8 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_ENERO.getOldValue()));//$JR_EXPR_ID=8$
                break;
            }
            case 9 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_FEBRERO.getOldValue()));//$JR_EXPR_ID=9$
                break;
            }
            case 10 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_MARZO.getOldValue()));//$JR_EXPR_ID=10$
                break;
            }
            case 11 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_ABRIL.getOldValue()));//$JR_EXPR_ID=11$
                break;
            }
            case 12 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_MAYO.getOldValue()));//$JR_EXPR_ID=12$
                break;
            }
            case 13 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_JUNIO.getOldValue()));//$JR_EXPR_ID=13$
                break;
            }
            case 14 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_JULIO.getOldValue()));//$JR_EXPR_ID=14$
                break;
            }
            case 15 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_AGOSTO.getOldValue()));//$JR_EXPR_ID=15$
                break;
            }
            case 16 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_SEPTIEMBRE.getOldValue()));//$JR_EXPR_ID=16$
                break;
            }
            case 17 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_OCTUBRE.getOldValue()));//$JR_EXPR_ID=17$
                break;
            }
            case 18 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_NOVIEMBRE.getOldValue()));//$JR_EXPR_ID=18$
                break;
            }
            case 19 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_DICIEMBRE.getOldValue()));//$JR_EXPR_ID=19$
                break;
            }
            case 20 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_TOTAL.getOldValue()));//$JR_EXPR_ID=20$
                break;
            }
            case 21 : 
            {
                value = (java.lang.String)("C:\\Civitrans\\transito\\web\\paginas\\reports\\images\\logo_.png");//$JR_EXPR_ID=21$
                break;
            }
            case 22 : 
            {
                value = (java.util.Date)(new java.util.Date());//$JR_EXPR_ID=22$
                break;
            }
            case 23 : 
            {
                value = (java.lang.String)(((java.lang.String)parameter_USUARIO.getValue()));//$JR_EXPR_ID=23$
                break;
            }
            case 24 : 
            {
                value = (java.lang.String)(((java.lang.String)parameter_ANO.getValue()));//$JR_EXPR_ID=24$
                break;
            }
            case 25 : 
            {
                value = (java.lang.String)(((java.lang.String)field_TRAMITE.getOldValue()));//$JR_EXPR_ID=25$
                break;
            }
            case 26 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_ENERO.getOldValue()));//$JR_EXPR_ID=26$
                break;
            }
            case 27 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_FEBRERO.getOldValue()));//$JR_EXPR_ID=27$
                break;
            }
            case 28 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_MARZO.getOldValue()));//$JR_EXPR_ID=28$
                break;
            }
            case 29 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_ABRIL.getOldValue()));//$JR_EXPR_ID=29$
                break;
            }
            case 30 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_MAYO.getOldValue()));//$JR_EXPR_ID=30$
                break;
            }
            case 31 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_JUNIO.getOldValue()));//$JR_EXPR_ID=31$
                break;
            }
            case 32 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_JULIO.getOldValue()));//$JR_EXPR_ID=32$
                break;
            }
            case 33 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_AGOSTO.getOldValue()));//$JR_EXPR_ID=33$
                break;
            }
            case 34 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_SEPTIEMBRE.getOldValue()));//$JR_EXPR_ID=34$
                break;
            }
            case 35 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_OCTUBRE.getOldValue()));//$JR_EXPR_ID=35$
                break;
            }
            case 36 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_DICIEMBRE.getOldValue()));//$JR_EXPR_ID=36$
                break;
            }
            case 37 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_TOTAL.getOldValue()));//$JR_EXPR_ID=37$
                break;
            }
            case 38 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_NOVIEMBRE.getOldValue()));//$JR_EXPR_ID=38$
                break;
            }
            case 39 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_ENERO.getOldValue()));//$JR_EXPR_ID=39$
                break;
            }
            case 40 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_FEBRERO.getOldValue()));//$JR_EXPR_ID=40$
                break;
            }
            case 41 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_MARZO.getOldValue()));//$JR_EXPR_ID=41$
                break;
            }
            case 42 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_ABRIL.getOldValue()));//$JR_EXPR_ID=42$
                break;
            }
            case 43 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_MAYO.getOldValue()));//$JR_EXPR_ID=43$
                break;
            }
            case 44 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_JUNIO.getOldValue()));//$JR_EXPR_ID=44$
                break;
            }
            case 45 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_JULIO.getOldValue()));//$JR_EXPR_ID=45$
                break;
            }
            case 46 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_AGOSTO.getOldValue()));//$JR_EXPR_ID=46$
                break;
            }
            case 47 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_SEPT.getOldValue()));//$JR_EXPR_ID=47$
                break;
            }
            case 48 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_OCTUBRE.getOldValue()));//$JR_EXPR_ID=48$
                break;
            }
            case 49 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_NOVIEMBRE.getOldValue()));//$JR_EXPR_ID=49$
                break;
            }
            case 50 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_DICIEMBRE.getOldValue()));//$JR_EXPR_ID=50$
                break;
            }
            case 51 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_TOTAL.getOldValue()));//$JR_EXPR_ID=51$
                break;
            }
           default :
           {
           }
        }
        
        return value;
    }


    /**
     *
     */
    public Object evaluateEstimated(int id) throws Throwable
    {
        Object value = null;

        switch (id)
        {
            case 0 : 
            {
                value = (java.lang.Integer)(new Integer(1));//$JR_EXPR_ID=0$
                break;
            }
            case 1 : 
            {
                value = (java.lang.Integer)(new Integer(1));//$JR_EXPR_ID=1$
                break;
            }
            case 2 : 
            {
                value = (java.lang.Integer)(new Integer(1));//$JR_EXPR_ID=2$
                break;
            }
            case 3 : 
            {
                value = (java.lang.Integer)(new Integer(0));//$JR_EXPR_ID=3$
                break;
            }
            case 4 : 
            {
                value = (java.lang.Integer)(new Integer(1));//$JR_EXPR_ID=4$
                break;
            }
            case 5 : 
            {
                value = (java.lang.Integer)(new Integer(0));//$JR_EXPR_ID=5$
                break;
            }
            case 6 : 
            {
                value = (java.lang.Integer)(new Integer(1));//$JR_EXPR_ID=6$
                break;
            }
            case 7 : 
            {
                value = (java.lang.Integer)(new Integer(0));//$JR_EXPR_ID=7$
                break;
            }
            case 8 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_ENERO.getValue()));//$JR_EXPR_ID=8$
                break;
            }
            case 9 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_FEBRERO.getValue()));//$JR_EXPR_ID=9$
                break;
            }
            case 10 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_MARZO.getValue()));//$JR_EXPR_ID=10$
                break;
            }
            case 11 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_ABRIL.getValue()));//$JR_EXPR_ID=11$
                break;
            }
            case 12 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_MAYO.getValue()));//$JR_EXPR_ID=12$
                break;
            }
            case 13 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_JUNIO.getValue()));//$JR_EXPR_ID=13$
                break;
            }
            case 14 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_JULIO.getValue()));//$JR_EXPR_ID=14$
                break;
            }
            case 15 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_AGOSTO.getValue()));//$JR_EXPR_ID=15$
                break;
            }
            case 16 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_SEPTIEMBRE.getValue()));//$JR_EXPR_ID=16$
                break;
            }
            case 17 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_OCTUBRE.getValue()));//$JR_EXPR_ID=17$
                break;
            }
            case 18 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_NOVIEMBRE.getValue()));//$JR_EXPR_ID=18$
                break;
            }
            case 19 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_DICIEMBRE.getValue()));//$JR_EXPR_ID=19$
                break;
            }
            case 20 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_TOTAL.getValue()));//$JR_EXPR_ID=20$
                break;
            }
            case 21 : 
            {
                value = (java.lang.String)("C:\\Civitrans\\transito\\web\\paginas\\reports\\images\\logo_.png");//$JR_EXPR_ID=21$
                break;
            }
            case 22 : 
            {
                value = (java.util.Date)(new java.util.Date());//$JR_EXPR_ID=22$
                break;
            }
            case 23 : 
            {
                value = (java.lang.String)(((java.lang.String)parameter_USUARIO.getValue()));//$JR_EXPR_ID=23$
                break;
            }
            case 24 : 
            {
                value = (java.lang.String)(((java.lang.String)parameter_ANO.getValue()));//$JR_EXPR_ID=24$
                break;
            }
            case 25 : 
            {
                value = (java.lang.String)(((java.lang.String)field_TRAMITE.getValue()));//$JR_EXPR_ID=25$
                break;
            }
            case 26 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_ENERO.getValue()));//$JR_EXPR_ID=26$
                break;
            }
            case 27 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_FEBRERO.getValue()));//$JR_EXPR_ID=27$
                break;
            }
            case 28 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_MARZO.getValue()));//$JR_EXPR_ID=28$
                break;
            }
            case 29 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_ABRIL.getValue()));//$JR_EXPR_ID=29$
                break;
            }
            case 30 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_MAYO.getValue()));//$JR_EXPR_ID=30$
                break;
            }
            case 31 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_JUNIO.getValue()));//$JR_EXPR_ID=31$
                break;
            }
            case 32 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_JULIO.getValue()));//$JR_EXPR_ID=32$
                break;
            }
            case 33 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_AGOSTO.getValue()));//$JR_EXPR_ID=33$
                break;
            }
            case 34 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_SEPTIEMBRE.getValue()));//$JR_EXPR_ID=34$
                break;
            }
            case 35 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_OCTUBRE.getValue()));//$JR_EXPR_ID=35$
                break;
            }
            case 36 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_DICIEMBRE.getValue()));//$JR_EXPR_ID=36$
                break;
            }
            case 37 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_TOTAL.getValue()));//$JR_EXPR_ID=37$
                break;
            }
            case 38 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)field_NOVIEMBRE.getValue()));//$JR_EXPR_ID=38$
                break;
            }
            case 39 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_ENERO.getEstimatedValue()));//$JR_EXPR_ID=39$
                break;
            }
            case 40 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_FEBRERO.getEstimatedValue()));//$JR_EXPR_ID=40$
                break;
            }
            case 41 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_MARZO.getEstimatedValue()));//$JR_EXPR_ID=41$
                break;
            }
            case 42 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_ABRIL.getEstimatedValue()));//$JR_EXPR_ID=42$
                break;
            }
            case 43 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_MAYO.getEstimatedValue()));//$JR_EXPR_ID=43$
                break;
            }
            case 44 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_JUNIO.getEstimatedValue()));//$JR_EXPR_ID=44$
                break;
            }
            case 45 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_JULIO.getEstimatedValue()));//$JR_EXPR_ID=45$
                break;
            }
            case 46 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_AGOSTO.getEstimatedValue()));//$JR_EXPR_ID=46$
                break;
            }
            case 47 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_SEPT.getEstimatedValue()));//$JR_EXPR_ID=47$
                break;
            }
            case 48 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_OCTUBRE.getEstimatedValue()));//$JR_EXPR_ID=48$
                break;
            }
            case 49 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_NOVIEMBRE.getEstimatedValue()));//$JR_EXPR_ID=49$
                break;
            }
            case 50 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_DICIEMBRE.getEstimatedValue()));//$JR_EXPR_ID=50$
                break;
            }
            case 51 : 
            {
                value = (java.math.BigDecimal)(((java.math.BigDecimal)variable_T_TOTAL.getEstimatedValue()));//$JR_EXPR_ID=51$
                break;
            }
           default :
           {
           }
        }
        
        return value;
    }


}
