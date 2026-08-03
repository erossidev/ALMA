import 'package:cloud_firestore/cloud_firestore.dart';

import 'ai_execution_recorder.dart';

import '../ai_request.dart';
import '../ai_response.dart';



class FirestoreExecutionRecorder
    implements AIExecutionRecorder {


  final FirebaseFirestore firestore;


  FirestoreExecutionRecorder({
    FirebaseFirestore? firestore,
  }) : firestore =
          firestore ?? FirebaseFirestore.instance;



  @override
  Future<void> record({
    required AIRequest request,
    required AIResponse response,
  }) async {


    await firestore
        .collection("ai_executions")
        .add({


      "timestamp":
          FieldValue.serverTimestamp(),


      "task":
          request.task.name,


      "provider":
          response.provider,


      "model":
          response.model,


      "promptTokens":
          response.usage.promptTokens,


      "completionTokens":
          response.usage.completionTokens,


      "totalTokens":
          response.usage.totalTokens,


      "responseTimeMs":
          response.usage.responseTimeMs,


    });


  }

}