import 'package:either_dart/either.dart';
import 'package:simplibuy/notification/domain/entities/notification_data.dart';

import '../../../core/error_types/error_types.dart';
import '../../../core/failure/failure.dart';
import '../../../core/network/network_info.dart';
import '../../../core/result/result.dart';

abstract class NotificationRepo {
  Future<Either<Failure, Result<List<NotificationData>>>> getNotificationDate();
}

class NotificationRepoImpl implements NotificationRepo {
  final NetworkInfo _networkInfo;

  NotificationRepoImpl(this._networkInfo);
  @override
  Future<Either<Failure, Result<List<NotificationData>>>>
      getNotificationDate() async {
    if (await _networkInfo.isConnected) {
      try {
        if (data.isEmpty) {
          return Left(Failure(error: EmptyListError()));
        }
        return Right(Result(value: data));
      } on Exception {
        return Left(Failure(error: ServerError()));
      }
    } else {
      return Left(Failure(error: InternetError()));
    }
  }

  var data = [
    NotificationData(0, 'Hey, John', "Just just received an order", 'Just now'),
    NotificationData(0, 'Hey, John', "Just just received an order", 'Just now'),
    NotificationData(0, 'Hey, John', "Just just received an order", 'Just now'),
    NotificationData(0, 'Hey, John', "Just just received an order", 'Just now'),
    NotificationData(0, 'Hey, John', "Just just received an order", 'Just now'),
    NotificationData(0, 'Hey, John', "Just just received an order", 'Just now'),
    NotificationData(0, 'Hey, John', "Just just received an order", 'Just now'),
    NotificationData(0, 'Hey, John', "Just just received an order", 'Just now'),
    NotificationData(0, 'Hey, John', "Just just received an order", 'Just now'),
    NotificationData(0, 'Hey, John', "Just just received an order", 'Just now'),
    NotificationData(0, 'Hey, John', "Just just received an order", 'Just now'),
  ];
}
