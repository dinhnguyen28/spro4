import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:spro4/bloc/login_validation_bloc/login_validation_bloc.dart';
import 'package:spro4/views/home/home_page/home_page.dart';

final _emailController = TextEditingController();
final _passwordController = TextEditingController();

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: Colors.white,
            // iconTheme: IconThemeData(color: Colors.black),
            foregroundColor: Colors.black,
          ),
        ),
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
                            errorText: state.email.invalid
                                ? 'Email kh??ng h???p l???'
                                : null,
                            errorMaxLines: 2,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none),
                            hintText: 'Email c???a b???n'),
                        onChanged: (value) {
                          context
                              .read<LoginBloc>()
                              .add(EmailChanged(email: _emailController.text));
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0, bottom: 36.0),
                        child: TextFormField(
                            obscureText: true,
                            controller: _passwordController,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                errorText: state.password.invalid
                                    ? 'Password kh??ng h???p l???. Ph???i c?? ??t nh???t 6 k?? t???, 1 ch??? hoa, ch??? th?????ng, s??? v?? 1 k?? t??? ?????c bi???t'
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
                            '????ng nh???p',
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
                            '????ng nh???p ko c???n tk',
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
      ),
    );
  }
}
