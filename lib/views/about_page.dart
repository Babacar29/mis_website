import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/mis_drawer.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBar(),
      endDrawer: const MisDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 60),
              color: AppTheme.backgroundLight,
              child: Column(
                children: [
                  Text(
                    "QUI SOMMES-NOUS ?",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      color: AppTheme.accentGold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Historique, Vocation & Gouvernance",
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryBlue,
                    ),
                  ),
                ],
              ),
            ),

            // 2. HISTORIQUE & VOCATION
            const _ContentSection(
              title: "Notre Histoire & Vocation",
              content: "La Mission Inter-Sénégal (MIS) tire ses racines d'un engagement profond pour l'évangile au Sénégal. Historiquement liée à la FES, notre vocation est de servir de pont entre les ressources spirituelles et les besoins sociaux.\n\nNous existons pour glorifier Dieu en répondant aux défis contemporains par une approche holistique : prêcher la parole et agir concrètement pour le développement des communautés.",
            ),

            // 3. NOS VALEURS (Grille de cartes)
            Container(
              width: double.infinity,
              color: AppTheme.primaryBlue,
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
              child: Column(
                children: [
                  Text(
                    "NOS VALEURS FONDAMENTALES",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Wrap(
                    spacing: 30,
                    runSpacing: 30,
                    alignment: WrapAlignment.center,
                    children: const [
                      _ValueCard(title: "Intégrité", icon: Icons.verified_user),
                      _ValueCard(title: "Service", icon: Icons.handshake),
                      _ValueCard(title: "Foi", icon: Icons.church),
                      _ValueCard(title: "Excellence", icon: Icons.star),
                    ],
                  ),
                ],
              ),
            ),

            // 4. LEADERSHIP & GOUVERNANCE
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
              child: Column(
                children: [
                  Text(
                    "LEADERSHIP & GOUVERNANCE",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(height: 3, width: 60, color: AppTheme.accentGold),
                  const SizedBox(height: 50),

                  // Section Directeur
                  const _LeadershipBlock(
                    role: "Le Directeur",
                    description: "Chargé de la vision opérationnelle et stratégique, le Directeur coordonne les départements et assure la représentation de la MIS auprès des partenaires. Il veille à l'exécution fidèle de la mission spirituelle et sociale sur le terrain.",
                    isDirector: true,
                  ),

                  const SizedBox(height: 60),

                  // Section Conseil d'Administration
                  const _LeadershipBlock(
                    role: "Le Conseil d'Administration",
                    description: "Le Conseil d'Administration joue un rôle stratégique et spirituel crucial. Il définit les grandes orientations, veille à la bonne gouvernance financière et éthique, et soutient la direction dans la prière et la prise de décision.",
                    isDirector: false,
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

// --- WIDGETS PRIVÉS ---

class _ContentSection extends StatelessWidget {
  final String title;
  final String content;

  const _ContentSection({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 30),
      child: SizedBox(
        width: 800,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryBlue,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              content,
              style: TextStyle(
                fontSize: 16,
                height: 1.6,
                color: AppTheme.textDark.withValues(alpha: .8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ValueCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const _ValueCard({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withValues(alpha: .2)),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppTheme.accentGold, size: 40),
          const SizedBox(height: 15),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

class _LeadershipBlock extends StatelessWidget {
  final String role;
  final String description;
  final bool isDirector;

  const _LeadershipBlock({required this.role, required this.description, required this.isDirector});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 800,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icône ou Photo (Placeholder)
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue.withValues(alpha: .1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isDirector ? Icons.person : Icons.groups,
              size: 40,
              color: AppTheme.primaryBlue,
            ),
          ),
          const SizedBox(width: 30),
          // Texte
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  role,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textDark,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: AppTheme.textDark.withValues(alpha: .7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}