import 'package:liveasy/screens/otp_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:liveasy/widgets/curves.dart';
import 'package:get/get.dart';
import 'package:liveasy/widgets/card_template.dart';
import 'package:liveasy/providerClass/providerData.dart';
import 'package:provider/provider.dart';
import 'package:liveasy/widgets/phone_number_text_field.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/constants/color.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Stack(
            children: [
              OrangeCurve(),
              GreenCurve(),
              CardTemplate(
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                    space_4, 
                    space_16, 
                    space_3, 
                    space_4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome',
                        style: TextStyle(
                          fontSize: size_12,
                          color: lightNavyBlue,
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(
                            space_0, 
                            space_3, 
                            space_0, 
                            space_6),
                          child: Text(
                            'Enter your Phone Number',
                            style: TextStyle(
                              fontSize: size_8,
                              color: lightNavyBlue,
                            ),
                          )),
                          
                      Form(
                          key: _formKey,
                          child: PhoneNumberTextField(),
                      ),
                      
                      Container(
                        width: MediaQuery.of(context).size.width * 0.70,
                        height: space_9,
                        margin: EdgeInsets.fromLTRB(
                          space_8, 
                          space_11, 
                          space_8, 
                          space_0
                          ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(space_10),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: providerData.buttonColor,
                              ),
                              child: Text(
                                'Send OTP',
                                style: TextStyle(
                                  color: white,
                                ),
                              ),
                              onPressed: providerData.inputControllerLengthCheck
                                  ? () {
                                        Get.to(() => NewOTPVerificationScreen(
                                            providerData.phoneController));  

                                            //null safety error here , needs to be resolved
                                      // if (_formKey.currentState!.validate()) {
                                      //   Get.to(() => NewOTPVerificationScreen(
                                      //       providerData.phoneController));    
                                      
                                        providerData.clearall();
                                      } // if
                                    
                                  : () {}),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
