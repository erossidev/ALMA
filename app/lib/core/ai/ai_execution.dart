import 'ai_request.dart';
import 'ai_resource.dart';
import 'ai_response.dart';


class AIExecution {

  final AIRequest request;

  final AIResource resource;

  final AIResponse response;

  final DateTime timestamp;


  final String provider;

  final String model;


  final int promptTokens;

  final int completionTokens;

  final int totalTokens;


  final int responseTimeMs;



  const AIExecution({

    required this.request,

    required this.resource,

    required this.response,

    required this.timestamp,


    required this.provider,

    required this.model,


    required this.promptTokens,

    required this.completionTokens,

    required this.totalTokens,


    required this.responseTimeMs,

  });



  factory AIExecution.now({

    required AIRequest request,

    required AIResource resource,

    required AIResponse response,

  }) {


    return AIExecution(

      request:
          request,


      resource:
          resource,


      response:
          response,


      timestamp:
          DateTime.now(),



      provider:
          response.provider,


      model:
          response.model,



      promptTokens:
          response.usage.promptTokens,


      completionTokens:
          response.usage.completionTokens,


      totalTokens:
          response.usage.totalTokens,


      responseTimeMs:
          response.usage.responseTimeMs,

    );

  }

}