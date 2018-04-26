<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="../../html/scripts/motorAjax.js" type="text/javascript"></script>
        <script src="../../html/scripts/ValidacionesTablasParametrica.js" type="text/javascript"></script>
        <script>
            function guardarColores(){
                alert("ajax");
                ajax2=nuevoAjax3();
                var IdColor = document.form.txt_IdColor.value;
                var NombreColor= document.form.txt_NombreColor.value;
                alert(IdColor +"-"+NombreColor);
                ajax2.open("POST", "GuardarColor.jsp",true);
                ajax2.onreadystatechange=function() {
                    if (ajax2.readyState==4) {
                         var docxml = ajax2.responseXML;
                        var result = docxml.getElementsByTagName('result')[0].childNodes[0].nodeValue;
                        alert("result : "+ result);
                        if(result == '1'){
                            var mensaje = docxml.getElementsByTagName('mensaje')[0].childNodes[0].nodeValue
                            alert(mensaje);
                        }else{
                            var mensaje = docxml.getElementsByTagName('mensaje')[0].childNodes[0].nodeValue
                            alert(mensaje);
                            document.form.txt_IdColor.value = "";
                            document.form.txt_NombreColor.value = "";
                        }
                    }
                }
                ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                ajax2.send("id_color="+IdColor+"&nombre_color="+NombreColor);
            }
            function nuevoAjax3(){
                var xmlhttp= false;
                try{
                    xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
                }catch(e){
                    try {
                        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                    }catch(E){
                        xmlhttp = false;
                    }
                }
                if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
                    xmlhttp = new XMLHttpRequest();
                }
                return xmlhttp;
            }
        </script>
    </head>
    <body>
        <form name="form" method="post" action="javascript:guardarColores()">
            <div>
                <table width="100%" border="1">
                    <tr>
                        <td>codigo</td>
                        <td>nombre</td>
                        <td>guardar</td>
                    </tr>
                    <tr>
                        <td><input type="text" id="txt_IdColor" name="txt_IdColor" maxlength="10" onkeypress="return soloNumeros(event)"/></td>
                        <td><input type="text" id="txt_NombreColor" name="txt_NombreColor" maxlength="50" size="50%" onkeypress="return validarLetras(event)"/></td>
                        <td><button type="submit" name="guardar" id="guardar">Guardar<img src="../../html/images/guardar.png" width="19" height="18"/></button></td>
                    </tr>
                </table>
            </div>
            <div>
                <iframe id="ColoresAgregados" name="ColoresAgregados" frameborder="0" width="100%" height="400px"></iframe>
            </div>
        </form>
    </body>
</html>
