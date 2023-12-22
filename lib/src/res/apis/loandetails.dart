class LoanRequestDetails {
  final int id;
  final String requestnumber;
  final String createdAt;
  final String updatedAt;
  final String description;
  final String costOfAsset;
  final String insuranceCost;
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
  final List<Applicant> applicants;
  final int applicantCount;
  final AgentDetails agent;
  final List<Document> documents;

  LoanRequestDetails({
    required this.requestnumber,
    required this.documents,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.description,
    required this.costOfAsset,
    required this.insuranceCost,
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
    required this.applicants,
    required this.applicantCount,
    required this.agent,
  });

  factory LoanRequestDetails.fromJson(Map<String, dynamic> json) {
    List<Document> documents = (json['documents'] as List<dynamic>)
        .map((doc) => Document.fromJson(doc as Map<String, dynamic>))
        .toList();
    return LoanRequestDetails(
      documents: documents,
      id: json['id'] ?? "NA",
      requestnumber: json['request_number'] ?? "NA",
      createdAt: json['created_at'] ?? "NA",
      updatedAt: json['updated_at'] ?? "NA",
      description: json['description'] ?? "NA",
      costOfAsset: json['cost_of_asset'] ?? "NA",
      insuranceCost: json['insurance_cost'] ?? "NA",
      advancePayment: json['advance_payment'] ?? "NA",
      loanAmount: json['loan_amount'] ?? "NA",
      loanTenure: json['loan_tenure'] ?? "NA",
      requestBankStatus: json['request_bank_status'] ?? "NA",
      requestSystemStatus: json['request_system_status'] ?? "NA",
      systemRejectionReason: json['system_rejection_reason'] ?? "NA",
      bankRejectionReason: json['bank_rejection_reason'] ?? "NA",
      requestOrderStatus: json['request_order_status'] ?? "NA",
      assignedAt: (json['assigned_at'] ?? "NA"),
      requestBankUpdateDate: (json['request_bank_update_date'] ?? "NA"),
      requestSystemUpdateDate: (json['request_system_update_date'] ?? "NA"),
      requestOrderUpdateDate: (json['request_order_update_date'] ?? "NA"),
      agent: AgentDetails.fromJson(json['assign_to'] ?? "NA"),
      product: Product.fromJson(json['product'] ?? "NA"),
      applicants: (json['applicants'] as List<dynamic>)
          .map(
            (applicant) =>
                Applicant.fromJson(applicant as Map<String, dynamic>),
          )
          .toList(),
      applicantCount: json['applicant_count'] ?? "NA",
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
      id: json['id'] ?? "NA",
      createdAt: json['created_at'] ?? "NA",
      updatedAt: json['updated_at'] ?? "NA",
      name: json['name'] ?? "NA",
      description: json['description'] ?? "NA",
    );
  }
}

class Applicant {
  final String exisitngstatus;
  final int id;
  final String createdAt;
  final String updatedAt;
  final String surname;
  final String firstName;
  final String middleName;
  final String email;
  final String dob;
  final String nrc;
  final String telephone;
  final String mobile;
  final String licenseNumber;
  final String licenseExpiry;
  final String residentialAddress;
  final String postalAddress;
  final String province;
  final String town;
  final String gender;
  final String ownership;
  final String howlongthisplace;
  final String loansharename;
  final String loansharepercent;
  final Occupation occupation;
  final List<Document> documents;
  final Kin kin;

  Applicant({
    required this.kin,
    required this.ownership,
    required this.howlongthisplace,
    required this.documents,
    required this.loansharename,
    required this.loansharepercent,
    required this.gender,
    required this.exisitngstatus,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.surname,
    required this.firstName,
    required this.middleName,
    required this.email,
    required this.dob,
    required this.nrc,
    required this.telephone,
    required this.mobile,
    required this.licenseNumber,
    required this.licenseExpiry,
    required this.residentialAddress,
    required this.postalAddress,
    required this.province,
    required this.town,
    required this.occupation,
  });

