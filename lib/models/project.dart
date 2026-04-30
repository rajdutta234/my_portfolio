class Project {
  const Project({
    required this.title,
    required this.description,
    required this.stack,
    required this.githubUrl,
    required this.demoUrl,
  });

  final String title;
  final String description;
  final List<String> stack;
  final String githubUrl;
  final String demoUrl;
}
