import 'package:flutter/material.dart';
import '../widgets/cat.dart';

/*ALL THAT ANIMATION KNOWS IS THAT IT IS ITSELF A NUMBER THAT WILL CHANGE OVER TIME,
SO YOU CHANGE THINGS WITH MARGIN AND GIVE IT THE VALUE, AND THEN WE */
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;

  @override
  void initState() {
    super.initState();

    catController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    catAnimation = Tween(begin: -25.0, end: -80.0).animate(
      CurvedAnimation(
        parent: catController,
        curve: Curves.easeIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    catAnimate() {
      if (catController.status == AnimationStatus.completed)
        catController.reverse();
      else if (catController.status == AnimationStatus.dismissed)
        catController.forward();
      // catController.status == AnimationStatus.completed? catController.reverse():
      // catController.forward();
      //AnimationStatus.dismissed is like opposite of completed
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: catAnimate,
          child: Stack(
            overflow: Overflow.visible,
            children: [
              buildCatAnimation(),
              buildBox(),

            ],
          ),
        ),
      ),
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
          top:catAnimation.value ,
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
}
