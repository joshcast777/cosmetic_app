import 'package:cosmetic_app/infrastructure/models/index.dart';

const String signIn = "Iniciar sesión";
const String signUp = "Registrarse";

final UserAppData userAppDataConstant = UserAppData(
  dni: "",
  name: "",
  lastName: "",
  email: "",
  password: "",
  role: "customer",
);

final UserApp userAppConstant = UserApp(
  id: "",
  data: userAppDataConstant,
);
