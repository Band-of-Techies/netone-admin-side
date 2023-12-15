class LoanRequest {
  final int applicantCount;
  final int id;
  final String createdAt;
  final String updatedAt;
  final String advancePayment;
  final String loanAmount;
  final String loanTenure;
  final String requestBankStatus;
  final String requestSystemStatus;
  final String systemRejectionReason;
  final String bankRejectionReason;
  final String requestOrderStatus;
  final String assignedAt;
  final String requestBankUpdateDate;
  final String requestSystemUpdateDate;
  final String requestOrderUpdateDate;
  final Product product;
  final String surname;
  final String firstName;
  final String middleName;
  final String telephone;
  final String mobile;
  final String gender;
  final AgentDetails agent;
  final String nrc;

  LoanRequest({
    required this.applicantCount,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.advancePayment,
    required this.loanAmount,
    required this.loanTenure,
    required this.requestBankStatus,
    required this.requestSystemStatus,
    required this.systemRejectionReason,
    required this.bankRejectionReason,
    required this.requestOrderStatus,
    required this.assignedAt,
    required this.requestBankUpdateDate,
    required this.requestSystemUpdateDate,
    required this.requestOrderUpdateDate,
    required this.product,
    required this.surname,
    required this.firstName,
    required this.middleName,
    required this.telephone,
    required this.mobile,
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
      updatedAt: json['updated_at'] ?? "NA",
      advancePayment: json['advance_payment'] ?? "NA",
      loanAmount: json['loan_amount'] ?? "NA",
      loanTenure: json['loan_tenure'] ?? "NA",
      requestBankStatus: json['request_bank_status'] ?? "NA",
      requestSystemStatus: json['request_system_status'] ?? "NA",
      systemRejectionReason: json['system_rejection_reason'] ?? "NA",
      bankRejectionReason: json['bank_rejection_reason'] ?? "NA",
      requestOrderStatus: json['request_order_status'] ?? "NA",
      assignedAt: json['assigned_at'] ?? '',
      requestBankUpdateDate: json['request_bank_update_date'] ?? '',
      requestSystemUpdateDate: json['request_system_update_date'] ?? '',
      requestOrderUpdateDate: json['request_order_update_date'] ?? '',
      product: Product.fromJson(json['product'] ?? {}),
      surname: json['surname'] ?? "NA",
      firstName: json['first_name'] ?? "NA",
      middleName: json['middle_name'] ?? "NA",
      telephone: json['telephone'] ?? "NA",
      mobile: json['mobile'] ?? "NA",
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
