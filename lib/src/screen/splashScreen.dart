import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    initApp();
  }

  initApp() async {
    controller = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 2,
      ),
    );
    animation = CurvedAnimation(
      curve: Curves.easeInExpo,
      parent: controller,
    );
    await controller.forward();
    await Future.delayed(Duration(
      seconds: 2,
    ));
    await Navigator.of(context).pushReplacementNamed("/home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: animation,
          builder: (ctx, child) {
            return Opacity(
              opacity: animation.value,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3,
                      color: Colors.black12,
                      offset: Offset(0, 2),
                      spreadRadius: 0.3,
                    )
                  ],
                ),
                child: Icon(
                  Icons.healing,
                  color: Color(0xFF455a64),
                  size: 60,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
