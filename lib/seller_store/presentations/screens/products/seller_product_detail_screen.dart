import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';
import 'package:simplibuy/seller_store/data/models/product.dart';
import 'package:simplibuy/seller_store/presentations/screens/products/image_slider.dart';
import '../../../../core/utils/price_formatter.dart';

class SellerProductDetailScreen extends StatelessWidget {
  SellerProductDetailScreen({Key? key}) : super(key: key);

  SingleProduct product = Get.arguments as SingleProduct;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: _body(context)),
    );
  }

  Widget _body(BuildContext context) {
    final desc = TextEditingController(text: product.description);
    final editPrice = TextEditingController(text: product.price);
    final resPrice = TextEditingController(text: product.reservationPrice);
    RxBool isAvailable =
        product.inStock.obs; // Set this variable based on your condition

    return Column(
      children: [
        ImageSliderWithIndicator(
            images: product.productImages.map((e) => e.url).toList()),
        Container(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.only(top: 30)),
              Text(product.productName,
                  style: TextStyle(
                      color: blackColor,
                      fontSize: 23,
                      fontWeight: FontWeight.bold)),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Radio(
                        value: true,
                        groupValue: isAvailable.value,
                        activeColor: blueColor,
                        onChanged: (value) {
                          isAvailable.value = value as bool;
                        },
                      ),
                      Text(
                        'Available',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Radio(
                        value: false,
                        groupValue: isAvailable.value,
                        activeColor: blueColor,
                        onChanged: (value) {
                          isAvailable.value = value as bool;
                        },
                      ),
                      Text(
                        'Out of stock',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  )),
              TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  maxLength: 200,
                  controller: desc,
                  decoration:
                      customInputDecoration(hint: null, errorText: null)),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Edit Price:",
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(
                            width: 120.w,
                            height: 60.h,
                            child: TextField(
                                controller: editPrice,
                                keyboardType: TextInputType.name,
                                maxLines: 1,
                                inputFormatters: [PriceInputFormatter()],
                                decoration: customInputDecoration(
                                    hint: null, errorText: null)))
                      ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Reservation Price:",
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(
                            width: 120.w,
                            height: 60.h,
                            child: TextField(
                                controller: resPrice,
                                keyboardType: TextInputType.name,
                                maxLines: 1,
                                //    inputFormatters: [PriceInputFormatter()],
                                decoration: customInputDecoration(
                                    hint: null, errorText: null)))
                      ]),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              defaultButtons(pressed: () {}, text: "Update")
            ],
          ),
        ),
      ],
    );
  }
}
