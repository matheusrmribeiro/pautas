import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({this.textKey, 
    this.keyboardType, 
    this.labelText, 
    this.icon, 
    this.obscureText = false, 
    this.validator, 
    this.onSaved,
    this.onChanged,
    this.onFieldSubmited,
    this.initialValue,
    this.maxLength,
    this.hintText,
    this.controller,
    this.margin,
    this.removeLeftMargin = false,
    this.enabled = true,
    this.textInputAction,
    this.focusNode,
    this.useStyle = true,
    this.textCapitalization = TextCapitalization.none,
    this.decoration,
    this.style,
    this.maxLines = 1});

  final Key textKey;
  final TextInputType keyboardType;
  final String labelText;
  final Widget icon;
  final bool obscureText;
  final FormFieldValidator<String> validator;
  final FormFieldSetter<String> onSaved;
  final FormFieldSetter<String> onFieldSubmited;
  final ValueChanged<String> onChanged;
  final String initialValue;
  final int maxLength;
  final String hintText;
  final TextEditingController controller;
  final EdgeInsetsGeometry margin;
  final bool removeLeftMargin;
  final bool enabled;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final FocusNode focusNode;
  final bool useStyle;
  final InputDecoration decoration;
  final TextStyle style;
  final int maxLines;

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  FocusNode node;

  @override
  void initState() {
    node = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        initialValue: widget.initialValue,
        maxLength: widget.maxLength,
        maxLines: widget.maxLines,
        controller: widget.controller,
        enabled: widget.enabled,
        focusNode: node,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        textCapitalization: widget.textCapitalization,
        key: widget.textKey,
        decoration: widget.decoration,
        style: widget.style,
        obscureText: widget.obscureText,
        validator: widget.validator,
        onSaved: widget.onSaved,
        onChanged: widget.onChanged,
        onFieldSubmitted: ((widget.onFieldSubmited==null)&&(widget.textInputAction==TextInputAction.next)) ? (String value){FocusScope.of(context).nextFocus();} : widget.onFieldSubmited,
      ),
    );
  }
}