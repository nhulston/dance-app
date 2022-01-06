import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerificationCode extends StatefulWidget {
  final ValueChanged<String> onCompleted;
  final ValueChanged<bool> onEditing;
  final TextInputType keyboardType;
  final int length;
  final double itemSize;
  final Color? underlineColor;
  final Color? underlineUnfocusedColor;
  final Color? fillColor;
  final double? underlineWidth;
  final TextStyle textStyle;
  final bool autofocus;
  final Widget? clearAll;
  final bool isSecure;
  final bool digitsOnly;

  const VerificationCode({
    Key? key,
    required this.onCompleted,
    required this.onEditing,
    this.keyboardType = TextInputType.number,
    this.length = 4,
    this.itemSize = 50,
    this.underlineColor,
    this.underlineUnfocusedColor,
    this.fillColor,
    this.underlineWidth,
    this.textStyle = const TextStyle(fontSize: 25.0),
    this.autofocus = false,
    this.clearAll,
    this.isSecure = false,
    this.digitsOnly = false,
  }) : super(key: key);

  @override
  _VerificationCodeState createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode> {
  final List<FocusNode> _listFocusNode = <FocusNode>[];
  final List<FocusNode> _listFocusNodeKeyListener = <FocusNode>[];
  final List<TextEditingController> _listControllerText =
  <TextEditingController>[];
  final List<String> _code = [];
  int _currentIndex = 0;

  @override
  void initState() {
    _listFocusNode.clear();
    _listFocusNodeKeyListener.clear();
    for (var i = 0; i < widget.length; i++) {
      _listFocusNode.add(FocusNode());
      _listFocusNodeKeyListener.add(FocusNode());
      _listControllerText.add(TextEditingController());
      _code.add('');
    }
    super.initState();
  }

  String _getInputVerify() {
    String verifyCode = '';
    for (var i = 0; i < widget.length; i++) {
      for (var index = 0; index < _listControllerText[i].text.length; index++) {
        if (_listControllerText[i].text[index] != '') {
          verifyCode += _listControllerText[i].text[index];
        }
      }
    }
    return verifyCode;
  }

  Widget _buildInputItem(int index) {
    return RawKeyboardListener(
      focusNode: _listFocusNodeKeyListener[index],
      onKey: (event) {
        if (event.runtimeType == RawKeyUpEvent) {
          if (event.data.logicalKey == LogicalKeyboardKey.arrowLeft) {
            _prev(index);
          } else if (event.data.logicalKey == LogicalKeyboardKey.arrowRight) {
            _next(index);
          }
        }
      },
      child: TextField(
        cursorColor: Colors.transparent,
        cursorWidth: 0,
        enableInteractiveSelection: false,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.digitsOnly
            ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
            : null,
        maxLines: 1,
        controller: _listControllerText[index],
        focusNode: _listFocusNode[index],
        showCursor: false,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        autocorrect: false,
        textAlign: TextAlign.center,
        autofocus: widget.autofocus,
        style: widget.textStyle,
        decoration: InputDecoration(
          fillColor: widget.fillColor,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: widget.underlineUnfocusedColor ?? Colors.grey,
              width: widget.underlineWidth ?? 1,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: widget.underlineColor ?? Theme.of(context).primaryColor,
              width: widget.underlineWidth ?? 1,
            ),
          ),
          counterText: '',
          contentPadding: EdgeInsets.all(((widget.itemSize * 2) / 10)),
          errorMaxLines: 1,
        ),
        onChanged: (String value) {
          if ((_currentIndex + 1) == widget.length && value.isNotEmpty) {
            widget.onEditing(false);
          } else {
            widget.onEditing(true);
          }

          if (value.isNotEmpty) {
            _listControllerText[index].text = value[value.length - 1];
            if (index < widget.length) _next(index);

            if (_listControllerText[widget.length - 1].value.text.length == 1 &&
                _getInputVerify().length == widget.length) {
              widget.onEditing(false);
              widget.onCompleted(_getInputVerify());
            }
          }
        },
      ),
    );
  }

  void _next(int index) {
    setState(() {
      _currentIndex = index + 1;
    });
    if (_currentIndex < widget.length) {
      FocusScope.of(context).requestFocus(_listFocusNode[_currentIndex]);
    } else {
      FocusScope.of(context).unfocus();
    }
  }

  void _prev(int index) {
    if (index > 0) {
      setState(() {
        if (_listControllerText[index].text.isEmpty) {}
        _currentIndex = index - 1;
      });
      FocusScope.of(context).unfocus();
      FocusScope.of(context).requestFocus(_listFocusNode[_currentIndex]);
    }
  }

  List<Widget> _buildListWidget() {
    List<Widget> listWidget = [];
    for (int index = 0; index < widget.length; index++) {
      double left = (index == 0) ? 0.0 : (widget.itemSize / 10);
      listWidget.add(Container(
          height: widget.itemSize,
          width: widget.itemSize,
          margin: EdgeInsets.only(left: left),
          child: _buildInputItem(index)));
    }
    return listWidget;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildListWidget(),
            ),
            widget.clearAll != null
                ? _clearAllWidget(widget.clearAll)
                : Container(),
          ],
        ));
  }

  Widget _clearAllWidget(child) {
    return GestureDetector(
      onTap: () {
        widget.onEditing(true);
        for (var i = 0; i < widget.length; i++) {
          _listControllerText[i].text = '';
        }
        setState(() {
          _currentIndex = 0;
          FocusScope.of(context).requestFocus(_listFocusNode[0]);
        });
      },
      child: child,
    );
  }
}
