
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