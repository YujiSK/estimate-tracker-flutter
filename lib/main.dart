import 'package:estimate_tracker_hive/estimate_form_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'estimate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(EstimateAdapter());
  await Hive.openBox<Estimate>('estimates');
  runApp(EstimateApp());
}

class EstimateApp extends StatelessWidget {
  const EstimateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Estimate Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: EstimateFormPage(),
    );
  }
}