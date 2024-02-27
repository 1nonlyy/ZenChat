import 'package:flutter/material.dart';
import 'package:zenchat/pages/login_page.dart';
import 'package:zenchat/pages/register_page.dart';
class LoginorRegister extends StatefulWidget {
  const LoginorRegister({super.key});

  @override
  State<LoginorRegister> createState() => _LoginorRegisterState();
}

class _LoginorRegisterState extends State<LoginorRegister> {
  bool showLoginPage = true;
  void TogglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLoginPage) {
      return LoginPage(onTap: TogglePages);
    } else {
      return RegisterPage(onTap: TogglePages);
    }
  }
}