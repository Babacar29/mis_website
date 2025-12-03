import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class MisDrawer extends StatelessWidget {
  const MisDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          // 1. EN-TÊTE AVEC LOGO
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppTheme.backgroundLight,
              border: Border(bottom: BorderSide(color: Colors.black12)),
            ),
            child: Center(
              child: Image.asset(
                'assets/images/mis_logo_full.png',
                height: 60,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // 2. LISTE DES LIENS
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _DrawerItem(icon: Icons.home, title: "Accueil", route: '/'),
                _DrawerItem(icon: Icons.info, title: "À propos", route: '/about'),
                _DrawerItem(icon: Icons.category, title: "Programmes", route: '/programs'),
                _DrawerItem(icon: Icons.handshake, title: "Partenariats", route: '/partners'),
                _DrawerItem(icon: Icons.mail, title: "Contact", route: '/contact'),
                
                const Divider(height: 30),
                
                // Lien Admin discret (Optionnel)
                ListTile(
                  leading: const Icon(Icons.admin_panel_settings, color: Colors.grey),
                  title: const Text("Admin", style: TextStyle(color: Colors.grey)),
                  onTap: () {
                    Navigator.pop(context); // Ferme le menu
                    context.go('/admin');
                  },
                ),
              ],
            ),
          ),

          // 3. BOUTON D'ACTION (DON) EN BAS
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.go('/donate');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accentGold,
                  foregroundColor: Colors.white,
                ),
                child: const Text("FAIRE UN DON"),
              ),
            ),
          ),
          const SizedBox(height: 20), // Marge bas pour les iPhone récents
        ],
      ),
    );
  }
}

// Petit widget helper pour éviter la répétition
class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String route;

  const _DrawerItem({required this.icon, required this.title, required this.route});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryBlue),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          color: AppTheme.textDark,
        ),
      ),
      onTap: () {
        Navigator.pop(context); // Important : ferme le tiroir avant de naviguer
        context.go(route);
      },
    );
  }
}