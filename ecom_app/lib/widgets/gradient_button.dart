import 'package:flutter/material.dart';

import '../constants/activate_constant.dart';

class GradientButton extends StatelessWidget {
  final Widget buttonText;
  final double btnWidth;
  final double btnHeight;
  final VoidCallback press;
  final TextStyle? btnTextStyle;
  const GradientButton({
    Key? key,
    required this.buttonText,
    required this.btnWidth,
    required this.btnHeight,
    required this.press,
    this.btnTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: btnWidth,
      height: btnHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            activeColors.gradientColor1,
            activeColors.gradientColor2
          ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ConstrainedBox(
        constraints:
            BoxConstraints.tightFor(width: MediaQuery.of(context).size.width),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: Colors.white,
            maximumSize: const Size(147, 60),
            minimumSize: const Size(147, 60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: press,
          child: buttonText,
          // child: Text(
          //   buttonText,
          //   style: btnTextStyle,
          // ),
        ),
      ),
    );
  }
}
