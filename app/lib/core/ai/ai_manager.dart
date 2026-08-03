import 'ai_orchestrator.dart';
import 'ai_provider_registry.dart';
import 'ai_request.dart';
import 'ai_response.dart';
import 'ai_resource_resolver.dart';
import 'backend_ai_registry.dart';
import 'ai_task.dart';

import '../di/service_locator.dart';

import 'services/ai_execution_recorder.dart';
import 'services/console_execution_recorder.dart';
import 'services/firestore_execution_recorder.dart';



class AIManager {

  late final AIOrchestrator _orchestrator;


  final List<AIExecutionRecorder> _recorders = [

    const ConsoleExecutionRecorder(),

    FirestoreExecutionRecorder(),

  ];



  bool _initialized = false;



  // =====================================================
  // INIT
  // =====================================================

  Future<void> init() async {

    if (_initialized) {
      return;
    }


    final providerRegistry =
        AIProviderRegistry();


    await providerRegistry.loadProviders();



    _orchestrator =
        AIOrchestrator(

      registry:
          BackendAIRegistry(),


      resolver:
          const AIResourceResolver(),


      providerRegistry:
          providerRegistry,


      backendAIService:
          ServiceLocator.backendAIService,

    );


    _initialized = true;

  }



  // =====================================================
  // CHECK INIT
  // =====================================================

  void _checkInitialized() {

    if (!_initialized) {

      throw Exception(
        "AIManager non inizializzato. Chiamare init() prima.",
      );

    }

  }



  // =====================================================
  // EXECUTE
  // =====================================================

  Future<AIResponse> _execute(
    AIRequest request,
  ) async {


    _checkInitialized();


    final response =
        await _orchestrator.execute(
      request,
    );



    for (final recorder in _recorders) {

      await recorder.record(

        request:
            request,

        response:
            response,

      );

    }



    return response;

  }



  // =====================================================
  // CHAT
  // =====================================================

  Future<AIResponse> generateResponse(
    String prompt,
  ) async {

    return _execute(

      AIRequest(

        prompt:
            prompt,

        task:
            AITask.language,

        requiredCapabilities:
            const [

          "conversation",

        ],

      ),

    );

  }



  // =====================================================
  // KNOWLEDGE
  // =====================================================

  Future<String> extractKnowledge(
    String prompt,
  ) async {

    final response =
        await _execute(

      AIRequest(

        prompt:
            prompt,

        task:
            AITask.knowledge,

        requiredCapabilities:
            const [

          "reasoning",

          "json",

        ],

      ),

    );


    return response.reply;

  }



  // =====================================================
  // LEARNING
  // =====================================================

  Future<String> classifyLearning(
    String prompt,
  ) async {

    final response =
        await _execute(

      AIRequest(

        prompt:
            prompt,

        task:
            AITask.learning,

        requiredCapabilities:
            const [

          "reasoning",

        ],

      ),

    );


    return response.reply;

  }



  // =====================================================
  // ONTOLOGY
  // =====================================================

  Future<String> normalizeOntology(
    String prompt,
  ) async {

    final response =
        await _execute(

      AIRequest(

        prompt:
            prompt,

        task:
            AITask.ontologyNormalization,

        requiredCapabilities:
            const [

          "reasoning",

          "json",

        ],

      ),

    );


    return response.reply;

  }

}