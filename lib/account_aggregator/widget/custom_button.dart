import 'package:flutter/material.dart';
import 'package:poc_delink/account_aggregator/config/theme/colors.dart';

class CustomButton extends  StatefulWidget {
  final GestureTapCallback onTap;
  final String label;
   Color backGroundColor;
    CustomButton({Key? key,required this.onTap,required this.label,this.backGroundColor =  AppColors.primaryColor,}) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return   InkWell(
      onTap: widget.onTap,
      child: Container(
        height: 48,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color:widget.backGroundColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(100)
        ),
        child:  Text(widget.label,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            maxLines: 1,
            style: const TextStyle(
                color: AppColors.whiteBackgroundColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.6
            )),
      ),
    );
  }
}
