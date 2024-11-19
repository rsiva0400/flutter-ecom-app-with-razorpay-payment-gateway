

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tshirt_design/app/components/custom_snackbar.dart';
import 'package:tshirt_design/app/data/local/my_shared_pref.dart';

import '../components/screen_title.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  String _imagePath = '';
  late TextEditingController _productName;
  late TextEditingController _username;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productName = TextEditingController();
    _username = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            30.verticalSpace,
            const ScreenTitle(
              title: 'Upload Design',
              dividerEndIndent: 200,
            ),
            20.verticalSpace,
            _imagePath == ''
            // upload Image
                ? GestureDetector(
                onTap: () async {
                  await ImagePicker().pickImage(source: ImageSource.gallery).then(
                          (selectedImage) {setState(() => _imagePath = selectedImage!.path);});
                },
                child: Column(
                  children: [
                    const Icon(Icons.upload_file, size: 128,),
                    Text('Tap to upload your design',style: context.theme.textTheme.displaySmall,)
                  ],
                ),)
            // show image and replace button
                : Column(
                  children: [
                    Image(image: FileImage(File(_imagePath))),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () => setState(() => _imagePath=''),
                          child: const Text("Replace image"),
                      ),
                    )
                  ],
                ),

            20.verticalSpace,
            // product name
            TextField(
              controller: _productName,
              decoration: const InputDecoration(
                  hintText: 'Product name',
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2)),
                  border: OutlineInputBorder(borderSide: BorderSide(width: 2))
              ),
            ),

            // user name
            20.verticalSpace,
            TextField(
              controller: _username,
              decoration: const InputDecoration(
                  hintText: 'Your User name',
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2)),
                  border: OutlineInputBorder(borderSide: BorderSide(width: 2))
              ),
            ),
            20.verticalSpace,

          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: (){
            if(_productName.text != '' && _username.text != '' && _imagePath != ''){
              MySharedPref.addToList('productnames', _productName.text);
              MySharedPref.addToList('imagePaths', _imagePath);
              MySharedPref.addToList('datetime', DateTime.now().toString());
              Navigator.pop(context);
            }else{
              CustomSnackBar.showCustomErrorSnackBar(title: 'Error', message: "Please fill the product Details.");
            }
          },
          child: const Text("Add to My Designs"),
        ),
      ),
    );
  }
}
