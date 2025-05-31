import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // tambahkan import ini
import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url:
        'https://defsgzzpblgkiidruvdq.supabase.co', // ganti dengan URL Supabase Anda
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRlZnNnenpwYmxna2lpZHJ1dmRxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc5MjYxODEsImV4cCI6MjA2MzUwMjE4MX0.TcGhGrYcbSvy5VYO251O8LgEtmjV_QRStM5CLYH4RHo', // ganti dengan anon key Supabase Anda
  );
  runApp(
    GetMaterialApp(
      title: "Konsinyasi App",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    ),
  );
}
