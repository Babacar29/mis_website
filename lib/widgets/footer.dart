import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.primaryBlue, // Fond bleu institutionnel
      padding: const EdgeInsets.only(top: 60, bottom: 20),
      child: Column(
        children: [
          // Contenu principal du footer
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Wrap(
              spacing: 60, // Espace horizontal entre les colonnes
              runSpacing: 40, // Espace vertical si ça passe à la ligne
              alignment: WrapAlignment.start,
              children: [
                
                // COLONNE 1 : Logo & Description courte
                SizedBox(
                  width: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "MIS",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "La Mission Inter-Sénégal œuvre pour l'évangile et le développement social, bâtissant des ponts entre les communautés.",
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: .8),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                // COLONNE 2 : Liens Rapides [cite: 10]
                const _FooterColumn(
                  title: "NAVIGATION",
                  links: [
                    "Accueil",
                    "À propos de la MIS",
                    "Nos Programmes & Activités",
                    "Partenariats",
                    "Faire un don",
                  ],
                ),

                // COLONNE 3 : Contact 
                SizedBox(
                  width: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "NOUS CONTACTER",
                        style: GoogleFonts.poppins(
                          color: AppTheme.accentGold,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const _ContactRow(icon: Icons.location_on, text: "Siège Social, Dakar, Sénégal"),
                      const _ContactRow(icon: Icons.phone, text: "+221 33 800 00 00"),
                      const _ContactRow(icon: Icons.email, text: "contact@mis-senegal.org"),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 60),
          const Divider(color: Colors.white24),
          const SizedBox(height: 20),

          // Copyright bas de page
          Text(
            "© ${2025} Mission Inter-Sénégal. Tous droits réservés.",
            style: TextStyle(color: Colors.white.withValues(alpha: .5), fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// --- WIDGETS PRIVÉS POUR LE FOOTER ---

class _FooterColumn extends StatelessWidget {
  final String title;
  final List<String> links;

  const _FooterColumn({required this.title, required this.links});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            color: AppTheme.accentGold,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        ...links.map((link) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: InkWell(
            onTap: () {}, // Lien inactif pour le moment
            child: Text(
              link,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        )),
      ],
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ContactRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.accentGold, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}