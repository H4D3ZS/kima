import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'for_sale.g.dart';

@JsonSerializable(includeIfNull: false)
class ForSale extends Equatable {
  final double price;
  final String itemCondition;

  const ForSale({
    required this.price,
    required this.itemCondition,
  });

  @override
  List<Object?> get props => [price, itemCondition];

  ForSale copyWith({
    double? price,
    String? itemCondition,
  }) =>
      ForSale(
        price: price ?? this.price,
        itemCondition: itemCondition ?? this.itemCondition,
      );

  Map<String, dynamic> toJson() => _$ForSaleToJson(this);

  factory ForSale.fromJson(Map<String, dynamic> json) => _$ForSaleFromJson(json);

  @override
  String toString() {
    return 'ForSale{price: $price, itemCondition: $itemCondition}';
  }
}
