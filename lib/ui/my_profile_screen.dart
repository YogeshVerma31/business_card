import 'package:buisness_card/controller/my_profile_controller.dart';
import 'package:buisness_card/ui/image_preview_screen.dart';
import 'package:buisness_card/ui/images_screen.dart';
import 'package:buisness_card/ui/update_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfileScreen extends StatefulWidget {
  bool isProfileCompleted;
  MyProfileScreen({Key? key,required this.isProfileCompleted}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  var controller = Get.put(MyProfileController());

  @override
  void initState() {
    controller.fetchMyProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: const Text("My Profile"),
            leading: widget.isProfileCompleted==true? InkWell(
                onTap: () => Get.back(), child: const Icon(Icons.arrow_back)):SizedBox.shrink(),
            actions: [
              InkWell(
                onTap: () async {
                  var result = await Get.to(ImageScreen(
                    businessModelList:
                        controller.myProfileData.value.business_images!,
                  ));
                  if (result != null) {
                    controller.fetchMyProfile();
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.add),
                ),
              ),
            ]),
        body: Obx(
          () => controller.isLoading.value == true
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    physics: const ScrollPhysics(),
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            "images/stockes.jpeg",
                            height: 70,
                            width: 70,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.myProfileData.value.name ?? '',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(controller.myProfileData.value.mobile_num
                                  .toString()),
                              Text(controller.myProfileData.value.email ?? '')
                            ],
                          )
                        ],
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () async {
                            var result = await Get.to(UpdateProfileScreen(
                              cityValue:
                                  controller.myProfileData.value.city ?? '',
                              stateValue:
                                  controller.myProfileData.value.state ?? '',
                              address:
                                  controller.myProfileData.value.address ?? '',
                              desc:
                                  controller.myProfileData.value.description ??
                                      '',
                            ));
                            if (result != null) {
                              controller.fetchMyProfile();
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            width: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.blue),
                            child: const Center(
                              child: Text(
                                "Edit Profile",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            "State - ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            controller.myProfileData.value.state ?? '',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            "City - ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            controller.myProfileData.value.city ?? '',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Address - ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            controller.myProfileData.value.address ?? '',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Description - ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            controller.myProfileData.value.description ?? '',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Business Category - ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            controller.myProfileData.value.business_category !=
                                    null
                                ? controller.myProfileData.value
                                    .business_category!.name!
                                    .toString()
                                : '',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Business Images - ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _businessImageLayout(),
                      const Text(
                        "Business FeedBacks - ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _businessFeedbackLayout()
                    ],
                  ),
                ),
        ));
  }

  _businessImageLayout() {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount: controller.myProfileData.value.business_images!.length,
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

  _businessFeedbackLayout() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: controller.myProfileData.value.business_feedbacks!.length,
        physics: const ScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)),
                child: ListView(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  children: [
                    Text(
                      controller.myProfileData.value.business_feedbacks![index]
                          .given_by_name!,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(controller.myProfileData.value
                        .business_feedbacks![index].description!),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(controller.myProfileData.value
                        .business_feedbacks![index].created_at!)
                  ],
                ),
              ));
        });
  }
}
