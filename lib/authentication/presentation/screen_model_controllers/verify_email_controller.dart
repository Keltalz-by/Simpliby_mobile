import 'dart:async';

import 'package:get/get.dart';
import 'package:simplibuy/authentication/domain/usecases/verify_email_usecase.dart';
import 'package:simplibuy/authentication/presentation/screens/account_creation_success.dart';
import 'package:simplibuy/authentication/presentation/screens/custom_widgets.dart';
import 'package:simplibuy/core/constants/route_constants.dart';
import 'package:simplibuy/core/prefs/shared_prefs.dart';
import '../../../core/state/state.dart';

class VerifyEmailController extends GetxController {
  final VerifyEmailUsecase _usecase;

  final _state = const State().obs;
  String _code = "";

  final countdown = '20:00'.obs;
  Timer? _timer;

  State get state => _state.value;

  VerifyEmailController(this._usecase);

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final currentCountdown = countdown.value.split(':');
      final minutes = int.parse(currentCountdown[0]);
      final seconds = int.parse(currentCountdown[1]);

      if (minutes == 0 && seconds == 0) {
        timer.cancel();
        countdown.value = 'Time Out';
      } else if (seconds == 0) {
        countdown.value = '${minutes - 1}:59';
      } else {
        final newSeconds = seconds - 1;
        final formattedSeconds = newSeconds.toString().padLeft(2, '0');
        countdown.value = '$minutes:$formattedSeconds';
      }
    });
  }

  void resetTimer() {
    _timer?.cancel();
    countdown.value = '20:00';
    startTimer();
  }

  Future<void> verifyEmail() async {
    if (_validateCode()) {
      _state.value = LoadingState();
      await SharedPrefs.initializeSharedPrefs();
      final uid = SharedPrefs.userId();
      final result = await _usecase.verifyEmail(uid, _code);
      if (result.isLeft) {
        final err = ErrorState(errorType: result.left.error);
        err.setErrorMessage(result.left.message);
        _state.value = err;
      } else {
        normalToast("Email verified");
        Get.off(const AccountCreationSuccess());
      }
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  Future<void> resendOtp(String email) async {
    _state.value = LoadingState();
    await SharedPrefs.initializeSharedPrefs();
    final uid = SharedPrefs.userId();
    email.isNotEmpty ? email : SharedPrefs.userEmail();
    final result = await _usecase.resendOtp(uid, email);
    if (result.isLeft) {
      final err = ErrorState(errorType: result.left.error);
      err.setErrorMessage(result.left.message);
      _state.value = err;
    } else {
      _state.value = State();
      normalToast("Otp has been sent");
      resetTimer();
    }
  }

  addCode(String code) {
    _code = code;
  }

  bool _validateCode() {
    if (_code.length < 4) {
      return false;
    } else {
      return true;
    }
  }
}
