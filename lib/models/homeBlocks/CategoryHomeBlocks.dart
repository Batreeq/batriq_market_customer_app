class CategoryHomeBlocks {
    String created_at;
    String home_blocks;
    int id;
    String lang;
    String name;
    String updated_at;

    CategoryHomeBlocks({this.created_at, this.home_blocks, this.id, this.lang, this.name, this.updated_at});

    factory CategoryHomeBlocks.fromJson(Map<String, dynamic> json) {
        return CategoryHomeBlocks(
            created_at: json['created_at'], 
            home_blocks: json['home_blocks'], 
            id: json['id'], 
            lang: json['lang'], 
            name: json['name'], 
            updated_at: json['updated_at'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['created_at'] = this.created_at;
        data['home_blocks'] = this.home_blocks;
        data['id'] = this.id;
        data['lang'] = this.lang;
        data['name'] = this.name;
        data['updated_at'] = this.updated_at;
        return data;
    }
}