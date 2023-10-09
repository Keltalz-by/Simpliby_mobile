import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:simplibuy/authentication/domain/usecases/enter_new_password_usecase.dart';
import 'package:simplibuy/core/validators/validators_string.dart';
import '../../../core/state/state.dart';

class EnterNewPasswordController extends GetxController with ValidatorMixin {
  final EnterNewPasswordUsecase _usecase;

  final _state = const State().obs;
  final RxBool _isVisible = true.obs;
  bool get isVisible => _isVisible.value;

  State get state => _state.value;

  String _password = "";
  String _passwordConfirm = "";
  final RxString _passwordError = "".obs;
  final RxString _passwordConfirmError = "".obs;
  String get passwordError => _passwordError.value;
  String get passwordConfirmError => _passwordConfirmError.value;

  EnterNewPasswordController(this._usecase);

  changeVisibility() {
    _isVisible.value = !_isVisible.value;
  }

  Future<void> resetPassword() async {
    if (_validatePasswords()) {
      _state.value = LoadingState();
      final result = await _usecase.resetPassword(_password, _passwordConfirm);
      if (result.isLeft) {
        final err = ErrorState(errorType: result.left.error);
        err.setErrorMessage(result.left.message);
        _state.value = err;
      } else {
        _state.value = FinishedState();
        toast("Password has been reset. You can log in with your new password");
      }
    }
  }

  addPassword(String data) {
    _password = data;
    _passwordError.value = getPasswordErrors(data);
  }

  addPasswordConfirm(String data) {
    _passwordConfirm = data;
    _passwordConfirmError.value = getPasswordErrors(data);
  }

  bool _validatePasswords() {
    String passwordErrors = getPasswordErrors(_password);
    String passwordConfirmErrors = getPasswordErrors(_passwordConfirm);
    if (passwordErrors.isEmpty &&
        passwordConfirmErrors.isEmpty &&
        _password == _passwordConfirm) {
      return true;
    } else {
      _passwordError.value = passwordError;
      _passwordConfirmError.value = passwordError;
      return false;
    }
  }
}
