import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simplibuy/core/constant.dart';
import '../core/constants/route_constants.dart';
import '../core/reusable_widgets/reusable_widgets.dart';

class UserFirstTime extends StatefulWidget {
  const UserFirstTime({Key? key}) : super(key: key);

  @override
  _SwipeableWidgetExampleState createState() => _SwipeableWidgetExampleState();
}

class _SwipeableWidgetExampleState extends State<UserFirstTime> {
  final PageController _pageController = PageController();

  int _currentPage = 0;
  num _pageOffset = 0;
  String initialText = "Next";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.only(
                    right: 20.w, top: 10.h, bottom: 70.h, left: 20.w),
                color: whiteColor,
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                          onTap: () {
                            Get.offNamed(LOGIN_ROUTE);
                          },
                          child: Text(
                            "Skip",
                            style: TextStyle(
                                color: blueColor, fontSize: smallTextFontSize),
                            textAlign: TextAlign.end,
                          )),
                    ),
                    SizedBox(height: 50.h),
                    Expanded(
                      child: PageView(
                        onPageChanged: (int page) {
                          setState(() {
                            _currentPage = page;
                            if (_currentPage == 2) {
                              initialText = "Get Started";
                            } else {
                              initialText = "Next";
                            }
                          });
                        },
                        controller: _pageController
                          ..addListener(() {
                            setState(() {
                              _pageOffset = (_pageController.page ??
                                      _pageController.initialPage) -
                                  _currentPage;
                            });
                          }),
                        children: <Widget>[
                          Column(children: [
                            imageFromAssetsFolder(
                                width: 370.w,
                                height: 370.h,
                                path:
                                    'assets/on_boarding/discover_malls_around_you.png',
                                padding: 0),
                            SizedBox(height: 20.h),
                            Text(
                              "Discover malls around you",
                              style: TextStyle(
                                  color: blueColor,
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 15.h),
                            Text(
                              "Login to discover various stores and malls near your vicinity and make your choice",
                              style:
                                  TextStyle(color: blackColor, fontSize: 20.sp),
                              textAlign: TextAlign.center,
                            ),
                          ]),
                          Column(children: [
                            imageFromAssetsFolder(
                                width: 370.w,
                                height: 370.h,
                                path:
                                    'assets/on_boarding/view_items_and_shelve_details.png',
                                padding: 0),
                            SizedBox(height: 20.h),
                            Text(
                              "View items and shelve details",
                              style: TextStyle(
                                  color: blueColor,
                                  overflow: TextOverflow.fade,
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 15.h),
                            Text(
                              "Now you don't need stressing yourself searching for your favorite item in a mall when you can easily find it here",
                              style:
                                  TextStyle(color: blackColor, fontSize: 20.sp),
                              textAlign: TextAlign.center,
                            )
                          ]),
                          Column(children: [
                            imageFromAssetsFolder(
                                width: 370.w,
                                height: 370.h,
                                path: 'assets/on_boarding/reserve_and_pay.png',
                                padding: 0),
                            SizedBox(height: 20.h),
                            Text(
                              "Reserve and pay for your selected item",
                              style: TextStyle(
                                  color: blueColor,
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 15.h),
                            Text(
                              "Pay for the reserved item and go and pick them up at your convinent time",
                              style:
                                  TextStyle(color: blackColor, fontSize: 20.sp),
                              textAlign: TextAlign.center,
                            )
                          ]),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: 40.h,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(3, (index) {
                              return AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                width: 8.w,
                                height: 8.h,
                                margin: EdgeInsets.symmetric(horizontal: 5.w),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _currentPage == index
                                      ? blueColor
                                      : _pageOffset > index &&
                                              _pageOffset < index
                                          ? blueColor
                                          : Colors.grey.withOpacity(0.7),
                                ),
                              );
                            }))),
                    defaultButtons(
                        pressed: () {
                          if (_currentPage == 2) {
                            Get.offAllNamed(LOGIN_ROUTE);
                          } else {
                            if (_currentPage == 1) {
                              setState(() {
                                initialText = "Get Started";
                              });
                            }
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          }
                        },
                        text: initialText)
                  ],
                ))));
  }
}
