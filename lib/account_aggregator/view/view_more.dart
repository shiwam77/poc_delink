

import 'package:flutter/material.dart';
import 'package:poc_delink/account_aggregator/config/theme/colors.dart';

class ViewMore extends StatefulWidget {
  final ScrollController myscrollController;
  const ViewMore({Key? key, required this.myscrollController}) : super(key: key);

  @override
  _ViewMoreState createState() => _ViewMoreState();
}

class _ViewMoreState extends State<ViewMore> {

  Map<String,String> info = {
    "Purpose": "Slice card application",
    "Data requested ": "Profile, summary, transaction",
    "Date range": "10/11/2021 to 10/10/2022",
    "Consent & Recurrence": "1 week validity One time"
  };


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.whiteBackgroundColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight:Radius.circular(25))
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          controller: widget.myscrollController,
          children: [

            Center(
                child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  height: 5,
                  width: 40,
                  decoration: BoxDecoration(
                    color: AppColors.lightGray100.withOpacity(.24),
                    borderRadius: BorderRadius.circular(50)
                  ),
                ),
            )),


            ListView.builder(
              shrinkWrap: true,
              controller: widget.myscrollController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: info.keys.length,
                itemBuilder: (context,index){
                String tittle = info.keys.toList()[index];
                String subTittle = info.values.toList()[index];
              return itemBuilder(tittle,subTittle);
            }),

            const SizedBox(height: 12,),

            const Text(
                "Accounts selected",
                style: TextStyle(
                    color: AppColors.textColorBlue100,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0.4,
                    height: 1.5
                )
            ),

            const SizedBox(height: 5,),

            ListView.builder(
                shrinkWrap: true,
                controller: widget.myscrollController,
                itemCount: info.keys.length,
                itemBuilder: (context,index){
                  String tittle = info.keys.toList()[index];
                  String subTittle = info.values.toList()[index];
                  return const SelectedBankItemBuilder(isSelected: true,);
                }),

          ],
        ),
      ),
    );
  }

  Widget itemBuilder(String title,String subTitle){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
              title,
              style: const TextStyle(
                  color: AppColors.textColorBlue100,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.4,
                  height: 1.5
              )
          ),

           Text(
               subTitle,
              style: const TextStyle(
                color: AppColors.lightBlack,
                fontSize: 12,
                fontWeight: FontWeight.normal,
                letterSpacing: 0.4,
              )
          ),
        ],
      ),
    );
  }

  Widget selectedBankItemBuilder(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        children: [
             InkWell(
               onTap: (){

               },
               child: Container(
                 height: 20,
                 width: 20,
                 alignment: Alignment.center,
                   decoration: const BoxDecoration(
                     color: AppColors.primaryColor100,
                     shape: BoxShape.circle
                   ),
                   child: const Icon(Icons.done,size: 10,color: AppColors.whiteBackgroundColor,)),
             ),
             Row(
               children: [

                 const SizedBox(width: 10,),

                 Text("HDFC",
                   overflow: TextOverflow.ellipsis,
                   style: customTextStyle(),),

                 const SizedBox(width: 8,),

                 const Icon(Icons.circle,size: 4,color: AppColors.lightGray100,),

                 const SizedBox(width: 8,),

                 Text("xx 4212",
                   overflow: TextOverflow.ellipsis,
                   style: customTextStyle(),),

                 const SizedBox(width: 8,),

                 const Icon(Icons.circle,size: 4,color: AppColors.lightGray100,),

                 const SizedBox(width: 8,),

                 Text("xx 4212",
                   overflow: TextOverflow.ellipsis,
                   style: customTextStyle(),),
               ],
             ),
        ],
      ),
    );
  }

  TextStyle customTextStyle([Color color = AppColors.lightGray100,double fontSize = 12,fontWeight = FontWeight.normal,double letterSpacing = .4,]){
    return   TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight:fontWeight,
        letterSpacing:letterSpacing,
    );
  }

}

class SelectedBankItemBuilder extends StatefulWidget {
  final bool isSelected;
  const SelectedBankItemBuilder({Key? key,this.isSelected = true}) : super(key: key);

  @override
  _SelectedBankItemBuilderState createState() => _SelectedBankItemBuilderState();
}

class _SelectedBankItemBuilderState extends State<SelectedBankItemBuilder> {
  late bool isSelected;

  @override
  void initState() {
    isSelected = widget.isSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        children: [
          InkWell(
            onTap: (){
              print(isSelected);
             setState(() {
               isSelected = !isSelected;

             });
            },
            child: Container(
                height: 20,
                width: 20,
                alignment: Alignment.center,
                decoration: !isSelected ? const BoxDecoration(
                    color: AppColors.whiteBackgroundColor,
                    shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2.0,
                    ),],
                )
                    : const BoxDecoration(
                    color: AppColors.primaryColor100,
                    shape: BoxShape.circle
                ),
                child: isSelected ? const Icon(Icons.done,size: 10,color: AppColors.whiteBackgroundColor,) : const SizedBox()),
          ),
          Row(
            children: [

              const SizedBox(width: 10,),

              Text("HDFC",
                overflow: TextOverflow.ellipsis,
                style: customTextStyle(),),

              const SizedBox(width: 8,),

              const Icon(Icons.circle,size: 4,color: AppColors.lightGray100,),

              const SizedBox(width: 8,),

              Text("xx 4212",
                overflow: TextOverflow.ellipsis,
                style: customTextStyle(),),

              const SizedBox(width: 8,),

              const Icon(Icons.circle,size: 4,color: AppColors.lightGray100,),

              const SizedBox(width: 8,),

              Text("xx 4212",
                overflow: TextOverflow.ellipsis,
                style: customTextStyle(),),
            ],
          ),
        ],
      ),
    );
  }

  TextStyle customTextStyle([Color color = AppColors.lightGray100,double fontSize = 12,fontWeight = FontWeight.normal,double letterSpacing = .4,]){
    return   TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight:fontWeight,
      letterSpacing:letterSpacing,
    );
  }

}

