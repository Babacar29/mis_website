import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/mis_drawer.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Détection pour la mise en page (Mobile vs Desktop)
    bool isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      appBar: const NavBar(),
      endDrawer: const MisDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 60),
              color: AppTheme.primaryBlue,
              child: Column(
                children: [
                  Text(
                    "UNE QUESTION ?",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      color: AppTheme.accentGold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Contact & FAQ",
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
              child: isMobile
                  ? Column(
                      children: const [
                        _ContactInfoPanel(),
                        SizedBox(height: 40),
                        _ContactForm(),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        _ContactInfoPanel(),
                        SizedBox(width: 60),
                        _ContactForm(),
                      ],
                    ),
            ),
            Container(
              color: AppTheme.backgroundLight,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
              child: Column(
                children: [
                  Text(
                    "QUESTIONS FRÉQUENTES",
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
                      children: const [
                        _FaqItem(
                          question: "Comment devenir partenaire de la MIS ?",
                          answer: "Pour devenir partenaire, vous pouvez nous contacter directement via le formulaire ci-dessus ou par email. Nous proposons plusieurs modes de collaboration : stratégique, financier ou via l'envoi de volontaires.",
                        ),
                        _FaqItem(
                          question: "Comment parrainer un enfant ?",
                          answer: "Le parrainage s'effectue via notre pôle Développement Social. Il suffit de nous signaler votre intérêt par email ou téléphone. Nous vous mettrons en relation avec le responsable du programme éducatif.",
                        ),
                        _FaqItem(
                          question: "Comment faire un don sécurisé ?",
                          answer: "Nous acceptons les virements bancaires, les chèques et les transferts Mobile Money (Orange Money, Wave). Toutes nos coordonnées officielles sont disponibles sur la page 'Faire un don'. Nous garantissons la traçabilité de chaque contribution.",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }
}

// --- WIDGETS PRIVÉS ---

class _ContactInfoPanel extends StatelessWidget {
  const _ContactInfoPanel();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "NOS COORDONNÉES",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryBlue,
            ),
          ),
          const SizedBox(height: 30),
          
          // Adresse
          const _InfoRow(
            icon: Icons.location_on, 
            title: "Adresse Postale", 
            content: "BP 715 Thiès, Sénégal" // [Source: User Prompt]
          ),
          
          const SizedBox(height: 20),
          
          // Téléphone
          const _InfoRow(
            icon: Icons.phone, 
            title: "Téléphone", 
            content: "(+221) 33 951 87 46" // [Source: User Prompt]
          ),
          
          const SizedBox(height: 20),
          
          // Email
          const _InfoRow(
            icon: Icons.email, 
            title: "Email", 
            content: "misintersen@gmail.com" // [Source: User Prompt]
          ),

          const SizedBox(height: 40),
          
          // Réseaux Sociaux
          Text(
            "SUIVEZ-NOUS",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryBlue,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              _SocialIcon(icon: Icons.facebook, onTap: () {}),
              const SizedBox(width: 15),
              _SocialIcon(icon: Icons.video_library, onTap: () {}), // YouTube placeholder
              const SizedBox(width: 15),
              _SocialIcon(icon: Icons.camera_alt, onTap: () {}), // Instagram placeholder
            ],
          )
        ],
      ),
    );
  }
}

class _ContactForm extends StatelessWidget {
  const _ContactForm();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "ENVOYER UN MESSAGE",
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              color: AppTheme.primaryBlue
            ),
          ),
          const SizedBox(height: 20),
          // Champs de formulaire décoratifs
          _buildTextField("Nom complet"),
          const SizedBox(height: 15),
          _buildTextField("Email"),
          const SizedBox(height: 15),
          _buildTextField("Sujet"),
          const SizedBox(height: 15),
          _buildTextField("Message", maxLines: 4),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Action d'envoi (simulée)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Merci ! Votre message a été envoyé (Simulation)."))
                );
              },
              child: const Text("ENVOYER"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const _InfoRow({required this.icon, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppTheme.primaryBlue.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppTheme.primaryBlue, size: 24),
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey)),
            Text(content, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: AppTheme.textDark)),
          ],
        ),
      ],
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SocialIcon({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.primaryBlue),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20, color: AppTheme.primaryBlue),
      ),
    );
  }
}

class _FaqItem extends StatelessWidget {
  final String question;
  final String answer;

  const _FaqItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryBlue),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: Text(
              answer,
              style: TextStyle(height: 1.5, color: Colors.grey.shade700),
            ),
          ),
        ],
      ),
    );
  }
}