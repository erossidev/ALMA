import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/di/service_locator.dart';

import '../models/ai_dashboard_data.dart';
import 'ai_statistics_service.dart';



class AIDashboardService {


  const AIDashboardService();



  Future<AIDashboardData> loadDashboard() async {



    // ==============================
    // RISORSE AI
    // ==============================


    final registry =
        ServiceLocator.backendAIService;



    final resources =
        await registry.loadResources();




    final providers =
        resources
            .map((e) => e.providerId)
            .toSet()
            .length;



    final models =
        resources.length;



    final defaultProvider =
        resources.isNotEmpty
            ? resources.first.providerId
            : "Nessuno";





    // ==============================
    // STATISTICHE GENERALI
    // ==============================


    final snapshot =
        await FirebaseFirestore.instance
            .collection("ai_executions")
            .get();



    int requests = 0;

    int totalTokens = 0;

    int totalTime = 0;



    final Map<String,int> providerCount = {};

    final Map<String,int> modelCount = {};





    for (final doc in snapshot.docs) {


      final data =
          doc.data();



      requests++;



      totalTokens +=
          (data["totalTokens"] ?? 0) as int;



      totalTime +=
          (data["responseTimeMs"] ?? 0) as int;



      final provider =
          data["provider"] ?? "unknown";



      final model =
          data["model"] ?? "unknown";




      providerCount[provider] =
          (providerCount[provider] ?? 0) + 1;



      modelCount[model] =
          (modelCount[model] ?? 0) + 1;


    }





    String mainProvider =
        "Nessuno";



    if (providerCount.isNotEmpty) {


      mainProvider =
          providerCount.entries
              .reduce(
                (a,b) =>
                    a.value > b.value
                        ? a
                        : b,
              )
              .key;

    }






    String mainModel =
        "Nessuno";



    if (modelCount.isNotEmpty) {


      mainModel =
          modelCount.entries
              .reduce(
                (a,b) =>
                    a.value > b.value
                        ? a
                        : b,
              )
              .key;

    }






    final averageResponseTime =
        requests > 0
            ? totalTime ~/ requests
            : 0;






    // ==============================
    // GRAFICI ULTIMI 7 GIORNI
    // ==============================


    final statistics =
        AIStatisticsService();



    final dailyRequests =
        await statistics.loadDailyRequests();



    final dailyTokens =
        await statistics.loadDailyTokens();







    return AIDashboardData(



      providers:
          providers,



      models:
          models,



      defaultProvider:
          defaultProvider,



      requestsToday:
          requests,



      totalTokens:
          totalTokens,



      averageResponseTime:
          averageResponseTime,



      mainProvider:
          mainProvider,



      mainModel:
          mainModel,



      dailyRequests:
          dailyRequests,



      dailyTokens:
          dailyTokens,



    );


  }


}