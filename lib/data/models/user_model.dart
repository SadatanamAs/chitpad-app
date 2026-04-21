class UserModel {
  final String id;
  String displayName;
  String username;
  String email;
  String bio;
  String? avatarUrl;
  String? coverUrl;
  int avatarColorIndex; // index into predefined avatar colors
  int coverGradientIndex; // index into predefined cover gradients

  UserModel({
    required this.id,
    required this.displayName,
    required this.username,
    required this.email,
    this.bio = '',
    this.avatarUrl,
    this.coverUrl,
    this.avatarColorIndex = 0,
    this.coverGradientIndex = 0,
  });

  String get initials {
    final parts = displayName.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return displayName.isNotEmpty ? displayName[0].toUpperCase() : '?';
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'display_name': displayName,
    'username': username,
    'email': email,
    'bio': bio,
    'avatar_url': avatarUrl,
    'cover_url': coverUrl,
    'avatar_color_index': avatarColorIndex,
    'cover_gradient_index': coverGradientIndex,
  };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] ?? '',
    displayName: json['display_name'] ?? '',
    username: json['username'] ?? '',
    email: json['email'] ?? '',
    bio: json['bio'] ?? '',
    avatarUrl: json['avatar_url'],
    coverUrl: json['cover_url'],
    avatarColorIndex: json['avatar_color_index'] ?? 0,
    coverGradientIndex: json['cover_gradient_index'] ?? 0,
  );
}
