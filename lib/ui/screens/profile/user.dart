class User {
  final String imagePath;
  final bool isDarkMode;

  const User({
     this.imagePath,
     this.isDarkMode,
  });

  User copy({
     imagePath,
     isDarkMode,
  }) =>
      User(
        imagePath: imagePath ?? this.imagePath,
        isDarkMode: isDarkMode ?? this.isDarkMode,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        imagePath: json['imagePath'],
        isDarkMode: json['isDarkMode'],
      );

  Map<String, dynamic> toJson() => {
        'imagePath': imagePath,
        'isDarkMode': isDarkMode,
      };
}
