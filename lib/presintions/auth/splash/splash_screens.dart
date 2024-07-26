import 'package:book_app/domain/local/pref_helper.dart';
import 'package:flutter/material.dart';

class SplashScreens extends StatelessWidget {
  const SplashScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/images/logo.png"),
                  fit: BoxFit.contain,
                )),
              ),
            ),
            // Image.asset("assets/images/logo.png"),
            const SizedBox(height: 40),
            // Image.asset("assets/images/book_fon.png",fit: BoxFit.cover,),
            Expanded(
              flex: 1,
              child: Image.asset(
                "assets/images/book.gif",
                fit: BoxFit.scaleDown,
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 50,
          right: 20,
          child: InkWell(
            onTap: () {
              bool a = PrefHelper.getIsLoggedIn();
              if (a) {
                Navigator.pushNamed(context, '/main');
              } else {
                Navigator.pushNamed(context, '/login');
              }
            },
            child: Container(
                width: 250,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(35)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Get Started",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.arrow_forward,
                      size: 30,
                      color: Colors.white,
                    )
                  ],
                )),
          ),
        )
      ]),
    );
  }
}
