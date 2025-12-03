import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/site_content.dart';
import '../../theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeOverview extends StatelessWidget {
  const HomeOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 60),
        
        // 1. LA MISSION (Texte Introduction)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Text(
                "NOTRE MISSION",
                style: GoogleFonts.poppins(
                  color: AppTheme.accentGold,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: 800, // Limite la largeur pour la lisibilité sur grand écran
                child: Text(
                  "La Mission Inter-Sénégal est une vitrine institutionnelle et un outil de mobilisation au service de l'évangile et du développement social.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryBlue,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 50),
        Container(
          width: double.infinity,
          color: AppTheme.primaryBlue,
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: Supabase.instance.client.from('statistics').select().order('id'),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(color: AppTheme.accentGold));
              
              final stats = snapshot.data!.map((e) => Statistic.fromJson(e)).toList();

              return Wrap(
                alignment: WrapAlignment.spaceEvenly,
                spacing: 40,
                runSpacing: 40,
                children: stats.map((stat) => _StatItem(
                  count: stat.count,
                  label: stat.label
                )).toList(),
              );
            },
          ),
        ),
        const SizedBox(height: 60),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text(
                "NOS DOMAINES D'INTERVENTION",
                style: TextStyle(
                  color: AppTheme.textDark.withValues(alpha: .6),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 30),
              Wrap(
                spacing: 30,
                runSpacing: 30,
                alignment: WrapAlignment.center,
                children: const [
                  _ProjectCard(
                    title: "Implantation d'églises",
                    description: "Témoignages et actions dans les zones ciblées.",
                    icon: Icons.church,
                  ),
                  _ProjectCard(
                    title: "Développement Social",
                    description: "Agriculture, santé, éducation et parrainage.",
                    icon: Icons.agriculture,
                  ),
                  _ProjectCard(
                    title: "Formation des Jeunes",
                    description: "Écoles, ateliers de formation et mentorat.",
                    icon: Icons.school,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}

// --- WIDGETS PRIVÉS POUR CETTE SECTION ---

class _StatItem extends StatelessWidget {
  final String count;
  final String label;

  const _StatItem({required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: GoogleFonts.poppins(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: AppTheme.accentGold, // Chiffres en doré
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const _ProjectCard({required this.title, required this.description, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 250,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: AppTheme.primaryBlue),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textDark,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.textDark.withValues(alpha: .7),
            ),
          ),
        ],
      ),
    );
  }
}