class AllProduct {
    String barcode;
    String category_id;
    String created_at;
    String details_image;
    String details_text;
    String details_title;
    int id;
    String image;
    String is_package;
    String lang;
    String name;
    String notice;
    String offers_ids;
    String points;
    String price;
    String product_source;
    String quantity;
    String size;
    String special_price_for;
    String updated_at;
    String wholesale_price;

    AllProduct({this.barcode, this.category_id, this.created_at, this.details_image, this.details_text, this.details_title, this.id, this.image, this.is_package, this.lang, this.name, this.notice, this.offers_ids, this.points, this.price, this.product_source, this.quantity, this.size, this.special_price_for, this.updated_at, this.wholesale_price});

    factory AllProduct.fromJson(Map<String, dynamic> json) {
        return AllProduct(
            barcode: json['barcode'], 
            category_id: json['category_id'], 
            created_at: json['created_at'], 
            details_image: json['details_image'], 
            details_text: json['details_text'], 
            details_title: json['details_title'], 
            id: json['id'], 
            image: json['image'], 
            is_package: json['is_package'], 
            lang: json['lang'], 
            name: json['name'], 
            notice: json['notice'], 
            offers_ids: json['offers_ids'], 
            points: json['points'], 
            price: json['price'], 
            product_source: json['product_source'], 
            quantity: json['quantity'], 
            size: json['size'], 
            special_price_for: json['special_price_for'], 
            updated_at: json['updated_at'], 
            wholesale_price: json['wholesale_price'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['barcode'] = this.barcode;
        data['category_id'] = this.category_id;
        data['created_at'] = this.created_at;
        data['details_image'] = this.details_image;
        data['details_text'] = this.details_text;
        data['details_title'] = this.details_title;
        data['id'] = this.id;
        data['image'] = this.image;
        data['is_package'] = this.is_package;
        data['lang'] = this.lang;
        data['name'] = this.name;
        data['notice'] = this.notice;
        data['offers_ids'] = this.offers_ids;
        data['points'] = this.points;
        data['price'] = this.price;
        data['product_source'] = this.product_source;
        data['quantity'] = this.quantity;
        data['size'] = this.size;
        data['special_price_for'] = this.special_price_for;
        data['updated_at'] = this.updated_at;
        data['wholesale_price'] = this.wholesale_price;
        return data;
    }
}