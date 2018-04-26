/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function inicioSesion(){
    document.form.action = "validar_login";
    document.form.submit();
}

function cancelar(){
    document.location.href = "index.html";
}