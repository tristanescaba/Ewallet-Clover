import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:flutter/material.dart';

class MyDropdownField extends StatefulWidget {
  final String title;
  final String hint;
  final Function(String) onChanged;
  final Function(String) validator;
  final List<String> options;
  String selectedValue;

  MyDropdownField({
    this.title,
    this.hint,
    this.onChanged,
    this.validator,
    this.options,
    this.selectedValue,
  });

  @override
  _MyDropdownFieldState createState() => _MyDropdownFieldState();
}

class _MyDropdownFieldState extends State<MyDropdownField> {
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
          DropdownButtonFormField<String>(
            value: widget.selectedValue,
            hint: widget.hint == null ? SizedBox() : Text(widget.hint),
            onChanged: widget.onChanged,
            validator: widget.validator,
            items: widget.options.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.all(18.0),
              labelStyle: TextStyle(color: kPrimaryColor),
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
          ),
        ],
      ),
    );
  }
}
