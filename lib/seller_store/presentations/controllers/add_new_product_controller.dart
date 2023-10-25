import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:simplibuy/core/prefs/shared_prefs.dart';
import 'package:simplibuy/seller_store/data/models/category.dart';
import 'package:simplibuy/seller_store/data/models/new_product.dart';
import 'package:simplibuy/seller_store/domain/repo/product_and_category_repository.dart';
import '../../../core/state/state.dart' as S;
import 'package:image_picker/image_picker.dart';

class AddNewProductController extends GetxController {
  final ProductAndCategoryRepository _repo;
  final Rx<File> _logo = File('').obs;
  final Rx<Category> selectedCategory = Category.empty().obs;
  final RxList<File> _images = RxList<File>([]);
  final RxList<Category> categories = RxList<Category>([]);
  final RxBool _isLogoSelected = false.obs;
  final RxBool _areImagesSelected = false.obs;

  TextEditingController name = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController priceRes = TextEditingController();
  bool get isLogoSelected => _isLogoSelected.value;
  bool get areImagesSelected => _areImagesSelected.value;
  File get logo => _logo.value;
  List<File> get images => _images.value;

  RxBool isCategoriesRetrieved = false.obs;

  final _state = S.State().obs;
  S.State get state => _state.value;

  AddNewProductController(this._repo);

  @override
  void onInit() {
    super.onInit();
    getAllCategories();
  }

  addNewProduct() async {
    if (areInputsValid() == true) {
      _state.value = S.LoadingState();
      await SharedPrefs.initializeSharedPrefs();
      _repo
          .addNewProduct(AddNewProduct(
              SharedPrefs.userId(),
              selectedCategory.value.id,
              name.text,
              desc.text,
              location.text,
              price.text,
              priceRes.text,
              images.map((e) => e.path).toList(),
              logo.path))
          .then((result) {
        if (result.isLeft) {
          final err = S.ErrorState(errorType: result.left.error);
          err.setErrorMessage(result.left.message);
          toast(result.left.message);
          _state.value = err;
        } else {
          _state.value = S.FinishedState();
        }
      });
    } else {
      toast("Inputs are not complete");
    }
  }

  getAllCategories() {
    _repo.getAllCategory().then((value) {
      if (value.isRight && value.right.value.isNotEmpty) {
        categories.value = value.right.value;
        selectedCategory.value = categories[0];
        isCategoriesRetrieved.value = true;
        print("These are the categoris $categories");
      } else {
        toast(value.left.message);
      }
    });
  }

  bool areInputsValid() {
    if (name.text.isEmpty ||
        desc.text.isEmpty ||
        price.text.isEmpty ||
        priceRes.text.isEmpty ||
        _isLogoSelected.value == false ||
        _areImagesSelected.value == false) {
      return false;
    } else {
      return true;
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
