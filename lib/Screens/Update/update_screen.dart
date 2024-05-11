import 'package:flutter/material.dart';

import '../../components/background.dart';
import '../../responsive.dart';

import 'components/new_btn.dart';
import 'components/update_image.dart';


class NewScreen extends StatelessWidget {
  const NewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Background(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Responsive(
            desktop: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: UpdateImage(),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 450,
                        child: NewBtn(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            mobile: MobileNewScreen(),
          ),
        ),
      ),
    );
  }
}

class MobileNewScreen extends StatelessWidget {
  const MobileNewScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        UpdateImage(),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: NewBtn(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
