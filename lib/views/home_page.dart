import 'package:flutter/material.dart';
import '../widgets/footer.dart';
import '../widgets/mis_drawer.dart';
import '../widgets/navbar.dart';
import '../theme/app_theme.dart';
import 'sections/home_overview.dart'; // <--- Nouvel import

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBar(),
      endDrawer: const MisDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- SECTION HERO ---
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 500,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppTheme.primaryBlue,
                    image: DecorationImage(
                      image: NetworkImage('https://images.unsplash.com/photo-1488521787991-ed7bbaae773c?q=80&w=1600&auto=format&fit=crop'),
                      fit: BoxFit.cover,
                      opacity: 0.4, 
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const Text(
                        "MISSION INTER-SÉNÉGAL",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Servir Dieu, Aimer le Prochain,\nBâtir l'Avenir.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: .9),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppTheme.accentGold, width: 2),
                        ),
                        child: const Text(
                          "« Allez, faites de toutes les nations des disciples... »\n- Matthieu 28:19",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppTheme.primaryBlue,
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            // --- SECTION APERÇU RAPIDE ---
            const HomeOverview(), // <--- Intégration ici
            
            // --- SECTION SUIVANTE ---
            // Le footer viendra ici
            const Footer(),
          ],
        ),
      ),
    );
  }
}