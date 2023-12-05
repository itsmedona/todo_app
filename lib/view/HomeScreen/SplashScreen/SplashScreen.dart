/*import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MySplash extends StatelessWidget {
  const MySplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('asset/animations/Animation - 1701246492847.json'),
      ),
    );
  }
}

class MySplash extends StatefulWidget {
  const MySplash({super.key});

  @override
  State<MySplash> createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  void initState() {
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreenWidget(
                title: '',
                description: '',
                date: '',
                color: Colors.pinkAccent,
              )));
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsetsDirectional.all(50),
              child: Container(
                child: Image.asset("asset/images/notes.png"),
                height: 55,
                width: 270,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/