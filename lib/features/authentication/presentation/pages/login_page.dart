import 'dart:async';

import 'package:dio/dio.dart';
import 'package:expenses_off/core/configs/config.dart';
import 'package:expenses_off/core/widgets/e_text_field.dart';
import 'package:expenses_off/features/expense/presentation/pages/expenses_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int activeIndex = 0;
  bool loading = false;
  TextEditingController userNameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        activeIndex++;

        if (activeIndex == 4) activeIndex = 0;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      key: UniqueKey(),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          key: UniqueKey(),
          children: [
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 350,
              child: Stack(children: [
                Positioned(
                  key: UniqueKey(),
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: AnimatedOpacity(
                    opacity: activeIndex == 0 ? 1 : 0,
                    duration: const Duration(
                      seconds: 1,
                    ),
                    curve: Curves.linear,
                    child: Image.network(
                      'https://www.onfly.com.br/wp-content/uploads/2022/06/02-1.png',
                      height: 400,
                    ),
                  ),
                ),
                Positioned(
                  key: UniqueKey(),
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: AnimatedOpacity(
                    opacity: activeIndex == 1 ? 1 : 0,
                    duration: const Duration(seconds: 1),
                    curve: Curves.linear,
                    child: Image.network(
                      'https://www.onfly.com.br/wp-content/uploads/2021/10/01.png',
                      height: 400,
                    ),
                  ),
                ),
                Positioned(
                  key: UniqueKey(),
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: AnimatedOpacity(
                    opacity: activeIndex == 2 ? 1 : 0,
                    duration: const Duration(seconds: 1),
                    curve: Curves.linear,
                    child: Image.network(
                      'https://www.onfly.com.br/wp-content/uploads/2022/07/03.png',
                      height: 400,
                    ),
                  ),
                ),
                Positioned(
                  key: UniqueKey(),
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: AnimatedOpacity(
                    opacity: activeIndex == 3 ? 1 : 0,
                    duration: const Duration(seconds: 1),
                    curve: Curves.linear,
                    child: Image.network(
                      'https://www.onfly.com.br/wp-content/uploads/2022/06/destaque-1.png',
                      height: 400,
                    ),
                  ),
                )
              ]),
            ),
            const SizedBox(
              height: 40,
            ),
            ETextField(
              labelText: 'Username',
              controller: userNameTextController,
            ),
            const SizedBox(
              height: 20,
            ),
            ETextField(
              labelText: 'Password',
              obscureText: true,
              controller: passwordTextController,
            ),
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
              onPressed: () async {
                setState(() {
                  loading = true;
                });
                await Dio().post<Map<String, dynamic>>(
                    'https://go-bd-api-3iyuzyysfa-uc.a.run.app/api/collections/users/auth-with-password',
                    data: {
                      "identity": userNameTextController.text,
                      "password": passwordTextController.text,
                    }).then((response) {
                  final account = response.data!;
                  globalToken = account['token'];
                  //TODO: add account data in a global state manager

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ExpensesPage(),
                    ),
                  );
                }).catchError((onError) {
                  late String message;
                  if (onError is DioError) {
                    message = onError.message;
                  } else {
                    message = onError.toString();
                  }

                  final snackBar = SnackBar(
                    content: Text(message),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });

                setState(() {
                  loading = false;
                });
              },
              height: 45,
              color: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Text(
                "Login",
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
