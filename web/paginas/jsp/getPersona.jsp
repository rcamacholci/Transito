<% 
modelo.Model modelo= (modelo.Model)session.getAttribute("model");
if (!request.getParameter("documento").isEmpty()){
	modelo.Persona persona = modelo.consultarPersona(Integer.parseInt(request.getParameter("tipo")),request.getParameter("documento").trim());
	if(persona!=null){
            out.print(persona.getNombre_1()+" "+(persona.getNombre_2()!=null?persona.getNombre_2():"")+" "+persona.getApellido_1()+" "+(persona.getApellido_2()!=null?persona.getApellido_2():""));
        }else{
            out.print("nueva");
        }
}else{
    out.print("nueva");
}
%>