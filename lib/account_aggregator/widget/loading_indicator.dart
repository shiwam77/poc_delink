
import 'dart:math';
import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:flutter/services.dart';
import 'package:poc_delink/account_aggregator/config/theme/colors.dart';
import 'package:sms_autofill/sms_autofill.dart';


class HomePageSmsAutoFill extends StatefulWidget {
  @override
  _HomePageSmsAutoFillState createState() => _HomePageSmsAutoFillState();
}

class _HomePageSmsAutoFillState extends State<HomePageSmsAutoFill> {
  String _code="";
  String signature = "{{ app signature }}";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              PhoneFieldHint(),
              Spacer(),
              PinFieldAutoFill(
                decoration: UnderlineDecoration(
                  textStyle: TextStyle(fontSize: 20, color: Colors.black),
                  colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
                ),
                currentCode: _code,
                onCodeSubmitted: (code) {},
                onCodeChanged: (code) {
                  if (code!.length == 6) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  }
                },
              ),
              Spacer(),
              TextFieldPinAutoFill(
                currentCode: _code,
              ),
              Spacer(),
              ElevatedButton(
                child: Text('Listen for sms code'),
                onPressed: () async {
                  await SmsAutoFill().listenForCode;
                },
              ),
              ElevatedButton(
                child: Text('Set code to 123456'),
                onPressed: () async {
                  setState(() {
                    _code = '123456';
                  });
                },
              ),
              SizedBox(height: 8.0),
              Divider(height: 1.0),
              SizedBox(height: 4.0),
              Text("App Signature : $signature"),
              SizedBox(height: 4.0),
              ElevatedButton(
                child: Text('Get app signature'),
                onPressed: () async {
                  signature = await SmsAutoFill().getAppSignature;
                  setState(() {});
                },
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => CodeAutoFillTestPage()));
                },
                child: Text("Test CodeAutoFill mixin"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CodeAutoFillTestPage extends StatefulWidget {
  @override
  _CodeAutoFillTestPageState createState() => _CodeAutoFillTestPageState();
}

class _CodeAutoFillTestPageState extends State<CodeAutoFillTestPage> with CodeAutoFill {
  String? appSignature;
  String? otpCode;

  @override
  void codeUpdated() {
    setState(() {
      otpCode = code!;
    });
  }

  @override
  void initState() {
    super.initState();
    listenForCode();

    SmsAutoFill().getAppSignature.then((signature) {
      setState(() {
        appSignature = signature;
        print(appSignature);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    cancel();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(fontSize: 18);

    return Scaffold(
      appBar: AppBar(
        title: Text("Listening for code"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
            child: Text(
              "This is the current app signature: $appSignature",
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Builder(
              builder: (_) {
                if (otpCode == null) {
                  return Text("Listening for code...", style: textStyle);
                }
                return Text("Code Received: $otpCode", style: textStyle);
              },
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class Altsmsfill extends StatefulWidget {
  @override
  _AltsmsfillState createState() => _AltsmsfillState();
}

class _AltsmsfillState extends State<Altsmsfill> {
  String? _commingSms = 'Unknown';

  Future<void> initSmsListener() async {
    String? commingSms;
    try {
      commingSms = await AltSmsAutofill().listenForSms;
    } on PlatformException {
      commingSms = 'Failed to get Sms.';
    }
    if (!mounted) return;

    setState(() {
      _commingSms = commingSms;
    });
  }

  @override
  void dispose() {
    AltSmsAutofill().unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AltAutoFill example app'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text('Running on: $_commingSms\n'),
            ),
            TextButton(
              child: Text('Listen for sms code'),
              onPressed: initSmsListener,
            ),
          ],
        ),
      ),
    );
  }
}


class WavingDots extends StatefulWidget {
  final double size;
  final Color color;
  final int time;

  const WavingDots({
    Key? key,
    required this.size,
    required this.color,
    required this.time,
  }) : super(key: key);

  @override
  _WavingDotsState createState() => _WavingDotsState();
}

class _WavingDotsState extends State<WavingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.time),
    )..repeat();
  }

  Widget _buildDot(
      {required Offset begin,
        required Offset end,
        required Interval interval}) =>
      Transform.translate(
        offset: Tween<Offset>(begin: begin, end: end)
            .animate(
          CurvedAnimation(
            parent: _controller,
            curve: interval,
          ),
        )
            .value,
        child: Container(
          width: widget.size / 5,
          height: widget.size / 5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color,
          ),
        ),
      );

  Widget _buildBottomDot({required double begin, required double end}) {
    final double offset = -widget.size / 4;
    return _buildDot(
      begin: Offset.zero,
      end: Offset(0.0, offset),
      interval: Interval(begin, end),
    );
  }

  Widget _buildTopDot({required double begin, required double end}) {
    final double offset = -widget.size / 4;
    return _buildDot(
      begin: Offset(0.0, offset),
      end: Offset.zero,
      interval: Interval(begin, end),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double size = widget.size;
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _controller.value <= 0.50
                    ? _buildBottomDot(begin: 0.12, end: 0.50)
                    : _buildTopDot(begin: 0.62, end: 1.0),
                _controller.value <= 0.44
                    ? _buildBottomDot(begin: 0.06, end: 0.44)
                    : _buildTopDot(begin: 0.56, end: 0.94),
                _controller.value <= 0.38
                    ? _buildBottomDot(begin: 0.0, end: 0.38)
                    : _buildTopDot(begin: 0.50, end: 0.88),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}