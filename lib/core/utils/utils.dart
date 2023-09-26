import 'package:bot_toast/bot_toast.dart';
import 'package:simplibuy/core/constant.dart';

String greeting() {
  var time = DateTime.now().hour;
  if (time < 12) {
    return 'Good morning';
  } else if (time < 18) {
    return 'Good afternoon';
  } else {
    return 'Good evening';
  }
}

toast(String msg, {bool isError = false}) {
  BotToast.showSimpleNotification(
    backgroundColor: lightBlueColor.withAlpha(200),
    title: msg,
  );
}
