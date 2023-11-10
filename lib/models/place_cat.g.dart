// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_cat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceCat _$PlaceCatFromJson(Map<String, dynamic> json) => PlaceCat(
      id: json['id'] as int?,
      name: json['name'] as String,
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlaceCatToJson(PlaceCat instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address.toJson(),
    };
