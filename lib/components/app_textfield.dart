import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:taneo/util/style.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    required this.suggestion,
    required this.focusNode,
    required this.callback,
    required this.editCallback,
    required this.validator,
    required this.controller,
    this.isPassword,
    this.isEmail,
  }) : super(key: key);
  final String suggestion;
  final FocusNode focusNode;
  final VoidCallback callback;
  final VoidCallback editCallback;
  final bool Function(String? s) validator;
  final TextEditingController controller;
  final bool? isPassword;
  final bool? isEmail;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final TextEditingController _controller = TextEditingController();
  bool _tapped = false;

  @override
  Widget build(BuildContext context) {
    final BorderSide borderSide = BorderSide(
      color: _tapped ? (widget.validator(_controller.text) ? Style.success : Style.error) : Style.gray,
      width: _tapped ? 1 : .4,
    );

    return SizedBox(
      width: Style.width * 2 / 3,
      child: TextFormField(
        keyboardType: widget.isEmail == null ? TextInputType.text : TextInputType.emailAddress,
        controller: widget.controller,
        focusNode: widget.focusNode,
        onTap: () {
          setState(() {
            _tapped = true;
            widget.callback();
            FocusScope.of(context).requestFocus(widget.focusNode);
          });
        },
        onChanged: (s) {
          setState(() {
            _controller.text = s;
          });
          widget.editCallback();
        },
        validator: (s) {
          if (!widget.validator(s)) {
            return '';
          }
        },
        obscureText: widget.isPassword != null,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: borderSide,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: borderSide,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: borderSide,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: borderSide,
          ),
          errorStyle: const TextStyle(
            height: 0,
            fontSize: 0,
          ),
          labelText: widget.suggestion,
          labelStyle: TextStyle(
            color: _tapped ? (widget.validator(_controller.text) ? Style.success : Style.error) : Style.gray,
          ),
          contentPadding: const EdgeInsets.fromLTRB(15, 10, 10, 0)
        ),
        // validator: validator,
      ),
    );
  }
}

class SimpleTextField {
  static const OutlineInputBorder _border = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(
      color: Style.black,
      width: .7,
    ),
  );

  static TextFieldConfiguration getTextFieldConfiguration(TextEditingController controller, var editCallback, VoidCallback tapCallback) {
    return TextFieldConfiguration(
      controller: controller,
      onChanged: (s) {
        editCallback();
      },
      onTap: tapCallback,
      decoration: InputDecoration(
          prefixIcon: const Icon(CupertinoIcons.search, color: Style.black),
          suffixIcon: IconButton(
            splashColor: controller.text.isEmpty ? Colors.transparent : null,
            onPressed: () {
              controller.text = '';
              editCallback();
            },
            icon: Visibility(
              visible: controller.text.isNotEmpty,
              child: const Icon(CupertinoIcons.clear, color: Style.black, size: 20)
            ),
          ),
          enabledBorder: _border,
          focusedBorder: _border,
          errorBorder: _border,
          focusedErrorBorder: _border,
          hintText: 'Skill, exercise, or playlist',
          hintStyle: const TextStyle(
            color: Style.black,
          ),
          contentPadding: const EdgeInsets.fromLTRB(15, 10, 10, 0)
      ),
    );
  }
}