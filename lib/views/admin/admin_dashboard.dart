import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_theme.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final _supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // 3 Onglets
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Administration MIS"),
          backgroundColor: AppTheme.primaryBlue,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.handshake), text: "Partenaires"),
              Tab(icon: Icon(Icons.analytics), text: "Chiffres Clés"),
              Tab(icon: Icon(Icons.category), text: "Programmes"),
            ],
            indicatorColor: AppTheme.accentGold,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await _supabase.auth.signOut();
                if (mounted) context.go('/admin'); // Retour au login
              },
            )
          ],
        ),
        body: const TabBarView(
          children: [
            _PartnersManager(),
            _StatsManager(),
            _ProgramsManager(),
          ],
        ),
      ),
    );
  }
}

class _PartnersManager extends StatefulWidget {
  const _PartnersManager();
  @override
  State<_PartnersManager> createState() => _PartnersManagerState();
}
class _PartnersManagerState extends State<_PartnersManager> {
  final _supabase = Supabase.instance.client;

  Future<void> _addPartner() async {
    String name = "";
    PlatformFile? pickedImage;
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Ajouter Partenaire"),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(decoration: const InputDecoration(labelText: "Nom"), onChanged: (v) => name = v),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
               var res = await FilePicker.platform.pickFiles(type: FileType.image);
               if(res != null) pickedImage = res.files.first;
            },
            child: const Text("Choisir Logo"),
          )
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Annuler")),
          ElevatedButton(onPressed: () async {
            if(name.isNotEmpty) {
              String? url;
              if(pickedImage?.bytes != null) {
                final path = 'partners/${DateTime.now().millisecondsSinceEpoch}_${pickedImage!.name}';
                await _supabase.storage.from('logos').uploadBinary(path, pickedImage!.bytes!);
                url = _supabase.storage.from('logos').getPublicUrl(path);
              }
              await _supabase.from('partners').insert({'name': name, 'logo_url': url});
              if(mounted) Navigator.pop(ctx);
              setState((){});
            }
          }, child: const Text("Sauvegarder"))
        ],
      )
    );
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: _addPartner, child: const Icon(Icons.add)),
      body: FutureBuilder(
        future: _supabase.from('partners').select().order('id'),
        builder: (ctx, snap) {
          if(!snap.hasData) return const Center(child: CircularProgressIndicator());
          final list = snap.data as List;
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (ctx, i) => ListTile(
              leading: list[i]['logo_url'] != null ? Image.network(list[i]['logo_url'], width: 40) : const Icon(Icons.image),
              title: Text(list[i]['name']),
              trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () async {
                await _supabase.from('partners').delete().eq('id', list[i]['id']);
                setState((){});
              }),
            ),
          );
        },
      ),
    );
  }
}

// --- ONGLET 2 : STATISTIQUES ---
class _StatsManager extends StatefulWidget {
  const _StatsManager();
  @override
  State<_StatsManager> createState() => _StatsManagerState();
}

class _StatsManagerState extends State<_StatsManager> {
  final _supabase = Supabase.instance.client;

