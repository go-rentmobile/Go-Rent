import 'package:flutter/material.dart';
import 'package:go_rent/views/themes/colors.dart';
import 'package:go_rent/views/themes/font_weights.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_circle_down,
                      size: 36.0,
                    ),
                    onPressed: () => Navigator.pop(context),
                    color: primaryColor,
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 36.0,
                        fontWeight: bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 70.0,
              ),

              // INPUT EMAIL
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: semibold,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: null,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "email@contoh.com",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),

              // INPUT PASSWORD
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: semibold,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: null,
                      obscureText: !showPassword,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            showPassword = !showPassword;
                            setState(() {});
                          },
                          icon: Icon(
                            showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 24.0,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "your password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),

              // BUTTON
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 40.0),
                  width: 200.0,
                  height: 50.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // <-- Radius
                      ),
                    ),
                    onPressed: () => Navigator.pushNamedAndRemoveUntil(
                        context, 'home', (route) => false),
                    child: const Text("Login"),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Belum punya akun ? '),
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, 'register'),
                    child: Text(
                      "Daftar disini",
                      style: TextStyle(fontWeight: bold, color: greenColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
