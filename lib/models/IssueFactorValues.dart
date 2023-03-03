/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the IssueFactorValues type in your schema. */
@immutable
class IssueFactorValues extends Model {
  static const classType = const _IssueFactorValuesModelType();
  final String id;
  final String? _candidateName;
  final String? _zipCode;
  final String? _state;
  final String? _politicalParty;
  final int? _immigrationIssueFactor;
  final int? _reproductiveRightsIssueFactor;
  final int? _housingIssueFactor;
  final int? _drugPolicyIssueFactor;
  final int? _policingIssueFactor;
  final int? _economyIssueFactor;
  final int? _climateIssueFactor;
  final int? _gunPolicyIssueFactor;
  final int? _healthcareIssueFactor;
  final int? _educationIssueFactor;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  IssueFactorValuesModelIdentifier get modelIdentifier {
      return IssueFactorValuesModelIdentifier(
        id: id
      );
  }
  
  String? get candidateName {
    return _candidateName;
  }
  
  String? get zipCode {
    return _zipCode;
  }
  
  String? get state {
    return _state;
  }
  
  String? get politicalParty {
    return _politicalParty;
  }
  
  int? get immigrationIssueFactor {
    return _immigrationIssueFactor;
  }
  
  int? get reproductiveRightsIssueFactor {
    return _reproductiveRightsIssueFactor;
  }
  
  int? get housingIssueFactor {
    return _housingIssueFactor;
  }
  
  int? get drugPolicyIssueFactor {
    return _drugPolicyIssueFactor;
  }
  
  int? get policingIssueFactor {
    return _policingIssueFactor;
  }
  
  int? get economyIssueFactor {
    return _economyIssueFactor;
  }
  
  int? get climateIssueFactor {
    return _climateIssueFactor;
  }
  
  int? get gunPolicyIssueFactor {
    return _gunPolicyIssueFactor;
  }
  
  int? get healthcareIssueFactor {
    return _healthcareIssueFactor;
  }
  
