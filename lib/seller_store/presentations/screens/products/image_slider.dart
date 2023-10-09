import 'package:flutter/material.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/constants/string_constants.dart';
import 'package:simplibuy/core/reusable_widgets/cache_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageSliderWithIndicator extends StatelessWidget {
  final List<String> images;
  ImageSliderWithIndicator({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(viewportFraction: 1);

    return Column(
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: PageView(
              physics: const BouncingScrollPhysics(),
              controller: pageController,
              children: images.map((data) {
                return Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 2),
                          blurRadius: 4,
                          spreadRadius: 0,
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                    child: ImageCacheR(
                      data,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.4,
                      errorPlaceHolder: defaultStoreImageBig,
                    ));
              }).toList(),
            )),
        const SizedBox(
          height: 16,
        ),
        SmoothPageIndicator(
          controller: pageController,
          count: images.length,
          effect: const ExpandingDotsEffect(
            activeDotColor: blueColor, // Replace with your desired color
            dotWidth: 6,
            dotHeight: 6,
          ),
          onDotClicked: (index) {},
        ),
      ],
    );
  }
}
