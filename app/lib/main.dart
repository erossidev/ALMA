import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'brain/ontology/ontology_loader.dart';

import 'core/ai/backend_ai_registry.dart';

import 'brain/semantic/yaml_semantic_loader.dart';
import 'brain/semantic/yaml_semantic_parser.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);

// ============================================
// TEST ONTOLOGY
// ============================================

final ontology = await OntologyLoader.load();

print("");
print("===== ONTOLOGY =====");
print(ontology);
print("====================");
print("");


  ///Script di test
  final registry = BackendAIRegistry();

final resources =
    await registry.loadResources();

print("");
print("===== AI RESOURCES =====");

  for (final r in resources) {
    print(r.displayName);
    print(r.providerId);
    print(r.modelId);
    print(r.capabilities);
    print("------");
  }

  print("========================");
  print("");

  //TEST SEMANTIC
  
  const loader = YamlSemanticLoader();

    const parser = YamlSemanticParser();

    final text = await loader.load(
      "assets/semantic/entities.yaml",
    );

    final nodes = await parser.parse(
      text,
    );

    print("=== SEMANTIC TEST ===");

    for (final node in nodes) {
      print("${node.id} -> ${node.label}");
    }

    print("=====================");

    //FINE TEST

  runApp(const AlmaApp());
}