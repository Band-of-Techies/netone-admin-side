class AgentInfo {
  final int id;
  final String createdAt;
  final String updatedAt;
  final String email;
  final String name;
  final String role;
  final String kind;
  final String url;
  final Map<String, dynamic> assignedRequests;

  AgentInfo({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.email,
    required this.name,
    required this.role,
    required this.kind,
    required this.url,
    required this.assignedRequests,
  });

  factory AgentInfo.fromJson(Map<String, dynamic> json) {
    return AgentInfo(
      id: json['id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      email: json['email'],
      name: json['name'],
      role: json['role'],
      kind: json['kind'],
      url: json['url'],
      assignedRequests: json['assigned_requests'],
    );
  }
}
