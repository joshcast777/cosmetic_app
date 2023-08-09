final RegExp dniRegExp = RegExp(r"^\d{10}$");
final RegExp emailRegExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
final RegExp passwordRegExp = RegExp(r"^(?=.*[A-ZÁÉÍÓÚÜÑ])(?=.*[a-záéíóúüñ])(?=.*\d)[A-Za-zÁÉÍÓÚÜÑáéíóúüñ\d]{8,}$");
final RegExp textRegExp = RegExp(r"^[A-ZÁÉÍÓÚÜÑ\s]+$");
