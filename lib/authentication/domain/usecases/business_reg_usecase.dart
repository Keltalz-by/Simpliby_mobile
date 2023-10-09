import 'package:either_dart/either.dart';
import 'package:simplibuy/authentication/data/models/business_reg_details.dart';
import 'package:simplibuy/authentication/data/repositories/business_reg_repo.dart';
import '../../../core/failure/failure.dart';
import '../../../core/result/result.dart';

class BusinessRegUsecase {
  final BusinessRegRepository repository;

  BusinessRegUsecase(this.repository);

  Future<Either<Failure, Result<String>>> sendBusinessDetails(
      BusinessRegDetails details) async {
    return repository.sendBusinessDetails(details);
  }
}
