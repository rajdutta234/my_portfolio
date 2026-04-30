class Experience {
  const Experience({
    required this.organization,
    required this.role,
    required this.duration,
    required this.description,
  });

  final String organization;
  final String role;
  final String duration;
  final List<String> description;
}
