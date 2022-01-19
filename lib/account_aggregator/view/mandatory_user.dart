

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poc_delink/account_aggregator/config/theme/colors.dart';
import 'package:poc_delink/account_aggregator/constant/app_image.dart';
import 'package:poc_delink/account_aggregator/widget/custom_button.dart';
import 'package:poc_delink/account_aggregator/widget/widget.dart';

import 'bank_account_list.dart';
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
                       color: AppColors.primaryColor200,
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

                  CustomButton(onTap: (){
                    routeToBankAccountLinkList(context);
                  }, label: 'Continue',
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  poweredByWidget(),

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

void routeToBankAccountLinkList(context){
  Navigator.push(context,  MaterialPageRoute<void>(
    builder: (BuildContext context) => const BankAccountList(),
  ),);
}