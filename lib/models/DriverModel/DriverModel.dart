class DriverModel {
    String availablity;
    String balance;
    String car;
    String car_model;
    String created_at;
    String driver_token;
    int id;
    String lat;
    String lng;
    String location;
    String name;
    String number_rounds;
    String number_work;
    String phone;
    String remember_token;
    String salary;
    String second_phone;
    String status;
    String updated_at;

    DriverModel({this.availablity, this.balance, this.car, this.car_model, this.created_at, this.driver_token, this.id, this.lat, this.lng, this.location, this.name, this.number_rounds, this.number_work, this.phone, this.remember_token, this.salary, this.second_phone, this.status, this.updated_at});

    factory DriverModel.fromJson(Map<String, dynamic> json) {
        return DriverModel(
            availablity: json['availablity'], 
            balance: json['balance'], 
            car: json['car'], 
            car_model: json['car_model'], 
            created_at: json['created_at'], 
            driver_token: json['driver_token'], 
            id: json['id'], 
            lat: json['lat'], 
            lng: json['lng'], 
            location: json['location'], 
            name: json['name'], 
            number_rounds: json['number_rounds'], 
            number_work: json['number_work'], 
            phone: json['phone'], 
            remember_token: json['remember_token'], 
            salary: json['salary'], 
            second_phone: json['second_phone'], 
            status: json['status'], 
            updated_at: json['updated_at'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['availablity'] = this.availablity;
        data['balance'] = this.balance;
        data['car'] = this.car;
        data['car_model'] = this.car_model;
        data['created_at'] = this.created_at;
        data['driver_token'] = this.driver_token;
        data['id'] = this.id;
        data['lat'] = this.lat;
        data['lng'] = this.lng;
        data['location'] = this.location;
        data['name'] = this.name;
        data['number_rounds'] = this.number_rounds;
        data['number_work'] = this.number_work;
        data['phone'] = this.phone;
        data['remember_token'] = this.remember_token;
        data['salary'] = this.salary;
        data['second_phone'] = this.second_phone;
        data['status'] = this.status;
        data['updated_at'] = this.updated_at;
        return data;
    }
}