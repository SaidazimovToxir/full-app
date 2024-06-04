class Course {
  final String title;
  final String? videoUrl;
  final String description;

  Course({
    required this.title,
    required this.description,
    this.videoUrl,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      title: json['title'],
      description: json['description'],
      videoUrl: json['videoUrl'],
    );
  }
}
