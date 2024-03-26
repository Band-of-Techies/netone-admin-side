import 'package:intl/intl.dart';

class LoanRequestDetails {
  final dynamic id;
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
  final List<Applicant> applicants;
  final dynamic applicantCount;
  final AgentDetails agent;
  final List<Document> documents;
  final List<Document> swap_agreement;
  final List<Document> psmpc_purchase_order;
  final List<Document> delivery_report;
  final List<Document> warranty_form;
  final List<Document> anti_fraud_form;
  final List<Document> authorize_letter;
  final List<Document> invoice;
  //final List<Document> orderdocuments;
  final List<RequestedProduct> requestedProducts;
  final Category category;
  final dynamic original_total_cost;

  final String invoicedate;
  final String totalcost;
  final String vat;

  final String bankname;
  final String accnumber;
  final String branchname;
  final String sortcode;
  final String banknameandaddress;

  LoanRequestDetails({
    required this.invoicedate,
    required this.original_total_cost,
    required this.requestedProducts,
    // required this.orderdocuments,
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
    required this.applicants,
    required this.applicantCount,
    required this.agent,
    required this.category,
    required this.anti_fraud_form,
    required this.authorize_letter,
    required this.delivery_report,
    required this.invoice,
    required this.psmpc_purchase_order,
    required this.swap_agreement,
    required this.warranty_form,
    required this.accnumber,
    required this.bankname,
    required this.branchname,
    required this.sortcode,
    required this.banknameandaddress,
    required this.totalcost,
    required this.vat,
  });

