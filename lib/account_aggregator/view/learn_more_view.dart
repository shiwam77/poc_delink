
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poc_delink/account_aggregator/config/theme/colors.dart';
import 'package:poc_delink/account_aggregator/constant/app_image.dart';
import 'package:poc_delink/account_aggregator/constant/app_string.dart';

class LearMoreView extends StatefulWidget {
  const LearMoreView({Key? key}) : super(key: key);

  @override
  _LearMoreViewState createState() => _LearMoreViewState();
}

class _LearMoreViewState extends State<LearMoreView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: LayoutBuilder(
              builder: (context,  BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              const  SizedBox(
                                  height: 52,
                                ),

                              Center(
                                child: SvgPicture.asset(
                                  AppImages.appIntro1,
                                  fit: BoxFit.contain,
                                  height: 150,
                                ),
                              ),

                              const SizedBox(
                                height: 24,
                              ),

                              const Center(
                                child: Text("let us tell you how we do it.",
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: AppColors.textColorBlue100,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.6
                                    )),
                              ),

                              const SizedBox(
                                height: 40,
                              ),

                              const Text("what is account aggregator?",
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: AppColors.textColorBlue200,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.6
                                  )),

                              const SizedBox(
                                height: 16,
                              ),

                               Flexible(
                                 child: Text(AppString.accountAggregator,
                                    softWrap: true,
                                    style: const TextStyle(
                                        color: AppColors.primaryColor100,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        letterSpacing: 0.6
                                    )),
                               ),

                              const SizedBox(
                                height: 10,
                              ),

                              dottedText(AppString.accountAggregatorFirstPoint),

                              const SizedBox(
                                height: 10,
                              ),

                              dottedText(AppString.accountAggregatorSecondPoint),

                              const SizedBox(
                                height: 40,
                              ),

                             const Text("banks  that are currently live in the aa space",
                                  softWrap: true,
                                  style: TextStyle(
                                      color: AppColors.textColorBlue200,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.6
                                  )),

                              SizedBox(
                                height: MediaQuery.of(context).size.height  * .5,
                                child: GridView.builder(
                                    shrinkWrap: true,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                                    itemCount: 10,
                                    itemBuilder: (context,index){
                                      return itemBuilder();
                                    },
                                ),
                              ),

                              const SizedBox(
                                height: 40,
                              ),

                              const Text("how do we plan to use the data?",
                                  softWrap: true,
                                  style: TextStyle(
                                      color: AppColors.textColorBlue200,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.6
                                  )),

                              const SizedBox(
                                height: 16,
                              ),

                              const Text("information collected by slice will be used for following purposes - ",
                                  softWrap: true,
                                  style: TextStyle(
                                      color: AppColors.primaryColor100,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      letterSpacing: 0.6
                                  )),

                              const SizedBox(
                                height: 10,
                              ),

                              dottedText("credit application processing "),

                              const SizedBox(
                                height: 40,
                              ),

                              const Text("do you already have an account aggregator account?",
                                  softWrap: true,
                                  style: TextStyle(
                                      color: AppColors.textColorBlue200,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.6
                                  )),

                              const SizedBox(
                                height: 40,
                              ),

                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.whiteBackgroundColor,
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.0,
                                    ),],

                                ),
                                child: TextField(
                                  style: const TextStyle(color: AppColors.primaryColor100,fontSize: 16),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    enabledBorder: outLineCustomInputBorder(radius: 100,color:  AppColors.transparent),
                                    errorBorder: outLineCustomInputBorder(radius: 100,color:   AppColors.transparent),
                                    focusedBorder: outLineCustomInputBorder(radius: 100,color:   AppColors.transparent),
                                    filled: true,
                                    contentPadding: const EdgeInsets.only(left: 24),
                                    hintStyle: const TextStyle(color: Color(0xffA5B6C5),fontSize: 16),
                                    hintText: "enter id",
                                    fillColor: Colors.white70,
                                    suffixIcon: Container(
                                      height: 39,
                                      width: 115,
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: AppColors.lightGray,
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      child: const Text("Continue",
                                        style: TextStyle(
                                            color: AppColors.whiteBackgroundColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500
                                        )
                                        ,),
                                    )
                                ),
                                ),
                              ),

                              const SizedBox(
                                height: 74,
                              ),

                            ],
                          ),
                        ),
                    ),
                  ),
                );
              }
            ),
          ),
        )
    );
  }

  InputBorder outLineCustomInputBorder({required double radius,required Color color}){
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      borderSide: BorderSide(color: color,),
    );
  }

  Widget dottedText(String text){
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 4,
          width: 4,
          margin: const EdgeInsets.only(top: 7,right: 8,left: 8),
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryColor100
          ),
        ),
        Flexible(
          child: Text(text,
              softWrap: true,
              style: const TextStyle(
                  color: AppColors.primaryColor100,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.4
              )),
        ),
      ],
    );
  }

  Widget itemBuilder(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 10),
          child: Container(
            height: 48,
            width: 48,
            decoration:  BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 1.0,
                ),],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text("federal banks efe ee er ee ere er er er er er ",
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              maxLines: 2,
              style: TextStyle(
                  color: AppColors.primaryColor100,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.2
              )),
        )
      ],
    );
  }
}
