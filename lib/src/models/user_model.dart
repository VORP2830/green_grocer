class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? cpf;
  final String? password;
  final String? token;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.cpf,
    this.password,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['fullname'],
      email: json['email'],
      phone: json['phone'],
      cpf: json['cpf'],
      password: json['password'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'fullname': name,
      'email': email,
      'phone': phone,
      'cpf': cpf,
      'password': password,
      'token': token,
    };
  }

  @override
  String toString() {
    return 'id: $id, name: $name, email: $email, phone: $phone, cpf: $cpf, password: $password, token: $token';
  }
}
