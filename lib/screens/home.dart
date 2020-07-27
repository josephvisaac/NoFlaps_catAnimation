import 'package:flutter/material.dart';
import '../widgets/cat.dart';
import 'dart:math';

/*ALL THAT ANIMATION KNOWS IS THAT IT IS ITSELF A NUMBER THAT WILL CHANGE OVER TIME,
SO YOU CHANGE THINGS WITH MARGIN AND GIVE IT THE VALUE, AND THEN WE */
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;
  Animation<double> boxAnimation;
  AnimationController boxController;
  @override
  void initState() {
    super.initState();
    boxController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    boxAnimation = Tween(
      begin: pi * 0.6,
      end: 1.85,
    ).animate(
      CurvedAnimation(
        parent: boxController,
        curve: Curves.easeInOut,
      ),
    );
    boxController.forward();

    boxAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // boxController.reverse();
        boxController.repeat(
          period: Duration(seconds: 1),
        );
      }
    });
    catController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    catAnimation = Tween(
      begin: -25.0,
      end: -80.0,
    ).animate(
      CurvedAnimation(
        parent: catController,
        curve: Curves.easeIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    onTap() {
      if (catController.status == AnimationStatus.completed) {
        catController.reverse();
        boxController.forward();
      } else if (catController.status == AnimationStatus.dismissed) {
        catController.forward();
        boxController.stop();
      }
      // catController.status == AnimationStatus.completed? catController.reverse():
      // catController.forward();
      //AnimationStatus.dismissed is like opposite of completed
      //  boxController.reverse();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      body: Column(children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 50),
          height: MediaQuery.of(context).size.height * .30,
          child: Text('Tap the box',style: TextStyle(fontSize: 35),),
        ),
        Center(
          child: GestureDetector(
            onTap: onTap,
            child: Stack(
              overflow: Overflow.visible,
              children: [
                buildCatAnimation(),
                buildBox(),
                buildLeftFlap(),
                buildRightFlap()
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Positioned(
          right: 0,
          left: 0,
          // bottom: ,
          top: catAnimation.value,
          child: child,
        );
      },
      child: Cat(),
    );
  }

  Widget buildBox() {
    return Container(
      height: 200.0,
      width: 200.0,
      color: Colors.brown,
    );
  }

  Widget buildLeftFlap() {
    return Positioned(
      left: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          color: Colors.brown,
          height: 10.0,
          width: 125.0,
        ),
        builder: (ctx, child) {
          return Transform.rotate(
            alignment: Alignment.topLeft,
            angle: boxAnimation.value,
            //  angle: pi * 0.6,
            child: child,
          );
        },
      ),
    );
  }

  Widget buildRightFlap() {
    return Positioned(
      right: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          color: Colors.brown,
          height: 10.0,
          width: 125.0,
        ),
        builder: (ctx, child) {
          return Transform.rotate(
            alignment: Alignment.topRight,
            angle: -boxAnimation.value,
            child: child,
          );
        },
      ),
    );
  }
}
