class LoanRequest {
  final int id;
  final String createdAt;
  final String loanAmount;
  final String requestBankStatus;
  final String requestSystemStatus;
  final String requestOrderStatus;
  final AgentDetails salesAgent;
  final AgentDetails deliveryAgent; // Added delivery agent
  final int applicantCount;
  final String surname;
  final String firstName;
  final String middleName;
  final String gender;
  final String nrc;
  final String history;

  LoanRequest({
    required this.id,
    required this.createdAt,
    required this.loanAmount,
    required this.requestBankStatus,
    required this.requestSystemStatus,
    required this.requestOrderStatus,
    required this.salesAgent,
    required this.deliveryAgent, // Added delivery agent
    required this.applicantCount,
    required this.surname,
    required this.firstName,
    required this.middleName,
    required this.gender,
    required this.nrc,
    required this.history,
  });

  factory LoanRequest.fromJson(Map<String, dynamic> json) {
    return LoanRequest(
      id: json['id'] ?? 0,
      createdAt: json['created_at'] ?? "NA",
      loanAmount: json['loan_amount'] ?? "NA",
      requestBankStatus: json['request_bank_status'] ?? "NA",
      requestSystemStatus: json['request_system_status'] ?? "NA",
      requestOrderStatus: json['request_order_status'] ?? "NA",
      salesAgent: AgentDetails.fromJson(json['assign_to']['sales'] ?? {}),
      deliveryAgent: AgentDetails.fromJson(json['assign_to']['delivery'] ?? {}),
      applicantCount: json['applicant_count'] ?? 0,
      surname: json['surname'] ?? "NA",
      firstName: json['first_name'] ?? "NA",
      middleName: json['middle_name'] ?? "NA",
      gender: json['gender'] ?? "NA",
      nrc: json['nrc'] ?? "NA",
      history: json['loan_history'] ?? "NA",
    );
  }
}

class AgentDetails {
  final dynamic id; // Changed type to int?
  final String? name;
  final String? assignedAt; // Added assignedAt

  AgentDetails({
    this.id,
    this.name,
    this.assignedAt,
  });

  factory AgentDetails.fromJson(Map<String, dynamic> json) {
    return AgentDetails(
      id: json['id'] ?? 'NA',
      name: json['name'] ?? 'NA',
      assignedAt: json['assigned_at'] ?? 'NA',
    );
  }
}
