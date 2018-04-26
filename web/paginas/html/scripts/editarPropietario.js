/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


function revisar(){
    if(document.getElementById("nombre").value.length>5){
        if(document.getElementById("fecha_inicial").value.length>0){
                if(document.getElementById("fecha_final").value.length>0){
                    fecha1 = document.getElementById("fecha_inicial").value
                    fecha2 = document.getElementById("fecha_final").value
                    f1 = new Date(fecha1.substr(6,4),fecha1.substr(3,2)-1,fecha1.substr(0,2)).getTime()
                    f2 = new Date(fecha2.substr(6,4),fecha2.substr(3,2)-1,fecha2.substr(0,2)).getTime()
                    if(f2>=f1){
                        if(document.getElementsByName('proIndiviso')[0].checked || document.getElementsByName('proIndiviso')[1].checked){
                            document.form.submit()
                        }else alert("Proindiviso? si/no")
                    }else alert("Fecha final debe ser mayor o igual a la inicial")
                }else if(document.getElementsByName('proIndiviso')[0].checked || document.getElementsByName('proIndiviso')[1].checked){
                    document.form.submit()
                }else alert("Proindiviso? si/no")
        }else alert("Seleccione al menos una fecha inicial")
}else alert("Digite un numero de identificacion valido")
}
function salir(){
        document.form.action = "verPropietarios.jsp?id=1"
        document.form.submit()
}