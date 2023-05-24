import 'package:buisness_card/controller/feedback_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AddFeedBack extends StatefulWidget {
  String businessUUid;
  AddFeedBack({Key? key,required this.businessUUid}) : super(key: key);

  @override
  State<AddFeedBack> createState() => _AddFeedBackState();
}

class _AddFeedBackState extends State<AddFeedBack> {
  var controller = Get.put(FeedBackController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add FeedBacks')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: [
            Text("Name"),
            TextFormField(
              controller: controller.nameController,
            ),
            SizedBox(
              height: 20,
            ),
            Text("Comment"),
            TextFormField(
              maxLines: 5,
              controller: controller.commentController,
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              height: 45,
              onPressed: () {
                controller.addFeedback(widget.businessUUid);
              },
              child: Text("Submit"),
              color: Colors.blue,
              textColor: Colors.white,
            ),
            SizedBox(height: 10,),
            Obx(() => controller.isLoading == true? Center(child: CircularProgressIndicator()):SizedBox())
          ],
        ),
      ),
    );
  }
}
