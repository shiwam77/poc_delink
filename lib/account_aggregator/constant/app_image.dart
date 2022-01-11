import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppImages {
  static var appIntro1 ='assets/appIntro.svg';

  static var oneMoneySdkLogo ='assets/oneMoneyLogo.png';

  static var noBankAccount ='assets/Frame.svg';

  static Widget toSvgWidget(String assetName, String label,
      {double height=200, double width=200}) {

    return SvgPicture.asset(
      assetName,
      height: height,
      width: width,
      semanticsLabel: label,
    );
  }
}