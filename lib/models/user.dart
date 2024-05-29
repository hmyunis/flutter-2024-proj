class User {
  final int? id;
  final String username;
  final String email;
  final String joinDate;
  final String role;
  final String? token;

  User({
    this.id,
    required this.username,
    required this.email,
    required this.joinDate,
    required this.role,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      joinDate: json['joinDate'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'joinDate': joinDate,
      'role': role,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final User otherUser = other as User;
    return id == otherUser.id &&
        username == otherUser.username &&
        email == otherUser.email &&
        joinDate == otherUser.joinDate &&
        role == otherUser.role;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      username.hashCode ^
      email.hashCode ^
      joinDate.hashCode ^
      role.hashCode;

  @override
  String toString() {
    return 'User(id: $id, username: $username, email: $email, joinDate: $joinDate, role: $role, token: $token)';
  }
}