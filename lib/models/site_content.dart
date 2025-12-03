class Statistic {
  final int id;
  final String count;
  final String label;

  Statistic({required this.id, required this.count, required this.label});

  factory Statistic.fromJson(Map<String, dynamic> json) {
    return Statistic(
      id: json['id'],
      count: json['count'],
      label: json['label'],
    );
  }
}

class Program {
  final int id;
  final String title;
  final String description;
  final List<String> details;
  final String? imageUrl;
  final String iconName;

  Program({
    required this.id,
    required this.title,
    required this.description,
    required this.details,
    this.imageUrl,
    this.iconName = 'church',
  });

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      details: List<String>.from(json['details'] ?? []),
      imageUrl: json['image_url'],
      iconName: json['icon_name'] ?? 'church',
    );
  }
}