

import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:poc_delink/account_aggregator/config/theme/colors.dart';
import 'package:poc_delink/account_aggregator/widget/timer.dart';
import 'package:poc_delink/account_aggregator/widget/widget.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'bank_otp_view.dart';

class OTP extends StatefulWidget {
  const OTP({Key? key}) : super(key: key);

  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> with CodeAutoFill {



   bool showTimer = true;
   bool isLoading = false;
   final TimerController _controller =  TimerController(autoStart: true);
   TextEditingController otpTextEditingController = TextEditingController();

   @override
   void codeUpdated() {
     setState(() {
       otpTextEditingController.text = code!;
       if(otpTextEditingController.text.length == 6){
         isLoading = true;
       }
     });
   }

  @override
  void initState() {
    super.initState();
    listenForCode();
    SmsAutoFill().getAppSignature.then((signature) {
     print(signature);
    });
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
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:   [

                  const SizedBox(
                    height: 40,
                  ),


                  const HeaderTitle(title: "enter the 6-digit code",),

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
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: poweredByWidget(),
                ),
              )
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

TextField buildTextField({required TextEditingController otpTextEditingController,required Function(String)? onChanged}) {
  return TextField(
    controller: otpTextEditingController,
    style: const TextStyle(color: AppColors.textColorBlue100,fontSize: 20,letterSpacing: 10),
    textAlign: TextAlign.center,
    maxLength: 6,
    cursorColor: AppColors.lightGray,
    keyboardType: TextInputType.number,
    onChanged: onChanged,
    inputFormatters: [
      FilteringTextInputFormatter.allow(
        RegExp('[0-9]'),
      ),
    ],
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      counter: const SizedBox(),
      enabledBorder: outLineCustomInputBorder(radius: 100,color: AppColors.lightGray,),
      errorBorder: outLineCustomInputBorder(radius: 100,color:   AppColors.transparent),
      focusedBorder: outLineCustomInputBorder(radius: 100,color: AppColors.lightGray,),
      filled: true,
      hintStyle: const TextStyle(color: Color(0xffA5B6C5),fontSize: 20,letterSpacing: 10),
      hintText: "••••••",
      fillColor: Colors.white70,
      contentPadding: EdgeInsets.zero,
    ),
  );
}




class Actor extends StatelessWidget {
  final Color? dotColor;
  final double? size;
  const Actor({Key? key, this.size,this.dotColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration:  BoxDecoration(
        shape: BoxShape.circle,
        // shape: BoxShape.rectangle,
        color: dotColor!,
      ),
    );
  }
}

/// The main animation widget.
class LoadingAnimation extends StatefulWidget {
  final int numberOfActors;
  final Color color;
  final double size;
  const LoadingAnimation({Key? key,this.numberOfActors = 3,this.color = AppColors.primaryColor, this.size = 15}) : super(key: key);

  @override
  _LoadingAnimationState createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation>
    with SingleTickerProviderStateMixin {

  final double initialOffset = 0.0;
  final double finalOffset = 0.7;
  late AnimationController _loadingAnimationController;

  @override
  void initState() {
    super.initState();
    _initLoadingAnimationController();
    _loadingAnimationController.forward();
  }

  @override
  void dispose() {
    _loadingAnimationController.dispose();
    super.dispose();
  }

  // method to be called when the widget mounts
  void _initLoadingAnimationController() {
    _loadingAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _loadingAnimationController.forward(from: 0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 50,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(widget.numberOfActors, _generateActors),
          ),

        ],
      ),
    );
  }


  Widget _generateActors(int index) {
    Animation animation = _initLoadingAnimation(index);
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        // We can have multiple variations of animations with
        // this technique
        double d =  animation.value;
        return Transform.translate(
          offset: Offset(0, -30 * d),
          child: child,
        );
        // return Transform.rotate(
        //   angle: animation.value * math.pi / 2,
        //   alignment: Alignment.bottomRight,
        //   child: child,
        // );
        // return Transform.scale(
        //   scale: animation.value,
        //   child: child,
        // );
        // return Opacity(
        //   opacity: animation.value,
        //   child: child,
        // );
      },
      child:  Actor(
        dotColor: widget.color,
        size: widget.size,
      ),
    );
  }

  Animation<double> _initLoadingAnimation(int index) {
    double lastActorStartTime = 0.3;
    double actorAnimationDuration = 0.6;
    double begin = lastActorStartTime * (index / widget.numberOfActors);
    double end = actorAnimationDuration + begin;
    // Using Tween doesnt give us the desired output so we create a
    // custom Animatable
    // return Tween(begin: initialOffset, end: finalOffset)
    return Sinusoid(min: initialOffset, max: finalOffset).animate(
      CurvedAnimation(
        parent: _loadingAnimationController,
        curve: Interval(begin, end, curve: Curves.easeIn),
      ),
    );
  }

}

/// Tween moves from begin to end linearly
/// We dont want this because the animation stays at its max value at the end
/// then jumps back to the begin at the start of the next cycle.
/// So we create our custom animation to move in a wavy like form using sine
/// It is at its max value at the middle of the animation
/// and it at its min value at the begin and end,
/// thus giving us a wavy effect.
class Sinusoid extends Animatable<double> {
  final double min;
  final double max;

  Sinusoid({required this.min, required this.max});

  /// Here, the transform method takes the `t` and multiply it by `math.pi`
  /// then find its `sine`.
  /// The sine of `pi` is 0. The sine of `pi/2` is 1.
  /// This means that when the animation is at 0.5 the result of the
  /// sine function would be 1 hence giving us the max at the middle of the animation
  @override
  double transform(double t) {
    return min + (max - min) * math.sin(math.pi * t);
  }
}
