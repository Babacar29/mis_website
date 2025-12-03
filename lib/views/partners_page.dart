import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../theme/app_theme.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import 'contact_page.dart';

class PartnersPage extends StatelessWidget {
  const PartnersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBar(),
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
                    "ILS NOUS FONT CONFIANCE",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      color: AppTheme.accentGold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Nos Partenaires",
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: 600,
                    child: Text(
                      "Nous collaborons avec des organisations qui partagent notre vision pour multiplier notre impact sur le terrain.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppTheme.textDark.withValues(alpha: .7),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
              child: // Remplace le contenu statique par ceci :
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: Supabase.instance.client.from('partners').select(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text("Aucun partenaire pour le moment.");
                    }

                    final partners = snapshot.data!;
                    
                    return Wrap(
                      spacing: 40,
                      runSpacing: 40,
                      alignment: WrapAlignment.center,
                      children: partners.map((data) {
                        return Container(
                          width: 150,
                          height: 100,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)
                            ],
                          ),
                          child: data['logo_url'] != null
                              ? Image.network(data['logo_url'], fit: BoxFit.contain)
                              : Center(
                                  child: Text(
                                    data['name'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                        );
                      }).toList(),
                    );
                  },
                ),
            ),

            const Divider(indent: 100, endIndent: 100),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
              child: Column(
                children: [
                  Text(
                    "COMMENT COLLABORER ?",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Wrap(
                    spacing: 30,
                    runSpacing: 30,
                    alignment: WrapAlignment.center,
                    children: const [
                      _CollaborationCard(
                        title: "Partenariat Stratégique",
                        description: "Co-construction de projets à long terme et échange d'expertise.",
                        icon: Icons.handshake,
                      ),
                      _CollaborationCard(
                        title: "Soutien Financier",
                        description: "Financement ciblé de programmes (éducation, santé, églises).",
                        icon: Icons.monetization_on,
                      ),
                      _CollaborationCard(
                        title: "Volontariat & Mission",
                        description: "Envoi d'équipes ou de missionnaires court/long terme.",
                        icon: Icons.groups,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              color: AppTheme.primaryBlue,
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
              child: Column(
                children: [
                  const Icon(Icons.mail_outline, size: 50, color: AppTheme.accentGold),
                  const SizedBox(height: 20),
                  Text(
                    "DEVENIR PARTENAIRE",
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Vous souhaitez rejoindre l'aventure et soutenir la vision de la MIS ?",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => const ContactPage())
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppTheme.primaryBlue,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                    child: const Text("Nous Contacter"),
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


class _PartnerLogo extends StatelessWidget {
  final String name;

  const _PartnerLogo({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .03),
            blurRadius: 10,
          )
        ],
      ),
      child: Center(
        child: Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey.shade400,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _CollaborationCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const _CollaborationCard({required this.title, required this.description, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: AppTheme.backgroundLight,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue.withValues(alpha: .1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 30, color: AppTheme.primaryBlue),
          ),
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