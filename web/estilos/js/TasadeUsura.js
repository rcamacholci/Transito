/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function () {
    $('#submit').click(function (event) {
        // alert("EStoy en la funcion");
        var vigencia = $("#vigencia").val();
        var mes = $("#Mes").val();
        var tasa = $("#tasa").val();
        if (mes === '-1') {
            alert('Debes escoger un mes');
            $("#Mes").focus();
            return;
        }
        if (tasa.trim() === '') {
            alert('Debes digitar una Tasa de usura');
            $("#tasa").focus();
            return;
        }
        if (mes > 12 || mes < 1) {
            alert("El mes seleccionado no existe.");
        } else {
            var opcionmes;
            switch (mes) {
                case '1':
                    opcionmes = "Enero";
                    break;
                case '2':
                    opcionmes = "Febrero";
                    break;
                case '3':
                    opcionmes = "Marzo";
                    break;
                case '4':
                    opcionmes = "Abril";
                    break;
                case '5':
                    opcionmes = "Mayo";
                    break;
                case '6':
                    opcionmes = "Junio";
                    break;
                case '7':
                    opcionmes = "Julio";
                    break;
                case '8':
                    opcionmes = "Agosto";
                    break;
                case '9':
                    opcionmes = "Septiembre";
                    break;
                case '10':
                    opcionmes = "Octubre";
                    break;
                case '11':
                    opcionmes = "Noviembre";
                    break;
                case '12':
                    opcionmes = "Diciembre";
                    break;

                default:
                    break;
            }
            ;

            var opcion = confirm("¿Desea Registrar la tasa de usura del mes de " + opcionmes + "?");
            if (opcion === true) {
                // Si en vez de por post lo queremos hacer por get, cambiamos el $.post por $.get
                $.post('../../procesarTasaUsura', {
                    vigencia: vigencia,
                    mes: mes,
                    tasa: tasa
                }, function (responseText, status) {
                    $("#Mes").val('-1');
                    $("#tasa").val('');
                    $('#respuesta').html(responseText);
                });
            } else {
                return;
            }//fin else

        }//fin else

    });
});
