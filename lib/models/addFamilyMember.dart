class AddFamilyMember {
  int userId;
  String name;
  String gender;
  String age;
  String updatedAt;
  String createdAt;
  int id;
  String salary ;
  String token ;

  AddFamilyMember(
      {this.userId,
        this.name,
        this.gender,
        this.age,
        this.updatedAt,
        this.createdAt,
        this.id ,
        this.token ,
        this.salary});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['api_token'] = this.token;
    data['age'] = this.age;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['salary'] = this.salary;
    return data;
  }
}