  factory Applicant.fromJson(Map<String, dynamic> json) {
    List<Document> documents = (json['documents'] as List<dynamic>)
        .map((doc) => Document.fromJson(doc as Map<String, dynamic>))
        .toList();
    return Applicant(
        id: json['id'] ?? "NA",
        ownership: json['ownership'] ?? "NA",
        howlongthisplace: json['ownership_how_long'] ?? "NA",
        loansharename: json['loan_share_name'] ?? "NA",
        loansharepercent: json['loan_share_percent'] ?? "NA",
        gender: json['gender'] ?? "NA",
        exisitngstatus: json['existing_loan_request_status'] ?? "NA",
        createdAt: json['created_at'] ?? "NA",
        updatedAt: json['updated_at'] ?? "NA",
        surname: json['surname'] ?? "NA",
        firstName: json['first_name'] ?? "NA",
        middleName: json['middle_name'] ?? "NA",
        email: json['email'] ?? "NA",
        dob: json['dob'] ?? "NA",
        nrc: json['nrc'] ?? "NA",
        telephone: json['telephone'] ?? "NA",
        mobile: json['mobile'] ?? "NA",
        licenseNumber: json['license_number'] ?? "NA",
        licenseExpiry: json['license_expiry'] ?? "NA",
        residentialAddress: json['residential_address'] ?? "NA",
        postalAddress: json['postal_address'] ?? "NA",
        province: json['province'] ?? "NA",
        town: json['town'] ?? "NA",
        documents: documents,
        occupation: Occupation.fromJson(
          json['occupation'] ?? "NA",
        ),
        kin: Kin.fromJson(
          json['kin'] ?? "NA",
        ));
  }
}

class Occupation {
  final int id;
  final String createdAt;
  final String updatedAt;
  final String jobTitle;
  final String ministry;
  final String physicalAddress;
  final String postalAddress;
  final String town;
  final String province;
  final String grossSalary;
  final String netSalary;
  final String salaryScale;
  final String retirementYear;
  final String employerNumber;
  final String yearsOfService;
  final String employmentType;
  final String expiryDate;
  final String currentNetSalary;
  final String tempExpiryDate;
  final String preferredRetirementYear;

  Occupation({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.jobTitle,
    required this.ministry,
    required this.physicalAddress,
    required this.postalAddress,
    required this.town,
    required this.province,
    required this.grossSalary,
    required this.netSalary,
    required this.salaryScale,
    required this.retirementYear,
    required this.employerNumber,
    required this.yearsOfService,
    required this.employmentType,
    required this.expiryDate,
    required this.currentNetSalary,
    required this.tempExpiryDate,
    required this.preferredRetirementYear,
  });

  factory Occupation.fromJson(Map<String, dynamic> json) {
    return Occupation(
      id: json['id'] ?? "NA",
      createdAt: json['created_at'] ?? "NA",
      updatedAt: json['updated_at'] ?? "NA",
      jobTitle: json['job_title'] ?? "NA",
      ministry: json['ministry'] ?? "NA",
      physicalAddress: json['physical_address'] ?? "NA",
      postalAddress: json['postal_address'] ?? "NA",
      town: json['town'] ?? "NA",
      province: json['province'] ?? "NA",
      grossSalary: json['gross_salary'] ?? "NA",
      netSalary: json['net_salary'] ?? "NA",
      salaryScale: json['salary_scale'] ?? "NA",
      retirementYear: json['retirement_year'] ?? "NA",
      employerNumber: json['employer_number'] ?? "NA",
      yearsOfService: json['years_of_service'] ?? "NA",
      employmentType: json['employment_type'] ?? "NA",
      expiryDate: json['expiry_date'] ?? "NA",
      currentNetSalary: json['current_net_salary'] ?? "NA",
      tempExpiryDate: json['temp_expiry_date'] ?? "NA",
      preferredRetirementYear: json['preferred_retirement_year'] ?? "NA",
    );
  }
}

class Kin {
  final int id;
  final String name;
  final String otherNames;
  final String physicalAddress;
  final String postalAddress;
  final String phoneNumber;
  final String email;

  Kin({
    required this.id,
    required this.name,
    required this.otherNames,
    required this.physicalAddress,
    required this.postalAddress,
    required this.phoneNumber,
    required this.email,
  });

  factory Kin.fromJson(Map<String, dynamic> json) {
    return Kin(
      id: json['id'] ?? "NA",
      name: json['name'] ?? "NA",
      otherNames: json['other_names'] ?? "NA",
      physicalAddress: json['physical_address'] ?? "NA",
      postalAddress: json['postal_address'] ?? "NA",
      phoneNumber: json['phone_number'] ?? "NA",
      email: json['email'] ?? "NA",
    );
  }
}

class Document {
  final int id;
  final String contentType;
  final String url;

  Document({
    required this.id,
    required this.contentType,
    required this.url,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json['id'] ?? "NA",
      contentType: json['content_type'] ?? "NA",
      url: json['url'] ?? "NA",
    );
  }
}
