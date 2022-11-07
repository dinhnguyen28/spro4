import 'package:flutter/material.dart';
import 'package:login_bloc/api/secure_storage/secure_storage.dart';

import 'package:login_bloc/views/login/login_page.dart';

final SecureStorage secureStorage = SecureStorage();

void main() {
  runApp(const Login());
}
