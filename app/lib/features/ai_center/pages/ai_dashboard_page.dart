import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../services/ai_dashboard_service.dart';
import '../models/ai_dashboard_data.dart';



class AIDashboardPage extends StatefulWidget {

  const AIDashboardPage({
    super.key,
  });


  @override
  State<AIDashboardPage> createState() =>
      _AIDashboardPageState();

}



class _AIDashboardPageState
    extends State<AIDashboardPage> {


  late final AIDashboardService _service;


  AIDashboardData? _data;


  bool _loading = true;




  @override
  void initState() {

    super.initState();


    _service =
        const AIDashboardService();


    _load();

  }





  Future<void> _load() async {


    final data =
        await _service.loadDashboard();



    setState(() {

      _data = data;

      _loading = false;

    });


  }






  Widget _statCard({

    required IconData icon,

    required String title,

    required String value,

    required Color color,

  }) {


    return Container(

      width: 170,


      padding:
          const EdgeInsets.all(18),



      decoration:

          BoxDecoration(

            color:
                const Color(0xff141b2d),


            borderRadius:
                BorderRadius.circular(18),



            border:

                Border.all(

                  color:
                      color.withOpacity(0.5),

                ),

          ),




      child: Column(


        crossAxisAlignment:
            CrossAxisAlignment.start,



        children: [



          Icon(

            icon,

            color:
                color,

            size:
                32,

          ),



          const SizedBox(height:12),




          Text(

            title,

            style:

                const TextStyle(

                  color:
                      Colors.white70,

                  fontSize:
                      14,

                ),

          ),




          const SizedBox(height:5),




          Text(

            value,

            style:

                const TextStyle(

                  color:
                      Colors.white,

                  fontSize:
                      25,

                  fontWeight:
                      FontWeight.bold,

                ),

          ),



        ],

      ),

    );

  }









  Widget _chartCard({

    required String title,

    required List<int> values,

  }) {


    return Container(

      padding:
          const EdgeInsets.all(20),



      decoration:

          BoxDecoration(

            color:
                const Color(0xff141b2d),

            borderRadius:
                BorderRadius.circular(20),

          ),




      child: Column(



        crossAxisAlignment:
            CrossAxisAlignment.start,



        children: [



          Text(

            title,

            style:

                const TextStyle(

                  color:
                      Colors.white,

                  fontSize:
                      18,

                  fontWeight:
                      FontWeight.bold,

                ),

          ),



          const SizedBox(height:20),




          SizedBox(

            height:220,



            child:

                LineChart(



              LineChartData(



                gridData:

                    const FlGridData(

                      show:true,

                    ),




                titlesData:

                    const FlTitlesData(

                      show:true,

                    ),




                borderData:

                    FlBorderData(

                      show:false,

                    ),




                lineBarsData: [



                  LineChartBarData(



                    spots:

                        List.generate(

                          values.length,

                          (index) => FlSpot(

                            index.toDouble(),

                            values[index].toDouble(),

                          ),

                        ),




                    isCurved:true,



                    dotData:

                        const FlDotData(

                          show:true,

                        ),



                  ),


                ],



              ),


            ),


          ),



        ],

      ),



    );


  }








  @override
  Widget build(BuildContext context) {


    if (_loading) {


      return const Center(

        child:
            CircularProgressIndicator(),

      );


    }




    final data =
        _data!;




    return SingleChildScrollView(



      padding:
          const EdgeInsets.all(24),



      child: Column(



        crossAxisAlignment:
            CrossAxisAlignment.start,



        children: [





          Row(


            children: [



              const Icon(

                Icons.psychology,

                size:
                    40,

                color:
                    Colors.purpleAccent,

              ),




              const SizedBox(width:12),




              Text(

                "ALMA AI CONTROL CENTER",

                style:

                    Theme.of(context)

                        .textTheme

                        .headlineSmall,

              ),



            ],


          ),





          const SizedBox(height:30),





          Wrap(



            spacing:18,

            runSpacing:18,



            children: [



              _statCard(

                icon:
                    Icons.cloud,

                title:
                    "Providers",

                value:
                    "${data.providers}",

                color:
                    Colors.blue,

              ),




              _statCard(

                icon:
                    Icons.memory,

                title:
                    "Models",

                value:
                    "${data.models}",

                color:
                    Colors.purple,

              ),





              _statCard(

                icon:
                    Icons.chat,

                title:
                    "Esecuzioni",

                value:
                    "${data.requestsToday}",

                color:
                    Colors.green,

              ),





              _statCard(

                icon:
                    Icons.token,

                title:
                    "Token",

                value:
                    "${data.totalTokens}",

                color:
                    Colors.orange,

              ),





              _statCard(

                icon:
                    Icons.speed,

                title:
                    "Tempo medio",

                value:
                    "${data.averageResponseTime} ms",

                color:
                    Colors.cyan,

              ),



            ],

          ),






          const SizedBox(height:35),





          Container(



            padding:
                const EdgeInsets.all(20),




            decoration:

                BoxDecoration(

                  color:
                      const Color(0xff141b2d),

                  borderRadius:
                      BorderRadius.circular(20),

                ),




            child: Column(



              crossAxisAlignment:
                  CrossAxisAlignment.start,



              children: [



                const Text(

                  "🏆 AI più utilizzata",

                  style:

                      TextStyle(

                        color:
                            Colors.white,

                        fontSize:
                            20,

                        fontWeight:
                            FontWeight.bold,

                      ),

                ),




                const SizedBox(height:15),




                Text(

                  "Provider: ${data.mainProvider}",

                  style:

                      const TextStyle(

                        color:
                            Colors.white70,

                      ),

                ),




                Text(

                  "Modello: ${data.mainModel}",

                  style:

                      const TextStyle(

                        color:
                            Colors.white70,

                      ),

                ),




                Text(

                  "Default: ${data.defaultProvider}",

                  style:

                      const TextStyle(

                        color:
                            Colors.white70,

                      ),

                ),



              ],

            ),

          ),






          const SizedBox(height:30),




          _chartCard(

            title:
                "📈 Richieste ultimi 7 giorni",

            values:
                data.dailyRequests,

          ),




          const SizedBox(height:25),




          _chartCard(

            title:
                "🪙 Token ultimi 7 giorni",

            values:
                data.dailyTokens,

          ),




        ],


      ),


    );


  }


}