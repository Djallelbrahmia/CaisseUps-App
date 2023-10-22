import 'package:caisseapp/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class TextFieldWidget extends StatefulWidget {
  TextFieldWidget(
      {super.key,
      required this.focusNode,
      required this.textEditingController,
      required this.leftIcon,
      required this.isEnabled,
      required this.validator,
      this.securePassword,
      required this.onEditingComplete,
      this.rightIcon,
      this.hasLeftIcon,
      required this.label});
  FocusNode focusNode;
  TextEditingController textEditingController;
  String leftIcon, label;
  bool? hasLeftIcon = false;
  bool isEnabled = true;
  Function onEditingComplete;
  Function validator;
  bool? securePassword = false;
  Widget? rightIcon;
  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

bool _isEditing = false;

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      setState(() {
        _isEditing = widget.focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.fromLTRB(4, 0, 0, 11),
              child: TextWidget(
                isBold: false,
                isHeader: false,
                textSize: 12,
                text: widget.label,
              )),
          Container(
            padding: const EdgeInsets.fromLTRB(4, 7, 4, 6),
            width: double.infinity,
            height: 64,
            decoration: BoxDecoration(
              color: widget.isEnabled
                  ? Colors.white
                  : const Color.fromARGB(255, 190, 144, 226).withOpacity(0.6),
              border: Border.all(
                  color: _isEditing
                      ? const Color(0Xff4B0082)
                      : const Color(0xffA84FEA)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                  visible: widget.hasLeftIcon ?? true,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                    width: 24,
                    height: 24,
                    child: Image.asset(
                      widget.leftIcon,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: double.infinity,
                      child: Center(
                        child: Focus(
                          onFocusChange: (hasFocus) {
                            setState(() {
                              _isEditing = hasFocus;
                            });
                          },
                          focusNode: widget.focusNode,
                          child: TextFormField(
                            obscureText: widget.securePassword ?? false,
                            onEditingComplete: widget.onEditingComplete(),
                            enabled: widget.isEnabled,
                            controller: widget.textEditingController,
                            validator: widget.validator(),
                            decoration: InputDecoration(
                              labelStyle: GoogleFonts.playfairDisplay(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                              hintStyle: GoogleFonts.playfairDisplay(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                widget.rightIcon ?? const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
