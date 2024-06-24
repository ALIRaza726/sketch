
import 'package:flutter/material.dart';
import 'package:sketch/models/video_cal_const.dart';
import 'package:sketch/screen/login.dart';
import 'package:sketch/screen/login_cal.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallPage extends StatelessWidget {
  const CallPage({Key? key, required this.callID}) : super(key: key);
  final String callID;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: Myconst.yourAppID, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign: Myconst.yourAppSign, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userName: Login.username,
      userID: Login.userid,
      
      callID: callID,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
