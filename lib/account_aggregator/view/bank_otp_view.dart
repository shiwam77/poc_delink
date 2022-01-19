

import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:poc_delink/account_aggregator/config/theme/colors.dart';
import 'package:poc_delink/account_aggregator/view/otp_view.dart';
import 'package:poc_delink/account_aggregator/widget/timer.dart';
import 'package:poc_delink/account_aggregator/widget/widget.dart';


class BankOtpView extends StatefulWidget {
  const BankOtpView({Key? key}) : super(key: key);

  @override
  _BankOtpViewState createState() => _BankOtpViewState();
}

class _BankOtpViewState extends State<BankOtpView> {



  bool showTimer = true;
  bool isLoading = false;
  final TimerController _controller =  TimerController(autoStart: true);
  TextEditingController otpTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 1.round())).then((value) {
        _controller.start();
      });

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:   [

              const SizedBox(
                height: 40,
              ),


              const HeaderTitle(title: "enter the OTP received",),

              const SizedBox(
                height: 67,
              ),

              buildTextField(
                otpTextEditingController: otpTextEditingController,
                onChanged: (value){
                  if(value.length == 6){
                    setState(() {
                      isLoading = true;
                    });
                  }
                },
              ),

              const SizedBox(
                height: 72,
              ),


              Visibility(
                visible: showTimer && !isLoading,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("retry in 00:",
                        softWrap: false,
                        maxLines: 1,
                        style: TextStyle(
                            color: AppColors.lightGray100,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0.6
                        )),
                    TimerWidget(
                      controller: _controller,
                      interval: const Duration(seconds: 1),
                      seconds: 5,
                      build: (_, double time) => Text(
                        humanize(time.toInt()),
                        style: const TextStyle(
                            color: AppColors.lightGray100,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0.6
                        ),
                      ),
                      onFinished: (){
                        setState(() {
                          showTimer = false;
                        });
                      },
                    ),
                  ],
                ),
              ),

              Visibility(
                visible: !showTimer && !isLoading,
                child: Flexible(
                  child: RichText(
                    text:  TextSpan(
                      text: 'didn’t receive the OTP?  ',
                      style: const TextStyle(fontWeight: FontWeight.normal,fontSize: 14,color: AppColors.lightGray100),
                      children: <TextSpan>[
                        TextSpan(text: "Retry",
                          style:  const TextStyle(fontWeight: FontWeight.normal,fontSize: 14,color: AppColors.primaryColor100,),
                          recognizer:  TapGestureRecognizer()..onTap = () {
                            setState(() {
                              showTimer = true;
                            });
                            SchedulerBinding.instance?.addPostFrameCallback((_) {
                              _controller.restart();
                            });

                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Visibility(
                visible: isLoading,
                child:const SizedBox(
                  width: 60,
                  child: LoadingAnimation(
                    size: 10,
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }


  String humanize(int num){
    if(num.toString().length == 1){
      return "0$num";
    }else{
      return num.toString();
    }
  }
}

class HeaderTitle extends StatelessWidget {
  final String title;
  const HeaderTitle({
    Key? key,
    required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children:  [
        InkWell(
          onTap: (){

          },
            child: const Icon(Icons.arrow_back_ios_sharp,size: 15,color: AppColors.textColorBlue100,)),
        const SizedBox(
            width: 20
        ),
        Text(title,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            maxLines: 1,
            style: const TextStyle(
                color: AppColors.textColorBlue100,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.6
            )),
      ],
    );
  }
}



