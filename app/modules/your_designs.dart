import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tshirt_design/app/data/local/my_shared_pref.dart';
import 'package:tshirt_design/app/modules/upload_page.dart';

import '../components/no_data.dart';
import '../components/screen_title.dart';

class MyDesigns extends StatefulWidget {
  const MyDesigns({super.key});

  @override
  State<MyDesigns> createState() => _MyDesignsState();
}

class _MyDesignsState extends State<MyDesigns> {
   List<String> productnames = MySharedPref.getList('productnames') ;
   List<String> imagepaths = MySharedPref.getList('imagePaths') ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            30.verticalSpace,
            const ScreenTitle(
              title: 'My Designs',
              dividerEndIndent: 200,
            ),
            20.verticalSpace,
            productnames.isNotEmpty
                ? GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15.w,
                  mainAxisSpacing: 15.h,
                  mainAxisExtent: 260.h,
                ),
                shrinkWrap: true,
                primary: false,
                itemCount: productnames.length,
                itemBuilder: (context, index) => Items(name: productnames[index], imagepath: imagepaths[index], index: index,)
            )
                : const NoData(text: "Upload your first design!",),
            10.verticalSpace,
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            Navigator
                .push(context, MaterialPageRoute(builder: (context) =>  const UploadPage()));
          },
          child: const Text("Upload your design"),
        ),
      ),
    );
  }
}


class Items extends StatelessWidget {
  String name;
  String imagepath;
  int index;
  Items({Key? key, required this.name, required this.imagepath, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25.r),
            child: Image.file(
                File(imagepath),
              width: double.infinity,
              height: 200.h,
            ),
          ),
          10.verticalSpace,
          Text(name, style: theme.textTheme.bodyMedium),
          5.verticalSpace,
          Text('₹449', style: theme.textTheme.displaySmall),
        ],
      ),
    );
  }
}