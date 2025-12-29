import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension SizeExtensionFull on num {
  SizedBox get height => SizedBox(height: toDouble().h);

  SizedBox get width => SizedBox(width: toDouble().w);

  EdgeInsets get paddingAll => EdgeInsets.all(toDouble().r);

  EdgeInsets get paddingHorizontal =>
      EdgeInsets.symmetric(horizontal: toDouble().w);

  EdgeInsets get paddingVertical =>
      EdgeInsets.symmetric(vertical: toDouble().h);
}
