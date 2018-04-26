<%
            String msg = "";
            try {
                modelo.Model model = (modelo.Model) session.getAttribute("model");
                String placa = request.getParameter("placa");
                String fun = request.getParameter("fun");
                String motor = request.getParameter("motor");
                String chasis = request.getParameter("chasis");
                String serie = request.getParameter("serie");
                String tramite = request.getParameter("tramite");
                
                if(tramite.equals("1")||tramite.equals("4")||tramite.equals("17")){
                    if(motor.length()>3)
                    msg += model.verificaMotor(motor, placa)==null?"":"Numero MOTOR ya existe - ";
                    if(chasis.length()>3)
                    msg += model.verificaChasis(chasis, placa)==null?"":"Numero CHASIS ya existe - ";
                    if(serie.length()>3)
                    msg += model.verificaSerie(serie, placa)==null?"":"Numero SERIE ya existe";
                }    
            } catch (Exception exc) {
                out.println(exc.getMessage());
            }
            out.print(msg.trim());
%>


