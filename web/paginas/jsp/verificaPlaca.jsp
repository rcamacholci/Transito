<%@ page  import="modelo.Vehiculo" import="modelo.Model" import = "java.util.HashMap"%>
<%
            int res = 1;
            try {
                if(request.getParameter("placa")!=null){
                    if(!request.getParameter("placa").equals("0")){
                        Model model = (Model) session.getAttribute("model");
                        String placa = request.getParameter("placa");
                        String valida = model.verificarPlaca(placa.toUpperCase());
                        session.setAttribute("placa", placa) ;
                        if (valida.equals("10")){
                            res = 0;
                        } else if (valida.equals("00")){
                            res = 2;
                        } else if (valida.equals("01")){
                            res = 3;
                        }
                    }else{
                        res = 4;
                    }
                }
            } catch (Exception exc) {
                exc.printStackTrace();
                out.println(exc.getMessage());
            }
            out.print(res);
%>


