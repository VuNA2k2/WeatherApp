import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/model/constants.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key, this.backgroundColor}) : super(key: key);

  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.transparent,
        child: const SpinKitCircle(
          color: Constants.primaryColor,
          size: 50,
        ),
      ),
    );
  }
}
