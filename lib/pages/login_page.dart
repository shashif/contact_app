import 'package:contact_app/auth_prefs.dart';
import 'package:contact_app/pages/contact_list_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/loginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email address',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: passwordController,
                // keyboardType: TextInputType.visiblePassword,
                obscureText: isObsecure,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isObsecure = !isObsecure;
                        });
                      },
                      icon: Icon(isObsecure
                          ? Icons.visibility_off
                          : Icons.visibility)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(onPressed: () {
                setLoginStatus(true).then((value) =>
                    Navigator.pushReplacementNamed(
                        context, ContactListPage.routeName));
              }, child: Text('Login'))
            ],
          ),
        ),
      ),
    );
  }
}
