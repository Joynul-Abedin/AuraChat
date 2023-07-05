import 'package:chat_app/generated/json/base/json_field.dart';
import 'package:chat_app/generated/json/test_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class TestEntity {
	late String createdAt;
	late String updatedAt;
	late bool isActive;
	late bool isRemoved;
	late int createdBy;
	late int updatedBy;
	late String remarks;
	late String email;
	late String phoneNumber;
	late String name;
	late int userTypeId;

	TestEntity();

	factory TestEntity.fromJson(Map<String, dynamic> json) => $TestEntityFromJson(json);

	Map<String, dynamic> toJson() => $TestEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}