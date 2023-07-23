import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/constants/string_constants.dart';

class ImageSliderWithIndicator extends StatelessWidget {
  final List<String> imageUrls;

  ImageSliderWithIndicator({required this.imageUrls});

  final PageController _pageController = PageController();
  var _currentPage = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: imageUrls.length,
            onPageChanged: (index) {
              _currentPage.value = index;
            },
            itemBuilder: (context, index) {
              return ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.r),
                    bottomRight: Radius.circular(20.r),
                  ),
                  child: FadeInImage.assetNetwork(
                      fit: BoxFit.cover,
                      placeholder: defaultProductImage,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.40,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          defaultProductImage,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.40,
                          fit: BoxFit.cover,
                        );
                      },
                      image: imageUrls[index]));
            },
          ),
          Positioned(
              bottom: -15.h,
              left: 0,
              right: 0,
              child: Obx(() => _buildIndicatorRow())),
        ],
      ),
    );
  }

  Widget _buildIndicatorRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        imageUrls.length,
        (index) => _buildIndicator(index),
      ),
    );
  }

  Widget _buildIndicator(int index) {
    return Container(
      width: 8,
      height: 8,
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage.value == index ? blueColor : Colors.grey.shade400,
      ),
    );
  }
}
