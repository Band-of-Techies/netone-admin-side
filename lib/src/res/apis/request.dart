class LoanRequest {
  final int applicantCount;
  final int id;
  final String createdAt;

  final String loanAmount;
  final String requestBankStatus;
  final String requestSystemStatus;

  final String requestOrderStatus;

  final Product product;
  final String surname;
  final String firstName;
  final String middleName;
  final String gender;
  final AgentDetails agent;
  final String nrc;

  LoanRequest({
    required this.applicantCount,
    required this.id,
    required this.createdAt,
    required this.loanAmount,
    required this.requestBankStatus,
    required this.requestSystemStatus,
    required this.requestOrderStatus,
    required this.product,
    required this.surname,
    required this.firstName,
    required this.middleName,
    required this.gender,
    required this.nrc,
    required this.agent,
  });

  factory LoanRequest.fromJson(Map<String, dynamic> json) {
    return LoanRequest(
      agent: AgentDetails.fromJson(json['assign_to'] ?? "NA"),
      applicantCount: json['applicant_count'] ?? 0,
      id: json['id'] ?? 0,
      createdAt: json['created_at'] ?? "NA",
      loanAmount: json['loan_amount'] ?? "NA",
      requestBankStatus: json['request_bank_status'] ?? "NA",
      requestSystemStatus: json['request_system_status'] ?? "NA",
      requestOrderStatus: json['request_order_status'] ?? "NA",
      product: Product.fromJson(json['product'] ?? {}),
      surname: json['surname'] ?? "NA",
      firstName: json['first_name'] ?? "NA",
      middleName: json['middle_name'] ?? "NA",
      gender: json['gender'] ?? "NA",
      nrc: json['nrc'] ?? "NA",
    );
  }
}

class AgentDetails {
  final dynamic id;
  final String name;

  AgentDetails({
    required this.id,
    required this.name,
  });
  factory AgentDetails.fromJson(Map<String, dynamic> json) {
    return AgentDetails(
      id: json['id'] ?? "NA",
      name: json['name'] ?? "NA",
    );
  }
}

class Product {
  final int id;
  final String createdAt;
  final String updatedAt;
  final String name;
  final String description;

  Product({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      createdAt: json['created_at'] ?? "NA",
      updatedAt: json['updated_at'] ?? "NA",
      name: json['name'] ?? "NA",
      description: json['description'] ?? "NA",
    );
  }
}
