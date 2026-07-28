import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'core/ai/backend_ai_registry.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);


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
  
  runApp(const AlmaApp());
}