import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../views/about_page.dart';
import '../views/contact_page.dart';
import '../views/donate_page.dart';
import '../views/home_page.dart';
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
      title: Image.asset(
        'assets/images/mis_logo_full.png',
        height: 50,
      ),
      actions: isDesktop 
        ? [
            _NavBarItem(title: "Accueil", onTap: () => context.go('/')),
            _NavBarItem(
                title: "À propos de la MIS", 
                onTap: () {
                  context.go('/about');
                }
              ),// 
            _NavBarItem(
              title: "Programmes & Activités", 
              onTap: () {
                context.go('/programs');
              }
            ),
            _NavBarItem(
              title: "Partenariats", 
              onTap: () {
                context.go('/partners');
              }
            ),

            _NavBarItem(
              title: "Contact & FAQ", 
              onTap: () {
                context.go('/contact');
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
        automaticallyImplyLeading: false,
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