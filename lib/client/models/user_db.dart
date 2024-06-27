class user {
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

  user(
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

  user.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['avatar'] = this.avatar;
    data['user_name'] = this.userName;
    data['password'] = this.password;
    data['last_name'] = this.lastName;
    data['first_name'] = this.firstName;
    data['birthday'] = this.birthday;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['status'] = this.status;
    return data;
  }
}
