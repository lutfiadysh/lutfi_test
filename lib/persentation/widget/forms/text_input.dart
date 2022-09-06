import 'package:flutter/material.dart';

class NormalTextInput extends StatelessWidget {
  final TextEditingController inputController;
  final String label;
  final String error;
  final bool enableInteractiveSelection;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  final Function(String val) onChange;
  const NormalTextInput({
    Key? key,
    this.enableInteractiveSelection = true,
    this.keyboardType = TextInputType.text,
    this.validator,
    required this.error,
    required this.inputController,
    required this.label,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: key,
      enabled: enableInteractiveSelection,
      enableInteractiveSelection: enableInteractiveSelection,
      onChanged: (val) => val != null ? onChange(val) : null,
      controller: inputController,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.go,
      onSubmitted: (val) {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      decoration: InputDecoration(
        errorText: error != "" ? error : null,
        // errorStyle: MainFonts.primaryTextTheme.copyWith(
        //   fontSize: 14,
        //   fontWeight: FontWeight.w400,
        //   color: MainColors.secondaryRed,
        // ),
        labelText: label,
        // labelStyle: MainFonts.primaryTextTheme.copyWith(
        //   fontSize: 14,
        //   fontWeight: FontWeight.w400,
        //   color: error != ""
        //       ? MainColors.secondaryRed
        //       : inputController.text != ""
        //           ? MainColors.primaryDarkBlue
        //           : MainColors.primaryGrey,
        // ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          // borderSide: const BorderSide(color: MainColors.secondaryRed),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          // borderSide: const BorderSide(color: MainColors.secondaryRed),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          // borderSide: const BorderSide(color: MainColors.primaryDarkBlue),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          // borderSide: BorderSide(
          //     color: inputController.text != ""
          //         ? MainColors.primaryDarkBlue
          //         : MainColors.textFormBorderColor),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          // borderSide: BorderSide(
          //     color: inputController.text != ""
          //         ? MainColors.primaryDarkBlue
          //         : MainColors.textFormBorderColor),
        ),
      ),
    );
  }
}
