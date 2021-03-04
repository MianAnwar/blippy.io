import 'package:flutter/material.dart';
import 'package:total_app/UI/Bottom_Nav_Bar/TSbottomNavBar.dart';
import 'package:flutter/services.dart';
import 'package:total_app/constants.dart';

/// Componen Login Animation to set Animation in login like a bounce ball to fullscreen
class TSLoginAnimation extends StatefulWidget {
  /// To set type animation and  start and end animation
  TSLoginAnimation({Key key, this.animationController, this.email})
      : animation = new Tween(
          end: 900.0,
          begin: 70.0,
        ).animate(CurvedAnimation(
            parent: animationController, curve: Curves.bounceInOut)),
        super(key: key);

  final AnimationController animationController;
  final Animation animation;
  final String email;

  Widget _buildAnimation(BuildContext context, Widget child) {
    /// Setting shape a animation
    return Padding(
        padding: EdgeInsets.only(bottom: 60.0),
        child: Container(
          height: animation.value,
          width: animation.value,
          decoration: BoxDecoration(
            color: Constants.basicColor,
            shape: animation.value < 600 ? BoxShape.circle : BoxShape.rectangle,
          ),
        ));
  }

  @override
  _TSLoginAnimationState createState() => _TSLoginAnimationState();
}

class _TSLoginAnimationState extends State<TSLoginAnimation> {
  @override

  /// To navigation after animation complete
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
    ));
    widget.animationController.addListener(() {
      if (widget.animation.isCompleted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) =>
                new TSBtmNavBar(email: widget.email), //////////
            transitionDuration: Duration(milliseconds: 600),
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return Opacity(
                opacity: animation.value,
                child: child,
              );
            },
          ),
        );
      }
    });

    return new AnimatedBuilder(
      animation: widget.animationController,
      builder: widget._buildAnimation,
    );
  }
}
