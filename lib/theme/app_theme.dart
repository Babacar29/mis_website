import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Palette de couleurs Option A
  static const Color primaryBlue = Color(0xFF1A3B5D); // Bleu profond/Institutionnel
  static const Color accentGold = Color(0xFFD4AF37);  // Doré élégant
  static const Color textDark = Color(0xFF2C3E50);    // Texte lisible
  static const Color backgroundLight = Color(0xFFF9FAFB); // Blanc cassé très léger

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: primaryBlue,
      scaffoldBackgroundColor: backgroundLight,
      
      // Configuration de la police (Moderne et propre)
      textTheme: GoogleFonts.poppinsTextTheme().apply(
        bodyColor: textDark,
        displayColor: primaryBlue,
      ),

      // Style des boutons par défaut
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: primaryBlue),
        titleTextStyle: TextStyle(color: primaryBlue, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}