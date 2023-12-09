class LoanRequest {
  final int id;
  final String createdAt;
  final String updatedAt;
  final String advancePayment;
  final String loanAmount; // Change this to String
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
  final String surname;
  final String firstName;
  final String middleName;
  final String telephone;
  final String mobile;
  final String gender;
  final String nrc;

  LoanRequest({
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
    required this.surname,
    required this.firstName,
    required this.middleName,
    required this.telephone,
    required this.mobile,
    required this.gender,
    required this.nrc,
  });

  // Add a factory method to convert JSON to LoanRequest
  factory LoanRequest.fromJson(Map<String, dynamic> json) {
    return LoanRequest(
      id: json['id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      advancePayment: json['advance_payment'],
      loanAmount: json['loan_amount'],
      loanTenure: json['loan_tenure'],
      requestBankStatus: json['request_bank_status'],
      requestSystemStatus: json['request_system_status'],
      systemRejectionReason: json['system_rejection_reason'],
      bankRejectionReason: json['bank_rejection_reason'],
      requestOrderStatus: json['request_order_status'],
      assignedAt: json['assigned_at'] ?? '',
      requestBankUpdateDate: json['request_bank_update_date'] ?? '',
      requestSystemUpdateDate: json['request_system_update_date'] ?? '',
      requestOrderUpdateDate: json['request_order_update_date'] ?? '',
      surname: json['surname'],
      firstName: json['first_name'],
      middleName: json['middle_name'],
      telephone: json['telephone'],
      mobile: json['mobile'],
      gender: json['gender'],
      nrc: json['nrc'],
    );
  }
}
