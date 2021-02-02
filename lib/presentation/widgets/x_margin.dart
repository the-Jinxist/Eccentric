import 'package:flutter/material.dart';
import 'package:game_app/domain/utils/size_config.dart';

class XMargin extends StatelessWidget {

  final double width;

  XMargin(this.width);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig().sw(width),
    );
  }
}
