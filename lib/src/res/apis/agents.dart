class Agent {
  final int id;
  final String createdAt;
  final String updatedAt;
  final String email;
  final String name;
  final String role;
  final String kind;
  final String url;
  final int totalRequests;

  Agent({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.email,
    required this.name,
    required this.role,
    required this.kind,
    required this.url,
    required this.totalRequests,
  });

  factory Agent.fromJson(Map<String, dynamic> json) {
    return Agent(
      id: json['id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      email: json['email'],
      name: json['name'],
      role: json['role'],
      kind: json['kind'],
      url: json['url'],
      totalRequests: json['assigned_requests']['total'],
    );
  }
}
