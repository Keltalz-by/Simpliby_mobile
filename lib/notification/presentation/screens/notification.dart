import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplibuy/core/constant.dart';
import '../../../core/error_types/error_types.dart';
import '../../../core/state/state.dart';
import 'package:simplibuy/core/reusable_widgets/reusable_widgets.dart';
import 'package:simplibuy/notification/presentation/controller/notification_controller.dart';
import 'package:simplibuy/notification/presentation/screens/custom_widgets.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);

  final NotificationController _controller = Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          text: "Notifications",
          onPressed: () {
            Get.back();
          }),
      body: Container(
          padding: const EdgeInsets.all(5),
          child: Obx(() {
            if (_controller.state == ErrorState(errorType: EmptyListError())) {
              return emptyNotification(context);
            }
            if (_controller.state == ErrorState(errorType: InternetError())) {
              return noInternetConnection(context);
            }
            if (_controller.state is FinishedState) {
              return ListView.separated(
                  separatorBuilder: ((context, index) {
                    return Container(padding: const EdgeInsets.all(10));
                  }),
                  itemCount: _controller.data.length,
                  itemBuilder: (context, index) {
                    return NotificationSingleItem(_controller.data[index]);
                  });
            }
            if (_controller.state == ErrorState(errorType: ServerError())) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                duration: Duration(milliseconds: 1000),
                content: Text('Error with Server'),
              ));
              return defaultLoading(context);
            }
            return defaultLoading(context);
          })),
    );
  }

  Widget emptyNotification(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(defaultPadding),
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(children: const [
          Icon(Icons.notifications, size: 50),
          Text('No notification yet', style: TextStyle()),
          Text('Stay tuned!', style: TextStyle())
        ]));
  }
}
