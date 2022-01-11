
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'account_aggregator/view/know_more_view.dart';
import 'account_aggregator/view/mandatory_user.dart';
import 'account_aggregator/view/no_bank_account_view.dart';
import 'account_aggregator/view/poc.dart';
import 'account_aggregator/widget/loading_indicator.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) =>  const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MandatoryUser(),
      );
}
