
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tshirt_design/app/components/custom_snackbar.dart';
import 'package:tshirt_design/app/data/local/my_shared_pref.dart';
import 'package:tshirt_design/utils/dummy_helper.dart';

import '../components/screen_title.dart';

class Payout extends StatefulWidget {
  const Payout({super.key});

  @override
  State<Payout> createState() => _PayoutState();
}

class _PayoutState extends State<Payout> {
  int total = 0;

  void checkSales(){
    var datetime = MySharedPref.getList('datetime');
    if(datetime.isNotEmpty){
      var hrs = DateTime.now().difference(DateTime.parse(datetime[0])).inHours;
      if(hrs > 68) {
        MySharedPref.setTotal(9);
      }else if(hrs > 44) {
        MySharedPref.setTotal(8);
      }else if(hrs > 23){
        MySharedPref.setTotal(7);
      }else if(hrs > 17){
        MySharedPref.setTotal(6);
      }else if (hrs > 11){
        MySharedPref.setTotal(5);
      }else if(hrs > 7){
        MySharedPref.setTotal(4);
      }else if (hrs > 4){
        MySharedPref.setTotal(3);
      }else if(hrs > 2){
        MySharedPref.setTotal(2);
      }else if (hrs >= 1){
        MySharedPref.setTotal(1);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    checkSales();
    total = MySharedPref.getTotal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  40.verticalSpace,
                const ScreenTitle(
                  title: 'My Payouts',
                  dividerEndIndent: 200,
                ),
                20.verticalSpace,
                  Container(
                    height: 200.h,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: context.theme.primaryColor,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Stack(
                      children: [
                        Center(child: Text(
                          "₹${total*49}",
                          style: context.theme.textTheme.displayLarge?.copyWith(
                              fontSize: 72,color: Colors.white),)),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                              'For requesting payout, you need to have minimum ₹500 balance in your account.',
                              style: context.theme.textTheme.displaySmall?.copyWith(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  20.verticalSpace,
                  Text("Sales History", style: context.theme.textTheme.displayMedium),
                  saleHistory(total),
                ]
              ),
            )
        ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () => CustomSnackBar.showCustomErrorSnackBar(title: 'Error', message: "You don't have enough balance."),
          child: Text("Request Payout",style: context.theme.textTheme.displayMedium?.copyWith(color: Colors.white)),
        ),
      ),
    );
  }
}

Widget saleHistory(int k){
  List<Widget> col = [];
  for(int i = 0; i<k;i++){
    col.add(saleTile(index: i));
  }
  return Column(children: col,);
}

class saleTile extends StatelessWidget {
  int index;
  saleTile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text('${index + 1}',style: context.theme.textTheme.displayMedium?.copyWith(fontSize: 16.sp,)),
      title: Text(DummyHelper.sales[index],style: context.theme.textTheme.displayMedium?.copyWith(fontSize: 16.sp,)),
      trailing: Text('+49',style: context.theme.textTheme.displayMedium?.copyWith(fontSize: 16.sp,)),);
  }
}
