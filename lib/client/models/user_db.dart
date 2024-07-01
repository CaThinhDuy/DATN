class User {
  int? id;
  String? avatar;
  String? userName;
  String? password;
  String? lastName;
  String? firstName;
  String? birthday;
  String? gender;
  String? email;
  String? phone;
  String? address1;
  String? address2;
  int? status;

  User(
      {this.id,
      this.avatar,
      this.userName,
      this.password,
      this.lastName,
      this.firstName,
      this.birthday,
      this.gender,
      this.email,
      this.phone,
      this.address1,
      this.address2,
      this.status});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avatar = json['avatar'];
    userName = json['user_name'];
    password = json['password'];
    lastName = json['last_name'];
    firstName = json['first_name'];
    birthday = json['birthday'];
    gender = json['gender'];
    email = json['email'];
    phone = json['phone'];
    address1 = json['address1'];
    address2 = json['address2'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['avatar'] = avatar;
    data['user_name'] = userName;
    data['password'] = password;
    data['last_name'] = lastName;
    data['first_name'] = firstName;
    data['birthday'] = birthday;
    data['gender'] = gender;
    data['email'] = email;
    data['phone'] = phone;
    data['address1'] = address1;
    data['address2'] = address2;
    data['status'] = status;
    return data;
  }
}
