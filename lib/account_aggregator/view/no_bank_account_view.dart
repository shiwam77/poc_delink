
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poc_delink/account_aggregator/config/theme/colors.dart';
import 'package:poc_delink/account_aggregator/constant/app_image.dart';
import 'package:poc_delink/account_aggregator/widget/custom_button.dart';

class NoBankAccount extends StatefulWidget {
  const NoBankAccount({Key? key}) : super(key: key);

  @override
  _NoBankAccountState createState() => _NoBankAccountState();
}

class _NoBankAccountState extends State<NoBankAccount> {
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
                  AppImages.noBankAccount,
                  fit: BoxFit.contain,
                  height: 250,
                ),

                const SizedBox(
                  height: 50,
                ),

                const Text("couldn't find bank account",
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


                RichText(
                  textAlign: TextAlign.center,
                  text:  TextSpan(
                    text: "bummer! we weren't able to fetch any details from your bank.",
                    style: const  TextStyle(
                      color: AppColors.primaryColor200,
                      fontSize: 14,
                      height: 1.2,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.6,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: "Know More",
                        style:  const  TextStyle(
                            color: Color(0xFF624DC2),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.2
                        ),
                        recognizer:  TapGestureRecognizer()..onTap = () => print("hi"),
                      ),
                    ],
                  ),
                ),


                const Spacer(),

                CustomButton(onTap: (){

                }, label: 'Change Phone Number',
                ),

              TextButton(
                onPressed: () {

                },
                child: const Text("Skip",
                  style:  TextStyle(
                      color: AppColors.purple4,
                      fontSize: 16,
                      letterSpacing: 0.4
                  ),
                ),
              ),

                const SizedBox(
                  height: 40,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
