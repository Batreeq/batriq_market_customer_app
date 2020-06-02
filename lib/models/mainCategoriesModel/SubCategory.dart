class SubCategory {
    String category_id;
    String created_at;
    int id;
    String lang;
    String name;
    String updated_at;

    SubCategory({this.category_id, this.created_at, this.id, this.lang, this.name, this.updated_at});

    factory SubCategory.fromJson(Map<String, dynamic> json) {
        return SubCategory(
            category_id: json['category_id'], 
            created_at: json['created_at'], 
            id: json['id'], 
            lang: json['lang'], 
            name: json['name'], 
            updated_at: json['updated_at'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['category_id'] = this.category_id;
        data['created_at'] = this.created_at;
        data['id'] = this.id;
        data['lang'] = this.lang;
        data['name'] = this.name;
        data['updated_at'] = this.updated_at;
        return data;
    }
}