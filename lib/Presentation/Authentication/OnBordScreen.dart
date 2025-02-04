import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transporter/Presentation/Routes/routes_strings.dart';
import 'package:transporter/Presentation/Utils/color_constants.dart';

class OnBordingScreen extends StatelessWidget {
  const OnBordingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: OnBoardingSlider(
          finishButtonStyle: FinishButtonStyle(
            backgroundColor: ColorConstants.primaryColorVendor,
          ),
          finishButtonText: 'लॉगिन',
          onFinish: () => context.go('/login'),
          skipTextButton: Text(
            'छोड़ना',
            style: TextStyle(
              fontSize: 16,
              color: ColorConstants.primaryColorVendor,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: Text(
            'रजिस्टर',
            style: TextStyle(
              fontSize: 16,
              color: ColorConstants.primaryColorVendor,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailingFunction: () => context.goNamed(RoutesStrings.register),
          controllerColor: ColorConstants.primaryColorVendor,
          totalPage: 3,
          headerBackgroundColor: Colors.white,
          pageBackgroundColor: Colors.white,
          background: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: Image.asset(
                'assets/GASRRTYSe6n-unscreen.gif',
                alignment: Alignment.centerRight,
                color: ColorConstants.primaryColorVendor,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: Image.network(
                'https://media.licdn.com/dms/image/D4E12AQFptZ2Hc-X9bA/article-cover_image-shrink_600_2000/0/1702405223824?e=2147483647&v=beta&t=WKAC5wlyOchaO9Dt9JMgLvtSq_cooODdtoBZYXNHPBA',
                alignment: Alignment.centerRight,
              ),
            ),
            SizedBox(
              // height: MediaQuery.of(context).size.height / 2,
              child: Image.network(
                'https://cdn.dribbble.com/users/143127/screenshots/2475556/truck-animation.gif',
                alignment: Alignment.centerRight,
              ),
            ),
          ],
          speed: 1.2,
          pageBodies: [
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                  ),
                  Row(
                    children: [
                      Expanded(child: Divider()),
                      Text(
                        '  स्वागत है!  ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ColorConstants.primaryColorVendor,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'इस ऐप के माध्यम से आपका सफर अब और भी आसान और सुरक्षित होगा।',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'इस ऐप के माध्यम से आप तुरंत किराया प्राप्त कर सकते है।',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                  ),
                  Text(
                    'शुरू करें!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorConstants.primaryColorVendor,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'हमारा ऐप आपको और भी बेहतर सेवा देने के लिए तैयार है\nइस ऐप के माध्यम से आप बुकिंग और व्यापार  को बढ़ा सकते  है',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '',
                    style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ],
        ));
    // );
  }
}
