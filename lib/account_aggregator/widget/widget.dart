
import 'package:flutter/material.dart';
import 'package:poc_delink/account_aggregator/config/theme/colors.dart';
import 'package:poc_delink/account_aggregator/constant/app_image.dart';

InputBorder outLineCustomInputBorder({required double radius,required Color color}){
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(radius)),
    borderSide: BorderSide(color: color,),
  );
}

Widget poweredByWidget () =>  Row(
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
                            );