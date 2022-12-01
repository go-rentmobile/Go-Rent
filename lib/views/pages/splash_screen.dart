import 'package:flutter/material.dart';
import 'package:go_rent/views/themes/colors.dart';
import 'package:go_rent/views/themes/images.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 45),
          child: Column(
            children: [
              Image.asset(
                logo,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
              const Text(
                "Go - Rent",
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 100.0,
              ),
              const Text(
                "Panik tidak ada kendaraan ?\nTenang sewa saja kendaraan disini",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              SizedBox(
                width: 200.0,
                height: 50.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                  onPressed: () => Navigator.pushNamed(context, 'login'),
                  child: const Text("Login"),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                width: 200.0,
                height: 50.0,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                  onPressed: () => Navigator.pushNamed(context, 'register'),
                  child: const Text("Daftar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
