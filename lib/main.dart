import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:simplibuy/authentication/presentation/screen_bindings/forgot_password_binding.dart';
import 'package:simplibuy/authentication/presentation/screen_bindings/login_screen_binding.dart';
import 'package:simplibuy/authentication/presentation/screen_bindings/profile_screen_binding.dart';
import 'package:simplibuy/authentication/presentation/screen_bindings/signup_screen_binding.dart';
import 'package:simplibuy/authentication/presentation/screen_bindings/verify_email_binding.dart';
import 'package:simplibuy/authentication/presentation/screens/forgot_password/forgot_password.dart';
import 'package:simplibuy/authentication/presentation/screens/login/login_screen.dart';
import 'package:simplibuy/authentication/presentation/screens/signup/signup_screen.dart';
import 'package:simplibuy/authentication/presentation/screens/verify_email/verify_email.dart';
import 'package:simplibuy/buyer_home/presentation/bindings/buyer_home_bottom_nav_screens_bindings.dart';
import 'package:simplibuy/buyer_home/presentation/screens/stores_and_malls_screen.dart';
import 'package:simplibuy/cart/presentation/screens/cart_list_screen.dart';
import 'package:simplibuy/chat_seller/presentation/screens/chat_seller.dart';
import 'package:simplibuy/core/constant.dart';
import 'package:simplibuy/core/constants/route_constants.dart';
import 'package:simplibuy/history/presentation/screens/history_screen.dart';
import 'package:simplibuy/main_binding.dart';
import 'package:get/get.dart';
import 'package:simplibuy/buyer_home/presentation/screens/buyer_home_drawers.dart';
import 'package:simplibuy/notification/presentation/binding/notification_binding.dart';
import 'package:simplibuy/on_boarding/splash_screen.dart';
import 'package:simplibuy/on_boarding/user_first_time.dart';
import 'package:simplibuy/authentication/presentation/screens/profile/profile_screen.dart';
import 'package:simplibuy/reserve/presentation/bindings/reserve_binding.dart';
import 'package:simplibuy/reserve/presentation/screens/reserve_screen.dart';
import 'package:simplibuy/reserve/presentation/screens/reserve_screen_completion.dart';
import 'package:simplibuy/settings/presentation/screens/settings_screen.dart';
import 'package:simplibuy/store_and_product/presentation/binding/product_binding.dart';
import 'package:simplibuy/store_and_product/presentation/binding/products_list_binding.dart';
import 'package:simplibuy/store_and_product/presentation/screens/product_screen.dart';
import 'package:simplibuy/to_buy_list/presentation/binding/to_buy_binding.dart';
import 'package:simplibuy/to_buy_list/presentation/screens/to_buy_screen.dart';
import 'authentication/presentation/screen_bindings/enter_new_password_binding.dart';
import 'authentication/presentation/screens/forgot_password/enter_new_password.dart';
import 'notification/presentation/screens/notification.dart';
import 'package:overlay_support/overlay_support.dart';

import 'store_and_product/presentation/binding/store_info_binding.dart';
import 'store_and_product/presentation/screens/product_via_category.dart';
import 'store_and_product/presentation/screens/store_info_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 902),
      useInheritedMediaQuery: true,
      minTextAdapt: true,
      builder: (context, child) {
        return OverlaySupport.global(
            child: GetMaterialApp(
                title: 'Flutter Demo',
                getPages: pages,
                builder: BotToastInit(),
                initialBinding: MainBinding(),
                navigatorObservers: [BotToastNavigatorObserver()],
                theme: ThemeData(
                    primarySwatch: Colors.blue,
                    fontFamily: "Inter",
                    scaffoldBackgroundColor: whiteColor),
                home: SplashScreen()));
      },
    );
  }

  final pages = [
    GetPage(
      name: USER_FIRST_TIME,
      page: () => const UserFirstTime(),
    ),
    GetPage(
        name: LOGIN_ROUTE,
        page: () => LoginForm(),
        binding: LoginScreenBinding()),
    GetPage(
        name: SIGNUP_ROUTE,
        page: () => SignUpForm(),
        binding: SignupScreenBinding()),
    GetPage(
        name: FORGOT_PASSWORD,
        page: () => ForgotPassword(),
        binding: ForgotPasswordBinding()),
    GetPage(
        name: ENTER_NEW_PASSWORD,
        page: () => EnterNewPassword(),
        binding: EnterNewPasswordBinding()),
    GetPage(
        name: VERIFY_EMAIL,
        page: () => VerifyEmail(),
        binding: VerifyEmailBinding(),
        arguments: "email"),
    GetPage(
        name: PRODUCTS_LIST_SCREEN,
        page: () => ProductsListScreen(),
        binding: ProductListBinding()),
    GetPage(
        name: PRODUCT_SCREEN,
        page: () => ProductScreen(),
        binding: ProductBinding()),
    GetPage(
        name: PROFILE_SCREEN,
        page: () => ProfileScreen(),
        binding: ProfileScreenBinding()),
    GetPage(
      name: BUYER_HOME_PAGE_ROUTE,
      binding: BuyerHomeBottomNavScreensBindings(),
      page: () => BuyerBottomNavScreen(),
    ),
    GetPage(
      name: STORES_LIST_ROUTE,
      page: () => StoresAndMallsScreen(),
      binding: BuyerHomeBottomNavScreensBindings(),
    ),
    GetPage(
      name: CART_LIST_SCREEN,
      page: () => CartList(),
      binding: BuyerHomeBottomNavScreensBindings(),
    ),
    GetPage(
        name: SINGLE_STORE_ROUTE,
        arguments: "id",
        page: () => StoreInfoScreen(),
        binding: StoreInfoBinding()),
    GetPage(
      name: HISTORY_SCREEN,
      page: () => HistoryScreen(),
      binding: BuyerHomeBottomNavScreensBindings(),
    ),
    GetPage(
      name: TO_BUY_SCREEN,
      page: () => ToBuyScreen(),
      binding: ToBuyBinding(),
    ),
    GetPage(
        name: RESERVE_SCREEN,
        page: () => ReserveScreen(),
        binding: ReserveBinding()),
    GetPage(
        name: RESERVE_SCREEN_COMPL,
        page: () => ReserveScreenCompletion(),
        binding: ReserveBinding()),
    GetPage(
        name: NOTIFICATION_SCREEN,
        page: () => NotificationScreen(),
        binding: NotificationBinding()),
    GetPage(
      name: SETTINGS_SCREEN,
      page: () => SettingsScreen(),
    ),
    GetPage(
      name: CHAT_SELLER_SCREEN,
      page: () => ChatSeller(),
    )
  ];
}
