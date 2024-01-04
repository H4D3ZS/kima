import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final bool canShow;
  final String? errorText;
  final Function(String?)? onChanged;
  final bool enabled;
  final Color? borderColor;
  final Color? backgroundColor;
  final double? radius;
  final double? height;
  final int? maxLength;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final TextCapitalization? textCapitalization;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hint,
    this.obscure = false,
    this.onChanged,
    this.canShow = false,
    this.enabled = true,
    this.errorText,
    this.borderColor,
    this.radius,
    this.height,
    this.maxLength,
    this.labelStyle,
    this.hintStyle,
    this.backgroundColor,
    this.suffixIcon,
    this.inputFormatters,
    this.focusNode,
    this.textCapitalization,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  var _obscure = false;

  @override
  void initState() {
    super.initState();

    _obscure = widget.obscure;
  }

  void _onObscurePressed() {
    setState(() {
      _obscure = !_obscure;
    });
  }

  bool _hasError() {
    if (widget.errorText != null) {
      return widget.errorText!.isNotEmpty;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius ?? 8.0),
            border: Border.all(
              width: 2,
              color: _hasError() ? const Color(0xFFD92F58) : widget.borderColor ?? const Color(0xFFEBEBEB),
            ),
            color: widget.backgroundColor ?? const Color(0xFFFFFFFF),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
                  controller: widget.controller,
                  focusNode: widget.focusNode,
                  obscureText: _obscure,
                  enabled: widget.enabled,
                  inputFormatters: [...?widget.inputFormatters],
                  maxLines: widget.maxLength ?? 1,
                  style: widget.enabled
                      ? const TextStyle(
                          color: Color(0xFF1E1E1E),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        )
                      : widget.labelStyle ??
                          const TextStyle(
                            color: Color(0xFF757575),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                  cursorColor: const Color(0xFF000000),
                  onChanged: widget.onChanged,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    hintText: widget.hint,
                    hintStyle: widget.hintStyle ??
                        const TextStyle(
                          color: Color(0xFF757575),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    suffixIcon: widget.canShow
                        ? IconButton(
                            onPressed: _onObscurePressed,
                            icon: Icon(
                              _obscure ? Icons.visibility : Icons.visibility_off,
                              color: const Color(0xFF9F9F9F),
                            ),
                          )
                        : null,
                  ),
                ),
              ),
              if (widget.suffixIcon != null) ...[
                widget.suffixIcon!,
                const SizedBox(width: 16.0),
              ]
            ],
          ),
        ),
        if (_hasError()) ...[
          const SizedBox(height: 15.0),
          CustomText(
            widget.errorText!,
            fontColor: const Color(0xFFD92F58),
            fontSize: 15.0,
          ),
        ]
      ],
    );
  }
}
