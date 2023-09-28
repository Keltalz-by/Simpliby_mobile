import 'package:equatable/equatable.dart';

class StoreCategory extends Equatable {
  final int categoryId;
  final String categoryName;
  final String categoryImage;

  StoreCategory(this.categoryId, this.categoryName, this.categoryImage);
  @override
  List<Object?> get props => [categoryId, categoryImage, categoryName];
}
