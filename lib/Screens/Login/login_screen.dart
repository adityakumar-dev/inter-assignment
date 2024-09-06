import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intern_assignment/services/Auth/auth_service.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetWidget();
  }
}

Future<void> loginUser() async {}

class GetWidget extends StatelessWidget {
  const GetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Center(
            child: SvgPicture.asset(
              'assets/login.svg',
              height: MediaQuery.of(context).size.height * 0.5,
            ),
          ),
          const Spacer(),
          const Text(
            "Welcome to the App",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                await Authservice().anonymousLogin(context);
              },
              child: const Text("Login as Guest")),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
