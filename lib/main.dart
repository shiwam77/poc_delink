
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poc_delink/data.dart';
import 'package:poc_delink/model/bank.dart';
import 'package:poc_delink/utils.dart';
import 'package:poc_delink/widget/dismissible_widget.dart';

import 'account_aggregator/view/mandatory_user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const MandatoryUser(),
      );
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);



  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<BankName> items = List.of(Data.chats);

  @override
  Widget build(BuildContext context) => Scaffold(

        body: Scaffold(

          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16,),

                const Text("Link your bank account",
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 1,
                    style: TextStyle(
                        color: Color(0xFF363648),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.6
                    )),

                const SizedBox(height: 8,),

                const Text("Please confirm to submit your details",
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 1,
                    style: TextStyle(
                        color: Color(0xFF8795A7),
                        fontSize: 14,
                        letterSpacing: 0.6
                    )),

                const SizedBox(height: 16,),

                Expanded(
                  child: ListView.builder(
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
                  ),
                ),
              ],
            ),
          ),
        ),
      );

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

  Widget buildListTiled(BankName item) => ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        leading: CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(item.urlAvatar),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(item.accountNumber)
          ],
        ),
        onTap: () {},
      );

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
}
