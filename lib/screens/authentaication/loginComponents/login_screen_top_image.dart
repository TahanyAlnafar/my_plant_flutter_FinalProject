import 'package:flutter/material.dart';

import '../../../../../../constants.dart';

class LoginScreenTopImage extends StatelessWidget {
  const LoginScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child:
              SizedBox(
                width: 100.0,
                height: 100.0,
                child: Image.asset('assets/images/cactus.png'),
              ),
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}