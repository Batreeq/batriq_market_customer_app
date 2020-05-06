class UserProfile {
  UserInfo userInfo;
  List <FamilyMembers> familyMembers;

  UserProfile({this.userInfo, this.familyMembers});

  UserProfile.fromJson(Map<String, dynamic> json) {
    userInfo = json['user_info'] != null
        ? new UserInfo.fromJson(json['user_info'])
        : null;
    if (json['family_members'] != null) {
      familyMembers = new List<FamilyMembers>();
      json['family_members'].forEach((v) {
        familyMembers.add(new FamilyMembers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userInfo != null) {
      data['user_info'] = this.userInfo.toJson(true);
    }
    if (this.familyMembers != null) {
      data['family_members'] =
          this.familyMembers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserInfo {
  int id;
  String name;
  String email;
  String emailVerifiedAt;
  String apiToken;
  String createdAt;
  String updatedAt;
  String phone;
  String location;
  String image;
  String salary;
  String role;
  String pinCode;
  String pinDate;
  String activeBalance;
  String inactiveBalance;
  String points;
  String activeAvg;

  UserInfo(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.apiToken,
        this.createdAt,
        this.updatedAt,
        this.phone,
        this.location,
        this.image,
        this.salary,
        this.role,
        this.pinCode,
        this.pinDate,
        this.activeBalance,
        this.inactiveBalance,
        this.points,
        this.activeAvg});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    apiToken = json['api_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    phone = json['phone'];
    location = json['location'];
    image = json['image'];
    salary = json['salary'];
    role = json['role'];
    pinCode = json['pin_code'];
    pinDate = json['pin_date'];
    activeBalance = json['active_balance'];
    inactiveBalance = json['inactive_balance'];
    points = json['points'];
    activeAvg = json['active_avg'];
  }

  Map<String, dynamic> toJson(bool addToken) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['phone'] = this.phone;
    data['location'] = this.location;
    data['image'] = this.image;
    data['salary'] = this.salary;
    data['role'] = this.role;
    data['pin_code'] = this.pinCode;
    data['pin_date'] = this.pinDate;
    data['active_balance'] = this.activeBalance;
    data['inactive_balance'] = this.inactiveBalance;
    data['points'] = this.points;
    data['active_avg'] = this.activeAvg;
    if (addToken)
    data['api_token'] = this.apiToken;
    return data;
  }
}

class FamilyMembers {
  int id;
  String userId;
  String name;
  String gender;
  String age;
  String token ;
  String createdAt;
  String updatedAt;
  String salary ;

  FamilyMembers(
      {this.id,
        this.salary ,
        this.userId,
        this.name,
        this.token ,
        this.gender,
        this.age,
        this.createdAt,
        this.updatedAt});

  FamilyMembers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    gender = json['gender'];
    age = json['age'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    token = json['api_token'];
    salary = json['salary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['api_token'] = this.token;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['salary'] = this.salary;
    return data;
  }
}