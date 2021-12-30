

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poc_delink/account_aggregator/config/theme/colors.dart';
import 'package:poc_delink/account_aggregator/constant/app_image.dart';

import 'learn_more_view.dart';

class MandatoryUser extends StatefulWidget {
  const MandatoryUser({Key? key}) : super(key: key);

  @override
  _MandatoryUserState createState() => _MandatoryUserState();
}

class _MandatoryUserState extends State<MandatoryUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  SizedBox(
                    height: MediaQuery.of(context).size.height *.1,
                  ),

                  SvgPicture.asset(
                    AppImages.appIntro1,
                    fit: BoxFit.contain,
                    height: 250,
                ),

                  const SizedBox(
                    height: 50,
                  ),

                  const Text("let's fetch your bank details",
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      maxLines: 1,
                      style: TextStyle(
                          color: AppColors.textColorBlue100,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.6
                      )),

                  const SizedBox(
                    height: 12,
                  ),

                   const Text("provide financial information of bank accounts linked to +91 889004126",
                     textAlign: TextAlign.center,
                       style:  TextStyle(
                       color: AppColors.primaryColor100,
                       fontSize: 14,
                       height: 1.2,
                       fontWeight: FontWeight.normal,
                       letterSpacing: 0.6,
                   ),),

                  const SizedBox(
                    height: 2,
                  ),

                  GestureDetector(
                  onTap: (){
                    routeToLearMoreScreen();
                  },
                    child: const Text("Learn more",
                       textAlign: TextAlign.center,
                         style:  TextStyle(
                             color: Color(0xFF624DC2),
                             fontSize: 14,
                             fontWeight: FontWeight.bold,
                             letterSpacing: 0.2
                         ),),
                  ),



                  const Spacer(),

                   InkWell(
                     onTap: (){

                     },
                     child: Container(
                      height: 48,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(100)
                      ),
                      child: const Text("Continue",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TextStyle(
                              color: AppColors.whiteBackgroundColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.6
                          )),
                  ),
                   ),

                  const SizedBox(
                    height: 25,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,

                    children:  [
                      const Text("Powered by  ",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TextStyle(
                              color: AppColors.lightBlack,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.4
                          )),

                      Image.asset(
                        AppImages.oneMoneySdkLogo,
                        fit: BoxFit.contain,
                        height: 18,
                        width: 62,
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 22,
                  ),

                ],
              ),
            ),
          ),
        ),
    );
  }

  void routeToLearMoreScreen(){
    Navigator.push(context,  MaterialPageRoute<void>(
            builder: (BuildContext context) => const LearMoreView(),
             ),);
  }
}
