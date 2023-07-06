import 'dart:io';

import 'package:get/get.dart';
import 'package:simplibuy/authentication/data/models/business_reg_details.dart';
import 'package:simplibuy/authentication/domain/usecases/business_reg_usecase.dart';
import 'package:simplibuy/core/validators/validators_string.dart';
import '../../../core/state/state.dart';
import 'package:image_picker/image_picker.dart';

class BusinessRegController extends GetxController with ValidatorMixin {
  final BusinessRegUsecase _usecase;
  final RxString _nameError = "".obs;
  final RxString _locationError = "".obs;
  final Rx<File> _logo = File('').obs;
  final Rx<File> _image = File('').obs;
  final RxString _descError = "".obs;
  final RxBool _isLogoSelected = false.obs;
  final RxBool _areImagesSelected = false.obs;
  final RxString _addressError = "".obs;
  final RxString _cityError = "".obs;

  String _name = "";
  String _location = "";
  String _desc = "";
  String _address = "";
  String _city = "";
  bool get isLogoSelected => _isLogoSelected.value;
  bool get areImagesSelected => _areImagesSelected.value;
  File get logo => _logo.value;
  // ignore: invalid_use_of_protected_member
  File get image => _image.value;
  String _country = "Nigeria";

  String get nameError => _nameError.value;
  String get locationError => _locationError.value;
  String get descError => _descError.value;
  String get addressError => _addressError.value;
  String get cityError => _cityError.value;
  String imageError = "";

  final _state = State().obs;
  State get state => _state.value;

  BusinessRegController(this._usecase);

  registerBusiness() async {
    if (_validateInputs()) {
      _state.value = LoadingState();
      _usecase
          .sendBusinessDetails(BusinessRegDetails(
              name: _name,
              location: _location,
              brief_desc: _desc,
              address: _address,
              city: _city,
              country: _country,
              images: image.path,
              logo: logo.path))
          .then((result) {
        if (result.isLeft) {
          final err = ErrorState(errorType: result.left.error);
          err.setErrorMessage(result.left.message);
          _state.value = err;
        } else {
          _state.value = FinishedState();
        }
      });
    }
  }

  addName(String data) {
    _name = data;
    _nameError.value = getInputFieldErrors(data);
  }

  addLocation(String data) {
    _location = data;
    _locationError.value = getInputFieldErrors(data);
  }

  addDesc(String data) {
    _desc = data;
    _descError.value = getInputFieldErrors(data);
  }

  addAddress(String data) {
    _address = data;
    _addressError.value = getInputFieldErrors(data);
  }

  addCity(String data) {
    _city = data;
    _cityError.value = getInputFieldErrors(data);
  }

  setCountry(String data) {
    _country = data;
  }

  bool _validateInputs() {
    if (_nameError.isEmpty &&
        _locationError.isEmpty &&
        _descError.isEmpty &&
        _addressError.isEmpty &&
        _isLogoSelected.value &&
        _areImagesSelected.value &&
        _cityError.isEmpty) {
      return true;
    } else {
      imageError = "Please select an image";
      _nameError.value = getInputFieldErrors(_name);
      _locationError.value = getInputFieldErrors(_location);
      _descError.value = getInputFieldErrors(_desc);
      _addressError.value = getInputFieldErrors(_address);
      _cityError.value = getInputFieldErrors(_city);
      return false;
    }
  }

  uploadImageLogo() {
    ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        final imageFile = File(value.path);
        _logo.value = imageFile;
        _isLogoSelected.value = true;
      }
    });
  }

  uploadBusinessImages() {
    ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        final imageFile = File(value.path);
        _image.value = imageFile;
        _areImagesSelected.value = true;
      }
    });
  }
}
