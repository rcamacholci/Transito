function mascara(d,sep,nums){
    if(d.valant != d.value){
        var pat = new Array(2,2,4)
	val = d.value
	largo = val.length
	val = val.split(sep)
	val2 = ''
	for(r=0;r<val.length;r++){
		val2 += val[r]
	}
	if(nums){
		for(z=0;z<val2.length;z++){
			if(isNaN(val2.charAt(z))){
				letra = new RegExp(val2.charAt(z),"g")
				val2 = val2.replace(letra,"")
			}
		}
	}
	val = ''
	val3 = new Array()
	for(s=0; s<pat.length; s++){
		val3[s] = val2.substring(0,pat[s])
		val2 = val2.substr(pat[s])
	}
	for(q=0;q<val3.length; q++){
		if(q ==0){
			val = val3[q]
		}
		else{
			if(val3[q] != ""){
				val += sep + val3[q]
				}
		}
	}
        d.value = val
        d.valant = val
	if(val.length==10){
            var dia = val.substr(0,2);
            var mes = val.substr(3,2);
            var ano = val.substr(6,4);
            var fecha = new Date(ano,mes-1,dia)
            var change = false;
            if(fecha.getMonth()!=mes-1){
                alert('Fecha erronea')
                change = false
            }else if(dia<1){
                dia = '01'
                change = true
            }else if(dia>31){
                dia = '31'
                change = true
            }else if(mes<1){
                mes = '01'
                change = true
            }else if(mes>12){
                mes = '12'
                change = true
            }else if(ano<1901){
                ano = '1901'
                change = true
            }else if(ano>2099){
                ano = '2015'
                change = true
            }
            if(change){
                d.value = dia+'/'+mes+'/'+ano
                d.valant = dia+'/'+mes+'/'+ano
            }
        }
        
    }
}