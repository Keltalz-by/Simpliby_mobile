import 'package:either_dart/either.dart';
import 'package:simplibuy/core/failure/failure.dart';
import 'package:simplibuy/core/result/result.dart';
import 'package:simplibuy/seller_store/data/models/seller_profile_details.dart';
import 'package:simplibuy/seller_store/domain/repo/seller_profile_repository.dart';

class SellerProfileUsecase {
  SellerProfileRepository repo;

  SellerProfileUsecase(this.repo);

  Future<Either<Failure, Result<SellerProfileDetails>>> getSellerProfile() {
    return repo.getSellerProfile();
  }

  Future<Either<Failure, Result<List<SellerSinglePromoPost>>>> getPromoPosts() {
    return repo.getPromoPosts();
  }
}
