class Card {
  final String title;
  final String? description;
  final int id;
  // final Array<Card> cards;
  // final String? color;
  // final Bool? archived;
  // // final Array<String>? labels;
  // final String? acl;
  // final Int? shared;
  // final DateTime? deletedAt;
  // final DateTime? lastModified;

  Card({required this.title, this.description, required this.id});

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      title: json['title'] as String,
      id: json['id'] as int,
      description: json['description'] as String?,
      // archived: json['archived'] as Bool?,
      // labels: json['labels'] as Label?,
      // acl: json['acl'] as String[]?,

      // permissions?: BoardPermissions;
      // users?: Array<User>;
      // shared: json['shared'] as Int?,
      // deletedAt:  json['deletedAt'] as DateTime?,
      // lastModified: json['lastModified'] as DateTime?,
      // settings:json['settings'] as BoardSettings;
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'id': id,
        'description': description,
      };
}
