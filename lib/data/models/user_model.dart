class User {
  final int id;
  final String name;
  final String role;
  final int age;
  
  User({required this.id, required this.name, this.role = 'user', this.age = 18});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], name: json['name'], role: json['role'], age: json['age']);
  }
}
