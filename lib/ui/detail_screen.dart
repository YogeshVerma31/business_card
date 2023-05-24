import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'image_preview_screen.dart';

class DetailScreen extends StatefulWidget {
  var businessImage = <dynamic>[];
  var businessAddress;
  var businessContact;
  var businessEmail;
  var businessDescription;
  var businessFeedbacks= <dynamic>[];

  DetailScreen(
      {Key? key,
      required this.businessImage,
      required this.businessAddress,
      required this.businessContact,
      required this.businessDescription,
      required this.businessFeedbacks,
      })
      : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Business Detail"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.businessImage.isEmpty
                ? Image.asset(
                    'images/stockes.jpeg',
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                  )
                : Image.network(
                    'https://businesscards.codvensolutions.com${widget.businessImage[0]['image']}'),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.location_on),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Address",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 40),
              child: Text(
                widget.businessAddress ?? '',
                style: TextStyle(fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.phone),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Contact Number",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 40),
              child: Text(
                widget.businessContact.toString(),
                style: TextStyle(fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.email),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Email Address",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 40),
              child: Text(
                widget.businessEmail ?? '',
                style: TextStyle(fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.my_library_books_rounded),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Description",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.businessDescription ?? '',
                style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Business Images - ",
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            _businessImageLayout(),
            Text(
              "Business FeedBacks - ",
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            _businessFeedbackLayout()
          ],
        ),
      ),
    );
  }

  _businessImageLayout() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.businessImage.length,
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Get.to(ImagePreviewScreen(
                    imageLink:
                    'https://businesscards.codvensolutions.com${widget.businessImage[index]['image']}'));
              },
              child: Image.network(
                  'https://businesscards.codvensolutions.com${widget.businessImage[index]['image']}'),
            ),
          );
        });
  }

  _businessFeedbackLayout() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.businessFeedbacks.length,
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)),
                child: ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: [
                    Text(
                      widget.businessFeedbacks[index]['given_by_name'],
                      style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text( widget.businessFeedbacks[index]['description'],),
                    SizedBox(
                      height: 5,
                    ),
                    Text(widget.businessFeedbacks[index]['created_at'])
                  ],
                ),
              ));
        });
  }
}
