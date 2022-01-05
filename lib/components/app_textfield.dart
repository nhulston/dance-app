import 'package:flutter/material.dart';
import 'package:taneo/style.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    required this.suggestion,
    required this.focusNode,
    required this.callback,
    required this.validator,
    this.isPassword,
  }) : super(key: key);
  final String suggestion;
  final FocusNode focusNode;
  final VoidCallback callback;
  final bool Function(String? s) validator;
  final bool? isPassword;

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
            contentPadding: const EdgeInsets.fromLTRB(15, 10, 10, 0)),
        // validator: validator,
      ),
    );
  }
}
