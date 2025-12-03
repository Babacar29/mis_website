import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../theme/app_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _signIn() async {
    setState(() => _isLoading = true);
    
    // On cache le clavier virtuel
    FocusManager.instance.primaryFocus?.unfocus();

    try {
      await Supabase.instance.client.auth.signInWithPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (mounted) {
        // Redirection vers le dashboard
        context.go('/admin/dashboard');
      }
    } on AuthException catch (e) {
      String errorMessage = "Une erreur est survenue.";

      if (e.message.contains("Invalid login credentials")) {
        errorMessage = "Email ou mot de passe incorrect.";
      } else if (e.message.contains("Email not confirmed")) {
        errorMessage = "Veuillez confirmer votre email avant de vous connecter.";
      } else if (e.message.contains("Network request failed")) {
        errorMessage = "Problème de connexion internet.";
      } else {
        errorMessage = e.message;
      }

      // Appel de la nouvelle méthode de Pop-up
      _showErrorDialog(errorMessage);

    } catch (e) {
      _showErrorDialog("Une erreur inattendue s'est produite. Vérifiez votre connexion.");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // --- NOUVELLE MÉTHODE : POP-UP CLASSIQUE ---
  void _showErrorDialog(String message) {
    if (!mounted) return;
    
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Row(
          children: const [
            Icon(Icons.warning_amber_rounded, color: Colors.redAccent),
            SizedBox(width: 10),
            Text("Erreur de connexion", style: TextStyle(fontSize: 18)),
          ],
        ),
        content: Text(
          message,
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx), // Ferme le pop-up
            child: const Text(
              "OK",
              style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryBlue),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBlue,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryBlue.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.admin_panel_settings, size: 50, color: AppTheme.primaryBlue),
                ),
                const SizedBox(height: 20),
                
                const Text(
                  "Espace Administration", 
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue)
                ),
                const SizedBox(height: 30),
                
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email", 
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                const SizedBox(height: 20),
                
                TextField(
                  controller: _passwordController, 
                  obscureText: true, 
                  decoration: InputDecoration(
                    labelText: "Mot de passe", 
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                const SizedBox(height: 30),
                
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: _isLoading 
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: _signIn,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryBlue, 
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text("SE CONNECTER", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                ),
                
                const SizedBox(height: 20),
                
                TextButton(
                  onPressed: () => context.go('/'),
                  child: const Text("Retour au site public", style: TextStyle(color: Colors.grey)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}