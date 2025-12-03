class Partner {
  final int id;
  final String name;
  final String? logoUrl;

  Partner({required this.id, required this.name, this.logoUrl});

  // Convertir depuis Supabase (JSON) vers Dart
  factory Partner.fromJson(Map<String, dynamic> json) {
    return Partner(
      id: json['id'],
      name: json['name'],
      logoUrl: json['logo_url'],
    );
  }
}