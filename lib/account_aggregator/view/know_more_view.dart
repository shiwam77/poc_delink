

import 'package:flutter/material.dart';
import 'package:poc_delink/account_aggregator/config/theme/colors.dart';
import 'package:poc_delink/account_aggregator/widget/loading_indicator.dart';

class KnowMore extends StatefulWidget {
  const KnowMore({Key? key}) : super(key: key);

  @override
  _KnowMoreState createState() => _KnowMoreState();
}

class _KnowMoreState extends State<KnowMore> {
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

                const SizedBox(
                  height: 24,
                ),

                Row(
                  children:  [
                    InkWell(
                        onTap: (){

                        },
                        child: const Icon(Icons.close,color: AppColors.lightGray100,size: 22,)),
                    const SizedBox(
                      width: 24,
                    ),
                    const Text("list of supported banks",
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        maxLines: 1,
                        style: TextStyle(
                            color: AppColors.textColorBlue100,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.04
                        )),
                  ],
                ),

                const SizedBox(
                  height: 24,
                ),

                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                    itemCount: 50,
                    itemBuilder: (context,index){
                      return itemBuilder();
                    },
                  ),
                ),

                SizedBox(
                  height: 20,
                  child: LoadingIndicator(
                    colors: [AppColors.primaryColor],
                    strokeWidth: 1.0,
                    pathBackgroundColor: Colors.black45 ,
                  ),
                ),

                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ),
      ),
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
                  color: AppColors.primaryColor200,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.2
              )),
        )
      ],
    );
  }

}
