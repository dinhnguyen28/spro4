import 'package:flutter/material.dart';
import 'package:spro4/api/secure_storage/secure_storage.dart';

import 'package:spro4/views/login/login_page.dart';

final SecureStorage secureStorage = SecureStorage();

void main() {
  runApp(const Login());
}
