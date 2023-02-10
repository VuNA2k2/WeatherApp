import 'package:flutter/material.dart';

import 'colors.dart';

class AppTextTheme {
  static const TextStyle textPageTitle = TextStyle(
    color: AppColor.black,
    overflow: TextOverflow.ellipsis,
    fontWeight: FontWeight.w600,
    fontSize: 18,
    fontFamily: "Lato",
  );

  static const TextStyle textPrimary = TextStyle(
    color: AppColor.black,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    overflow: TextOverflow.ellipsis,
    fontFamily: "Lato",
  );

  static TextStyle textPrimarySmall = TextStyle(
    color: AppColor.black,
    fontWeight: FontWeight.w500,
    fontSize: 12,
    fontFamily: "Lato",
  );

  static TextStyle textPrimarySmallGreen = TextStyle(
    color: AppColor.green,
    fontWeight: FontWeight.w500,
    fontSize: 12,
    fontFamily: "Lato",
  );

  static const TextStyle textPrimaryWhite = TextStyle(
    color: AppColor.white,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    fontFamily: "Lato",
  );

  static const TextStyle textPrimaryGreen = TextStyle(
    color: AppColor.green,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    fontFamily: "Lato",
  );

  static const TextStyle textAppBarPrimary = TextStyle(
    color: AppColor.white,
    overflow: TextOverflow.ellipsis,
    fontWeight: FontWeight.w700,
    fontSize: 17,
    fontFamily: "Lato",
  );

  static const TextStyle textLowPriority = TextStyle(
    color: Color.fromARGB(255, 184, 182, 182),
    overflow: TextOverflow.ellipsis,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    fontFamily: "Lato",
  );

  static const TextStyle textButtonPrimary = TextStyle(
    color: AppColor.white,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    fontFamily: "Lato",
    overflow: TextOverflow.ellipsis,
  );
  static const TextStyle textRed = TextStyle(
    color: AppColor.errorColor,
    overflow: TextOverflow.ellipsis,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    fontFamily: "Lato",
  );
}
