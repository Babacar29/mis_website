import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'env.dart';
import 'routes.dart';
import 'theme/app_theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: Env.supabaseKey, 
  );
  runApp(const MisWebsiteApp());
}

class MisWebsiteApp extends StatelessWidget {
  const MisWebsiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    // On utilise MaterialApp.router au lieu de MaterialApp simple
    return MaterialApp.router(
      title: 'Mission Inter-Sénégal',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      
      // Configuration du Router
      routerConfig: appRouter, 
    );
  }
}