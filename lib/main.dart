import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:essence/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Inicializa sqflite para Linux
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  // ⚠️ SÓ PARA TESTES — apaga o banco toda vez
  final databasesPath = await getDatabasesPath();
  final dbPath = join(databasesPath, 'essence.db');
  await deleteDatabase(dbPath);

  runApp(const ProviderScope(child: EssenceApp()));
}
