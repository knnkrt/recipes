import 'package:flutter/material.dart';
import 'package:recipes/app/utils/constants/sizer.dart';

class LoadingSecondaryButton extends StatelessWidget {
  const LoadingSecondaryButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: kWidth15, vertical: kHeight12),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.tertiaryContainer),
        ),
        onPressed: null,
        child: SizedBox(
          height: kFontSize16 * 1.3,
          width: kFontSize16 * 1.3,
          child: CircularProgressIndicator(
            backgroundColor: Colors.transparent,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
            strokeWidth: kWidth2,
          ),
        ),
      ),
    );
  }
}
