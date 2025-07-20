
import '../../domain/Entities/ServiceProviderEntity.dart';

class ServiceProviderModel extends ServiceProviderEntity {
  const ServiceProviderModel({
    super.id, // Pass id to super
    required super.nameOfService,
    required super.nameOfEmployee,
    required super.address,
  });

  /// Factory constructor to create a ServiceProviderModel from a JSON map.
  factory ServiceProviderModel.fromJson(Map<String, dynamic> json) {
    return ServiceProviderModel(
      id: json['id'] as String?, // ID might be stored in the document itself or as the key
      nameOfService: json['nameOfService'] as String,
      nameOfEmployee: json['nameOfEmployee'] as String,
      address: json['address'] as String,
    );
  }

  /// Converts this ServiceProviderModel instance into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'nameOfService': nameOfService,
      'nameOfEmployee': nameOfEmployee,
      'address': address,
      // 'id': id, // Usually, ID is the document key, not stored inside the document
    };
  }

  /// Creates a new ServiceProviderModel with updated ID.
  ServiceProviderModel copyWith({String? id}) {
    return ServiceProviderModel(
      id: id ?? this.id,
      nameOfService: nameOfService,
      nameOfEmployee: nameOfEmployee,
      address: address,
    );
  }
}