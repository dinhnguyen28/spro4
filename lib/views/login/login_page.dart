import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:login_bloc/bloc/login_validation_bloc/login_validation_bloc.dart';
import 'package:login_bloc/views/home/home_page.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => MyLoginPage();
}

class MyLoginPage extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFE5E5E5),
        body: SafeArea(
          child: BlocConsumer<LoginBloc, LoginState>(
            listenWhen: (previous, current) =>
                previous.authStatus != current.authStatus,
            listener: (context, state) {
              switch (state.authStatus) {
                case AuthStatus.initial:
                  break;
                case AuthStatus.success:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                  break;
                case AuthStatus.failure:
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text(state.message),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Ok'),
                          ),
                        ],
                      );
                    },
                  );
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          errorText:
                              state.email.invalid ? 'Email không hợp lệ' : null,
                          errorMaxLines: 2,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none),
                          hintText: 'Email của bạn'),
                      onChanged: (value) {
                        context
                            .read<LoginBloc>()
                            .add(EmailChanged(email: _emailController.text));
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0, bottom: 36.0),
                      child: TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              errorText: state.password.invalid
                                  ? 'Password không hợp lệ. Phải có ít nhất 6 kí tự, 1 chữ hoa, chữ thường, số và 1 kí tự đặc biệt'
                                  : null,
                              errorMaxLines: 2,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none),
                              hintText: 'Password'),
                          onChanged: (value) {
                            context.read<LoginBloc>().add(PasswordChanged(
                                password: _passwordController.text));
                          }),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF209F84),
                        ),
                        onPressed: () {
                          context.read<LoginBloc>().add(
                                Submitted(
                                    state.email.value, state.password.value),
                              );
                        },
                        child: const Text(
                          'Đăng nhập',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () {
                          context.read<LoginBloc>().add(
                                Test(),
                              );
                        },
                        child: const Text(
                          'Pass Đăng nhập',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
