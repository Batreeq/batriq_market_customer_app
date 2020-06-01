  class IncreasePointsListClass {
    List<IncreasePoints> increasePoints;

    IncreasePointsListClass({this.increasePoints});

    IncreasePointsListClass.fromJson(Map<String, dynamic> json) {
      if (json['increase_points'] != null) {
        increasePoints = new List<IncreasePoints>();
        json['increase_points'].forEach((v) {
          increasePoints.add(new IncreasePoints.fromJson(v));
        });
      }
    }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      if (this.increasePoints != null) {
        data['increase_points'] =
            this.increasePoints.map((v) => v.toJson()).toList();
      }
      return data;
    }
  }

  class IncreasePoints {
    int id;
    String type;
    String points;
    String createdAt;
    String updatedAt;

    IncreasePoints(
        {this.id, this.type, this.points, this.createdAt, this.updatedAt});

    IncreasePoints.fromJson(Map<String, dynamic> json) {
      id = json['id'];
      type = json['type'];
      points = json['points'];
      createdAt = json['created_at'];
      updatedAt = json['updated_at'];

      print(points);
    }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['id'] = this.id;
      data['type'] = this.type;
      data['points'] = this.points;
      data['created_at'] = this.createdAt;
      data['updated_at'] = this.updatedAt;
      return data;
    }
  }