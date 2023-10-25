// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      details: json['details'] as String,
      postalCode: json['postalCode'] as int,
      city: City.fromJson(json['city'] as Map<String, dynamic>),
      state: State.fromJson(json['state'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'details': instance.details,
      'postalCode': instance.postalCode,
      'city': instance.city.toJson(),
      'state': instance.state.toJson(),
    };
