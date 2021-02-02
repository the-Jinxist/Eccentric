
import 'package:flutter/material.dart';
import 'package:game_app/domain/utils/size_config.dart';

class TitleText extends StatelessWidget {

  final String text;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final int maxLines;
  final TextDecoration decoration;

  TitleText({@required this.text, this.fontSize, this.fontWeight, this.textColor, this.textAlign, this.maxLines, this.decoration});

  @override
  Widget build(BuildContext context) {
    return Text(text,
      maxLines: maxLines,
      textAlign: textAlign != null ? textAlign: TextAlign.start,
      style: Theme.of(context).textTheme.headline1
          .copyWith(
            decoration: decoration,
            fontSize: fontSize != null ? SizeConfig().sp(fontSize): 17,
            fontWeight: fontWeight != null ? fontWeight : FontWeight.bold,
            color: textColor != null ? textColor: Theme.of(context).accentColor,
          ),
    );
  }
}

class SubTitleText extends StatelessWidget {

  final String text;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final TextDecoration decoration;

  SubTitleText({@required this.text, this.fontSize, this.fontWeight, this.textColor, this.textAlign, this.decoration});

  @override
  Widget build(BuildContext context) {
    return Text(text,
      textAlign: textAlign != null ? textAlign: TextAlign.start,
      style: Theme.of(context).textTheme.headline2
          .copyWith(
          decoration: decoration,
          fontSize: fontSize != null ? SizeConfig().sp(fontSize): 15,
          fontWeight: fontWeight != null ? fontWeight : FontWeight.normal,
          color: textColor != null ? textColor: Colors.black
      ),
    );
  }
}

class NormalText extends StatelessWidget {

  final String text;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final int maxLines;
  final TextDecoration decoration;

  NormalText({@required this.text, this.fontSize, this.textColor, this.fontWeight, this.textAlign, this.maxLines, this.decoration});

  @override
  Widget build(BuildContext context) {
    return Text(text,
      maxLines: maxLines,
      textAlign: textAlign != null ? textAlign: TextAlign.start,
      style: Theme.of(context).textTheme.bodyText1
          .copyWith(
          decoration: decoration,
          fontSize: fontSize != null ? SizeConfig().sp(fontSize): 14,
          color: textColor != null ? textColor: Theme.of(context).accentColor,
          fontWeight: fontWeight != null ? fontWeight: FontWeight.normal
      ),
    );
  }
}

class AccentText extends StatelessWidget {

  final String text;
  final double fontSize;
  final Color textColor;
  final TextAlign textAlign;
  final TextDecoration decoration;

  AccentText({@required this.text, this.fontSize, this.textColor, this.textAlign, this.decoration});

  @override
  Widget build(BuildContext context) {

    return Text(text,
      textAlign: textAlign != null ? textAlign: TextAlign.start,
      style: Theme.of(context).textTheme.bodyText1
          .copyWith(
          decoration: decoration,
          fontSize: fontSize != null ? SizeConfig().sp(fontSize): 14,
          color: textColor != null ? textColor: Colors.black
      ),
    );
  }
}