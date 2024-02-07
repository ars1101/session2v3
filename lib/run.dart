import 'package:flutter/material.dart';
import 'auth/presentation/pages/signup.dart';
import 'core/color.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  Supabase.initialize( url: 'https://lwtgrvmdvlhofehpmgtb.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx3dGdydm1kdmxob2ZlaHBtZ3RiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDcyMzc4NDYsImV4cCI6MjAyMjgxMzg0Nn0.V6mo8ojP3m2HGKgLzNItYp4k-Mfylz5DYLmEIodd1v0',
  );
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: coloresdefault,
      home: const signUp(),
    );
  }
}

