import 'package:buisness_card/controller/images_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/model/my_profile_model.dart';
import '../services/media_services_interface.dart';

import '../utils/styles.dart';
import 'image_preview_screen.dart';

class ImageScreen extends StatefulWidget {
  var businessModelList = <BusinessImagesModel>[];

  ImageScreen({Key? key, required this.businessModelList}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  var controller = Get.put(ImagesController());

  @override
  void initState() {
    controller.fetchMyProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back(result: "jjdjf");
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Add Images"),
          ),
          body: Obx(
            () => controller.isLoading.value == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Your Images",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _previousImages(),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () => {_modalBottomSheetMenu()},
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width * .5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.blue),
                            child: const Text(
                              "Add More Images",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          )),
    );
  }

  _previousImages() {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount: controller.myProfileData.value.business_images?.length,
      physics: const ScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: InkWell(
            onTap: () {
              Get.to(ImagePreviewScreen(
                  imageLink:
                      'https://businesscards.codvensolutions.com${controller.myProfileData.value.business_images![index].image}'));
            },
            child: Image.network(
              'https://businesscards.codvensolutions.com${controller.myProfileData.value.business_images![index].image}',
              fit: BoxFit.fill,
            ),
          ),
        );
      },
    );
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    Get.back();
                    controller.getPhoto(menuOptions.camera, true, context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text("Camera", style: titleStyle),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                    controller.getPhoto(menuOptions.gallery, true, context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text("Gallery", style: titleStyle),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
