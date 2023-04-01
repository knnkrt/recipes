import 'package:flutter/material.dart';
import 'package:recipes/app/utils/constants/sizer.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: kWidth30,
        height: kWidth30,
        child: CircularProgressIndicator(
          backgroundColor: Colors.transparent,
          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
          strokeWidth: kWidth3,
        ),
      ),
    );
  }
}
