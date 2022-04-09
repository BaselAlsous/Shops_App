class ProfileModel {
  bool? status;
  Users? users;

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    users = json['data'] != null ? Users.fromJson(json['data']) : null;
  }
}

class Users {
  int? id;
  late String name;
  late String email;
  late String phone;
  late String? image;
  int? points;
  int? credit;
  String? token;

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}