  factory LoanRequestDetails.fromJson(Map<String, dynamic> json) {
    List<Document> documents = (json['documents'] as List<dynamic>)
        .map((doc) => Document.fromJson(doc as Map<String, dynamic>))
        .toList();
    List<Document> anti_fraud_form = (json['anti_fraud_form'] as List<dynamic>)
        .map((doc) => Document.fromJson(doc as Map<String, dynamic>))
        .toList();
    List<Document> authorize_letter =
        (json['authorize_letter'] as List<dynamic>)
            .map((doc) => Document.fromJson(doc as Map<String, dynamic>))
            .toList();
    List<Document> delivery_report = (json['delivery_report'] as List<dynamic>)
        .map((doc) => Document.fromJson(doc as Map<String, dynamic>))
        .toList();
    List<Document> invoice = (json['invoice'] as List<dynamic>)
        .map((doc) => Document.fromJson(doc as Map<String, dynamic>))
        .toList();
    List<Document> psmpc_purchase_order =
        (json['psmpc_purchase_order'] as List<dynamic>)
            .map((doc) => Document.fromJson(doc as Map<String, dynamic>))
            .toList();
    List<Document> swap_agreement = (json['swap_agreement'] as List<dynamic>)
        .map((doc) => Document.fromJson(doc as Map<String, dynamic>))
        .toList();
    List<Document> warranty_form = (json['warranty_form'] as List<dynamic>)
        .map((doc) => Document.fromJson(doc as Map<String, dynamic>))
        .toList();

    List<RequestedProduct> requestedProducts =
        (json['requested_products'] as List<dynamic>)
            .map((product) =>
                RequestedProduct.fromJson(product as Map<String, dynamic>))
            .toList();
    return LoanRequestDetails(
      // orderdocuments: orderdocuments,
      original_total_cost: json["original_total_cost"] ?? "NA",
      documents: documents,
      id: json['id'] ?? "NA",
      psmpc_purchase_order: psmpc_purchase_order,
      delivery_report: delivery_report,
      warranty_form: warranty_form,
      anti_fraud_form: anti_fraud_form,
      authorize_letter: authorize_letter,
      invoice: invoice,
      invoicedate:
          DateFormat('dd/MM/yyyy').format(DateTime.parse(json['created_at'])),
      swap_agreement: swap_agreement,
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
      requestedProducts: requestedProducts,
      applicants: (json['applicants'] as List<dynamic>)
          .map(
            (applicant) =>
                Applicant.fromJson(applicant as Map<String, dynamic>),
          )
          .toList(),
      applicantCount: json['applicant_count'] ?? "NA",
      category: Category.fromJson(json['category'] ?? {}),
      bankname: (json['bank_name'] ?? "NA"),
      branchname: (json['bank_branch_name'] ?? "NA"),
      accnumber: (json['bank_account_number'] ?? "NA"),
      totalcost: (json['total_cost'] ?? "NA"),
      vat: (json['vat'] ?? "NA"),
      sortcode: (json['bank_sort_code'] ?? "NA"),
      banknameandaddress: (json['bank_name_and_full_address'] ?? "NA"),
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

class Applicant {
  final String exisitngstatus;
  final dynamic id;
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
  final List<Document> payslip1;
  final List<Document> payslip2;
  final List<Document> payslip3;
  final List<Document> intoletter;
  final List<Document> bankstatemtn;
  final List<Document> nrccopy;
  final Signature signature;

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
    required this.bankstatemtn,
    required this.nrccopy,
    required this.payslip1,
    required this.payslip2,
    required this.payslip3,
    required this.intoletter,
    required this.signature,
  });

  factory Applicant.fromJson(Map<String, dynamic> json) {
    List<Document> documents = (json['documents'] as List<dynamic>)
        .map((doc) => Document.fromJson(doc as Map<String, dynamic>))
        .toList();
    List<Document> bankstatemtn = (json['bank_statement'] as List<dynamic>)
        .map((doc) => Document.fromJson(doc as Map<String, dynamic>))
        .toList();

    List<Document> nrccopy = (json['nrc_copy'] as List<dynamic>)
        .map((doc) => Document.fromJson(doc as Map<String, dynamic>))
        .toList();

    List<Document> payslip1 = (json['payslip_1'] as List<dynamic>)
        .map((doc) => Document.fromJson(doc as Map<String, dynamic>))
        .toList();

    List<Document> payslip2 = (json['payslip_2'] as List<dynamic>)
        .map((doc) => Document.fromJson(doc as Map<String, dynamic>))
        .toList();

    List<Document> payslip3 = (json['payslip_3'] as List<dynamic>)
        .map((doc) => Document.fromJson(doc as Map<String, dynamic>))
        .toList();
    List<Document> intoletter = (json['intro_letter'] as List<dynamic>)
        .map((doc) => Document.fromJson(doc as Map<String, dynamic>))
        .toList();
    return Applicant(
        bankstatemtn: bankstatemtn,
        intoletter: intoletter,
        nrccopy: nrccopy,
        payslip1: payslip1,
        payslip2: payslip2,
        payslip3: payslip3,
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
        ),
        signature: Signature.fromJson(
          json['signature'] ?? {}, // Handle empty signature object
        ));
  }
}

class Signature {
  final dynamic id;
  final String contentType;
  final String url;

  Signature({
    required this.id,
    required this.contentType,
    required this.url,
  });

  factory Signature.fromJson(Map<String, dynamic> json) {
    return Signature(
      id: json['id'] ?? "NA",
      contentType: json['content_type'] ?? "NA",
      url: json['url'] ?? "NA",
    );
  }
}

class Occupation {
  final dynamic id;
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
  final dynamic id;
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
  final dynamic id;
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

class RequestedProduct {
  final dynamic id;
  final int quantity;
  final int productId;
  final String productName;
  final String productDescription;
  final String unitprice;
  final String totalcost;

  RequestedProduct({
    required this.id,
    required this.quantity,
    required this.productId,
    required this.productName,
    required this.totalcost,
    required this.unitprice,
    required this.productDescription,
  });

  factory RequestedProduct.fromJson(Map<String, dynamic> json) {
    return RequestedProduct(
      id: json['id'] ?? "NA",
      quantity: json['quantity'] ?? 0,
      productId: json['product_id'] ?? "NA",
      productName: json['product_name'] ?? "NA",
      productDescription: json['product_description'] ?? "NA",
      totalcost: json['total_cost'] ?? "NA",
      unitprice: json['unit_price'] ?? "NA",
    );
  }
}

class Category {
  final dynamic id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? "NA",
      name: json['name'] ?? "NA",
    );
  }
}
