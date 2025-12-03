import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';

class DonatePage extends StatelessWidget {
  const DonatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. EN-TÊTE : APPEL À L'ACTION
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
              color: AppTheme.primaryBlue,
              child: Column(
                children: [
                  const Icon(Icons.volunteer_activism, size: 60, color: AppTheme.accentGold),
                  const SizedBox(height: 20),
                  Text(
                    "SOUTENIR LA MISSION",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      color: AppTheme.accentGold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Votre générosité bâtit l'avenir",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 600,
                    child: Text(
                      "Votre soutien change des vies et contribue à l’expansion du Royaume de Dieu au Sénégal.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: .9),
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 50),

            // 2. MODALITÉS DE DON (Cartes de paiement)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Text(
                    "MODALITÉS DE DON",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // Utilisation de Wrap pour l'adaptation mobile/desktop
                  Wrap(
                    spacing: 30,
                    runSpacing: 30,
                    alignment: WrapAlignment.center,
                    children: const [
                      _DonationMethodCard(
                        title: "Virement Bancaire",
                        icon: Icons.account_balance,
                        details: [
                          "Banque : À Remplir",
                          "Code IBAN : SNXX XXXX XXXX...",
                          "Code SWIFT : XXXXXX",
                          "Titulaire : Mission Inter-Sénégal"
                        ],
                      ),
                      _DonationMethodCard(
                        title: "Mobile Money",
                        icon: Icons.phone_android,
                        details: [
                          "Orange Money : +221 77 XXX XX XX",
                          "Wave : +221 77 XXX XX XX",
                          "Free Money : +221 76 XXX XX XX",
                          "Motif : Don MIS"
                        ],
                      ),
                      _DonationMethodCard(
                        title: "Chèque / Espèces",
                        icon: Icons.mail_outline,
                        details: [
                          "À l'ordre de : Mission Inter-Sénégal",
                          "Adresse : Siège Social, Dakar",
                          "Ou directement au bureau administratif",
                          "du Lundi au Vendredi."
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 80),

            // 3. ENGAGEMENT ÉTHIQUE & TRANSPARENCE
            Container(
              color: AppTheme.backgroundLight,
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
              child: Column(
                children: [
                  Text(
                    "NOTRE ENGAGEMENT DE TRANSPARENCE",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(height: 3, width: 60, color: AppTheme.accentGold),
                  const SizedBox(height: 40),
                  
                  SizedBox(
                    width: 800,
                    child: Column(
                      children: [
                        _TransparencyItem(
                          title: "Gestion Rigoureuse",
                          content: "La MIS s'engage à une gestion financière rigoureuse sous la supervision du Conseil d'Administration. Chaque franc est affecté au projet désigné.",
                        ),
                        _TransparencyItem(
                          title: "Rapports d'Impact",
                          content: "Nous publions régulièrement des chiffres clés et des témoignages pour montrer l'impact concret de vos dons sur le terrain.",
                        ),
                        _TransparencyItem(
                          title: "Sécurité des Données",
                          content: "Vos informations personnelles restent confidentielles et ne sont jamais partagées avec des tiers.",
                        ),
                      ],
                    ),
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

class _DonationMethodCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<String> details;

  const _DonationMethodCard({required this.title, required this.icon, required this.details});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Icon(icon, size: 50, color: AppTheme.primaryBlue)),
          const SizedBox(height: 20),
          Center(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.textDark,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 20),
          ...details.map((detail) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SelectableText( // Permet à l'utilisateur de copier le texte (IBAN, etc.)
              detail,
              style: const TextStyle(fontSize: 14, color: AppTheme.textDark),
            ),
          )),
        ],
      ),
    );
  }
}

class _TransparencyItem extends StatelessWidget {
  final String title;
  final String content;

  const _TransparencyItem({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline, color: AppTheme.accentGold, size: 28),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppTheme.primaryBlue,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  content,
                  style: TextStyle(
                    fontSize: 15,
                    color: AppTheme.textDark.withValues(alpha: .7),
                    height: 1.5,
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