class Project {
  const Project({
    required this.title,
    required this.description,
    required this.stack,
    required this.githubUrl,
    required this.demoUrl,
    this.imageUrl,
    this.contributions = const [],
    this.impact = const [],
  });

  final String title;
  final String description;
  final List<String> stack;
  final String githubUrl;
  final String demoUrl;
  final String? imageUrl;
  final List<String> contributions;
  final List<String> impact;
}

