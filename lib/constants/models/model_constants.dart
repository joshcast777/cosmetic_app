import 'package:cosmetic_app/infrastructure/models/index.dart';

final BillData billDataConstant = BillData(
  date: DateTime.now(),
  total: 0.0,
  cartItems: [],
);

final Bill billConstant = Bill(
  id: "",
  data: billDataConstant,
);

final List<CartItem> cartItemsConstant = [];

final ProductData productDataConstant = ProductData(
  description: "",
  fullPath: "",
  imageUrl: "",
  name: "",
  price: 0.0,
  summary: "",
);

final Product productConstant = Product(
  id: "",
  data: productDataConstant,
);

final List<Product> productsConstant = [];

final UserApp userAppConstant = UserApp(
  id: "",
  data: UserAppData(
    dni: "",
    email: "",
    lastName: "",
    name: "",
    password: "",
    role: "",
    bills: [],
  ),
);
