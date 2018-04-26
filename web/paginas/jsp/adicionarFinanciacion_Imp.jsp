<%
            String msg = "";
            boolean paso = false;
            modelo.Model model = (modelo.Model) session.getAttribute("model");
            try {
                if (session.getAttribute("usuario") != null) {
                    if (model != null) {
                        modelo.Usuario usuario = (modelo.Usuario) session.getAttribute("usuario");
                        if (model.tienePermiso(usuario.getId_usuario(), 238)) {
                            if (session.getAttribute("carteraF") != null) {
                                if (request.getParameter("idF") != null && request.getParameter("cInicial") != null && request.getParameter("fInicial") != null && request.getParameter("nCuotas") != null && request.getParameter("totalf")!= null ) {
                                    java.util.List<modelo.Cartera> listaF = (java.util.List<modelo.Cartera>) session.getAttribute("carteraF");
                                    float cI = Float.parseFloat(request.getParameter("cInicial"));
                                    int nC = Integer.parseInt(request.getParameter("nCuotas"));
                                    java.sql.Date fI = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fInicial")).getTime());

                                    float total = 0;
                                    total = Float.parseFloat(request.getParameter("totalf"));
                                    /*for (modelo.Cartera c : listaF) {
                                        total += c.getSaldo();
                                    }*/
                                    if (total >= 0) {
                                        long idV = listaF.get(0).getFk_vehiculo();
                                        modelo.Propietario proV = model.consultarPropietarioVehiculo(idV);
                                        long idP = proV.getFk_persona();
                                        modelo.Tipo_Financiacion tipoF = model.consultarTipoDeFinanciacion2ByTotal(total);
                                        if (tipoF != null) {
                                            long idF = tipoF.getId_tipoFinanciacion();
                                            double cuotaInicial = tipoF.getInicial_desde();
                                            int nCuotas = tipoF.getCuotas_hasta();
                                            if ((long) cI >= (long) cuotaInicial) {
                                                if (nC <= nCuotas) {
                                                    float intereses = 0;
                                                    procesos.calcularAmortizacion amortizacion = new procesos.calcularAmortizacion(3, nC, (double) total, (double) cI, intereses, fI);
                                                    utility.Cuota[] cuotas = amortizacion.getCuotas();
                                                    if (cuotas != null) {
                                                        if (idP != 0) {
                                                            model.getCon().setAutoCommit(false);
                                                            int vigencia = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
                                                            int numero = model.consultarConsecutivo(usuario.getFk_sede(), 18, vigencia);
                                                            String consecutivo = "AP" + vigencia + ("000000".substring(0, 6 - (numero + "").length())) + numero;

                                                            modelo.Financiacion_Imp financiacion_imp = new modelo.Financiacion_Imp();
                                                            financiacion_imp.setFk_usuario(usuario.getId_usuario());
                                                            financiacion_imp.setFecha(new java.sql.Date(new java.util.Date().getTime()));
                                                            financiacion_imp.setNumero(consecutivo);
                                                            financiacion_imp.setValor(total);
                                                            financiacion_imp.setCuotas(nC);
                                                            financiacion_imp.setCuota_inicial(cI);
                                                            financiacion_imp.setEstado(1);
                                                            financiacion_imp.setFecha_proceso(new java.sql.Timestamp(new java.util.Date().getTime()));
                                                            financiacion_imp.setObservacion("");
                                                            if (idV != 0) {
                                                                financiacion_imp.setFk_vehiculo(idV);
                                                            }
                                                            financiacion_imp.setFk_persona(idP);
                                                            financiacion_imp.setFk_sede(usuario.getFk_sede());
                                                            financiacion_imp.setFk_tipo_financiacion(idF);
                                                            long idFinanciacion = model.adicionarFinanciacion_Imp(financiacion_imp);
                                                            if (idFinanciacion != 0) {
                                                                model.actualizarConsecutivo(usuario.getFk_sede(), 18, vigencia);
                                                                java.util.List<Long> carterasFinanciadas = new java.util.LinkedList<Long>();
                                                                for (modelo.Cartera c : listaF) {
                                                                    model.actualizarCartera(c.getId_cartera(), 0, 4, 0, null, null, 3);
                                                                    modelo.Financiacion_Cartera financiacion_cartera = new modelo.Financiacion_Cartera();
                                                                    financiacion_cartera.setFk_financiacion(idFinanciacion);
                                                                    financiacion_cartera.setFk_cartera(c.getId_cartera());
                                                                    model.adicionarFinanciacionCartera_Imp(financiacion_cartera);
                                                                    carterasFinanciadas.add(c.getId_cartera());
                                                                }

                                                                java.util.HashMap<Long, Float> detalleConcepto = model.detalleCarterasFinanciacion(carterasFinanciadas);

                                                                for (int i = 0; i < cuotas.length; i++) {
                                                                    utility.Cuota cuota = cuotas[i];
                                                                    modelo.Cartera cartera = new modelo.Cartera();
                                                                    cartera.setFk_persona(idP);
                                                                    if (idV != 0) {
                                                                        cartera.setFk_vehiculo(idV);
                                                                    }
                                                                    cartera.setFk_sede(usuario.getFk_sede());
                                                                    cartera.setTipo(3);
                                                                    cartera.setReferencia(financiacion_imp.getNumero() + " [" + cuota.obtenerPeriodo() + "]");
                                                                    cartera.setFecha_creacion(cuota.obtenerFecha());
                                                                    cartera.setFecha_ingreso(new java.sql.Date(new java.util.Date().getTime()));
                                                                    cartera.setValor(Math.round(cuota.obtenerValorCuota()));
                                                                    cartera.setSaldo(Math.round(cuota.obtenerValorCuota()));
                                                                    cartera.setFecha_saldo(cartera.getFecha_creacion());
                                                                    cartera.setEstado_cartera(1);
                                                                    cartera.setFecha_estado(cartera.getFecha_creacion());
                                                                    cartera.setEstado_vigencia(1);
                                                                    cartera.setFecha_estado_vigencia(cartera.getFecha_creacion());
                                                                    cartera.setFk_usuario(usuario.getId_usuario());
                                                                    cartera.setFk_concepto(tipoF.getFk_conceptoCartera());
                                                                    long id_cartera = model.adicionarCartera(cartera);
                                                                    cartera.setId_cartera(id_cartera);
                                                                    long key = 0;
                                                                    float totalD = 0;
                                                                    for (java.util.Iterator<Long> it = detalleConcepto.keySet().iterator(); it.hasNext();) {
                                                                        key = it.next();
                                                                        modelo.Detalle_Cartera detalle_cartera = new modelo.Detalle_Cartera();
                                                                        detalle_cartera.setFk_cartera(id_cartera);
                                                                        detalle_cartera.setEstado(1);
                                                                        detalle_cartera.setFecha(cartera.getFecha_creacion());
                                                                        detalle_cartera.setFecha_sistema(new java.sql.Timestamp(new java.util.Date().getTime()));
                                                                        detalle_cartera.setFk_concepto(key);
                                                                        detalle_cartera.setFk_usuario(usuario.getId_usuario());
                                                                        detalle_cartera.setReferencia(cartera.getReferencia());
                                                                        detalle_cartera.setValor(Math.round(detalleConcepto.get(key) * cartera.getValor()));
                                                                        model.adicionarDetalleCartera(detalle_cartera);
                                                                        totalD += detalle_cartera.getValor();
                                                                    }
                                                                    totalD = (float) (cartera.getValor() - totalD);
                                                                    model.actualizarDetalleCartera(cartera.getId_cartera(), 1, key, Math.round(detalleConcepto.get(key) * cartera.getValor()) + totalD);
                                                                    modelo.Detalle_Financiacion_Imp detalle_financiacion = new modelo.Detalle_Financiacion_Imp();
                                                                    detalle_financiacion.setFk_financiacion(idFinanciacion);
                                                                    detalle_financiacion.setFk_cartera(id_cartera);
                                                                    detalle_financiacion.setCuota(cuota.obtenerPeriodo());
                                                                    detalle_financiacion.setEstado(1);
                                                                    detalle_financiacion.setFecha_pago(cartera.getFecha_creacion());
                                                                    detalle_financiacion.setFecha_proceso(new java.sql.Timestamp(new java.util.Date().getTime()));
                                                                    detalle_financiacion.setValor((float) cuota.obtenerAbonoCapital());
                                                                    detalle_financiacion.setIntereses((float) cuota.obtenerIntPagados());
                                                                    detalle_financiacion.setSaldo((float) (cuota.obtenerAbonoCapital() + cuota.obtenerIntPagados()));
                                                                    model.adicionarDetalleFinanciacion_IMP(detalle_financiacion);
                                                                }
                                                                session.removeAttribute("carteraF");
                                                                model.getCon().commit(); %>
                                                                <script language="javascript" type="text/javascript">
                                                                        window.parent.parent.parent.document.location.href = "verFinanciacion_Imp.jsp?idFinanciacion=<%=idFinanciacion%>";
                                                                </script>
                                                         <%      msg = "Financiacion Realizada !!!";
                                                            } else {
                                                                msg = "No se pudo registrar la financiacion";
                                                            }
                                                        } else {
                                                            msg = "No existe una persona asociada a la financiacion";
                                                        }
                                                    } else {
                                                        msg = "No se pudo calcular la amortizacion de cuotas de la financiacion";
                                                    }
                                                } else {
                                                    msg = "El numero de cuotas supera el limite permitido para el tipo de financiacion";
                                                }
                                            } else {
                                                msg = "El valor de la cuota inicial es menor al limite permitido para el tipo de financiacion";
                                            }
                                        } else {
                                            msg = "No se ha definido un tipo de financiacion valido";
                                        }
                                    } else {
                                        msg = "El valor total de la financiacion debe ser mayor a 0";
                                    }
                                } else {
                                    msg = "Algunos parametros no fueron enviados al acuerdo";
                                }
                            } else {
                                msg = "El listado de carteras a financiar no existe";
                            }
                        } else {
                            msg = "El usuario no tiene permisos para realizar la financiacion";
                        }
                    } else {
                        msg = "Conexion no existente";
                    }
                } else {
                    msg = "Sesion invalidada";
                }
            } catch (Exception exc) {
                msg = "Error de procesamiento :" + exc.getMessage();
                exc.printStackTrace();
            }
            if (!paso) {
                model.getCon().rollback(); %>
                <script language="javascript" type="text/javascript">
                    alert('<%=msg%>');
                </script>
        <%  } %>

