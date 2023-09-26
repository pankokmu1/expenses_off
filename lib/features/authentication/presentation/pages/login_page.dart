import 'dart:async';

import 'package:dio/dio.dart';
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
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 350,
              child: Stack(children: [
                Positioned(
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
            TextField(
              cursorColor: Colors.black,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0.0),
                labelText: 'Username',
                hintText: 'Username',
                labelStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                ),
                prefixIcon: const Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 18,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                floatingLabelStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              obscureText: true,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0.0),
                labelText: 'Password',
                hintText: 'Password',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                ),
                labelStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
                prefixIcon: const Icon(
                  Icons.key,
                  color: Colors.black,
                  size: 18,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                floatingLabelStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
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
                      "identity": "xfqBre",
                      "password": "rxHBgm9USl",
                    }).then((response) {
                  // final account = response.data!;
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
