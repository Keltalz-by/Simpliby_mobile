import 'dart:io';

import 'package:get/get.dart';
import 'package:simplibuy/add_new_product/data/models/add_new_product.dart';
import 'package:simplibuy/add_new_product/domain/usecases/add_new_prduct_usecase.dart';
import 'package:simplibuy/core/validators/validators_string.dart';
import '../../../core/state/state.dart';
import 'package:image_picker/image_picker.dart';

class AddNewProductController extends GetxController with ValidatorMixin {
  final AddNewProductUsecase _usecase;
  final RxString _nameError = "".obs;
  final RxString _locationError = "".obs;
  final Rx<File> _logo = File('').obs;
  final RxList<File> _images = RxList<File>([]);
  final RxString _descError = "".obs;
  final RxBool _isLogoSelected = false.obs;
  final RxBool _areImagesSelected = false.obs;
  final RxString _priceError = "0".obs;
  final RxString _priceResError = "0".obs;
  final RxString _cityError = "".obs;

  String _name = "";
  String _location = "";
  String _desc = "";
  String _city = "";
  String _price = "0";
  String _priceRes = "0";
  bool get isLogoSelected => _isLogoSelected.value;
  bool get areImagesSelected => _areImagesSelected.value;
  File get logo => _logo.value;
  // ignore: invalid_use_of_protected_member
  List<File> get images => _images.value;
  String _category = "Cosmetics";

  String get nameError => _nameError.value;
  String get locationError => _locationError.value;
  String get descError => _descError.value;
  String get priceError => _priceError.value;
  String get priceResError => _priceResError.value;
  String get cityError => _cityError.value;
  String imageError = "";

  final _state = State().obs;
  State get state => _state.value;

  AddNewProductController(this._usecase);

  addNewProduct() async {
    if (_validateInputs()) {
      _state.value = LoadingState();
      _usecase
          .addNewProduct(AddNewProduct(
              "name", "desc", "location", "currency", 2, 2, "category", [], ""))
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

  addPrice(String data) {
    _price = data;
    _priceError.value = getInputFieldErrors(data);
  }

  addPriceRes(String data) {
    _priceRes = data;
    _priceResError.value = getInputFieldErrors(data);
  }

  addCity(String data) {
    _city = data;
    _cityError.value = getInputFieldErrors(data);
  }

  setCategory(String data) {
    _category = data;
  }

  bool _validateInputs() {
    if (_nameError.isEmpty &&
        _locationError.isEmpty &&
        _descError.isEmpty &&
        _priceError.isEmpty &&
        _priceResError.isEmpty &&
        _isLogoSelected.value &&
        _areImagesSelected.value &&
        _cityError.isEmpty) {
      return true;
    } else {
      imageError = "Please select an image";
      _nameError.value = getInputFieldErrors(_name);
      _locationError.value = getInputFieldErrors(_location);
      _descError.value = getShortFieldErrors(_desc);
      _priceError.value = getShortFieldErrors(_price);
      _priceResError.value = getInputFieldErrors(_priceRes);
      _cityError.value = getInputFieldErrors(_city);
      return false;
    }
  }

  uploaRackImage() {
    ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        final imageFile = File(value.path);
        _logo.value = imageFile;
        _isLogoSelected.value = true;
      }
    });
  }

  uploadProductImages() {
    ImagePicker()
        .pickMultiImage(maxWidth: 200, maxHeight: 200, imageQuality: 100)
        .then((value) {
      if (value != null) {
        List<File> files = images.map((image) => File(image.path)).toList();
        _images.value = files;
        _areImagesSelected.value = true;
      }
    });
  }
}
