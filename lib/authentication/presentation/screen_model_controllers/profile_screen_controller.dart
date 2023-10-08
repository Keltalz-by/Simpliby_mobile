import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simplibuy/authentication/domain/entities/profile_details.dart';
import 'package:simplibuy/core/validators/validators_string.dart';
import 'package:simplibuy/authentication/domain/usecases/profile_usecase.dart';

import '../../../core/state/state.dart';

class ProfileScreenController extends GetxController with ValidatorMixin {
  final ProfileUsecase usecase;

  ProfileScreenController(this.usecase);

  final _state = const State().obs;
  final Rx<ProfileDatails> _details =
      ProfileDatails('', '', null, null, null, '').obs;
  final RxBool _isFile = false.obs;
  final Rx<File> _localImage = File('').obs;
  final RxBool _isEditable = false.obs;

  bool get isFile => _isFile.value;
  State get state => _state.value;
  File get localImage => _localImage.value;
  ProfileDatails get details => _details.value;

  makeEditable() {
    _isEditable.value = !_isEditable.value;
  }

  @override
  void onInit() {
    _getUserProfileDetails();
    super.onInit();
  }

  addEmail(String data) {
    _details.value.email = data;
  }

  addName(String data) {
    _details.value.name = data;
  }

  addLocation(String data) {
    _details.value.location = data;
  }

  addOccupation(String data) {
    _details.value.occupation = data;
  }

  addPhoneNumber(String data) {
    _details.value.phoneNumber = data;
  }

  _getUserProfileDetails() async {
    _state.value = LoadingState();
    var result = await usecase.getUserDetails();
    result.fold((left) => _state.value = ErrorState(errorType: left.error),
        (right) {
      _state.value = FinishedState();
      _details.value = right.value;
    });
  }

  bool get isEditable => _isEditable.value;

  onSubmit() async {
    _state.value = LoadingState();
    var result = await usecase.updateUserProfileDetails(_details.value);
    result.fold((left) => _state.value = ErrorState(errorType: left.error),
        (right) {
      _state.value = FinishedState();
      _isEditable.value = false;
    });
  }

  loadImageFromCamera() {
    _loadImageFrom(ImageSource.camera);
  }

  loadImageFromGallery() {
    _loadImageFrom(ImageSource.gallery);
  }

  _loadImageFrom(ImageSource source) async {
    var image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      var imageFile = File(image.path);
      _localImage.value = imageFile;
      _isFile.value = true;
      _details.value.image = imageFile.toString();
    }
  }
}
