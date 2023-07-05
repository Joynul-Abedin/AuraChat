import 'package:chat_app/generated/json/base/json_convert_content.dart';
import 'package:chat_app/models/test_entity.dart';

TestEntity $TestEntityFromJson(Map<String, dynamic> json) {
	final TestEntity testEntity = TestEntity();
	final String? createdAt = jsonConvert.convert<String>(json['createdAt']);
	if (createdAt != null) {
		testEntity.createdAt = createdAt;
	}
	final String? updatedAt = jsonConvert.convert<String>(json['updatedAt']);
	if (updatedAt != null) {
		testEntity.updatedAt = updatedAt;
	}
	final bool? isActive = jsonConvert.convert<bool>(json['isActive']);
	if (isActive != null) {
		testEntity.isActive = isActive;
	}
	final bool? isRemoved = jsonConvert.convert<bool>(json['isRemoved']);
	if (isRemoved != null) {
		testEntity.isRemoved = isRemoved;
	}
	final int? createdBy = jsonConvert.convert<int>(json['createdBy']);
	if (createdBy != null) {
		testEntity.createdBy = createdBy;
	}
	final int? updatedBy = jsonConvert.convert<int>(json['updatedBy']);
	if (updatedBy != null) {
		testEntity.updatedBy = updatedBy;
	}
	final String? remarks = jsonConvert.convert<String>(json['remarks']);
	if (remarks != null) {
		testEntity.remarks = remarks;
	}
	final String? email = jsonConvert.convert<String>(json['email']);
	if (email != null) {
		testEntity.email = email;
	}
	final String? phoneNumber = jsonConvert.convert<String>(json['phoneNumber']);
	if (phoneNumber != null) {
		testEntity.phoneNumber = phoneNumber;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		testEntity.name = name;
	}
	final int? userTypeId = jsonConvert.convert<int>(json['userTypeId']);
	if (userTypeId != null) {
		testEntity.userTypeId = userTypeId;
	}
	return testEntity;
}

Map<String, dynamic> $TestEntityToJson(TestEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['createdAt'] = entity.createdAt;
	data['updatedAt'] = entity.updatedAt;
	data['isActive'] = entity.isActive;
	data['isRemoved'] = entity.isRemoved;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['remarks'] = entity.remarks;
	data['email'] = entity.email;
	data['phoneNumber'] = entity.phoneNumber;
	data['name'] = entity.name;
	data['userTypeId'] = entity.userTypeId;
	return data;
}