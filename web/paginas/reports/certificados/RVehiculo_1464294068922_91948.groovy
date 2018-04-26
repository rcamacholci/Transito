/*
 * Generated by JasperReports - 26/05/16 03:21 PM
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
class RVehiculo_1464294068922_91948 extends JREvaluator
{


    /**
     *
     */
    private JRFillParameter parameter_CHASIS = null;
    private JRFillParameter parameter_PERSONA = null;
    private JRFillParameter parameter_RADICADO = null;
    private JRFillParameter parameter_EXPEDICION = null;
    private JRFillParameter parameter_LINEA = null;
    private JRFillParameter parameter_TIPO = null;
    private JRFillParameter parameter_REPORT_TIME_ZONE = null;
    private JRFillParameter parameter_REPORT_FILE_RESOLVER = null;
    private JRFillParameter parameter_NUMERO = null;
    private JRFillParameter parameter_COMBUSTIBLE = null;
    private JRFillParameter parameter_MATRICULA = null;
    private JRFillParameter parameter_REPORT_PARAMETERS_MAP = null;
    private JRFillParameter parameter_EJES = null;
    private JRFillParameter parameter_REPORT_CLASS_LOADER = null;
    private JRFillParameter parameter_REPORT_URL_HANDLER_FACTORY = null;
    private JRFillParameter parameter_REPORT_DATA_SOURCE = null;
    private JRFillParameter parameter_IS_IGNORE_PAGINATION = null;
    private JRFillParameter parameter_CLASE = null;
    private JRFillParameter parameter_LICENCIA = null;
    private JRFillParameter parameter_REPORT_MAX_COUNT = null;
    private JRFillParameter parameter_PLACA = null;
    private JRFillParameter parameter_REPORT_TEMPLATES = null;
    private JRFillParameter parameter_MODELO = null;
    private JRFillParameter parameter_MODALIDAD = null;
    private JRFillParameter parameter_MOTOR = null;
    private JRFillParameter parameter_COLOR = null;
    private JRFillParameter parameter_PASAJEROS = null;
    private JRFillParameter parameter_REPORT_LOCALE = null;
    private JRFillParameter parameter_CAPACIDAD = null;
    private JRFillParameter parameter_FECHA_COT = null;
    private JRFillParameter parameter_FECHAPAGO = null;
    private JRFillParameter parameter_OBSERVACION = null;
    private JRFillParameter parameter_REPORT_VIRTUALIZER = null;
    private JRFillParameter parameter_MARCA = null;
    private JRFillParameter parameter_CILINDRADA = null;
    private JRFillParameter parameter_REPORT_SCRIPTLET = null;
    private JRFillParameter parameter_TRASLADADO = null;
    private JRFillParameter parameter_REPORT_CONNECTION = null;
    private JRFillParameter parameter_SUBREPORT_DIR = null;
    private JRFillParameter parameter_ESTADO = null;
    private JRFillParameter parameter_USUARIO = null;
    private JRFillParameter parameter_SERIE = null;
    private JRFillParameter parameter_REPORT_FORMAT_FACTORY = null;
    private JRFillParameter parameter_NRO_PAGO = null;
    private JRFillParameter parameter_SERVICIO = null;
    private JRFillParameter parameter_TONELADAS = null;
    private JRFillParameter parameter_REPORT_RESOURCE_BUNDLE = null;
    private JRFillField field_ID_VEHICULO = null;
    private JRFillField field_ALERTA = null;
    private JRFillField field_EMBARGO = null;
    private JRFillVariable variable_PAGE_NUMBER = null;
    private JRFillVariable variable_COLUMN_NUMBER = null;
    private JRFillVariable variable_REPORT_COUNT = null;
    private JRFillVariable variable_PAGE_COUNT = null;
    private JRFillVariable variable_COLUMN_COUNT = null;


    /**
     *
     */
    void customizedInit(
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
    void initParams(Map pm)
    {
        parameter_CHASIS = (JRFillParameter)pm.get("CHASIS");
        parameter_PERSONA = (JRFillParameter)pm.get("PERSONA");
        parameter_RADICADO = (JRFillParameter)pm.get("RADICADO");
        parameter_EXPEDICION = (JRFillParameter)pm.get("EXPEDICION");
        parameter_LINEA = (JRFillParameter)pm.get("LINEA");
        parameter_TIPO = (JRFillParameter)pm.get("TIPO");
        parameter_REPORT_TIME_ZONE = (JRFillParameter)pm.get("REPORT_TIME_ZONE");
        parameter_REPORT_FILE_RESOLVER = (JRFillParameter)pm.get("REPORT_FILE_RESOLVER");
        parameter_NUMERO = (JRFillParameter)pm.get("NUMERO");
        parameter_COMBUSTIBLE = (JRFillParameter)pm.get("COMBUSTIBLE");
        parameter_MATRICULA = (JRFillParameter)pm.get("MATRICULA");
        parameter_REPORT_PARAMETERS_MAP = (JRFillParameter)pm.get("REPORT_PARAMETERS_MAP");
        parameter_EJES = (JRFillParameter)pm.get("EJES");
        parameter_REPORT_CLASS_LOADER = (JRFillParameter)pm.get("REPORT_CLASS_LOADER");
        parameter_REPORT_URL_HANDLER_FACTORY = (JRFillParameter)pm.get("REPORT_URL_HANDLER_FACTORY");
        parameter_REPORT_DATA_SOURCE = (JRFillParameter)pm.get("REPORT_DATA_SOURCE");
        parameter_IS_IGNORE_PAGINATION = (JRFillParameter)pm.get("IS_IGNORE_PAGINATION");
        parameter_CLASE = (JRFillParameter)pm.get("CLASE");
        parameter_LICENCIA = (JRFillParameter)pm.get("LICENCIA");
        parameter_REPORT_MAX_COUNT = (JRFillParameter)pm.get("REPORT_MAX_COUNT");
        parameter_PLACA = (JRFillParameter)pm.get("PLACA");
        parameter_REPORT_TEMPLATES = (JRFillParameter)pm.get("REPORT_TEMPLATES");
        parameter_MODELO = (JRFillParameter)pm.get("MODELO");
        parameter_MODALIDAD = (JRFillParameter)pm.get("MODALIDAD");
        parameter_MOTOR = (JRFillParameter)pm.get("MOTOR");
        parameter_COLOR = (JRFillParameter)pm.get("COLOR");
        parameter_PASAJEROS = (JRFillParameter)pm.get("PASAJEROS");
        parameter_REPORT_LOCALE = (JRFillParameter)pm.get("REPORT_LOCALE");
        parameter_CAPACIDAD = (JRFillParameter)pm.get("CAPACIDAD");
        parameter_FECHA_COT = (JRFillParameter)pm.get("FECHA_COT");
        parameter_FECHAPAGO = (JRFillParameter)pm.get("FECHAPAGO");
        parameter_OBSERVACION = (JRFillParameter)pm.get("OBSERVACION");
        parameter_REPORT_VIRTUALIZER = (JRFillParameter)pm.get("REPORT_VIRTUALIZER");
        parameter_MARCA = (JRFillParameter)pm.get("MARCA");
        parameter_CILINDRADA = (JRFillParameter)pm.get("CILINDRADA");
        parameter_REPORT_SCRIPTLET = (JRFillParameter)pm.get("REPORT_SCRIPTLET");
        parameter_TRASLADADO = (JRFillParameter)pm.get("TRASLADADO");
        parameter_REPORT_CONNECTION = (JRFillParameter)pm.get("REPORT_CONNECTION");
        parameter_SUBREPORT_DIR = (JRFillParameter)pm.get("SUBREPORT_DIR");
        parameter_ESTADO = (JRFillParameter)pm.get("ESTADO");
        parameter_USUARIO = (JRFillParameter)pm.get("USUARIO");
        parameter_SERIE = (JRFillParameter)pm.get("SERIE");
        parameter_REPORT_FORMAT_FACTORY = (JRFillParameter)pm.get("REPORT_FORMAT_FACTORY");
        parameter_NRO_PAGO = (JRFillParameter)pm.get("NRO_PAGO");
        parameter_SERVICIO = (JRFillParameter)pm.get("SERVICIO");
        parameter_TONELADAS = (JRFillParameter)pm.get("TONELADAS");
        parameter_REPORT_RESOURCE_BUNDLE = (JRFillParameter)pm.get("REPORT_RESOURCE_BUNDLE");
    }


    /**
     *
     */
    void initFields(Map fm)
    {
        field_ID_VEHICULO = (JRFillField)fm.get("ID_VEHICULO");
        field_ALERTA = (JRFillField)fm.get("ALERTA");
        field_EMBARGO = (JRFillField)fm.get("EMBARGO");
    }


    /**
     *
     */
    void initVars(Map vm)
    {
        variable_PAGE_NUMBER = (JRFillVariable)vm.get("PAGE_NUMBER");
        variable_COLUMN_NUMBER = (JRFillVariable)vm.get("COLUMN_NUMBER");
        variable_REPORT_COUNT = (JRFillVariable)vm.get("REPORT_COUNT");
        variable_PAGE_COUNT = (JRFillVariable)vm.get("PAGE_COUNT");
        variable_COLUMN_COUNT = (JRFillVariable)vm.get("COLUMN_COUNT");
    }


    /**
     *
     */
    Object evaluate(int id)
    {
        Object value = null;

        if (id == 0)
        {
            value = (java.lang.String)("C://Civitrans//transito//web//paginas//reports//");
        }
        else if (id == 1)
        {
            value = (java.lang.Integer)(new Integer(1));
        }
        else if (id == 2)
        {
            value = (java.lang.Integer)(new Integer(1));
        }
        else if (id == 3)
        {
            value = (java.lang.Integer)(new Integer(1));
        }
        else if (id == 4)
        {
            value = (java.lang.Integer)(new Integer(0));
        }
        else if (id == 5)
        {
            value = (java.lang.Integer)(new Integer(1));
        }
        else if (id == 6)
        {
            value = (java.lang.Integer)(new Integer(0));
        }
        else if (id == 7)
        {
            value = (java.lang.Integer)(new Integer(1));
        }
        else if (id == 8)
        {
            value = (java.lang.Integer)(new Integer(0));
        }
        else if (id == 9)
        {
            value = (java.lang.String)("C:\\Civitrans\\transito\\web\\paginas\\html\\images\\colombia.png");
        }
        else if (id == 10)
        {
            value = (java.lang.String)("C:\\Civitrans\\transito\\web\\paginas\\html\\images\\RUNT.PNG");
        }
        else if (id == 11)
        {
            value = (java.lang.String)("C:\\Civitrans\\transito\\web\\paginas\\html\\images\\RUNT2.PNG");
        }
        else if (id == 12)
        {
            value = (java.lang.String)("C:\\Civitrans\\transito\\web\\paginas\\html\\images\\transito1.png");
        }
        else if (id == 13)
        {
            value = (java.lang.Object)(((java.lang.String)parameter_SUBREPORT_DIR.getValue()));
        }
        else if (id == 14)
        {
            value = (java.lang.Object)(((java.lang.String)field_ID_VEHICULO.getValue()));
        }
        else if (id == 15)
        {
            value = (java.sql.Connection)(((java.sql.Connection)parameter_REPORT_CONNECTION.getValue()));
        }
        else if (id == 16)
        {
            value = (java.lang.String)(((java.lang.String)parameter_SUBREPORT_DIR.getValue()) + "certificados/RVehiculo_subreport4.jasper");
        }
        else if (id == 17)
        {
            value = (java.lang.Boolean)(((java.lang.String)field_ALERTA.getValue())==null);
        }
        else if (id == 18)
        {
            value = (java.lang.Object)(((java.lang.String)parameter_SUBREPORT_DIR.getValue()));
        }
        else if (id == 19)
        {
            value = (java.lang.Object)(((java.lang.String)field_ID_VEHICULO.getValue()));
        }
        else if (id == 20)
        {
            value = (java.sql.Connection)(((java.sql.Connection)parameter_REPORT_CONNECTION.getValue()));
        }
        else if (id == 21)
        {
            value = (java.lang.String)(((java.lang.String)parameter_SUBREPORT_DIR.getValue()) + "certificados/RVehiculo_subreport3.jasper");
        }
        else if (id == 22)
        {
            value = (java.lang.String)(((java.lang.String)parameter_MARCA.getValue()));
        }
        else if (id == 23)
        {
            value = (java.lang.String)(((java.lang.String)parameter_LINEA.getValue()));
        }
        else if (id == 24)
        {
            value = (java.lang.String)(((java.lang.String)parameter_MODELO.getValue()));
        }
        else if (id == 25)
        {
            value = (java.lang.String)(((java.lang.String)parameter_COLOR.getValue()));
        }
        else if (id == 26)
        {
            value = (java.lang.String)(((java.lang.String)parameter_CLASE.getValue()));
        }
        else if (id == 27)
        {
            value = (java.lang.String)(((java.lang.String)parameter_MOTOR.getValue()));
        }
        else if (id == 28)
        {
            value = (java.lang.String)(((java.lang.String)parameter_CHASIS.getValue()));
        }
        else if (id == 29)
        {
            value = (java.lang.String)(((java.lang.String)parameter_SERIE.getValue()));
        }
        else if (id == 30)
        {
            value = (java.lang.String)(((java.lang.String)parameter_TIPO.getValue()));
        }
        else if (id == 31)
        {
            value = (java.lang.String)(((java.lang.String)parameter_SERVICIO.getValue()));
        }
        else if (id == 32)
        {
            value = (java.lang.Object)(((java.lang.String)parameter_SUBREPORT_DIR.getValue()));
        }
        else if (id == 33)
        {
            value = (java.lang.Object)(((java.lang.String)field_ID_VEHICULO.getValue()));
        }
        else if (id == 34)
        {
            value = (java.sql.Connection)(((java.sql.Connection)parameter_REPORT_CONNECTION.getValue()));
        }
        else if (id == 35)
        {
            value = (java.lang.String)(((java.lang.String)parameter_SUBREPORT_DIR.getValue()) + "certificados/RVehiculo_subreport2.jasper");
        }
        else if (id == 36)
        {
            value = (java.lang.String)(((java.lang.String)parameter_PLACA.getValue()));
        }
        else if (id == 37)
        {
            value = (java.lang.String)(((java.lang.String)parameter_CILINDRADA.getValue()));
        }
        else if (id == 38)
        {
            value = (java.lang.String)(((java.lang.String)parameter_COMBUSTIBLE.getValue()));
        }
        else if (id == 39)
        {
            value = (java.lang.String)(((java.lang.String)parameter_EJES.getValue()));
        }
        else if (id == 40)
        {
            value = (java.util.Date)(new java.util.Date());
        }
        else if (id == 41)
        {
            value = (java.util.Date)(((java.util.Date)parameter_MATRICULA.getValue()));
        }
        else if (id == 42)
        {
            value = (java.lang.String)(((java.lang.String)parameter_NUMERO.getValue()));
        }
        else if (id == 43)
        {
            value = (java.lang.String)(((java.lang.String)parameter_MODALIDAD.getValue()));
        }
        else if (id == 44)
        {
            value = (java.util.Date)(((java.util.Date)parameter_EXPEDICION.getValue()));
        }
        else if (id == 45)
        {
            value = (java.lang.String)(((java.lang.String)parameter_LICENCIA.getValue()));
        }
        else if (id == 46)
        {
            value = (java.lang.Object)(((java.lang.String)field_ID_VEHICULO.getValue()));
        }
        else if (id == 47)
        {
            value = (java.sql.Connection)(((java.sql.Connection)parameter_REPORT_CONNECTION.getValue()));
        }
        else if (id == 48)
        {
            value = (java.lang.String)(((java.lang.String)parameter_SUBREPORT_DIR.getValue()) + "certificados/RVehiculo_subreport1.jasper");
        }
        else if (id == 49)
        {
            value = (java.lang.String)(((java.lang.String)parameter_USUARIO.getValue()));
        }
        else if (id == 50)
        {
            value = (java.util.Date)(((java.util.Date)parameter_FECHAPAGO.getValue()));
        }
        else if (id == 51)
        {
            value = (java.lang.String)(((java.lang.String)parameter_NRO_PAGO.getValue()));
        }
        else if (id == 52)
        {
            value = (java.lang.String)(((java.lang.String)parameter_PERSONA.getValue()));
        }
        else if (id == 53)
        {
            value = (java.lang.String)(((java.lang.String)parameter_CAPACIDAD.getValue())+" kgs");
        }
        else if (id == 54)
        {
            value = (java.lang.String)(((java.lang.String)parameter_RADICADO.getValue()));
        }
        else if (id == 55)
        {
            value = (java.lang.Boolean)(((java.lang.String)parameter_RADICADO.getValue())!=null);
        }
        else if (id == 56)
        {
            value = (java.lang.String)(((java.lang.String)parameter_TRASLADADO.getValue()));
        }
        else if (id == 57)
        {
            value = (java.lang.Boolean)(((java.lang.String)parameter_TRASLADADO.getValue())!=null);
        }
        else if (id == 58)
        {
            value = (java.lang.Boolean)(((java.lang.String)parameter_ESTADO.getValue())!=null);
        }
        else if (id == 59)
        {
            value = (java.lang.Boolean)(((java.util.Date)parameter_FECHA_COT.getValue())!=null);
        }
        else if (id == 60)
        {
            value = (java.lang.String)(((java.lang.String)parameter_ESTADO.getValue()));
        }
        else if (id == 61)
        {
            value = (java.util.Date)(((java.util.Date)parameter_FECHA_COT.getValue()));
        }
        else if (id == 62)
        {
            value = (java.lang.String)(((java.lang.String)parameter_OBSERVACION.getValue()));
        }
        else if (id == 63)
        {
            value = (java.lang.Boolean)(((java.lang.String)field_EMBARGO.getValue())==null);
        }

        return value;
    }


    /**
     *
     */
    Object evaluateOld(int id)
    {
        Object value = null;

        if (id == 0)
        {
            value = (java.lang.String)("C://Civitrans//transito//web//paginas//reports//");
        }
        else if (id == 1)
        {
            value = (java.lang.Integer)(new Integer(1));
        }
        else if (id == 2)
        {
            value = (java.lang.Integer)(new Integer(1));
        }
        else if (id == 3)
        {
            value = (java.lang.Integer)(new Integer(1));
        }
        else if (id == 4)
        {
            value = (java.lang.Integer)(new Integer(0));
        }
        else if (id == 5)
        {
            value = (java.lang.Integer)(new Integer(1));
        }
        else if (id == 6)
        {
            value = (java.lang.Integer)(new Integer(0));
        }
        else if (id == 7)
        {
            value = (java.lang.Integer)(new Integer(1));
        }
        else if (id == 8)
        {
            value = (java.lang.Integer)(new Integer(0));
        }
        else if (id == 9)
        {
            value = (java.lang.String)("C:\\Civitrans\\transito\\web\\paginas\\html\\images\\colombia.png");
        }
        else if (id == 10)
        {
            value = (java.lang.String)("C:\\Civitrans\\transito\\web\\paginas\\html\\images\\RUNT.PNG");
        }
        else if (id == 11)
        {
            value = (java.lang.String)("C:\\Civitrans\\transito\\web\\paginas\\html\\images\\RUNT2.PNG");
        }
        else if (id == 12)
        {
            value = (java.lang.String)("C:\\Civitrans\\transito\\web\\paginas\\html\\images\\transito1.png");
        }
        else if (id == 13)
        {
            value = (java.lang.Object)(((java.lang.String)parameter_SUBREPORT_DIR.getValue()));
        }
        else if (id == 14)
        {
            value = (java.lang.Object)(((java.lang.String)field_ID_VEHICULO.getOldValue()));
        }
        else if (id == 15)
        {
            value = (java.sql.Connection)(((java.sql.Connection)parameter_REPORT_CONNECTION.getValue()));
        }
        else if (id == 16)
        {
            value = (java.lang.String)(((java.lang.String)parameter_SUBREPORT_DIR.getValue()) + "certificados/RVehiculo_subreport4.jasper");
        }
        else if (id == 17)
        {
            value = (java.lang.Boolean)(((java.lang.String)field_ALERTA.getOldValue())==null);
        }
        else if (id == 18)
        {
            value = (java.lang.Object)(((java.lang.String)parameter_SUBREPORT_DIR.getValue()));
        }
        else if (id == 19)
        {
            value = (java.lang.Object)(((java.lang.String)field_ID_VEHICULO.getOldValue()));
        }
        else if (id == 20)
        {
            value = (java.sql.Connection)(((java.sql.Connection)parameter_REPORT_CONNECTION.getValue()));
        }
        else if (id == 21)
        {
            value = (java.lang.String)(((java.lang.String)parameter_SUBREPORT_DIR.getValue()) + "certificados/RVehiculo_subreport3.jasper");
        }
        else if (id == 22)
        {
            value = (java.lang.String)(((java.lang.String)parameter_MARCA.getValue()));
        }
        else if (id == 23)
        {
            value = (java.lang.String)(((java.lang.String)parameter_LINEA.getValue()));
        }
        else if (id == 24)
        {
            value = (java.lang.String)(((java.lang.String)parameter_MODELO.getValue()));
        }
        else if (id == 25)
        {
            value = (java.lang.String)(((java.lang.String)parameter_COLOR.getValue()));
        }
        else if (id == 26)
        {
            value = (java.lang.String)(((java.lang.String)parameter_CLASE.getValue()));
        }
        else if (id == 27)
        {
            value = (java.lang.String)(((java.lang.String)parameter_MOTOR.getValue()));
        }
        else if (id == 28)
        {
            value = (java.lang.String)(((java.lang.String)parameter_CHASIS.getValue()));
        }
        else if (id == 29)
        {
            value = (java.lang.String)(((java.lang.String)parameter_SERIE.getValue()));
        }
        else if (id == 30)
        {
            value = (java.lang.String)(((java.lang.String)parameter_TIPO.getValue()));
        }
        else if (id == 31)
        {
            value = (java.lang.String)(((java.lang.String)parameter_SERVICIO.getValue()));
        }
        else if (id == 32)
        {
            value = (java.lang.Object)(((java.lang.String)parameter_SUBREPORT_DIR.getValue()));
        }
        else if (id == 33)
        {
            value = (java.lang.Object)(((java.lang.String)field_ID_VEHICULO.getOldValue()));
        }
        else if (id == 34)
        {
            value = (java.sql.Connection)(((java.sql.Connection)parameter_REPORT_CONNECTION.getValue()));
        }
        else if (id == 35)
        {
            value = (java.lang.String)(((java.lang.String)parameter_SUBREPORT_DIR.getValue()) + "certificados/RVehiculo_subreport2.jasper");
        }
        else if (id == 36)
        {
            value = (java.lang.String)(((java.lang.String)parameter_PLACA.getValue()));
        }
        else if (id == 37)
        {
            value = (java.lang.String)(((java.lang.String)parameter_CILINDRADA.getValue()));
        }
        else if (id == 38)
        {
            value = (java.lang.String)(((java.lang.String)parameter_COMBUSTIBLE.getValue()));
        }
        else if (id == 39)
        {
            value = (java.lang.String)(((java.lang.String)parameter_EJES.getValue()));
        }
        else if (id == 40)
        {
            value = (java.util.Date)(new java.util.Date());
        }
        else if (id == 41)
        {
            value = (java.util.Date)(((java.util.Date)parameter_MATRICULA.getValue()));
        }
        else if (id == 42)
        {
            value = (java.lang.String)(((java.lang.String)parameter_NUMERO.getValue()));
        }
        else if (id == 43)
        {
            value = (java.lang.String)(((java.lang.String)parameter_MODALIDAD.getValue()));
        }
        else if (id == 44)
        {
            value = (java.util.Date)(((java.util.Date)parameter_EXPEDICION.getValue()));
        }
        else if (id == 45)
        {
            value = (java.lang.String)(((java.lang.String)parameter_LICENCIA.getValue()));
        }
        else if (id == 46)
        {
            value = (java.lang.Object)(((java.lang.String)field_ID_VEHICULO.getOldValue()));
        }
        else if (id == 47)
        {
            value = (java.sql.Connection)(((java.sql.Connection)parameter_REPORT_CONNECTION.getValue()));
        }
        else if (id == 48)
        {
            value = (java.lang.String)(((java.lang.String)parameter_SUBREPORT_DIR.getValue()) + "certificados/RVehiculo_subreport1.jasper");
        }
        else if (id == 49)
        {
            value = (java.lang.String)(((java.lang.String)parameter_USUARIO.getValue()));
        }
        else if (id == 50)
        {
            value = (java.util.Date)(((java.util.Date)parameter_FECHAPAGO.getValue()));
        }
        else if (id == 51)
        {
            value = (java.lang.String)(((java.lang.String)parameter_NRO_PAGO.getValue()));
        }
        else if (id == 52)
        {
            value = (java.lang.String)(((java.lang.String)parameter_PERSONA.getValue()));
        }
        else if (id == 53)
        {
            value = (java.lang.String)(((java.lang.String)parameter_CAPACIDAD.getValue())+" kgs");
        }
        else if (id == 54)
        {
            value = (java.lang.String)(((java.lang.String)parameter_RADICADO.getValue()));
        }
        else if (id == 55)
        {
            value = (java.lang.Boolean)(((java.lang.String)parameter_RADICADO.getValue())!=null);
        }
        else if (id == 56)
        {
            value = (java.lang.String)(((java.lang.String)parameter_TRASLADADO.getValue()));
        }
        else if (id == 57)
        {
            value = (java.lang.Boolean)(((java.lang.String)parameter_TRASLADADO.getValue())!=null);
        }
        else if (id == 58)
        {
            value = (java.lang.Boolean)(((java.lang.String)parameter_ESTADO.getValue())!=null);
        }
        else if (id == 59)
        {
            value = (java.lang.Boolean)(((java.util.Date)parameter_FECHA_COT.getValue())!=null);
        }
        else if (id == 60)
        {
            value = (java.lang.String)(((java.lang.String)parameter_ESTADO.getValue()));
        }
        else if (id == 61)
        {
            value = (java.util.Date)(((java.util.Date)parameter_FECHA_COT.getValue()));
        }
        else if (id == 62)
        {
            value = (java.lang.String)(((java.lang.String)parameter_OBSERVACION.getValue()));
        }
        else if (id == 63)
        {
            value = (java.lang.Boolean)(((java.lang.String)field_EMBARGO.getOldValue())==null);
        }

        return value;
    }


    /**
     *
     */
    Object evaluateEstimated(int id)
    {
        Object value = null;

        if (id == 0)
        {
            value = (java.lang.String)("C://Civitrans//transito//web//paginas//reports//");
        }
        else if (id == 1)
        {
            value = (java.lang.Integer)(new Integer(1));
        }
        else if (id == 2)
        {
            value = (java.lang.Integer)(new Integer(1));
        }
        else if (id == 3)
        {
            value = (java.lang.Integer)(new Integer(1));
        }
        else if (id == 4)
        {
            value = (java.lang.Integer)(new Integer(0));
        }
        else if (id == 5)
        {
            value = (java.lang.Integer)(new Integer(1));
        }
        else if (id == 6)
        {
            value = (java.lang.Integer)(new Integer(0));
        }
        else if (id == 7)
        {
            value = (java.lang.Integer)(new Integer(1));
        }
        else if (id == 8)
        {
            value = (java.lang.Integer)(new Integer(0));
        }
        else if (id == 9)
        {
            value = (java.lang.String)("C:\\Civitrans\\transito\\web\\paginas\\html\\images\\colombia.png");
        }
        else if (id == 10)
        {
            value = (java.lang.String)("C:\\Civitrans\\transito\\web\\paginas\\html\\images\\RUNT.PNG");
        }
        else if (id == 11)
        {
            value = (java.lang.String)("C:\\Civitrans\\transito\\web\\paginas\\html\\images\\RUNT2.PNG");
        }
        else if (id == 12)
        {
            value = (java.lang.String)("C:\\Civitrans\\transito\\web\\paginas\\html\\images\\transito1.png");
        }
        else if (id == 13)
        {
            value = (java.lang.Object)(((java.lang.String)parameter_SUBREPORT_DIR.getValue()));
        }
        else if (id == 14)
        {
            value = (java.lang.Object)(((java.lang.String)field_ID_VEHICULO.getValue()));
        }
        else if (id == 15)
        {
            value = (java.sql.Connection)(((java.sql.Connection)parameter_REPORT_CONNECTION.getValue()));
        }
        else if (id == 16)
        {
            value = (java.lang.String)(((java.lang.String)parameter_SUBREPORT_DIR.getValue()) + "certificados/RVehiculo_subreport4.jasper");
        }
        else if (id == 17)
        {
            value = (java.lang.Boolean)(((java.lang.String)field_ALERTA.getValue())==null);
        }
        else if (id == 18)
        {
            value = (java.lang.Object)(((java.lang.String)parameter_SUBREPORT_DIR.getValue()));
        }
        else if (id == 19)
        {
            value = (java.lang.Object)(((java.lang.String)field_ID_VEHICULO.getValue()));
        }
        else if (id == 20)
        {
            value = (java.sql.Connection)(((java.sql.Connection)parameter_REPORT_CONNECTION.getValue()));
        }
        else if (id == 21)
        {
            value = (java.lang.String)(((java.lang.String)parameter_SUBREPORT_DIR.getValue()) + "certificados/RVehiculo_subreport3.jasper");
        }
        else if (id == 22)
        {
            value = (java.lang.String)(((java.lang.String)parameter_MARCA.getValue()));
        }
        else if (id == 23)
        {
            value = (java.lang.String)(((java.lang.String)parameter_LINEA.getValue()));
        }
        else if (id == 24)
        {
            value = (java.lang.String)(((java.lang.String)parameter_MODELO.getValue()));
        }
        else if (id == 25)
        {
            value = (java.lang.String)(((java.lang.String)parameter_COLOR.getValue()));
        }
        else if (id == 26)
        {
            value = (java.lang.String)(((java.lang.String)parameter_CLASE.getValue()));
        }
        else if (id == 27)
        {
            value = (java.lang.String)(((java.lang.String)parameter_MOTOR.getValue()));
        }
        else if (id == 28)
        {
            value = (java.lang.String)(((java.lang.String)parameter_CHASIS.getValue()));
        }
        else if (id == 29)
        {
            value = (java.lang.String)(((java.lang.String)parameter_SERIE.getValue()));
        }
        else if (id == 30)
        {
            value = (java.lang.String)(((java.lang.String)parameter_TIPO.getValue()));
        }
        else if (id == 31)
        {
            value = (java.lang.String)(((java.lang.String)parameter_SERVICIO.getValue()));
        }
        else if (id == 32)
        {
            value = (java.lang.Object)(((java.lang.String)parameter_SUBREPORT_DIR.getValue()));
        }
        else if (id == 33)
        {
            value = (java.lang.Object)(((java.lang.String)field_ID_VEHICULO.getValue()));
        }
        else if (id == 34)
        {
            value = (java.sql.Connection)(((java.sql.Connection)parameter_REPORT_CONNECTION.getValue()));
        }
        else if (id == 35)
        {
            value = (java.lang.String)(((java.lang.String)parameter_SUBREPORT_DIR.getValue()) + "certificados/RVehiculo_subreport2.jasper");
        }
        else if (id == 36)
        {
            value = (java.lang.String)(((java.lang.String)parameter_PLACA.getValue()));
        }
        else if (id == 37)
        {
            value = (java.lang.String)(((java.lang.String)parameter_CILINDRADA.getValue()));
        }
        else if (id == 38)
        {
            value = (java.lang.String)(((java.lang.String)parameter_COMBUSTIBLE.getValue()));
        }
        else if (id == 39)
        {
            value = (java.lang.String)(((java.lang.String)parameter_EJES.getValue()));
        }
        else if (id == 40)
        {
            value = (java.util.Date)(new java.util.Date());
        }
        else if (id == 41)
        {
            value = (java.util.Date)(((java.util.Date)parameter_MATRICULA.getValue()));
        }
        else if (id == 42)
        {
            value = (java.lang.String)(((java.lang.String)parameter_NUMERO.getValue()));
        }
        else if (id == 43)
        {
            value = (java.lang.String)(((java.lang.String)parameter_MODALIDAD.getValue()));
        }
        else if (id == 44)
        {
            value = (java.util.Date)(((java.util.Date)parameter_EXPEDICION.getValue()));
        }
        else if (id == 45)
        {
            value = (java.lang.String)(((java.lang.String)parameter_LICENCIA.getValue()));
        }
        else if (id == 46)
        {
            value = (java.lang.Object)(((java.lang.String)field_ID_VEHICULO.getValue()));
        }
        else if (id == 47)
        {
            value = (java.sql.Connection)(((java.sql.Connection)parameter_REPORT_CONNECTION.getValue()));
        }
        else if (id == 48)
        {
            value = (java.lang.String)(((java.lang.String)parameter_SUBREPORT_DIR.getValue()) + "certificados/RVehiculo_subreport1.jasper");
        }
        else if (id == 49)
        {
            value = (java.lang.String)(((java.lang.String)parameter_USUARIO.getValue()));
        }
        else if (id == 50)
        {
            value = (java.util.Date)(((java.util.Date)parameter_FECHAPAGO.getValue()));
        }
        else if (id == 51)
        {
            value = (java.lang.String)(((java.lang.String)parameter_NRO_PAGO.getValue()));
        }
        else if (id == 52)
        {
            value = (java.lang.String)(((java.lang.String)parameter_PERSONA.getValue()));
        }
        else if (id == 53)
        {
            value = (java.lang.String)(((java.lang.String)parameter_CAPACIDAD.getValue())+" kgs");
        }
        else if (id == 54)
        {
            value = (java.lang.String)(((java.lang.String)parameter_RADICADO.getValue()));
        }
        else if (id == 55)
        {
            value = (java.lang.Boolean)(((java.lang.String)parameter_RADICADO.getValue())!=null);
        }
        else if (id == 56)
        {
            value = (java.lang.String)(((java.lang.String)parameter_TRASLADADO.getValue()));
        }
        else if (id == 57)
        {
            value = (java.lang.Boolean)(((java.lang.String)parameter_TRASLADADO.getValue())!=null);
        }
        else if (id == 58)
        {
            value = (java.lang.Boolean)(((java.lang.String)parameter_ESTADO.getValue())!=null);
        }
        else if (id == 59)
        {
            value = (java.lang.Boolean)(((java.util.Date)parameter_FECHA_COT.getValue())!=null);
        }
        else if (id == 60)
        {
            value = (java.lang.String)(((java.lang.String)parameter_ESTADO.getValue()));
        }
        else if (id == 61)
        {
            value = (java.util.Date)(((java.util.Date)parameter_FECHA_COT.getValue()));
        }
        else if (id == 62)
        {
            value = (java.lang.String)(((java.lang.String)parameter_OBSERVACION.getValue()));
        }
        else if (id == 63)
        {
            value = (java.lang.Boolean)(((java.lang.String)field_EMBARGO.getValue())==null);
        }

        return value;
    }


}
