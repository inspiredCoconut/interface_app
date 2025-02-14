class User {
  final int id;
  final String name;
  final String role;
  final int age;
  final String email;
  
  User({required this.id, required this.name, this.role = 'user', this.age = 18, this.email = ''});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], name: json['name'], role: json['role'], age: json['age'], email: json['email']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'age': age,
      'email': email,
    };
  }
}
