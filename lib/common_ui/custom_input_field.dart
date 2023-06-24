import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/color.dart';
import '../utils/styles.dart';

class CustomInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  final bool readOnly;
  final Color? labelColor;
  final bool? obscureText;
  final Function()? onTap;
  final int? maxLength;
  final TextInputType? textInputType;
  final Function(String)? onTextChanged;
  final Function(String)? onSumitted;

  const CustomInputField(
      {Key? key,
      required this.title,
      required this.hint,
      required this.readOnly,
      this.onTap,
      this.maxLength,
      this.textInputType,
      this.controller,
      this.widget,
      this.onTextChanged,
      this.onSumitted,
      this.obscureText,
      this.labelColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 47,
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.only(left: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: borderColor, width: 1.0),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  readOnly: readOnly,
                  autofocus: false,
                  cursorColor: Colors.black,
                  onChanged: onTextChanged,
                  onSubmitted: onSumitted,
                  controller: controller,
                  maxLength: maxLength,
                  keyboardType: textInputType,
                  obscureText: obscureText ?? false,
                  style: subtitleStyle.copyWith(color: Colors.black),
                  decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: subtitleStyle,
                      counterText: "",
                      focusedBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: borderColor, width: 0)),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: borderColor, width: 0))),
                )),
                widget == null
                    ? Container()
                    : Container(
                        child: widget,
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
