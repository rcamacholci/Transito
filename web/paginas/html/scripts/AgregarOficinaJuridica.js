function VerificarOficina(id){

        var seleccion = document.getElementById('oficina');
        var texto = seleccion.options[seleccion.selectedIndex].text;//esto es lo que ve el usuario

        if(id!="nuevo"){
            document.form.idoficinaJuridica.value = id;
            document.form.oficinaJuridica.value = texto;
        }else{
            document.form.idoficinaJuridica.value = id;
            document.form.oficinaJuridica.value="";
        }
   }

        function VerificarCampo(){
            if(document.form.oficinaJuridica.value.length>0){
                document.form.action = "procesarOficinaJuridica.jsp"
                document.form.submit();
            }else{
                alert("El campo no puede estar vacio, ingrese Oficina Juridica")
                window.location.href = "AgregarOficinaJuridica.jsp";
            }
        }