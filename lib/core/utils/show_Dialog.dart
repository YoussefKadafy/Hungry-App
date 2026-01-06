import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/shared/custom_button.dart';
import 'package:hungry/core/utils/sized_box_extension.dart';

Future<void> showSuccessDialog(
  BuildContext parentContext, {
  void Function()? confirmPressed,
  String? title,
}) async {
  showDialog(
    barrierDismissible: false,
    context: parentContext,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: SizedBox(
          height: 334.h,
          width: 341.w,
          child: Padding(
            padding: const EdgeInsets.only(top: 24.0, right: 24.0, left: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'Just Pay',
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      8.width,
                      Expanded(
                        child: CustomButton(
                          backgroundColor: Colors.blueAccent,

                          text: 'Pay & Save',
                          onTap: confirmPressed,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
