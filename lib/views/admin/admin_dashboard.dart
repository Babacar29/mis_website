import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:file_picker/file_picker.dart';
import '../../models/partner.dart';
import '../../theme/app_theme.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final _supabase = Supabase.instance.client;
  
  // Fonction pour ajouter un partenaire
  Future<void> _addPartner() async {
    String name = "";
    PlatformFile? pickedImage;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Ajouter un partenaire"),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: const InputDecoration(labelText: "Nom du partenaire"),
                    onChanged: (value) => name = value,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles(type: FileType.image);
                      if (result != null) {
                        setState(() => pickedImage = result.files.first);
                      }
                    },
                    child: Text(pickedImage == null ? "Choisir un logo" : "Logo sélectionné !"),
                  )
                ],
              );
            },
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Annuler")),
            ElevatedButton(
              onPressed: () async {
                if (name.isNotEmpty) {
                  String? imageUrl;
                  // Upload de l'image si présente
                  if (pickedImage != null && pickedImage!.bytes != null) {
                    final fileName = '${DateTime.now().millisecondsSinceEpoch}_${pickedImage!.name}';
                    await _supabase.storage.from('logos').uploadBinary(
                      fileName,
                      pickedImage!.bytes!,
                    );
                    imageUrl = _supabase.storage.from('logos').getPublicUrl(fileName);
                  }
                  
                  // Insertion en base de données
                  await _supabase.from('partners').insert({'name': name, 'logo_url': imageUrl});
                  if (mounted) Navigator.pop(context);
                }
              },
              child: const Text("Enregistrer"),
            ),
          ],
        );
      },
    );
    setState(() {}); // Rafraîchir la liste
  }

  // Fonction pour supprimer
  Future<void> _deletePartner(int id) async {
    await _supabase.from('partners').delete().eq('id', id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestion des Partenaires"),
        backgroundColor: AppTheme.primaryBlue,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _supabase.auth.signOut();
              if (mounted) Navigator.pop(context);
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPartner,
        backgroundColor: AppTheme.accentGold,
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _supabase.from('partners').select().order('id', ascending: false),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final partners = snapshot.data!.map((e) => Partner.fromJson(e)).toList();

          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: partners.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final partner = partners[index];
              return ListTile(
                leading: partner.logoUrl != null 
                  ? Image.network(partner.logoUrl!, width: 50, height: 50, fit: BoxFit.contain)
                  : const Icon(Icons.image_not_supported),
                title: Text(partner.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deletePartner(partner.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}