  // Fonction unique pour AJOUTER (stat == null) ou MODIFIER (stat != null)
  Future<void> _showStatDialog([Map<String, dynamic>? stat]) async {
    // Si 'stat' existe, on pré-remplit les contrôleurs
    final countController = TextEditingController(text: stat?['count'] ?? '');
    final labelController = TextEditingController(text: stat?['label'] ?? '');
    
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(stat == null ? "Ajouter Chiffre" : "Modifier Chiffre"),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(
            controller: countController, 
            decoration: const InputDecoration(labelText: "Chiffre (ex: 50+)"),
          ),
          TextField(
            controller: labelController, 
            decoration: const InputDecoration(labelText: "Libellé (ex: Églises)"),
          ),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Annuler")),
          ElevatedButton(
            onPressed: () async {
              final count = countController.text;
              final label = labelController.text;

              if (stat == null) {
                // --- CRÉATION ---
                await _supabase.from('statistics').insert({'count': count, 'label': label});
              } else {
                // --- MODIFICATION ---
                await _supabase.from('statistics').update({
                  'count': count, 
                  'label': label
                }).eq('id', stat['id']); // On cible l'ID précis
              }
              
              if (mounted) Navigator.pop(ctx);
              setState((){}); // Rafraîchir la liste
            }, 
            child: Text(stat == null ? "Ajouter" : "Mettre à jour")
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showStatDialog(), // Appel sans argument = Ajout
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: _supabase.from('statistics').select().order('id'),
        builder: (ctx, snap) {
          if(!snap.hasData) return const Center(child: CircularProgressIndicator());
          final list = snap.data as List;
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (ctx, i) {
              final item = list[i];
              return ListTile(
                title: Text("${item['count']} - ${item['label']}", style: const TextStyle(fontWeight: FontWeight.bold)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // BOUTON MODIFIER
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue), 
                      onPressed: () => _showStatDialog(item), // On passe l'item pour pré-remplir
                    ),
                    // BOUTON SUPPRIMER
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red), 
                      onPressed: () async {
                        await _supabase.from('statistics').delete().eq('id', item['id']);
                        setState((){});
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// --- ONGLET 3 : PROGRAMMES ---
class _ProgramsManager extends StatefulWidget {
  const _ProgramsManager();
  @override
  State<_ProgramsManager> createState() => _ProgramsManagerState();
}

class _ProgramsManagerState extends State<_ProgramsManager> {
  final _supabase = Supabase.instance.client;

  // Fonction unique pour AJOUTER ou MODIFIER
  Future<void> _showProgramDialog([Map<String, dynamic>? program]) async {
    // Pré-remplissage
    String title = program?['title'] ?? "";
    String desc = program?['description'] ?? "";
    // Conversion de la liste de détails en String avec sauts de ligne
    String detailsRaw = program != null 
        ? (program['details'] as List).join('\n') 
        : ""; 
    String iconName = program?['icon_name'] ?? "church";
    
    // Gestion Image
    PlatformFile? pickedImage;
    String? currentImageUrl = program?['image_url'];

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(program == null ? "Ajouter Programme" : "Modifier Programme"),
        content: StatefulBuilder( // StatefulBuilder pour mettre à jour l'UI du dialog (nom du fichier)
          builder: (context, setStateDialog) {
            return SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                TextFormField(initialValue: title, decoration: const InputDecoration(labelText: "Titre"), onChanged: (v) => title = v),
                TextFormField(initialValue: desc, decoration: const InputDecoration(labelText: "Description"), maxLines: 3, onChanged: (v) => desc = v),
                TextFormField(initialValue: detailsRaw, decoration: const InputDecoration(labelText: "Détails (1 par ligne)"), maxLines: 4, onChanged: (v) => detailsRaw = v),
                const SizedBox(height: 10),
                DropdownButton<String>(
                  value: iconName,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(value: "church", child: Text("Icône Église")),
                    DropdownMenuItem(value: "school", child: Text("Icône École/Formation")),
                    DropdownMenuItem(value: "agriculture", child: Text("Icône Agriculture/Social")),
                  ],
                  onChanged: (v) => setStateDialog(() => iconName = v!),
                ),
                const SizedBox(height: 10),
                
                // --- SÉLECTEUR D'IMAGE ---
                Row(
                  children: [
                    if (currentImageUrl != null && pickedImage == null)
                      const Text("Image actuelle conservée ", style: TextStyle(color: Colors.green, fontSize: 12)),
                    if (pickedImage != null)
                      const Text("Nouvelle image sélectionnée ", style: TextStyle(color: Colors.orange, fontSize: 12)),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                     var res = await FilePicker.platform.pickFiles(type: FileType.image);
                     if(res != null) {
                       setStateDialog(() => pickedImage = res.files.first);
                     }
                  },
                  child: Text(pickedImage == null ? "Changer/Choisir Image" : "Image OK"),
                )
              ]),
            );
          }
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Annuler")),
          ElevatedButton(onPressed: () async {
            // 1. Gestion de l'Upload Image
            String? finalUrl = currentImageUrl; // Par défaut, on garde l'ancienne
            
            if(pickedImage?.bytes != null) {
              // Si une nouvelle image est choisie, on upload et on remplace l'URL
              final path = 'programs/${DateTime.now().millisecondsSinceEpoch}_${pickedImage!.name}';
              await _supabase.storage.from('logos').uploadBinary(path, pickedImage!.bytes!);
              finalUrl = _supabase.storage.from('logos').getPublicUrl(path);
            }

            // 2. Conversion texte -> liste
            List<String> detailsList = detailsRaw.split('\n').where((s) => s.trim().isNotEmpty).toList();

            // 3. Envoi à Supabase
            final data = {
              'title': title, 
              'description': desc, 
              'details': detailsList,
              'icon_name': iconName,
              'image_url': finalUrl
            };

            if (program == null) {
              // Création
              await _supabase.from('programs').insert(data);
            } else {
              // Mise à jour
              await _supabase.from('programs').update(data).eq('id', program['id']);
            }

            if(mounted) Navigator.pop(ctx);
            setState((){});
          }, child: Text(program == null ? "Enregistrer" : "Mettre à jour"))
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showProgramDialog(), // Ajout
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: _supabase.from('programs').select().order('id'),
        builder: (ctx, snap) {
          if(!snap.hasData) return const Center(child: CircularProgressIndicator());
          final list = snap.data as List;
          return ListView.separated(
            padding: const EdgeInsets.all(10),
            separatorBuilder: (_,__) => const Divider(),
            itemCount: list.length,
            itemBuilder: (ctx, i) {
              final item = list[i];
              return ListTile(
                leading: item['image_url'] != null 
                    ? Image.network(item['image_url'], width: 50, height: 50, fit: BoxFit.cover) 
                    : const Icon(Icons.article),
                title: Text(item['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(item['description'], maxLines: 1, overflow: TextOverflow.ellipsis),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // BOUTON MODIFIER
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue), 
                      onPressed: () => _showProgramDialog(item),
                    ),
                    // BOUTON SUPPRIMER
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red), 
                      onPressed: () async {
                        await _supabase.from('programs').delete().eq('id', item['id']);
                        setState((){});
                      }
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}