import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';

class NoData extends StatelessWidget {
  final String? text;
  const NoData({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        180.verticalSpace,
        const Icon(
            Icons.shopping_cart_outlined,
          size: 104,
        ),
        20.verticalSpace,
        Text(text ?? 'No Data', style: context.textTheme.displayMedium),
      ],
    );
  }
}
