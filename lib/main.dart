
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'account_aggregator/view/bank_otp_view.dart';
import 'account_aggregator/view/mandatory_user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) =>  const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MandatoryUser(),
      );
}