  int? get educationIssueFactor {
    return _educationIssueFactor;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const IssueFactorValues._internal({required this.id, candidateName, zipCode, state, politicalParty, immigrationIssueFactor, reproductiveRightsIssueFactor, housingIssueFactor, drugPolicyIssueFactor, policingIssueFactor, economyIssueFactor, climateIssueFactor, gunPolicyIssueFactor, healthcareIssueFactor, educationIssueFactor, createdAt, updatedAt}): _candidateName = candidateName, _zipCode = zipCode, _state = state, _politicalParty = politicalParty, _immigrationIssueFactor = immigrationIssueFactor, _reproductiveRightsIssueFactor = reproductiveRightsIssueFactor, _housingIssueFactor = housingIssueFactor, _drugPolicyIssueFactor = drugPolicyIssueFactor, _policingIssueFactor = policingIssueFactor, _economyIssueFactor = economyIssueFactor, _climateIssueFactor = climateIssueFactor, _gunPolicyIssueFactor = gunPolicyIssueFactor, _healthcareIssueFactor = healthcareIssueFactor, _educationIssueFactor = educationIssueFactor, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory IssueFactorValues({String? id, String? candidateName, String? zipCode, String? state, String? politicalParty, int? immigrationIssueFactor, int? reproductiveRightsIssueFactor, int? housingIssueFactor, int? drugPolicyIssueFactor, int? policingIssueFactor, int? economyIssueFactor, int? climateIssueFactor, int? gunPolicyIssueFactor, int? healthcareIssueFactor, int? educationIssueFactor}) {
    return IssueFactorValues._internal(
      id: id == null ? UUID.getUUID() : id,
      candidateName: candidateName,
      zipCode: zipCode,
      state: state,
      politicalParty: politicalParty,
      immigrationIssueFactor: immigrationIssueFactor,
      reproductiveRightsIssueFactor: reproductiveRightsIssueFactor,
      housingIssueFactor: housingIssueFactor,
      drugPolicyIssueFactor: drugPolicyIssueFactor,
      policingIssueFactor: policingIssueFactor,
      economyIssueFactor: economyIssueFactor,
      climateIssueFactor: climateIssueFactor,
      gunPolicyIssueFactor: gunPolicyIssueFactor,
      healthcareIssueFactor: healthcareIssueFactor,
      educationIssueFactor: educationIssueFactor);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is IssueFactorValues &&
      id == other.id &&
      _candidateName == other._candidateName &&
      _zipCode == other._zipCode &&
      _state == other._state &&
      _politicalParty == other._politicalParty &&
      _immigrationIssueFactor == other._immigrationIssueFactor &&
      _reproductiveRightsIssueFactor == other._reproductiveRightsIssueFactor &&
      _housingIssueFactor == other._housingIssueFactor &&
      _drugPolicyIssueFactor == other._drugPolicyIssueFactor &&
      _policingIssueFactor == other._policingIssueFactor &&
      _economyIssueFactor == other._economyIssueFactor &&
      _climateIssueFactor == other._climateIssueFactor &&
      _gunPolicyIssueFactor == other._gunPolicyIssueFactor &&
      _healthcareIssueFactor == other._healthcareIssueFactor &&
      _educationIssueFactor == other._educationIssueFactor;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("IssueFactorValues {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("candidateName=" + "$_candidateName" + ", ");
    buffer.write("zipCode=" + "$_zipCode" + ", ");
    buffer.write("state=" + "$_state" + ", ");
    buffer.write("politicalParty=" + "$_politicalParty" + ", ");
    buffer.write("immigrationIssueFactor=" + (_immigrationIssueFactor != null ? _immigrationIssueFactor!.toString() : "null") + ", ");
    buffer.write("reproductiveRightsIssueFactor=" + (_reproductiveRightsIssueFactor != null ? _reproductiveRightsIssueFactor!.toString() : "null") + ", ");
    buffer.write("housingIssueFactor=" + (_housingIssueFactor != null ? _housingIssueFactor!.toString() : "null") + ", ");
    buffer.write("drugPolicyIssueFactor=" + (_drugPolicyIssueFactor != null ? _drugPolicyIssueFactor!.toString() : "null") + ", ");
    buffer.write("policingIssueFactor=" + (_policingIssueFactor != null ? _policingIssueFactor!.toString() : "null") + ", ");
    buffer.write("economyIssueFactor=" + (_economyIssueFactor != null ? _economyIssueFactor!.toString() : "null") + ", ");
    buffer.write("climateIssueFactor=" + (_climateIssueFactor != null ? _climateIssueFactor!.toString() : "null") + ", ");
    buffer.write("gunPolicyIssueFactor=" + (_gunPolicyIssueFactor != null ? _gunPolicyIssueFactor!.toString() : "null") + ", ");
    buffer.write("healthcareIssueFactor=" + (_healthcareIssueFactor != null ? _healthcareIssueFactor!.toString() : "null") + ", ");
    buffer.write("educationIssueFactor=" + (_educationIssueFactor != null ? _educationIssueFactor!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  IssueFactorValues copyWith({String? candidateName, String? zipCode, String? state, String? politicalParty, int? immigrationIssueFactor, int? reproductiveRightsIssueFactor, int? housingIssueFactor, int? drugPolicyIssueFactor, int? policingIssueFactor, int? economyIssueFactor, int? climateIssueFactor, int? gunPolicyIssueFactor, int? healthcareIssueFactor, int? educationIssueFactor}) {
    return IssueFactorValues._internal(
      id: id,
      candidateName: candidateName ?? this.candidateName,
      zipCode: zipCode ?? this.zipCode,
      state: state ?? this.state,
      politicalParty: politicalParty ?? this.politicalParty,
      immigrationIssueFactor: immigrationIssueFactor ?? this.immigrationIssueFactor,
      reproductiveRightsIssueFactor: reproductiveRightsIssueFactor ?? this.reproductiveRightsIssueFactor,
      housingIssueFactor: housingIssueFactor ?? this.housingIssueFactor,
      drugPolicyIssueFactor: drugPolicyIssueFactor ?? this.drugPolicyIssueFactor,
      policingIssueFactor: policingIssueFactor ?? this.policingIssueFactor,
      economyIssueFactor: economyIssueFactor ?? this.economyIssueFactor,
      climateIssueFactor: climateIssueFactor ?? this.climateIssueFactor,
      gunPolicyIssueFactor: gunPolicyIssueFactor ?? this.gunPolicyIssueFactor,
      healthcareIssueFactor: healthcareIssueFactor ?? this.healthcareIssueFactor,
      educationIssueFactor: educationIssueFactor ?? this.educationIssueFactor);
  }
  
  IssueFactorValues.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _candidateName = json['candidateName'],
      _zipCode = json['zipCode'],
      _state = json['state'],
      _politicalParty = json['politicalParty'],
      _immigrationIssueFactor = (json['immigrationIssueFactor'] as num?)?.toInt(),
      _reproductiveRightsIssueFactor = (json['reproductiveRightsIssueFactor'] as num?)?.toInt(),
      _housingIssueFactor = (json['housingIssueFactor'] as num?)?.toInt(),
      _drugPolicyIssueFactor = (json['drugPolicyIssueFactor'] as num?)?.toInt(),
      _policingIssueFactor = (json['policingIssueFactor'] as num?)?.toInt(),
      _economyIssueFactor = (json['economyIssueFactor'] as num?)?.toInt(),
      _climateIssueFactor = (json['climateIssueFactor'] as num?)?.toInt(),
      _gunPolicyIssueFactor = (json['gunPolicyIssueFactor'] as num?)?.toInt(),
      _healthcareIssueFactor = (json['healthcareIssueFactor'] as num?)?.toInt(),
      _educationIssueFactor = (json['educationIssueFactor'] as num?)?.toInt(),
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'candidateName': _candidateName, 'zipCode': _zipCode, 'state': _state, 'politicalParty': _politicalParty, 'immigrationIssueFactor': _immigrationIssueFactor, 'reproductiveRightsIssueFactor': _reproductiveRightsIssueFactor, 'housingIssueFactor': _housingIssueFactor, 'drugPolicyIssueFactor': _drugPolicyIssueFactor, 'policingIssueFactor': _policingIssueFactor, 'economyIssueFactor': _economyIssueFactor, 'climateIssueFactor': _climateIssueFactor, 'gunPolicyIssueFactor': _gunPolicyIssueFactor, 'healthcareIssueFactor': _healthcareIssueFactor, 'educationIssueFactor': _educationIssueFactor, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'candidateName': _candidateName, 'zipCode': _zipCode, 'state': _state, 'politicalParty': _politicalParty, 'immigrationIssueFactor': _immigrationIssueFactor, 'reproductiveRightsIssueFactor': _reproductiveRightsIssueFactor, 'housingIssueFactor': _housingIssueFactor, 'drugPolicyIssueFactor': _drugPolicyIssueFactor, 'policingIssueFactor': _policingIssueFactor, 'economyIssueFactor': _economyIssueFactor, 'climateIssueFactor': _climateIssueFactor, 'gunPolicyIssueFactor': _gunPolicyIssueFactor, 'healthcareIssueFactor': _healthcareIssueFactor, 'educationIssueFactor': _educationIssueFactor, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryModelIdentifier<IssueFactorValuesModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<IssueFactorValuesModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField CANDIDATENAME = QueryField(fieldName: "candidateName");
  static final QueryField ZIPCODE = QueryField(fieldName: "zipCode");
  static final QueryField STATE = QueryField(fieldName: "state");
  static final QueryField POLITICALPARTY = QueryField(fieldName: "politicalParty");
  static final QueryField IMMIGRATIONISSUEFACTOR = QueryField(fieldName: "immigrationIssueFactor");
  static final QueryField REPRODUCTIVERIGHTSISSUEFACTOR = QueryField(fieldName: "reproductiveRightsIssueFactor");
  static final QueryField HOUSINGISSUEFACTOR = QueryField(fieldName: "housingIssueFactor");
  static final QueryField DRUGPOLICYISSUEFACTOR = QueryField(fieldName: "drugPolicyIssueFactor");
  static final QueryField POLICINGISSUEFACTOR = QueryField(fieldName: "policingIssueFactor");
  static final QueryField ECONOMYISSUEFACTOR = QueryField(fieldName: "economyIssueFactor");
  static final QueryField CLIMATEISSUEFACTOR = QueryField(fieldName: "climateIssueFactor");
  static final QueryField GUNPOLICYISSUEFACTOR = QueryField(fieldName: "gunPolicyIssueFactor");
  static final QueryField HEALTHCAREISSUEFACTOR = QueryField(fieldName: "healthcareIssueFactor");
  static final QueryField EDUCATIONISSUEFACTOR = QueryField(fieldName: "educationIssueFactor");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "IssueFactorValues";
    modelSchemaDefinition.pluralName = "IssueFactorValues";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: IssueFactorValues.CANDIDATENAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: IssueFactorValues.ZIPCODE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: IssueFactorValues.STATE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: IssueFactorValues.POLITICALPARTY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: IssueFactorValues.IMMIGRATIONISSUEFACTOR,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: IssueFactorValues.REPRODUCTIVERIGHTSISSUEFACTOR,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: IssueFactorValues.HOUSINGISSUEFACTOR,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: IssueFactorValues.DRUGPOLICYISSUEFACTOR,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: IssueFactorValues.POLICINGISSUEFACTOR,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: IssueFactorValues.ECONOMYISSUEFACTOR,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: IssueFactorValues.CLIMATEISSUEFACTOR,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: IssueFactorValues.GUNPOLICYISSUEFACTOR,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: IssueFactorValues.HEALTHCAREISSUEFACTOR,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: IssueFactorValues.EDUCATIONISSUEFACTOR,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _IssueFactorValuesModelType extends ModelType<IssueFactorValues> {
  const _IssueFactorValuesModelType();
  
  @override
  IssueFactorValues fromJson(Map<String, dynamic> jsonData) {
    return IssueFactorValues.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'IssueFactorValues';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [IssueFactorValues] in your schema.
 */
@immutable
class IssueFactorValuesModelIdentifier implements ModelIdentifier<IssueFactorValues> {
  final String id;

  /** Create an instance of IssueFactorValuesModelIdentifier using [id] the primary key. */
  const IssueFactorValuesModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'IssueFactorValuesModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is IssueFactorValuesModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}