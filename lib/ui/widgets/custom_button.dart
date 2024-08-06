
import 'package:flutter/material.dart';
import 'package:test_flutter_developer_enterkomputer/utils/colors.dart';
import 'package:test_flutter_developer_enterkomputer/utils/textstyles.dart';


class CustomButton extends StatelessWidget {
  final String? label;
  final VoidCallback? onPressed;
  final Color? color;
  final bool disabled;
  final bool isUpperCase;
  final Widget? leading;
  final bool _isContained;
  final Color? textColor;
  final double? elevation;
  final bool isCompact;
  final bool isSmall;
  final bool isLoading;
  final Color? hoverColor;
  final Color? splashColor;
  final Color? highlightColor;
  final double? borderRadius;

  CustomButton.contained({
    Key? key,
    @required this.label,
    @required this.onPressed,
    this.color,
    this.disabled = false,
    this.isUpperCase = true,
    this.textColor,
    this.elevation = 4,
    this.isCompact = false,
    this.isSmall = false,
    this.isLoading = false,
    this.hoverColor,
    this.splashColor,
    this.highlightColor,
    this.leading,
    this.borderRadius = 36,
  })  : this._isContained = true,
        super(key: key);

  CustomButton.outlined(
      {Key? key,
      @required this.label,
      @required this.onPressed,
      this.color,
      this.disabled = false,
      this.isUpperCase = true,
      this.leading,
      this.textColor,
      this.elevation,
      this.isCompact = false,
      this.isSmall = false,
      this.isLoading = false,
      this.hoverColor,
      this.splashColor,
      this.highlightColor,
      this.borderRadius})
      : this._isContained = false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color buildColor = color ?? Theme.of(context).primaryColor;

    return _isContained
        ? buildContained(buildColor)
        : buildOutlined(buildColor, leading);
  }

  ElevatedButton buildContained(Color buildColor) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled))
              return roundedButtonDisabled;
            return buildColor;
          },
        ),
        overlayColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.hovered)) return hoverColor;
            if (states.contains(MaterialState.pressed)) return splashColor;
            return null;
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.disabled)) return textSecondary!;
            return textColor;
          },
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius!)),
        ),
        padding: MaterialStateProperty.all(
          EdgeInsets.all(0.0),
        ),
        shadowColor: MaterialStateProperty.resolveWith(
          (states) {
            return Colors.black38;
          },
        ),
        elevation: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.disabled)) return 0;
            if (states.contains(MaterialState.pressed)) return 1;
            return this.elevation;
          },
        ),
      ),
      onPressed: disabled || isLoading ? null : onPressed,
      child: Container(
        margin: isCompact
            ? const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
            : const EdgeInsets.all(12),
        child: Center(
          child: Container(

            child: !isLoading
                ? Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      leading ?? SizedBox.shrink(),
                      leading != null
                          ? SizedBox(
                              width: 6,
                            )
                          : SizedBox.shrink(),
                      Text(
                        isUpperCase ? label!.toUpperCase() : label!,
                        style: caption.copyWith(
                            color: textColor ?? white,
                            letterSpacing: isUpperCase ? 1.25 : 0,
                            fontSize: isSmall ? 14 : 15,
                            fontWeight: disabled || onPressed == null
                                ? FontWeight.w500
                                : FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                : SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(buildColor),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget buildOutlined(Color buildColor, Widget? leading) {
    var text = Text(
      isUpperCase ? label!.toUpperCase() : label!,
      style: caption.copyWith(
        color: disabled || onPressed == null
            ? Colors.grey[400]
            : textColor ?? buildColor,
        fontSize: isSmall ? 14 : 15,
        fontWeight:
            disabled || onPressed == null ? FontWeight.w500 : FontWeight.w600,
      ),
      textAlign: TextAlign.center,
    );
    return OutlinedButton(
      onPressed: disabled ? null : onPressed,
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.hovered)) return hoverColor;
            if (states.contains(MaterialState.pressed)) return splashColor;
            return Colors.transparent;
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.disabled)) return textSecondary;
            return textColor;
          },
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        ),
        padding: MaterialStateProperty.all(
          EdgeInsets.all(0.0),
        ),
        shadowColor: MaterialStateProperty.resolveWith(
          (states) {
            return Colors.black38;
          },
        ),
        side: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled))
            return BorderSide(color: roundedButtonDisabled, width: 2);
          return BorderSide(color: buildColor, width: 1);
        }),
        elevation: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.disabled)) return 0;
            if (states.contains(MaterialState.pressed)) return 1;
            return this.elevation;
          },
        ),
      ),
      child: Stack(
        children: [
          Container(
            margin: isCompact
                ? const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
                : const EdgeInsets.all(12),
            child: Center(
              child: Container(
                child: !isLoading
                    ? Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          leading != null ? leading : SizedBox.shrink(),
                          leading != null
                              ? SizedBox(
                                  width: 6,
                                )
                              : SizedBox.shrink(),
                          text,
                        ],
                      )
                    : Opacity(opacity: 0, child: text),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              child: isLoading
                  ? Center(
                      child: SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(
                          valueColor:
                               AlwaysStoppedAnimation<Color>(buildColor),
                        ),
                      ),
                    )
                  : SizedBox(),
            ),
          )
        ],
      ),
    );
  }
}
