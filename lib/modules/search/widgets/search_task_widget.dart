import 'package:flutter/material.dart';

import '../../../../core/values/dimens.dart';
import '../../../../core/values/icons.dart';

class SearchTaskWidget extends StatelessWidget {
  const SearchTaskWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        width: Dimens.infinity,
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  ImageIcon(
                    Image.asset(MyIcons.car).image,
                    size: 26,
                    color: Colors.red,
                  ),
                  const Text(
                    'خودرو',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              const VerticalDivider(
                color: Colors.red,
                thickness: 2,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'تعمیر ماشین',
                    style: TextStyle(
                        color: Colors.red, fontSize: 14),
                  ),
                  Row(
                    children: [
                      ImageIcon(
                    Image.asset(MyIcons.calendar).image,
                        size: 14,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 4.0,
                      ),
                      const Text(
                        '1401/01/01',
                        style: TextStyle(
                            color: Colors.red, fontSize: 12),
                      ),
                      const SizedBox(
                        width: 24.0,
                      ),
                      ImageIcon(
                        Image.asset(MyIcons.clock).image,
                        size: 14,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 4.0,
                      ),
                      const Text(
                        '10:30',
                        style: TextStyle(
                            color: Colors.red, fontSize: 12),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}