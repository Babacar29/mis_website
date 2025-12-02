import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../views/about_page.dart';
import '../views/donate_page.dart';
import '../views/partners_page.dart';
import '../views/programs_page.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  const NavBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    // Vérifie si l'écran est large (Desktop) ou petit (Mobile)
    bool isDesktop = MediaQuery.of(context).size.width > 800;

    return AppBar(
      centerTitle: false,
      title: Row(
        children: [
          // Ici on mettra le Logo plus tard [cite: 24]
          const Icon(Icons.church, color: AppTheme.primaryBlue, size: 30),
          const SizedBox(width: 10),
          Text(
            "MIS",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, 
              color: AppTheme.primaryBlue,
              letterSpacing: 1.5
            ),
          ),
        ],
      ),
      actions: isDesktop 
        ? [
            _NavBarItem(title: "Accueil", onTap: () {}),
            _NavBarItem(
                title: "À propos de la MIS", 
                onTap: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => const AboutPage()) 
                  );
                }
              ),// 
            _NavBarItem(
              title: "Programmes & Activités", 
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const ProgramsPage())
                );
              }
            ),
            _NavBarItem(
              title: "Partenariats", 
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const PartnersPage())
                );
              }
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const DonatePage())
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.accentGold),
              child: const Text("Faire un don"), // 
            ),
            const SizedBox(width: 20),
          ]
        : null, // Sur mobile, le menu hamburger apparaît automatiquement
    );
  }
}

// Widget pour les liens du menu
class _NavBarItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _NavBarItem({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        title,
        style: const TextStyle(
          color: AppTheme.textDark, 
          fontWeight: FontWeight.w600
        ),
      ),
    );
  }
}