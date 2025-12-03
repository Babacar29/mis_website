import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/site_content.dart';
import '../theme/app_theme.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import 'donate_page.dart';

class ProgramsPage extends StatelessWidget {
  const ProgramsPage({super.key});

  // Helper pour convertir la string de la DB en Icone Flutter
  IconData _getIcon(String name) {
    switch (name) {
      case 'school': return Icons.school;
      case 'agriculture': return Icons.agriculture;
      default: return Icons.church;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. EN-TÊTE DE PAGE
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 60),
              color: AppTheme.primaryBlue,
              child: Column(
                children: [
                  Text(
                    "NOS CHAMPS D'ACTION",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      color: AppTheme.accentGold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Programmes & Activités",
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: 600,
                    child: Text(
                      "Une approche holistique pour toucher les cœurs et transformer les conditions de vie.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            FutureBuilder<List<Map<String, dynamic>>>(
              future: Supabase.instance.client.from('programs').select().order('id'),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const SizedBox(height: 200, child: Center(child: CircularProgressIndicator()));
                
                final programs = snapshot.data!.map((e) => Program.fromJson(e)).toList();

                if (programs.isEmpty) return const Padding(padding: EdgeInsets.all(40), child: Text("Aucun programme pour le moment."));

                return Column(
                  children: programs.asMap().entries.map((entry) {
                    final index = entry.key;
                    final program = entry.value;
                    
                    return Column(
                      children: [
                        _ProgramSection(
                          title: program.title,
                          description: program.description,
                          details: program.details,
                          icon: _getIcon(program.iconName),
                          // Alterne l'image Droite/Gauche selon l'index (Pair/Impair)
                          isImageRight: index % 2 == 0, 
                          imageUrl: program.imageUrl ?? "https://via.placeholder.com/800x600", // Image par défaut
                        ),
                        // Ajoute un diviseur sauf après le dernier élément
                        if (index < programs.length - 1) const Divider(indent: 100, endIndent: 100),
                      ],
                    );
                  }).toList(),
                );
              },
            ),
           
            const SizedBox(height: 60),
            
            // APPEL À L'ACTION RAPIDE
            Container(
              padding: const EdgeInsets.symmetric(vertical: 40),
              color: AppTheme.backgroundLight,
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    "Vous souhaitez soutenir un de ces programmes ?",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const DonatePage())
                    );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.accentGold,
                    ),
                    child: const Text("Je fais un don"),
                  ),
                ],
              ),
            ),

            // PIED DE PAGE
            const Footer(),
          ],
        ),
      ),
    );
  }
}

// --- WIDGET MODIFIÉ POUR ACCEPTER UNE URL D'IMAGE ---

class _ProgramSection extends StatelessWidget {
  final String title;
  final String description;
  final List<String> details;
  final IconData icon;
  final bool isImageRight;
  final String imageUrl; // Nouveau paramètre

  const _ProgramSection({
    required this.title,
    required this.description,
    required this.details,
    required this.icon,
    required this.isImageRight,
    required this.imageUrl, // Requis maintenant
  });

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 800;

    Widget textContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: AppTheme.accentGold, size: 30),
            const SizedBox(width: 10),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryBlue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          description,
          style: TextStyle(
            fontSize: 16,
            height: 1.6,
            color: AppTheme.textDark.withOpacity(0.8),
          ),
        ),
        const SizedBox(height: 20),
        ...details.map((detail) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.check_circle, color: AppTheme.primaryBlue, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  detail,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        )),
      ],
    );

    // Contenu visuel mis à jour
    Widget imageContent = Container(
      height: 350, // Légèrement plus grand pour bien voir le visuel
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
        image: DecorationImage(
          image: NetworkImage(imageUrl), // Utilise l'URL spécifique
          fit: BoxFit.cover,
        ),
      ),
      // J'ai retiré le texte "Visuel Terrain" au milieu car l'image parle d'elle-même
    );

    if (isMobile) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            imageContent,
            const SizedBox(height: 30),
            textContent,
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      child: Row(
        children: [
          if (!isImageRight) Expanded(child: imageContent),
          if (!isImageRight) const SizedBox(width: 60),

          Expanded(child: textContent),

          if (isImageRight) const SizedBox(width: 60),
          if (isImageRight) Expanded(child: imageContent),
        ],
      ),
    );
  }
}