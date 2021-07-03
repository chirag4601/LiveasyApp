import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/spaces.dart';

// ignore: must_be_immutable
class PriceContainer extends StatelessWidget {
  String? rate;
  String? unitValue;

  PriceContainer({ required this.rate, required this.unitValue});

  @override
  Widget build(BuildContext context) {
    unitValue = unitValue == 'PER_TON' ? 'tonne' : 'truck';
    print(rate);
    print(rate.runtimeType);
    return
     Container(
      margin: EdgeInsets.only(left: 10),
      padding: EdgeInsets.all(space_2),
      decoration: BoxDecoration(
          color: lightGrayishBlue,
          borderRadius: BorderRadius.circular(5)),
      // height: 35,
      // width: 110,
      child: Center(
        child: Text(
          "\u20B9$rate/$unitValue",
          style: TextStyle(
              color: darkBlueColor,
              fontWeight: mediumBoldWeight,
              ),
        ),
      ),
    );

  }
}
