import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

class SmsVerificationPage extends StatefulWidget {
  const SmsVerificationPage({Key? key}) : super(key: key);

  @override
  State<SmsVerificationPage> createState() => _SmsVerificationPageState();
}

class _SmsVerificationPageState extends State<SmsVerificationPage>
    with SingleTickerProviderStateMixin {

  AnimationController? _animationController;
  int levelClock = 2 * 5;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(seconds: levelClock));

    _animationController!.forward();

    _listenSmsCode();

    _animationController!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _animationController!.value = 0;
        });
      }
    });
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    _animationController!.dispose();
    super.dispose();
  }

  _listenSmsCode() async {
    await SmsAutoFill().listenForCode();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F4FD),

      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text("Verification"),
                  Text(
                    "We sent you a SMS Code",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "On number: +998993727053",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            Center(
              child: PinFieldAutoFill(
                codeLength: 4,
                autoFocus: true,
                decoration: UnderlineDecoration(
                  lineHeight: 2,
                  lineStrokeCap: StrokeCap.square,
                  bgColorBuilder: PinListenColorBuilder(
                      Colors.green.shade200, Colors.grey.shade200),
                  colorBuilder: const FixedColorBuilder(Colors.transparent),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _animationController!.value == 0
                        ? const Text("Resend code after: ")
                        : InkWell(
                      onTap: () {
                        // Handle resend code button click
                      },
                      child:  Text(
                        "${_animationController!.value}",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Countdown(
                      animation: StepTween(
                        begin: levelClock, // THIS IS A USER ENTERED NUMBER
                        end: 0,
                      ).animate(_animationController!),
                    ),
                  ],
                ),
              ],
            ),
            _buildCountdown(context)
          ],
        ),
      ),
    );
  }
  Widget _buildCountdown(BuildContext context) {
    final countdownValue = _animationController!.value;

    if (countdownValue == 0) {
      return TextButton(
        onPressed: () {
          _animationController!.reset();
          _animationController!.forward();
        },
        child: const Text('Resend'),
      );
    }

    final clockTimer = Duration(seconds: countdownValue.ceil());
    final timerText = '${clockTimer.inMinutes.remainder(60)}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Resend code after: '),
        Countdown(
          animation: StepTween(
            begin: levelClock, // THIS IS A USER ENTERED NUMBER
            end: 0,
          ).animate(_animationController!),
        ),
      ],
    );
  }

}

class Countdown extends AnimatedWidget {
  Countdown({Key? key, required this.animation})
      : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    return Text(
      timerText,
      style: TextStyle(
        fontSize: 18,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
