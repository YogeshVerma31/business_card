import 'package:buisness_card/ui/select_city_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common_ui/custom_input_field.dart';
import '../controller/home_controller.dart';
import '../data/model/categories_model.dart';

class UpdateProfileScreen extends StatefulWidget {
  var countryValue;
  var stateValue;
  var cityValue;
  var address;
  var desc;

  UpdateProfileScreen(
      {Key? key,
      this.countryValue,
      this.stateValue,
      this.cityValue,
      this.address,
      this.desc})
      : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  var controller = Get.put(HomeController());
  var addressController = TextEditingController();
  var descController = TextEditingController();

  @override
  void initState() {
    controller.fetchCategories();
    addressController.text = widget.address ?? '';
    descController.text = widget.desc ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back(result: "kjfkdf");
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Update Profile"),
        ),
        body: Obx(
          () => controller.isLoading.value == true
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  children: [
                    SelectState(
                      onCountryChanged: (value) {
                        setState(() {
                          widget.countryValue = value;
                        });
                      },
                      onStateChanged: (value) {
                        setState(() {
                          widget.stateValue = value;
                        });
                      },
                      onCityChanged: (value) {
                        setState(() {
                          widget.cityValue = value;
                        });
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: .5),
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.all(10),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        underline: Container(),
                        items: controller.categoriesData.value.data
                            ?.map((CategoriesData dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem.name,
                            child: Text(dropDownStringItem.name!),
                          );
                        }).toList(),
                        onChanged: (value) => setState(() {
                          controller.selectCategories.value = value!;
                        }),
                        value: controller.selectCategories.value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: CustomInputField(
                          controller: addressController,
                          title: "Address",
                          hint: "Enter Your Address",
                          readOnly: false),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: CustomInputField(
                          controller: descController,
                          title: "Description",
                          hint: "Enter Your Description",
                          readOnly: false),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () => controller.updateProfile(
                            widget.stateValue,
                            widget.cityValue,
                            addressController.text,
                            descController.text),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.blue),
                          child: const Center(
                            child: Text(
                              "Update Profile",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
