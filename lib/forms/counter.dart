import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CountDown extends StatefulWidget {
  const CountDown({Key? key}) : super(key: key);
  static Timer? timer;
  static const maxSeconds = 10;
  static ValueNotifier<int> newSecondsVal = ValueNotifier(maxSeconds);
  @override
  State<CountDown> createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  /*make a counter start from 10 to 0,
   make it circlar  and use circularProgressIndecator in it */
  
  @override
  Widget build(BuildContext context) {
    return Text(
            '${CountDown.newSecondsVal.value}',
            style: GoogleFonts.castoro(
              textStyle: const TextStyle(
                fontSize: 60,
              ),
            ),
          );
  }
}