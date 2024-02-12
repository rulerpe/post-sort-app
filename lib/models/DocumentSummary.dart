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

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;


/** This is an auto generated class representing the DocumentSummary type in your schema. */
class DocumentSummary {
  final String? _documentId;
  final String? _originalText;
  final String? _shortSummary;
  final String? _longSummary;
  final String? _shortSummaryZh;
  final String? _longSummaryZh;

  String get documentId {
    try {
      return _documentId!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get originalText {
    try {
      return _originalText!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get shortSummary {
    return _shortSummary;
  }
  
  String? get longSummary {
    return _longSummary;
  }
  
  String? get shortSummaryZh {
    return _shortSummaryZh;
  }
  
  String? get longSummaryZh {
    return _longSummaryZh;
  }
  
  const DocumentSummary._internal({required documentId, required originalText, shortSummary, longSummary, shortSummaryZh, longSummaryZh}): _documentId = documentId, _originalText = originalText, _shortSummary = shortSummary, _longSummary = longSummary, _shortSummaryZh = shortSummaryZh, _longSummaryZh = longSummaryZh;
  
  factory DocumentSummary({required String documentId, required String originalText, String? shortSummary, String? longSummary, String? shortSummaryZh, String? longSummaryZh}) {
    return DocumentSummary._internal(
      documentId: documentId,
      originalText: originalText,
      shortSummary: shortSummary,
      longSummary: longSummary,
      shortSummaryZh: shortSummaryZh,
      longSummaryZh: longSummaryZh);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DocumentSummary &&
      _documentId == other._documentId &&
      _originalText == other._originalText &&
      _shortSummary == other._shortSummary &&
      _longSummary == other._longSummary &&
      _shortSummaryZh == other._shortSummaryZh &&
      _longSummaryZh == other._longSummaryZh;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("DocumentSummary {");
    buffer.write("documentId=" + "$_documentId" + ", ");
    buffer.write("originalText=" + "$_originalText" + ", ");
    buffer.write("shortSummary=" + "$_shortSummary" + ", ");
    buffer.write("longSummary=" + "$_longSummary" + ", ");
    buffer.write("shortSummaryZh=" + "$_shortSummaryZh" + ", ");
    buffer.write("longSummaryZh=" + "$_longSummaryZh");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  DocumentSummary copyWith({String? documentId, String? originalText, String? shortSummary, String? longSummary, String? shortSummaryZh, String? longSummaryZh}) {
    return DocumentSummary._internal(
      documentId: documentId ?? this.documentId,
      originalText: originalText ?? this.originalText,
      shortSummary: shortSummary ?? this.shortSummary,
      longSummary: longSummary ?? this.longSummary,
      shortSummaryZh: shortSummaryZh ?? this.shortSummaryZh,
      longSummaryZh: longSummaryZh ?? this.longSummaryZh);
  }
  
  DocumentSummary copyWithModelFieldValues({
    ModelFieldValue<String>? documentId,
    ModelFieldValue<String>? originalText,
    ModelFieldValue<String?>? shortSummary,
    ModelFieldValue<String?>? longSummary,
    ModelFieldValue<String?>? shortSummaryZh,
    ModelFieldValue<String?>? longSummaryZh
  }) {
    return DocumentSummary._internal(
      documentId: documentId == null ? this.documentId : documentId.value,
      originalText: originalText == null ? this.originalText : originalText.value,
      shortSummary: shortSummary == null ? this.shortSummary : shortSummary.value,
      longSummary: longSummary == null ? this.longSummary : longSummary.value,
      shortSummaryZh: shortSummaryZh == null ? this.shortSummaryZh : shortSummaryZh.value,
      longSummaryZh: longSummaryZh == null ? this.longSummaryZh : longSummaryZh.value
    );
  }
  
  DocumentSummary.fromJson(Map<String, dynamic> json)  
    : _documentId = json['documentId'],
      _originalText = json['originalText'],
      _shortSummary = json['shortSummary'],
      _longSummary = json['longSummary'],
      _shortSummaryZh = json['shortSummaryZh'],
      _longSummaryZh = json['longSummaryZh'];
  
  Map<String, dynamic> toJson() => {
    'documentId': _documentId, 'originalText': _originalText, 'shortSummary': _shortSummary, 'longSummary': _longSummary, 'shortSummaryZh': _shortSummaryZh, 'longSummaryZh': _longSummaryZh
  };
  
  Map<String, Object?> toMap() => {
    'documentId': _documentId,
    'originalText': _originalText,
    'shortSummary': _shortSummary,
    'longSummary': _longSummary,
    'shortSummaryZh': _shortSummaryZh,
    'longSummaryZh': _longSummaryZh
  };

  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "DocumentSummary";
    modelSchemaDefinition.pluralName = "DocumentSummaries";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'documentId',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'originalText',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'shortSummary',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'longSummary',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'shortSummaryZh',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'longSummaryZh',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
  });
}