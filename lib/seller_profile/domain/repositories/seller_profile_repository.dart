import 'package:either_dart/either.dart';
import 'package:simplibuy/core/error_types/error_types.dart';
import 'package:simplibuy/core/failure/failure.dart';
import 'package:simplibuy/core/network/network_info.dart';
import 'package:simplibuy/core/result/result.dart';
import 'package:simplibuy/seller_profile/data/models/seller_profile_details.dart';

abstract class SellerProfileRepository {
  Future<Either<Failure, Result<SellerProfileDetails>>> getSellerProfile();
  Future<Either<Failure, Result<List<SellerSinglePromoPost>>>> getPromoPosts();
}

class SellerProfileRepositoryImpl implements SellerProfileRepository {
  final NetworkInfo info;

  SellerProfileRepositoryImpl(this.info);

  @override
  Future<Either<Failure, Result<List<SellerSinglePromoPost>>>>
      getPromoPosts() async {
    if (await info.isConnected) {
      try {
        return Right(Result(value: posts));
      } on Exception {
        return Left(Failure(error: ServerError()));
      }
    } else {
      return Left(Failure(error: InternetError()));
    }
  }

  final List<SellerSinglePromoPost> posts = [
    SellerSinglePromoPost("New Phone Release", "image"),
    SellerSinglePromoPost("Discount this month", "image"),
    SellerSinglePromoPost("New Update.", "image")
  ];

  @override
  Future<Either<Failure, Result<SellerProfileDetails>>>
      getSellerProfile() async {
    if (await info.isConnected) {
      try {
        return Right(Result(value: SellerProfileDetails.demo()));
      } on Exception {
        return Left(Failure(error: ServerError()));
      }
    } else {
      return Left(Failure(error: InternetError()));
    }
  }
}
