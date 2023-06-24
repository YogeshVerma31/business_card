import 'package:buisness_card/common_ui/custom_input_field.dart';
import 'package:buisness_card/controller/home_controller.dart';
import 'package:buisness_card/data/sharedPreference/shared_preference.dart';
import 'package:buisness_card/ui/add_feedback_screen.dart';
import 'package:buisness_card/ui/detail_screen.dart';
import 'package:buisness_card/ui/my_profile_screen.dart';
import 'package:buisness_card/ui/search_screen.dart';
import 'package:buisness_card/ui/select_city_state.dart';
import 'package:buisness_card/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/model/categories_model.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var controller = Get.put(HomeController());
  var countryValue;
  var stateValue;
  var cityValue;
  String _selectedState = "Choose Categories";
  bool isFilterShow = false;

  @override
  void initState() {
    controller.fetchMyProfile();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            "ViIndia Card",
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () => Get.offAll(() => MyProfileScreen(
                        isProfileCompleted: true,
                      )),
                  child: const Icon(Icons.person_2_rounded)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    SharedPreference().remove();
                    Get.offAll(LoginScreen());
                  },
                  child: const Icon(Icons.power_settings_new)),
            )
          ],
        ),
        body: Obx(
          () => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                  children: [
                    ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      shrinkWrap: true,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _searchButton(),
                            const SizedBox(
                              width: 10,
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    isFilterShow = true;
                                  });
                                },
                                icon: const Icon(Icons.filter_list))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: controller.business.length,
                            itemBuilder: (context, index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                elevation: 2,
                                child: Column(
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 16 / 9,
                                      child: controller
                                                  .business[index]
                                                      ['business_images']
                                                  .length ==
                                              0
                                          ? Image.asset('images/stockes.jpeg')
                                          : Image.network(
                                              'https://businesscards.codvensolutions.com${controller.business[index]['business_images'][0]['image']}',
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        controller.business[index]['name'] ??
                                            '',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Montserrat',
                                            fontSize: 18),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: MaterialButton(
                                              onPressed: () {
                                                _makePhoneCall(
                                                    'tel:${controller.business[index]['mobile_num']}');
                                              },
                                              color: Colors.blue,
                                              textColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              elevation: 1,
                                              child: const Text("CALL NOW"),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: MaterialButton(
                                              onPressed: () {
                                                Get.to(() => DetailScreen(
                                                      businessImage: controller
                                                              .business[index]
                                                          ['business_images'],
                                                      businessAddress:
                                                          controller.business[
                                                              index]['address'],
                                                      businessContact:
                                                          controller.business[
                                                                  index]
                                                              ['mobile_num'],
                                                      businessDescription:
                                                          controller.business[
                                                                  index]
                                                              ['description'],
                                                      businessFeedbacks: controller
                                                              .business[index][
                                                          'business_feedbacks'],
                                                    ));
                                              },
                                              child: Text("VIEW DETAILS"),
                                              color: Colors.blue,
                                              textColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              elevation: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        Get.to(AddFeedBack(
                                          businessUUid: controller
                                              .business[index]['uuid'],
                                        ));
                                      },
                                      child: Text("FEEDBACK"),
                                      color: Colors.blue,
                                      textColor: Colors.white,
                                    ),
                                  ],
                                ),
                              );
                            })
                      ],
                    ),
                    isFilterShow == true
                        ? Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.cancel),
                                  onPressed: () {
                                    setState(() {
                                      isFilterShow = false;
                                    });
                                  },
                                ),
                                SelectState(
                                  onCountryChanged: (value) {
                                    setState(() {
                                      countryValue = value;
                                    });
                                  },
                                  onStateChanged: (value) {
                                    setState(() {
                                      stateValue = value;
                                    });
                                  },
                                  onCityChanged: (value) {
                                    setState(() {
                                      cityValue = value;
                                    });
                                  },
                                ),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey, width: .5),
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: const EdgeInsets.all(10),
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    underline: Container(),
                                    items: controller.categoriesData.value.data
                                        ?.map((CategoriesData
                                            dropDownStringItem) {
                                      return DropdownMenuItem<String>(
                                        value: dropDownStringItem.name,
                                        child: Text(dropDownStringItem.name!),
                                      );
                                    }).toList(),
                                    onChanged: (value) => setState(() {
                                      controller.selectCategories.value =
                                          value!;
                                    }),
                                    value: controller.selectCategories.value,
                                  ),
                                ),
                                Center(
                                  child: InkWell(
                                    onTap: () {
                                      controller.fetchBusiness(
                                          stateValue,
                                          cityValue,
                                          controller.selectCategories.value);
                                      setState(() {
                                        isFilterShow = false;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.blue),
                                      child: const Text(
                                        "Search Business",
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
                          )
                        : SizedBox.shrink()
                  ],
                ),
        ));
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _searchButton() {
    return InkWell(
      onTap: () => Get.to(() => SearchScreen()),
      child: Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            border: Border.all(color: greyColor50),
            borderRadius: BorderRadius.circular(8)),
        width: MediaQuery.of(context).size.width * .75,
        child: Text(
          "Search",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
