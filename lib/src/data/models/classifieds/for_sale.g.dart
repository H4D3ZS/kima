// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'for_sale.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForSale _$ForSaleFromJson(Map<String, dynamic> json) => ForSale(
      price: (json['price'] as num).toDouble(),
      itemCondition: json['itemCondition'] as String,
    );

Map<String, dynamic> _$ForSaleToJson(ForSale instance) => <String, dynamic>{
      'price': instance.price,
      'itemCondition': instance.itemCondition,
    };
