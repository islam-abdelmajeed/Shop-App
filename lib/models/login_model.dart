class LoginModel{
  late bool status;
  late String message;
  late UserData data;

  LoginModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = json['data'] = UserData.fromJson(json['data']) ;

  }

}

class UserData{
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late int point;
  late int credit;
  late String token;

//   UserData({
//     this.id,
//     this.name,
//     this.email,
//     this.phone,
//     this.image,
//     this.point,
//     this.credit,
//     this.token,
// });

  //named Constructor

  UserData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    point = json['point'];
    credit = json['credit'];
    token = json['token'];
  }
}