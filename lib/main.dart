import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:simplibuy/authentication/presentation/screen_bindings/forgot_password_binding.dart';
import 'package:simplibuy/authentication/presentation/screen_bindings/login_screen_binding.dart';
import 'package:simplibuy/authentication/presentation/screen_bindings/profile_screen_binding.dart';
import 'package:simplibuy/authentication/presentation/screen_bindings/signup_screen_binding.dart';
import 'package:simplibuy/authentication/presentation/screen_bindings/verify_email_binding.dart';
import 'package:simplibuy/authentication/presentation/screens/business_details/business_details_screen.dart';
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
import 'package:simplibuy/on_boarding/user_type.dart';
import 'package:simplibuy/orders/presentation/bindings/orders_bindings.dart';
import 'package:simplibuy/orders/presentation/screens/orders_screens.dart';
import 'package:simplibuy/reserve/presentation/bindings/reserve_binding.dart';
import 'package:simplibuy/reserve/presentation/screens/reserve_screen.dart';
import 'package:simplibuy/reserve/presentation/screens/reserve_screen_completion.dart';
import 'package:simplibuy/seller_home/presentation/bindings/seller_home_bindings.dart';
import 'package:simplibuy/seller_home/presentation/screens/seller_home.dart';
import 'package:simplibuy/seller_payments/presentation/bindings/seller_payments_bindings.dart';
import 'package:simplibuy/seller_payments/presentation/screens/add_bank_screen.dart';
import 'package:simplibuy/seller_payments/presentation/screens/seller_payments_screen.dart';
import 'package:simplibuy/seller_payments/presentation/screens/withdraw_to_bank_screen.dart';
import 'package:simplibuy/seller_plan/presentation/screens/confirm_pro_sub.dart';
import 'package:simplibuy/seller_plan/presentation/screens/pay_sub_screen.dart';
import 'package:simplibuy/seller_plan/presentation/screens/plans.dart';
import 'package:simplibuy/seller_plan/presentation/screens/pro_plan.dart';
import 'package:simplibuy/seller_store/presentations/binding/add_new_product_binding.dart';
import 'package:simplibuy/seller_store/presentations/binding/seller_categories_bindings.dart';
import 'package:simplibuy/seller_store/presentations/binding/seller_products_bindings.dart';
import 'package:simplibuy/seller_store/presentations/controllers/seller_categories_controller.dart';
import 'package:simplibuy/seller_store/presentations/screens/categories/seller_product_categories_screen.dart';
import 'package:simplibuy/seller_store/presentations/screens/products/add_new_product.dart';
import 'package:simplibuy/seller_store/presentations/screens/products/seller_product_detail_screen.dart';
import 'package:simplibuy/seller_store/presentations/screens/products/seller_products_screen.dart';
import 'package:simplibuy/seller_store/presentations/screens/profile/create_promo_post_screen.dart';
import 'package:simplibuy/seller_store/presentations/screens/profile/seller_edit_profile_screen.dart';
import 'package:simplibuy/seller_store/presentations/screens/profile/seller_profile_screen.dart';
import 'package:simplibuy/settings/presentation/screens/settings_screen.dart';
import 'package:simplibuy/store_and_product/presentation/binding/product_binding.dart';
import 'package:simplibuy/store_and_product/presentation/binding/products_list_binding.dart';
import 'package:simplibuy/store_and_product/presentation/screens/product_screen.dart';
import 'package:simplibuy/to_buy_list/presentation/binding/to_buy_binding.dart';
import 'package:simplibuy/to_buy_list/presentation/screens/to_buy_screen.dart';
import 'authentication/presentation/screen_bindings/business_reg_screen_binding.dart';
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
    // GetPage(name: "SPLASH", page: () => SplashScreen()),
    GetPage(
      name: USER_FIRST_TIME,
      page: () => const UserFirstTime(),
    ),
    GetPage(
      name: USER_TYPE,
      page: () => const UserType(),
    ),
    GetPage(
        name: LOGIN_ROUTE,
        page: () => LoginForm(),
        binding: LoginScreenBinding()),
    GetPage(
        name: SINGLE_STORE_ROUTE,
        page: () => StoreInfoScreen(),
        arguments: "id",
        binding: StoreInfoBinding()),
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
        name: PRODUCTS_LIST_SCREEN,
        page: () => ProductsListScreen(),
        binding: ProductListBinding()),
    GetPage(
        name: PRODUCT_SCREEN,
        page: () => ProductScreen(),
        binding: ProductBinding()),
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
        name: BUSINESS_DETAILS_SCREEN,
        page: () => BusinessDetailsScreen(),
        binding: BusinessRegScreenBinding()),
    GetPage(name: PLAN_CHOICE_SCREEN, page: () => PlanScreen()),
    GetPage(name: PRO_PLAN_CHOICE_SCREEN, page: () => ProPlanScreen()),
    GetPage(
      name: CONFIRM_PRO_SUB_SCREEN,
      page: () => ConfirmProSubScreen(),
      arguments: "price",
    ),
    GetPage(
      name: PAY_SUB_SCREEN,
      page: () => PaySubScreen(),
      arguments: "price",
    ),
    GetPage(
        name: SELLER_HOME_PAGE_ROUTE,
        page: () => SellerHomeDrawers(),
        binding: SellerHomeBindings()),
    GetPage(
      name: ORDERS_SCREEN,
      page: () => OrdersScreen(),
      binding: OrdersBindings(),
    ),
    GetPage(
        name: ADD_NEW_PRODUCT,
        page: () => AddNewProductScreen(),
        binding: AddNewProductBinding()),
    GetPage(
      name: SELLER_PRODUCT_CATEGORIES,
      binding: SellerCategoriesBindings(),
      page: () => SellerProductCategoriesScreen(),
    ),
    GetPage(
        name: SELLER_PRODUCTS,
        page: () => SellerProductsScreens(),
        binding: SellerProductsBindings()),
    GetPage(
      name: SELLER_PRODUCT_DETAIL,
      page: () => SellerProductDetailScreen(),
    ),
    GetPage(
        name: SELLER_PAYMENTS,
        page: () => SellerPaymentsScreen(),
        binding: SellerPaymentsBindings()),
    GetPage(
      name: ADD_BANK_SCREEN,
      page: () => AddBankScreen(),
    ),
    GetPage(
      name: WITHDRAWAL_SCREEN,
      page: () => WithdrawToBankScreen(),
    ),
    GetPage(name: SELLER_PROFILE_SCREEN, page: () => SellerProfileScreen()),
    GetPage(
      name: SELLER_EDIT_PROFILE_SCREEN,
      page: () => SellerEditProfileScreen(),
    ),
    GetPage(
      name: CREATE_PROMO_POST_SCREEN,
      page: () => CreatePromoPostScreen(),
    ),
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
