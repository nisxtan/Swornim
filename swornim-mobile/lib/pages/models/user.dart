class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? profileImage;
  final UserType userType;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.profileImage,
    required this.userType,
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      profileImage: json['profile_image'],
      userType: UserType.values.byName(json['user_type']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      isActive: json['is_active'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'profile_image': profileImage,
      'user_type': userType.name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_active': isActive,
    };
  }
}

enum UserType { client, photographer, makeupArtist, decorator, venue }