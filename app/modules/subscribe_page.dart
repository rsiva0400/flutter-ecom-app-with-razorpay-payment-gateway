import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:get/get.dart';
import 'package:tshirt_design/app/data/local/my_shared_pref.dart';

import '../components/custom_snackbar.dart';

class SubscribePage extends StatefulWidget {
  const SubscribePage({super.key});

  @override
  State<SubscribePage> createState() => _SubscribePageState();
}

class _SubscribePageState extends State<SubscribePage> {

  final Razorpay _razorpay = Razorpay();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    CustomSnackBar.showCustomSnackBar(title: 'Success', message: "Please restart the application.");
    MySharedPref.setPremium(true);
    Navigator.pop(context);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    CustomSnackBar.showCustomErrorSnackBar(title: 'Error', message: "Payment Failed.");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            30.verticalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Become a Seller', style: context.theme.textTheme.displayMedium?.copyWith(
                  fontSize: 24.sp,
                )),
                const Divider(thickness: 3, endIndent: 200,),
              ],
            ),
            20.verticalSpace,
            Text(
                "Earn Rs.49 for each sale and your earnings will be directly deposited to your account",
                textAlign: TextAlign.center,
                style: context.theme.textTheme.displaySmall
            ),
            20.verticalSpace,
            Text(
                "Get your very own brand store today",
                textAlign: TextAlign.center,
                style: context.theme.textTheme.displayMedium
            ),
            Text(
                "@ Rs. 99 for lifetime",
                textAlign: TextAlign.center,
                style: context.theme.textTheme.displayMedium,
            ),
            30.verticalSpace,
            tiles(context, 'Design your own merchandise', 'Create your own style and trend and make money unlimitedly.', Icons.design_services_sharp),
            30.verticalSpace,
            tiles(context, 'Get lifetime membership', 'Zero monthly charges and free storage and markeplace for your design.', Icons.card_membership_sharp),
            30.verticalSpace,
            tiles(context, 'Receive Fast Payout', 'Once you reach withdrawal limit, get paid directly to your account.', Icons.payments_sharp),
            30.verticalSpace,
            tiles(context, 'Membership fee Refund', "If you didn't get any sales in 3 days, we'll refund your membership fee.", Icons.credit_score_sharp),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: (){
            var options = {
              'key': 'rzp_live_s9A6wEk4ZlioCN',
              'amount': 9900,
              'name': 'Shirt Bazaar',
              'description': 'Seller Membership',
              'prefill': {
                'contact': '8888888888',
                'email': 'test@razorpay.com'
              }
            };
            _razorpay.open(options);
          },
          child: const Text("Become a member now!"),
        ),
      ),
    );
  }
}

Widget tiles(BuildContext context,String title, String Subtitle, IconData icon){
  return ListTile(
    contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
    title: Text(title, style: context.theme.textTheme.displayMedium?.copyWith(fontSize: 14.sp)),
    subtitle: Text(
      Subtitle,
      style: context.theme.textTheme.displaySmall?.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w100),
    ),
    leading: CircleAvatar(
      radius: 20.r,
      backgroundColor: context.theme.primaryColor,
      child: Icon(icon),
    ),
    shape: RoundedRectangleBorder(
      side: BorderSide(width: 1, color: context.isDarkMode ? Colors.white : Colors.black),
      borderRadius: BorderRadius.circular(10.r),
    ),
  );
}