class Author {
  final String name;

  Author({this.name});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      name: json['name'],
    );
  }
}
