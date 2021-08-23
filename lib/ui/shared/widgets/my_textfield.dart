import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatefulWidget {
  final String title;
  final bool autoFocus;
  final String labelText;
  final String hintText;
  final bool dynamicColor;
  final IconData prefixIcon;
  final String prefixText;
  final IconData suffixIcon;
  final String suffixText;
  final int maxLines;
  final int minLines;
  final int maxLength;
  final bool counterVisible;
  final bool filled;
  final bool enabled;
  final bool obscureText;
  final bool amountField;
  final bool accountNumberField;
  final bool enableInteractiveSelection;
  final bool denySpacing;
  final TextAlign textAlign;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final Function onTap;
  final Function(String) onSaved;
  final Function(String) onChanged;
  final Function(String) validator;
  final Function onEditingComplete;
  final Function suffixFunction;
  final List<TextInputFormatter> inputFormatters;
  final FocusNode focusNode;

  MyTextField({
    Key key,
    this.title,
    this.autoFocus = false,
    this.labelText,
    this.hintText,
    this.dynamicColor = true,
    this.prefixIcon,
    this.prefixText,
    this.suffixIcon,
    this.suffixText,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.counterVisible = true,
    this.filled = false,
    this.enabled = true,
    this.obscureText = false,
    this.amountField = false,
    this.accountNumberField = false,
    this.enableInteractiveSelection = true,
    this.denySpacing = true,
    this.textAlign = TextAlign.left,
    this.keyboardType,
    this.textInputAction,
    this.controller,
    this.onTap,
    this.onSaved,
    this.onChanged,
    this.onEditingComplete,
    this.validator,
    this.suffixFunction,
    this.inputFormatters = const [],
    this.focusNode,
  });

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  RegExp validCharChecker = new RegExp(r'^[0-9]+$');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0, left: 2.0),
              child: Text(
                ' ${widget.title}',
                style: TextStyle(
                  fontSize: 15.0,
                  color: kPrimaryColor,
                ),
              ),
            ),
          TextFormField(
            style: TextStyle(fontSize: 17.0),
            autofocus: widget.autoFocus,
            focusNode: widget.focusNode != null ? widget.focusNode : null,
            controller: widget.controller,
            textAlign: widget.textAlign,
            enabled: widget.enabled,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            maxLength: widget.maxLength,
            obscureText: widget.obscureText,
            keyboardType: widget.amountField ? TextInputType.number : widget.keyboardType,
            textInputAction: widget.textInputAction,
            enableInteractiveSelection: widget.amountField ? true : widget.enableInteractiveSelection,
            inputFormatters: widget.amountField
                ? [FilteringTextInputFormatter.allow(new RegExp(r'^[0-9-.]+$'))]
                : widget.denySpacing
                    ? [FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))]
                    : [],
            decoration: InputDecoration(
              counterText: widget.counterVisible ? null : '',
              contentPadding: EdgeInsets.all(18.0),
              filled: widget.filled,
              labelStyle: TextStyle(color: kPrimaryColor),
              labelText: widget.labelText,
              hintText: widget.amountField ? '0.00' : widget.hintText,
              hintStyle: TextStyle(color: Colors.black38),
              prefixIcon: widget.amountField
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        'PHP',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : widget.prefixText != null
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            widget.prefixText,
                            style: TextStyle(
                              color: widget.enabled ? kPrimaryColor : kPrimaryLightColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : widget.prefixIcon != null
                          ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              child: Icon(
                                widget.prefixIcon,
                                size: 25.0,
                                color: kPrimaryColor,
                              ),
                            )
                          : SizedBox(width: 12.0),
              suffixIcon: widget.suffixText != null
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: GestureDetector(
                        onTap: widget.suffixFunction == null ? () {} : widget.suffixFunction,
                        child: Text(
                          widget.suffixText,
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  : widget.suffixIcon != null
                      ? GestureDetector(
                          onTap: widget.suffixFunction == null ? () {} : widget.suffixFunction,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Icon(
                              widget.suffixIcon,
                              size: 25.0,
                              color: kPrimaryColor,
                            ),
                          ),
                        )
                      : SizedBox(),
              isDense: true,
              prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
              suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(color: kPrimaryColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(color: Colors.grey),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(color: kPrimaryLightColor),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(color: Colors.red),
              ),
              errorStyle: TextStyle(
                color: Theme.of(context).errorColor, // or any other color
              ),
            ),
            onTap: widget.onTap,
            onChanged: widget.onChanged,
            onEditingComplete: widget.onEditingComplete,
            validator: widget.validator,
            onSaved: widget.onSaved,
          ),
        ],
      ),
    );
  }
}
