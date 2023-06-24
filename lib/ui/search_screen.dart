import 'package:buisness_card/controller/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common_ui/custom_input_field.dart';
import 'add_feedback_screen.dart';
import 'detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var _searchEditingController = TextEditingController();
  var controller = Get.put(SearchController());
  var isRecentShow = false;

  @override
  void initState() {
    super.initState();
    // controller.fetchRecentSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Search"),
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomInputField(
                  title: 'Search',
                  hint: 'Search',
                  readOnly: false,
                  controller: _searchEditingController,
                  onTextChanged: (value) {
                    controller.fetchRecentSearch();
                    if (value.isNotEmpty)
                      setState(() {
                        isRecentShow = true;
                      });
                    else {
                      setState(() {
                        isRecentShow = false;
                      });
                    }
                  },
                  onSumitted: (value) {
                    controller.fetchSearchBusiness(value);
                    setState(() {
                      isRecentShow = false;
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Obx(() => controller.isLoading.value == true
                    ? const Center(child: CircularProgressIndicator())
                    : Expanded(
                        child: ListView.builder(
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
                            }),
                      ))
              ],
            ),
          ),
          isRecentShow == true
              ? Obx(() => AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    margin: EdgeInsets.only(top: 55, left: 10, right: 10),
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    duration: Duration(milliseconds: 500),
                    child: Wrap(
                      children: controller.recentSearches
                          .map((element) => _recentSearch(element["query"]))
                          .toList(),
                    ),
                  ))
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _recentSearch(String text) {
    return InkWell(
      onTap: () {

        _searchEditingController.text = text;
        controller.fetchSearchBusiness(text);
        setState(() {
          isRecentShow = false;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(right: 10, top: 5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.av_timer_outlined,
              color: Colors.grey,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: Colors.black),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
