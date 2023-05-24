import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ImagePreviewScreen extends StatefulWidget {
  String imageLink;

  ImagePreviewScreen({Key? key, required this.imageLink}) : super(key: key);

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(''),
        elevation: 0.0,
        leading: IconButton(
            icon: const Icon(
              Icons.chevron_left_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Container(
        color: Colors.black,
        child: Center(child: Image.network(widget.imageLink)),
      ),
    );
  }
}
