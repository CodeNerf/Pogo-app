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


/** This is an auto generated class representing the UserIssueFactorValues type in your schema. */
@immutable
class UserIssueFactorValues extends Model {
  static const classType = const _UserIssueFactorValuesModelType();
  final String id;
  final String? _userId;
  final double? _climateScore;
  final double? _climateWeight;
  final double? _drugPolicyScore;
  final double? _drugPolicyWeight;
  final double? _economyScore;
  final double? _economyWeight;
  final double? _educationScore;
  final double? _educationWeight;
  final double? _gunPolicyScore;
  final double? _gunPolicyWeight;
  final double? _healthcareScore;
  final double? _healthcareWeight;
  final double? _housingScore;
  final double? _housingWeight;
  final double? _immigrationScore;
  final double? _immigrationWeight;
  final double? _policingScore;
  final double? _policingWeight;
  final double? _reproductiveScore;
  final double? _reproductiveWeight;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  UserIssueFactorValuesModelIdentifier get modelIdentifier {
      return UserIssueFactorValuesModelIdentifier(
        id: id
      );
  }
  
  String get userId {
    try {
      return _userId!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  double? get climateScore {
    return _climateScore;
  }
  
  double? get climateWeight {
    return _climateWeight;
  }
  
  double? get drugPolicyScore {
    return _drugPolicyScore;
  }
  
  double? get drugPolicyWeight {
    return _drugPolicyWeight;
  }
  
  double? get economyScore {
    return _economyScore;
  }
  
  double? get economyWeight {
    return _economyWeight;
  }
  
  double? get educationScore {
    return _educationScore;
  }
  
  double? get educationWeight {
    return _educationWeight;
  }
  
  double? get gunPolicyScore {
    return _gunPolicyScore;
  }
  
  double? get gunPolicyWeight {
    return _gunPolicyWeight;
  }
  
  double? get healthcareScore {
    return _healthcareScore;
  }
  
  double? get healthcareWeight {
    return _healthcareWeight;
  }
  
  double? get housingScore {
    return _housingScore;
  }
  
  double? get housingWeight {
    return _housingWeight;
  }
  
  double? get immigrationScore {
    return _immigrationScore;
  }
  
  double? get immigrationWeight {
    return _immigrationWeight;
  }
  
  double? get policingScore {
    return _policingScore;
  }
  
  double? get policingWeight {
    return _policingWeight;
  }
  
  double? get reproductiveScore {
    return _reproductiveScore;
  }
  
  double? get reproductiveWeight {
    return _reproductiveWeight;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const UserIssueFactorValues._internal({required this.id, required userId, climateScore, climateWeight, drugPolicyScore, drugPolicyWeight, economyScore, economyWeight, educationScore, educationWeight, gunPolicyScore, gunPolicyWeight, healthcareScore, healthcareWeight, housingScore, housingWeight, immigrationScore, immigrationWeight, policingScore, policingWeight, reproductiveScore, reproductiveWeight, createdAt, updatedAt}): _userId = userId, _climateScore = climateScore, _climateWeight = climateWeight, _drugPolicyScore = drugPolicyScore, _drugPolicyWeight = drugPolicyWeight, _economyScore = economyScore, _economyWeight = economyWeight, _educationScore = educationScore, _educationWeight = educationWeight, _gunPolicyScore = gunPolicyScore, _gunPolicyWeight = gunPolicyWeight, _healthcareScore = healthcareScore, _healthcareWeight = healthcareWeight, _housingScore = housingScore, _housingWeight = housingWeight, _immigrationScore = immigrationScore, _immigrationWeight = immigrationWeight, _policingScore = policingScore, _policingWeight = policingWeight, _reproductiveScore = reproductiveScore, _reproductiveWeight = reproductiveWeight, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory UserIssueFactorValues({String? id, required String userId, double? climateScore, double? climateWeight, double? drugPolicyScore, double? drugPolicyWeight, double? economyScore, double? economyWeight, double? educationScore, double? educationWeight, double? gunPolicyScore, double? gunPolicyWeight, double? healthcareScore, double? healthcareWeight, double? housingScore, double? housingWeight, double? immigrationScore, double? immigrationWeight, double? policingScore, double? policingWeight, double? reproductiveScore, double? reproductiveWeight}) {
    return UserIssueFactorValues._internal(
      id: id == null ? UUID.getUUID() : id,
      userId: userId,
      climateScore: climateScore,
      climateWeight: climateWeight,
      drugPolicyScore: drugPolicyScore,
      drugPolicyWeight: drugPolicyWeight,
      economyScore: economyScore,
      economyWeight: economyWeight,
      educationScore: educationScore,
      educationWeight: educationWeight,
      gunPolicyScore: gunPolicyScore,
      gunPolicyWeight: gunPolicyWeight,
      healthcareScore: healthcareScore,
      healthcareWeight: healthcareWeight,
      housingScore: housingScore,
      housingWeight: housingWeight,
      immigrationScore: immigrationScore,
      immigrationWeight: immigrationWeight,
      policingScore: policingScore,
      policingWeight: policingWeight,
      reproductiveScore: reproductiveScore,
      reproductiveWeight: reproductiveWeight);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserIssueFactorValues &&
      id == other.id &&
      _userId == other._userId &&
      _climateScore == other._climateScore &&
      _climateWeight == other._climateWeight &&
      _drugPolicyScore == other._drugPolicyScore &&
      _drugPolicyWeight == other._drugPolicyWeight &&
      _economyScore == other._economyScore &&
      _economyWeight == other._economyWeight &&
      _educationScore == other._educationScore &&
      _educationWeight == other._educationWeight &&
      _gunPolicyScore == other._gunPolicyScore &&
      _gunPolicyWeight == other._gunPolicyWeight &&
      _healthcareScore == other._healthcareScore &&
      _healthcareWeight == other._healthcareWeight &&
      _housingScore == other._housingScore &&
      _housingWeight == other._housingWeight &&
      _immigrationScore == other._immigrationScore &&
      _immigrationWeight == other._immigrationWeight &&
      _policingScore == other._policingScore &&
      _policingWeight == other._policingWeight &&
      _reproductiveScore == other._reproductiveScore &&
      _reproductiveWeight == other._reproductiveWeight;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("UserIssueFactorValues {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("userId=" + "$_userId" + ", ");
    buffer.write("climateScore=" + (_climateScore != null ? _climateScore!.toString() : "null") + ", ");
    buffer.write("climateWeight=" + (_climateWeight != null ? _climateWeight!.toString() : "null") + ", ");
    buffer.write("drugPolicyScore=" + (_drugPolicyScore != null ? _drugPolicyScore!.toString() : "null") + ", ");
    buffer.write("drugPolicyWeight=" + (_drugPolicyWeight != null ? _drugPolicyWeight!.toString() : "null") + ", ");
    buffer.write("economyScore=" + (_economyScore != null ? _economyScore!.toString() : "null") + ", ");
    buffer.write("economyWeight=" + (_economyWeight != null ? _economyWeight!.toString() : "null") + ", ");
    buffer.write("educationScore=" + (_educationScore != null ? _educationScore!.toString() : "null") + ", ");
    buffer.write("educationWeight=" + (_educationWeight != null ? _educationWeight!.toString() : "null") + ", ");
    buffer.write("gunPolicyScore=" + (_gunPolicyScore != null ? _gunPolicyScore!.toString() : "null") + ", ");
    buffer.write("gunPolicyWeight=" + (_gunPolicyWeight != null ? _gunPolicyWeight!.toString() : "null") + ", ");
    buffer.write("healthcareScore=" + (_healthcareScore != null ? _healthcareScore!.toString() : "null") + ", ");
    buffer.write("healthcareWeight=" + (_healthcareWeight != null ? _healthcareWeight!.toString() : "null") + ", ");
    buffer.write("housingScore=" + (_housingScore != null ? _housingScore!.toString() : "null") + ", ");
    buffer.write("housingWeight=" + (_housingWeight != null ? _housingWeight!.toString() : "null") + ", ");
    buffer.write("immigrationScore=" + (_immigrationScore != null ? _immigrationScore!.toString() : "null") + ", ");
    buffer.write("immigrationWeight=" + (_immigrationWeight != null ? _immigrationWeight!.toString() : "null") + ", ");
    buffer.write("policingScore=" + (_policingScore != null ? _policingScore!.toString() : "null") + ", ");
    buffer.write("policingWeight=" + (_policingWeight != null ? _policingWeight!.toString() : "null") + ", ");
    buffer.write("reproductiveScore=" + (_reproductiveScore != null ? _reproductiveScore!.toString() : "null") + ", ");
    buffer.write("reproductiveWeight=" + (_reproductiveWeight != null ? _reproductiveWeight!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  UserIssueFactorValues copyWith({String? userId, double? climateScore, double? climateWeight, double? drugPolicyScore, double? drugPolicyWeight, double? economyScore, double? economyWeight, double? educationScore, double? educationWeight, double? gunPolicyScore, double? gunPolicyWeight, double? healthcareScore, double? healthcareWeight, double? housingScore, double? housingWeight, double? immigrationScore, double? immigrationWeight, double? policingScore, double? policingWeight, double? reproductiveScore, double? reproductiveWeight}) {
    return UserIssueFactorValues._internal(
      id: id,
      userId: userId ?? this.userId,
      climateScore: climateScore ?? this.climateScore,
      climateWeight: climateWeight ?? this.climateWeight,
      drugPolicyScore: drugPolicyScore ?? this.drugPolicyScore,
      drugPolicyWeight: drugPolicyWeight ?? this.drugPolicyWeight,
      economyScore: economyScore ?? this.economyScore,
      economyWeight: economyWeight ?? this.economyWeight,
      educationScore: educationScore ?? this.educationScore,
      educationWeight: educationWeight ?? this.educationWeight,
      gunPolicyScore: gunPolicyScore ?? this.gunPolicyScore,
      gunPolicyWeight: gunPolicyWeight ?? this.gunPolicyWeight,
      healthcareScore: healthcareScore ?? this.healthcareScore,
      healthcareWeight: healthcareWeight ?? this.healthcareWeight,
      housingScore: housingScore ?? this.housingScore,
      housingWeight: housingWeight ?? this.housingWeight,
      immigrationScore: immigrationScore ?? this.immigrationScore,
      immigrationWeight: immigrationWeight ?? this.immigrationWeight,
      policingScore: policingScore ?? this.policingScore,
      policingWeight: policingWeight ?? this.policingWeight,
      reproductiveScore: reproductiveScore ?? this.reproductiveScore,
      reproductiveWeight: reproductiveWeight ?? this.reproductiveWeight);
  }
  
  UserIssueFactorValues.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _userId = json['userId'],
      _climateScore = (json['climateScore'] as num?)?.toDouble(),
      _climateWeight = (json['climateWeight'] as num?)?.toDouble(),
      _drugPolicyScore = (json['drugPolicyScore'] as num?)?.toDouble(),
      _drugPolicyWeight = (json['drugPolicyWeight'] as num?)?.toDouble(),
      _economyScore = (json['economyScore'] as num?)?.toDouble(),
      _economyWeight = (json['economyWeight'] as num?)?.toDouble(),
      _educationScore = (json['educationScore'] as num?)?.toDouble(),
      _educationWeight = (json['educationWeight'] as num?)?.toDouble(),
      _gunPolicyScore = (json['gunPolicyScore'] as num?)?.toDouble(),
      _gunPolicyWeight = (json['gunPolicyWeight'] as num?)?.toDouble(),
      _healthcareScore = (json['healthcareScore'] as num?)?.toDouble(),
      _healthcareWeight = (json['healthcareWeight'] as num?)?.toDouble(),
      _housingScore = (json['housingScore'] as num?)?.toDouble(),
      _housingWeight = (json['housingWeight'] as num?)?.toDouble(),
      _immigrationScore = (json['immigrationScore'] as num?)?.toDouble(),
      _immigrationWeight = (json['immigrationWeight'] as num?)?.toDouble(),
      _policingScore = (json['policingScore'] as num?)?.toDouble(),
      _policingWeight = (json['policingWeight'] as num?)?.toDouble(),
      _reproductiveScore = (json['reproductiveScore'] as num?)?.toDouble(),
      _reproductiveWeight = (json['reproductiveWeight'] as num?)?.toDouble(),
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'userId': _userId, 'climateScore': _climateScore, 'climateWeight': _climateWeight, 'drugPolicyScore': _drugPolicyScore, 'drugPolicyWeight': _drugPolicyWeight, 'economyScore': _economyScore, 'economyWeight': _economyWeight, 'educationScore': _educationScore, 'educationWeight': _educationWeight, 'gunPolicyScore': _gunPolicyScore, 'gunPolicyWeight': _gunPolicyWeight, 'healthcareScore': _healthcareScore, 'healthcareWeight': _healthcareWeight, 'housingScore': _housingScore, 'housingWeight': _housingWeight, 'immigrationScore': _immigrationScore, 'immigrationWeight': _immigrationWeight, 'policingScore': _policingScore, 'policingWeight': _policingWeight, 'reproductiveScore': _reproductiveScore, 'reproductiveWeight': _reproductiveWeight, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'userId': _userId, 'climateScore': _climateScore, 'climateWeight': _climateWeight, 'drugPolicyScore': _drugPolicyScore, 'drugPolicyWeight': _drugPolicyWeight, 'economyScore': _economyScore, 'economyWeight': _economyWeight, 'educationScore': _educationScore, 'educationWeight': _educationWeight, 'gunPolicyScore': _gunPolicyScore, 'gunPolicyWeight': _gunPolicyWeight, 'healthcareScore': _healthcareScore, 'healthcareWeight': _healthcareWeight, 'housingScore': _housingScore, 'housingWeight': _housingWeight, 'immigrationScore': _immigrationScore, 'immigrationWeight': _immigrationWeight, 'policingScore': _policingScore, 'policingWeight': _policingWeight, 'reproductiveScore': _reproductiveScore, 'reproductiveWeight': _reproductiveWeight, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryModelIdentifier<UserIssueFactorValuesModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<UserIssueFactorValuesModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField USERID = QueryField(fieldName: "userId");
  static final QueryField CLIMATESCORE = QueryField(fieldName: "climateScore");
  static final QueryField CLIMATEWEIGHT = QueryField(fieldName: "climateWeight");
  static final QueryField DRUGPOLICYSCORE = QueryField(fieldName: "drugPolicyScore");
  static final QueryField DRUGPOLICYWEIGHT = QueryField(fieldName: "drugPolicyWeight");
  static final QueryField ECONOMYSCORE = QueryField(fieldName: "economyScore");
  static final QueryField ECONOMYWEIGHT = QueryField(fieldName: "economyWeight");
  static final QueryField EDUCATIONSCORE = QueryField(fieldName: "educationScore");
  static final QueryField EDUCATIONWEIGHT = QueryField(fieldName: "educationWeight");
  static final QueryField GUNPOLICYSCORE = QueryField(fieldName: "gunPolicyScore");
  static final QueryField GUNPOLICYWEIGHT = QueryField(fieldName: "gunPolicyWeight");
  static final QueryField HEALTHCARESCORE = QueryField(fieldName: "healthcareScore");
  static final QueryField HEALTHCAREWEIGHT = QueryField(fieldName: "healthcareWeight");
  static final QueryField HOUSINGSCORE = QueryField(fieldName: "housingScore");
  static final QueryField HOUSINGWEIGHT = QueryField(fieldName: "housingWeight");
  static final QueryField IMMIGRATIONSCORE = QueryField(fieldName: "immigrationScore");
  static final QueryField IMMIGRATIONWEIGHT = QueryField(fieldName: "immigrationWeight");
  static final QueryField POLICINGSCORE = QueryField(fieldName: "policingScore");
  static final QueryField POLICINGWEIGHT = QueryField(fieldName: "policingWeight");
  static final QueryField REPRODUCTIVESCORE = QueryField(fieldName: "reproductiveScore");
  static final QueryField REPRODUCTIVEWEIGHT = QueryField(fieldName: "reproductiveWeight");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "UserIssueFactorValues";
    modelSchemaDefinition.pluralName = "UserIssueFactorValues";
    
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
      key: UserIssueFactorValues.USERID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserIssueFactorValues.CLIMATESCORE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserIssueFactorValues.CLIMATEWEIGHT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserIssueFactorValues.DRUGPOLICYSCORE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserIssueFactorValues.DRUGPOLICYWEIGHT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserIssueFactorValues.ECONOMYSCORE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserIssueFactorValues.ECONOMYWEIGHT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserIssueFactorValues.EDUCATIONSCORE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserIssueFactorValues.EDUCATIONWEIGHT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserIssueFactorValues.GUNPOLICYSCORE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserIssueFactorValues.GUNPOLICYWEIGHT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserIssueFactorValues.HEALTHCARESCORE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserIssueFactorValues.HEALTHCAREWEIGHT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserIssueFactorValues.HOUSINGSCORE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserIssueFactorValues.HOUSINGWEIGHT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserIssueFactorValues.IMMIGRATIONSCORE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserIssueFactorValues.IMMIGRATIONWEIGHT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserIssueFactorValues.POLICINGSCORE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserIssueFactorValues.POLICINGWEIGHT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserIssueFactorValues.REPRODUCTIVESCORE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserIssueFactorValues.REPRODUCTIVEWEIGHT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
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

class _UserIssueFactorValuesModelType extends ModelType<UserIssueFactorValues> {
  const _UserIssueFactorValuesModelType();
  
  @override
  UserIssueFactorValues fromJson(Map<String, dynamic> jsonData) {
    return UserIssueFactorValues.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'UserIssueFactorValues';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [UserIssueFactorValues] in your schema.
 */
@immutable
class UserIssueFactorValuesModelIdentifier implements ModelIdentifier<UserIssueFactorValues> {
  final String id;

  /** Create an instance of UserIssueFactorValuesModelIdentifier using [id] the primary key. */
  const UserIssueFactorValuesModelIdentifier({
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
  String toString() => 'UserIssueFactorValuesModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is UserIssueFactorValuesModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}