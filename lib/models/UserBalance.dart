class UserBalanceModel {
  List<UserPayments> userPayments;
  UserBalance userBalance;

  UserBalanceModel({this.userPayments, this.userBalance});

  UserBalanceModel.fromJson(Map<String, dynamic> json) {
    if (json['user_payments'] != null) {
      userPayments = new List<UserPayments>();
      json['user_payments'].forEach((v) {
        userPayments.add(new UserPayments.fromJson(v));
      });
    }
    userBalance = json['user_balance'] != null
        ? new UserBalance.fromJson(json['user_balance'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userPayments != null) {
      data['user_payments'] = this.userPayments.map((v) => v.toJson()).toList();
    }
    if (this.userBalance != null) {
      data['user_balance'] = this.userBalance.toJson();
    }
    return data;
  }
}

class UserPayments {
  int id;
  String userId;
  String details;
  String amount;
  String activeBalance;
  String inactiveBalance;
  String totalBalance;
  String creditDebt;
  String createdAt;
  String updatedAt;
  String createdDate;

  UserPayments(
      {this.id,
        this.userId,
        this.details,
        this.amount,
        this.activeBalance,
        this.inactiveBalance,
        this.totalBalance,
        this.creditDebt,
        this.createdAt,
        this.updatedAt,
        this.createdDate});

  UserPayments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    details = json['details'];
    amount = json['amount'];
    activeBalance = json['active_balance'];
    inactiveBalance = json['inactive_balance'];
    totalBalance = json['total_balance'];
    creditDebt = json['Credit_debt'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['details'] = this.details;
    data['amount'] = this.amount;
    data['active_balance'] = this.activeBalance;
    data['inactive_balance'] = this.inactiveBalance;
    data['total_balance'] = this.totalBalance;
    data['Credit_debt'] = this.creditDebt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_date'] = this.createdDate;
    return data;
  }
}

class UserBalance {
  String activeBalance;
  String inactiveBalance;
  String totalBalance;

  UserBalance({this.activeBalance, this.inactiveBalance, this.totalBalance});

  UserBalance.fromJson(Map<String, dynamic> json) {
    activeBalance = json['active_balance'];
    inactiveBalance = json['inactive_balance'];
    totalBalance = json['total_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active_balance'] = this.activeBalance;
    data['inactive_balance'] = this.inactiveBalance;
    data['total_balance'] = this.totalBalance;
    return data;
  }
}