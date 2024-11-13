import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class CommonAppBar {
  static Widget buildHeader({
    required String title,
}
      ) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF565656),
          ),
        ),
        // Divider(color: Color(0xFF9EA7B3), thickness: 1),
        Gap(10),
      ],
    );
  }

  static Widget buildFooter() {
    return Column(
      children: [
        // Divider(color: Color(0xFF9EA7B3), thickness: 1),
        IconButton(
          icon: SvgPicture.asset('assets/icons/github.svg',
              width: 24, height: 24),
          onPressed: () {},
        ),
        Text(
          'Copyright © Hoowave Memory Editor 2024',
          style: TextStyle(
            color: Color(0xFF565656),
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
