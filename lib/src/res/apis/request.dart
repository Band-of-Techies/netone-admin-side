class LoanRequest {
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
  final Map<String, dynamic> applicants;

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
    required this.applicants,
  });

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
      applicants: Map<String, dynamic>.from(json['applicants']),
    );
  }
}
