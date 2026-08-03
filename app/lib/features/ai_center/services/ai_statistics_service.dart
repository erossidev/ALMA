import 'package:cloud_firestore/cloud_firestore.dart';


class AIStatisticsService {


  final FirebaseFirestore _firestore;


  AIStatisticsService({
    FirebaseFirestore? firestore,
  }) :
    _firestore =
        firestore ?? FirebaseFirestore.instance;



  // ==========================================
  // ULTIMI 7 GIORNI - RICHIESTE
  // ==========================================

  Future<List<int>> loadDailyRequests() async {


    final now =
        DateTime.now();


    final start =
        DateTime(
          now.year,
          now.month,
          now.day - 6,
        );



    final snapshot =
        await _firestore
            .collection(
              "ai_executions",
            )
            .where(
              "timestamp",
              isGreaterThanOrEqualTo:
                  start,
            )
            .get();



    final days =
        List<int>.filled(
          7,
          0,
        );



    for (final doc in snapshot.docs) {


      final data =
          doc.data();



      final timestamp =
          (data["timestamp"]
              as Timestamp)
              .toDate();



      final difference =
          timestamp
              .difference(start)
              .inDays;



      if (difference >= 0 &&
          difference < 7) {

        days[difference]++;

      }

    }


    return days;

  }





  // ==========================================
  // TOKEN ULTIMI 7 GIORNI
  // ==========================================

  Future<List<int>> loadDailyTokens() async {


    final now =
        DateTime.now();



    final start =
        DateTime(
          now.year,
          now.month,
          now.day - 6,
        );



    final snapshot =
        await _firestore
            .collection(
              "ai_executions",
            )
            .where(
              "timestamp",
              isGreaterThanOrEqualTo:
                  start,
            )
            .get();



    final days =
        List<int>.filled(
          7,
          0,
        );



    for (final doc in snapshot.docs) {


      final data =
          doc.data();



      final timestamp =
          (data["timestamp"]
              as Timestamp)
              .toDate();



      final index =
          timestamp
              .difference(start)
              .inDays;



      if (index >= 0 &&
          index < 7) {


        days[index] +=
            (data["totalTokens"] ?? 0)
                as int;

      }

    }



    return days;

  }





  // ==========================================
  // TEMPO MEDIO RISPOSTA
  // ==========================================

  Future<double> loadAverageResponseTime() async {


    final snapshot =
        await _firestore
            .collection(
              "ai_executions",
            )
            .get();



    if (snapshot.docs.isEmpty) {

      return 0;

    }



    int total = 0;



    for (final doc in snapshot.docs) {


      total +=
          (doc["responseTimeMs"] ?? 0)
              as int;

    }



    return total /
        snapshot.docs.length;

  }



}