

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:poc_delink/account_aggregator/config/theme/colors.dart';
import 'package:poc_delink/account_aggregator/model/bank.dart';
import 'package:poc_delink/account_aggregator/view/view_more.dart';
import 'package:poc_delink/account_aggregator/widget/custom_button.dart';
import 'package:poc_delink/account_aggregator/widget/dismissible_widget.dart';
import 'package:poc_delink/account_aggregator/data.dart';
import 'package:poc_delink/account_aggregator/utils.dart';
import 'package:shimmer/shimmer.dart';

class BankAccountList extends   StatefulWidget {
  const BankAccountList({Key? key}) : super(key: key);

  @override
  _BankAccountListState createState() => _BankAccountListState();
}

class _BankAccountListState extends State<BankAccountList> {

  List<BankName> items = List.of(Data.chats);
  bool isButtomWidget = false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

          const IntroductionHeader(
          title: "Link your bank account",
          subTitle: "please confirm to submit your details",
        ),

            const SizedBox(height: 22,),

            Expanded(
              child: FutureBuilder(
                  future: shimmerBuilder(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      SchedulerBinding.instance?.addPostFrameCallback((_) {
                        setState(() {
                          isButtomWidget = true;
                        });
                      });

                      return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 10),
                            child: Container(
                              height: 96,
                              width: MediaQuery.of(context).size.width,
                              decoration:  BoxDecoration(
                                color: Color(0xFF8795A7),
                                borderRadius: BorderRadius.circular(16),
                                shape: BoxShape.rectangle,
                              ),
                              child: DismissibleWidget(
                                item: item,
                                child: buildListTile(item),
                                onDismissed: (direction) =>
                                    dismissItem(context, index, direction),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 10),
                          child: Container(
                            height: 96,
                            width: MediaQuery.of(context).size.width,
                            decoration:  BoxDecoration(
                              color: Color(0xFF8795A7),
                              borderRadius: BorderRadius.circular(16),
                              shape: BoxShape.rectangle,
                            ),
                            child: shimmerBuildListTile(item),
                          ),
                        );
                      },
                    );
                  }
              ),
            ),

             isButtomWidget == true ? const BottomWidget() : const SizedBox(),

          ],
        ),
      ),
    );
  }


  Future<String> shimmerBuilder(){
    return Future.delayed(const Duration(seconds: 2)).then((value) {
      return "Done";
    });
  }

  void dismissItem(
      BuildContext context,
      int index,
      DismissDirection direction,
      ) {
      setState(() {
        items.removeAt(index);
      });

    switch (direction) {
      case DismissDirection.endToStart:
        Utils.showSnackBar(context, 'Bank account has been de-linked');
        break;
      case DismissDirection.startToEnd:
        Utils.showSnackBar(context, 'Bank account has been archived');
        break;
      default:
        break;
    }
  }

  Widget buildListTile(BankName item) => Container(
    height: 96,
    width: MediaQuery.of(context).size.width,
    decoration:  BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      shape: BoxShape.rectangle,
      boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 1.0,
        ),],
    ),
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:  [
          Row(
            children:  [

              Container(
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

              Padding(
                padding: const EdgeInsets.only(left: 16,top: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [

                    SizedBox(
                      width: 150,
                      child: Text("Standard chss dddd ddd ddd",
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        maxLines: 1,
                        style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 16,
                            letterSpacing: 0.6
                        ),
                      ),
                    ),

                    SizedBox(height: 6,),

                    Text("xx 5432 ",
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                          color: Color(0xFF8795A7),
                          fontSize: 12,
                          letterSpacing: 0.6
                      ),),

                  ],
                ),
              ),

            ],
          ),

          const Text("Link",
            style: TextStyle(
                color: Color(0xFF624DC2),
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.2
            ),),
        ],
      ),
    ),
  );

  Widget shimmerBuildListTile(BankName item) => Container(
    height: 96,
    width: MediaQuery.of(context).size.width,
    decoration:  BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      shape: BoxShape.rectangle,
      boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 1.0,
        ),],
    ),
    child: Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(.3),
      highlightColor: Colors.grey.withOpacity(.8),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:  [
            Row(
              children:  [

                Container(
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

                Padding(
                  padding: const EdgeInsets.only(left: 16,top: 2),
                  child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Container(height: 20,width: 87,color: AppColors.lightBlack,),
                      const SizedBox(height: 10),
                      Container(height: 11,width: 130,color: AppColors.lightBlack,)

                    ],
                  ),
                ),

              ],
            ),

            Container(height: 20,width: 41,color: AppColors.lightBlack,)
          ],
        ),
      ),
    ),
  );

}


class BottomWidget extends StatefulWidget {
  const BottomWidget({Key? key}) : super(key: key);

  @override
  _BottomWidgetState createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget> {

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24,),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
               Padding(
                 padding: const EdgeInsets.only(bottom: 5),
                 child: Checkbox(value: isChecked,
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  onChanged: (bool? value) {
                  setState(() {
                    isChecked = !isChecked;
                  });
              },),
               ),

               Flexible(
                 child: RichText(
                   text:  TextSpan(
                     text: 'I agree to allow slice to store my account details \n and access account statements.',
                     style: const TextStyle(fontWeight: FontWeight.normal,fontSize: 12,color: AppColors.lightBlack100),
                     children: <TextSpan>[
                       TextSpan(text: "View More",
                         style:  const TextStyle(fontWeight: FontWeight.normal,fontSize: 12,color: AppColors.textColorBlue200,decoration: TextDecoration.underline,),
                         recognizer:  TapGestureRecognizer()..onTap = () => viewMore(),
                       ),
                     ],
                   ),
                 ),
               )
            ],
          ),

          const SizedBox(height: 17,),

          IgnorePointer(
            ignoring: !isChecked,
            child: CustomButton(
              backGroundColor: !isChecked ? AppColors.lightBlue100 : AppColors.primaryColor,
              onTap: (){

            }, label: 'Confirm',
            ),
          ),

          const SizedBox(height: 17,),
        ],
      ),
    );
  }

   Color getColor(Set<MaterialState> states) {
     const Set<MaterialState> interactiveStates = <MaterialState>{
       MaterialState.pressed,
       MaterialState.hovered,
       MaterialState.focused,
     };
     if (states.any(interactiveStates.contains)) {
       return AppColors.primaryColor200;
     }
     return AppColors.lightBlack;
   }

   viewMore(){
     showModalBottomSheet(
         context: context,
         isScrollControlled: true,
         backgroundColor: AppColors.transparent,
         builder: (_) {
         return DraggableScrollableSheet(
           builder: (BuildContext context, myscrollController) {
             return ViewMore(myscrollController:myscrollController);
           },
         );
       }
     );
   }
}

class IntroductionHeader extends StatelessWidget {
  final String title;
  final String subTitle;
  const IntroductionHeader({Key? key, required this.title,required this.subTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24,),
      child: Column(
        children:  [
          const SizedBox(height: 24,),

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

          const SizedBox(height: 12,),

          Text(subTitle,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: const TextStyle(
                  color:AppColors.lightGray100,
                  fontSize: 14,
                  letterSpacing: 0.6
              )),
        ],
      ),
    );
  }
}
