import '../../share/constant.dart';
import '/data/spref/spref.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () async {
      var token = await SPref.instance.get(SPrefCache.KEY_TOKEN);

      if (token != null) {
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        //Navigator.pushReplacementNamed(context, "/sign-in");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/icon.png",
              width: 200,
              height: 200,
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Text(
                "Dev Flutter",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.brown[600],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
