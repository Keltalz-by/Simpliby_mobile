import 'package:get/get.dart';
import 'package:simplibuy/authentication/domain/usecases/forgot_password_usecase.dart';
import 'package:simplibuy/authentication/presentation/screens/custom_widgets.dart';
import 'package:simplibuy/core/constants/route_constants.dart';
import 'package:simplibuy/core/validators/validators_string.dart';
import '../../../core/state/state.dart';

class ForgotPasswordController extends GetxController with ValidatorMixin {
  final ForgotPasswordUsecase _usecase;

  final _state = const State().obs;

  State get state => _state.value;

  String _email = "";
  final RxString _emailError = "".obs;
  String get emailError => _emailError.value;

  ForgotPasswordController(this._usecase);

  Future<void> sendPaswordResetCode() async {
    if (_validateEmail()) {
      _state.value = LoadingState();
      final result = await _usecase.sendPaswordResetCode(_email);
      if (result.isLeft) {
        final err = ErrorState(errorType: result.left.error);
        err.setErrorMessage(result.left.message);
        _state.value = err;
      } else {
        Get.toNamed(VERIFY_EMAIL, arguments: _email);
        normalToast("Code has been sent to your email");
      }
    }
  }

  addEmail(String data) {
    _email = data;
    _emailError.value = getEmailErrors(data);
  }

  bool _validateEmail() {
    String emailErrors = getEmailErrors(_email);
    if (_emailError.isEmpty) {
      return true;
    } else {
      _emailError.value = emailErrors;
      return false;
    }
  }
}
