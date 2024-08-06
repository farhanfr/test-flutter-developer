import 'package:flutter/material.dart';
import 'package:test_flutter_developer_enterkomputer/ui/widgets/widgets.dart';
import 'package:test_flutter_developer_enterkomputer/utils/colors.dart';
import 'package:test_flutter_developer_enterkomputer/utils/images.dart';
import 'package:test_flutter_developer_enterkomputer/utils/textstyles.dart';

class EmptyDataWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String labelBtn;
  final void Function()? onClick;

  const EmptyDataWidget({
    Key? key,
    this.title = "Data not found",
    required this.subtitle,
    this.onClick,
    this.labelBtn = "Back",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.fromLTRB(
        _screenWidth * (5 / 100),
        0,
        _screenWidth * (5 / 100),
        _screenWidth * (5 / 100),
      ),
      child: Wrap(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                img_empty_data,
                width: _screenWidth * (60 / 100),
                height: _screenHeight * (30 / 100),
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: _screenWidth * (75 / 100),
                child: Text(
                  title,
                  style: h3.copyWith(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                width: _screenWidth * (75 / 100),
                child: Text(
                  subtitle,
                  style: body1v2,
                  textAlign: TextAlign.center,
                ),
              ),
              onClick != null
                  ? SizedBox(
                      height: 30,
                    )
                  : SizedBox.shrink(),
              onClick != null
                  ? SizedBox(
                      width: _screenWidth * (80 / 100),
                      child: CustomButton.contained(
                        isSmall: true,
                        isUpperCase: false,
                        textColor: white,
                        label: labelBtn,
                        onPressed: onClick,
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}
