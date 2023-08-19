import 'package:cosmetic_app/infrastructure/models/index.dart';

class UserApp {
  final String _id;
  final UserAppData _data;

  UserApp({
    required String id,
    required UserAppData data,
  })  : _id = id,
        _data = data;

  UserApp.copy(UserApp userApp)
      : _id = userApp.id,
        _data = UserAppData.copy(userApp.data);

  String get id => _id;

  UserAppData get data => _data;

  factory UserApp.fromJson(Map<String, dynamic> json) => UserApp(
        id: json["id"],
        data: UserAppData.fromJson(json["data"]),
      );
}

class UserAppData {
  String dni;
  String name;
  String lastName;
  String email;
  String password;
  String role;
  List<Bill>? bills;

  UserAppData({
    required this.dni,
    required this.name,
    required this.lastName,
    required this.email,
    required this.password,
    required this.role,
    this.bills,
  });

  UserAppData.copy(UserAppData data)
      : dni = data.dni,
        name = data.name,
        lastName = data.lastName,
        email = data.email,
        password = data.password,
        role = data.role,
        bills = data.bills;

  factory UserAppData.fromJson(Map<String, dynamic> json) => UserAppData(
        dni: json["dni"],
        name: json["name"],
        lastName: json["lastName"],
        email: json["email"],
        password: json["password"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "dni": dni,
        "name": name,
        "lastName": lastName,
        "email": email,
        "password": password,
        "role": role,
      };
}
