import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pautas/src/app/theme/colors.dart';
import 'package:pautas/src/app/theme/text_styles.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({this.textKey, 
    this.keyboardType, 
    this.labelText = "", 
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
    this.maxLines = 1,
    this.minLines = 1,
    this.ancestor = 0
    });

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
  final int minLines;
  int ancestor;

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  FocusNode node;

  bool isAncestor = true;
  final double counterTextSize = 40;

  @override
  void initState() {
    node = FocusNode();
    super.initState();

    isAncestor = widget.ancestor == 0;
    if (!isAncestor)
      node.requestFocus();
  }

  @override
  void dispose() {
    node.dispose();
    super.dispose();
  }

  Future<void> _openTextDialog(CustomTextFormField widget) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: AppColors.backgroundColor,
      builder: (BuildContext context) {
        TextStyles textStyle = TextStyles(context: context);

        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            backgroundColor: AppColors.backgroundColor,
            elevation: 0,
            actions: [
              Container(
                height: 20,
                width: 100,
                margin: EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).primaryColor
                    )
                  ),
                  child: Text("Feito",
                    style: textStyle.h2White,
                  ),
                  onPressed: () {
                    widget.onFieldSubmited("");
                  }
                ),
              )
            ],
          ),
          body: Container(
            margin: EdgeInsets.all(10),
            color: AppColors.backgroundColor,
            child: widget..ancestor = 1
          ),
        );
      },
    ).then((value) => widget.ancestor = 0);
  }

  @override
  Widget build(BuildContext context) {
    TextStyles textStyle = TextStyles(context: context);

    double counterSize = ((widget.maxLength == null) || isAncestor) 
      ? 0
      : counterTextSize;

    return Container(
      height: 70.0 
        + (widget.minLines * 20) 
        + counterSize,
      width: double.infinity,
      child: Stack(
        children: [
          (widget.labelText.isEmpty)
            ? Container()
            : Text(widget.labelText.toUpperCase(),
              style: textStyle.customTextFieldLabel
            ),
          Positioned(
            bottom: 0,
            left: (widget.labelText.isEmpty) 
              ? 0 
              : 20,
            right: 0,
            top: 35,
            child: TextFormField(
              onTap: () {
                if (isAncestor) {
                  node.unfocus();
                  _openTextDialog(widget);
                }
              },
              initialValue: widget.initialValue,
              maxLength: (widget.maxLength == null) 
                ? null 
                : (isAncestor) ? null : widget.maxLength,
              maxLines: (isAncestor) 
                ? widget.maxLines
                : 1,
              minLines: (isAncestor)
                ? (widget.minLines == 1) ? null : widget.minLines
                : null,
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
              onFieldSubmitted: ((widget.onFieldSubmited==null)&&(widget.textInputAction==TextInputAction.next)) 
                ? (String value){
                    FocusScope.of(context).nextFocus();
                  } 
                : widget.onFieldSubmited,
            ),
          ),
        ],
      ),
    );
  }
}