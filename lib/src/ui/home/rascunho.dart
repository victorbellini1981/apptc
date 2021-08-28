/*

Text(
                  "Digite a atividade",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xffb22222),
                      fontSize: 20,
                      fontFamily: 'Montserrat'),
                ),

Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: btnEntrar,
                );
              } else {
                return Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height / 2,
                  child: Column(
                    children: [
                      Container(child: btnEntrar),
                      SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                        itemCount: listaAtividades.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: MediaQuery.of(context).size.width * 1,
                            padding: EdgeInsets.only(right: 10, left: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Text(
                                    listaAtividades[index].data_atv,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xffb22222),
                                        fontSize: 13,
                                        fontFamily: 'Montserrat'),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    listaAtividades[index].atividade,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xffb22222),
                                        fontSize: 13,
                                        fontFamily: 'Montserrat'),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: btnAtv,
                                )
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                );

*/