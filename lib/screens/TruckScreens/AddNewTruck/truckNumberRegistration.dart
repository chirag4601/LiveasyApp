import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/functions/truckApiCalls.dart';
import 'package:liveasy/screens/TruckScreens/AddNewTruck/truckDescriptionScreen.dart';
import 'package:liveasy/widgets/addTruckSubtitleText.dart';
import 'package:liveasy/widgets/Header.dart';
import 'package:liveasy/widgets/buttons/mediumSizedButton.dart';
import 'package:provider/provider.dart';
import 'package:liveasy/providerClass/providerData.dart';
import 'package:liveasy/functions/driverApiCalls.dart';

//TODO: loading widget while post executes
class AddNewTruck extends StatefulWidget {
  const AddNewTruck({Key? key}) : super(key: key);

  @override
  _AddNewTruckState createState() => _AddNewTruckState();
}

class _AddNewTruckState extends State<AddNewTruck> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _controller = TextEditingController();
  TruckApiCalls truckApiCalls = TruckApiCalls();
  DriverApiCalls driverApiCalls = DriverApiCalls();

  String? truckId;
  RegExp truckNoRegex = RegExp(
      r"^[A-Za-z]{2}[ -/]{0,1}[0-9]{1,2}[ -/]{0,1}(?:[A-Za-z]{0,1})[ -/]{0,1}[A-Za-z]{0,2}[ -/]{0,1}[0-9]{4}$");

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);

    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(space_4, space_4, space_4, space_10),
        color: backgroundColor,
        child: SafeArea(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(
                  backButton: true,
                  text: 'Add Truck',
                  reset: true,
                  resetFunction: () {
                    _controller.text = '';
                    providerData.resetTruckNumber();
                    providerData.updateResetActive(false);
                  },
                ),
                SizedBox(
                  height: space_2,
                ),
                AddTruckSubtitleText(text: 'Truck Number'),
                //TODO: apply shadows to textformfield
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: space_6),
                    margin: EdgeInsets.symmetric(vertical: space_4),
                    height: space_8,
                    child: TextFormField(
                      onChanged: (value) {
                        if (_controller.text != value.toUpperCase())
                          _controller.value = _controller.value
                              .copyWith(text: value.toUpperCase());
                        if (truckNoRegex.hasMatch(value)) {
                          providerData.updateResetActive(true);
                        } else {
                          providerData.updateResetActive(false);
                        }
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.allow(
                            RegExp(r"[a-zA-Z0-9]")),
                      ],
                      textCapitalization: TextCapitalization.characters,
                      controller: _controller,
                      // textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: space_2),
                        filled: true,
                        fillColor: whiteBackgroundColor,
                        hintText: 'Eg: UP 22 GK 2222',
                        hintStyle: TextStyle(
                          fontWeight: boldWeight,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            color: unselectedGrey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            color: unselectedGrey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: MediumSizedButton(
                        text: 'Next',
                        optional: false,
                        onPressedFunction: providerData.resetActive
                            ? () async {
                                providerData
                                    .updateTruckNumberValue(_controller.text);

                                truckId = await truckApiCalls.postTruckData(
                                    truckNo: _controller.text);

                                if (truckId != null) {
                                  // driverApiCalls.getDriversByTransporterId();
                                  providerData.updateResetActive(false);
                                  Get.to(
                                      () => TruckDescriptionScreen(truckId!));
                                } else {
                                  Get.snackbar(
                                      'Enter Correct truck Number', '');
                                }
                              }
                            : () {
                                Get.snackbar('Enter Correct truck Number', '');
                              }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
