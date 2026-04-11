import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/app.dart';
import 'package:frontend/shared/api/api_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env.example");
  ApiClient.initialize();
  runApp(const ProviderScope(child: App()));
}
