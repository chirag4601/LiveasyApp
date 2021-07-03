import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/radius.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/controller/transporterIdController.dart';
import 'package:liveasy/functions/bidApiCalls.dart';
import 'package:liveasy/providerClass/providerData.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class BidButtonSendRequest extends StatelessWidget {
  String? loadId, unitValue, bidId;

  // int? rate;
  bool? isPost;

  BidButtonSendRequest({
    this.loadId,
    // this.rate,
    this.unitValue,
    this.bidId,
    required this.isPost,
  });

  TransporterIdController tIdController = Get.find<TransporterIdController>();

  @override
  Widget build(BuildContext context) {
    ProviderData providerData =
        Provider.of<ProviderData>(context, listen: false);
    return Container(
      margin: EdgeInsets.only(right: space_3),
      height: space_6 + 1,
      width: space_16,
      child: TextButton(
        child: Center(
          child: Text(
            "Bid",
            style: TextStyle(
                color: Colors.white,
                fontWeight: normalWeight,
                fontSize: size_6 + 2),
          ),
        ),
        onPressed: () {
          if (Provider.of<ProviderData>(context, listen: false)
                  .bidButtonSendRequestState ==
              "false") {
            return null;
          } else {
            if (Provider.of<ProviderData>(context, listen: false).rate == "" ||
                Provider.of<ProviderData>(context, listen: false).rate ==
                    null) {
              return null;
            } else {
              // postBidAPi(
              //     loadId,
              //     Provider.of<ProviderData>(context, listen: false).rate,
              //     tIdController.transporterId.value,
              //     unitValue);
              isPost!
                  ? postBidAPi(loadId, providerData.rate,
                      tIdController.transporterId.value, unitValue)
                  : putBidForNegotiate(bidId, providerData.rate, unitValue);

              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Bidding Request Send')));
              providerData.updateRate("");
              providerData.updateBidButtonSendRequest(newValue: "false");
              Navigator.of(context).pop();
            }
          }
        },
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius_4),
            )),
            overlayColor: providerData.bidButtonSendRequestState == "true"
                ? null
                : MaterialStateProperty.all(Colors.transparent),
            backgroundColor: providerData.bidButtonSendRequestState == "true"
                ? activeButtonColor
                : deactiveButtonColor),
      ),
    );
  }
}
