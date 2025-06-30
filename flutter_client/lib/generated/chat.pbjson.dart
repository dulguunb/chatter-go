// This is a generated file - do not edit.
//
// Generated from chat.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use userDescriptor instead')
const User$json = {
  '1': 'User',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    {'1': 'display_name', '3': 3, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'avatar_url', '3': 4, '4': 1, '5': 9, '10': 'avatarUrl'},
    {'1': 'available', '3': 5, '4': 1, '5': 8, '10': 'available'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode(
    'CgRVc2VyEg4KAmlkGAEgASgJUgJpZBIaCgh1c2VybmFtZRgCIAEoCVIIdXNlcm5hbWUSIQoMZG'
    'lzcGxheV9uYW1lGAMgASgJUgtkaXNwbGF5TmFtZRIdCgphdmF0YXJfdXJsGAQgASgJUglhdmF0'
    'YXJVcmwSHAoJYXZhaWxhYmxlGAUgASgIUglhdmFpbGFibGU=');

@$core.Deprecated('Use messageDescriptor instead')
const Message$json = {
  '1': 'Message',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'conversation_id', '3': 2, '4': 1, '5': 9, '10': 'conversationId'},
    {'1': 'sender_id', '3': 3, '4': 1, '5': 9, '10': 'senderId'},
    {'1': 'content', '3': 4, '4': 1, '5': 9, '10': 'content'},
    {'1': 'timestamp', '3': 5, '4': 1, '5': 3, '10': 'timestamp'},
    {'1': 'username', '3': 6, '4': 1, '5': 9, '10': 'username'},
  ],
};

/// Descriptor for `Message`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messageDescriptor = $convert.base64Decode(
    'CgdNZXNzYWdlEg4KAmlkGAEgASgJUgJpZBInCg9jb252ZXJzYXRpb25faWQYAiABKAlSDmNvbn'
    'ZlcnNhdGlvbklkEhsKCXNlbmRlcl9pZBgDIAEoCVIIc2VuZGVySWQSGAoHY29udGVudBgEIAEo'
    'CVIHY29udGVudBIcCgl0aW1lc3RhbXAYBSABKANSCXRpbWVzdGFtcBIaCgh1c2VybmFtZRgGIA'
    'EoCVIIdXNlcm5hbWU=');

@$core.Deprecated('Use conversationDescriptor instead')
const Conversation$json = {
  '1': 'Conversation',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'participant_ids', '3': 2, '4': 3, '5': 9, '10': 'participantIds'},
    {'1': 'name', '3': 4, '4': 1, '5': 9, '10': 'name'},
    {'1': 'last_message_id', '3': 5, '4': 1, '5': 9, '10': 'lastMessageId'},
  ],
};

/// Descriptor for `Conversation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List conversationDescriptor = $convert.base64Decode(
    'CgxDb252ZXJzYXRpb24SDgoCaWQYASABKAlSAmlkEicKD3BhcnRpY2lwYW50X2lkcxgCIAMoCV'
    'IOcGFydGljaXBhbnRJZHMSEgoEbmFtZRgEIAEoCVIEbmFtZRImCg9sYXN0X21lc3NhZ2VfaWQY'
    'BSABKAlSDWxhc3RNZXNzYWdlSWQ=');

@$core.Deprecated('Use publicKeyDescriptor instead')
const PublicKey$json = {
  '1': 'PublicKey',
  '2': [
    {'1': 'participant_id', '3': 1, '4': 1, '5': 9, '10': 'participantId'},
    {'1': 'public_key', '3': 2, '4': 1, '5': 9, '10': 'publicKey'},
  ],
};

/// Descriptor for `PublicKey`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List publicKeyDescriptor = $convert.base64Decode(
    'CglQdWJsaWNLZXkSJQoOcGFydGljaXBhbnRfaWQYASABKAlSDXBhcnRpY2lwYW50SWQSHQoKcH'
    'VibGljX2tleRgCIAEoCVIJcHVibGljS2V5');

@$core.Deprecated('Use publicKeySendRequestDescriptor instead')
const PublicKeySendRequest$json = {
  '1': 'PublicKeySendRequest',
  '2': [
    {'1': 'participant_id', '3': 1, '4': 1, '5': 9, '10': 'participantId'},
    {'1': 'public_key', '3': 2, '4': 1, '5': 9, '10': 'publicKey'},
  ],
};

/// Descriptor for `PublicKeySendRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List publicKeySendRequestDescriptor = $convert.base64Decode(
    'ChRQdWJsaWNLZXlTZW5kUmVxdWVzdBIlCg5wYXJ0aWNpcGFudF9pZBgBIAEoCVINcGFydGljaX'
    'BhbnRJZBIdCgpwdWJsaWNfa2V5GAIgASgJUglwdWJsaWNLZXk=');

@$core.Deprecated('Use publicKeySendResponseDescriptor instead')
const PublicKeySendResponse$json = {
  '1': 'PublicKeySendResponse',
  '2': [
    {'1': 'participant_id', '3': 1, '4': 1, '5': 9, '10': 'participantId'},
    {'1': 'success', '3': 2, '4': 1, '5': 5, '10': 'success'},
  ],
};

/// Descriptor for `PublicKeySendResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List publicKeySendResponseDescriptor = $convert.base64Decode(
    'ChVQdWJsaWNLZXlTZW5kUmVzcG9uc2USJQoOcGFydGljaXBhbnRfaWQYASABKAlSDXBhcnRpY2'
    'lwYW50SWQSGAoHc3VjY2VzcxgCIAEoBVIHc3VjY2Vzcw==');

@$core.Deprecated('Use publicKeyRequestDescriptor instead')
const PublicKeyRequest$json = {
  '1': 'PublicKeyRequest',
  '2': [
    {'1': 'participant_id', '3': 1, '4': 1, '5': 9, '10': 'participantId'},
  ],
};

/// Descriptor for `PublicKeyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List publicKeyRequestDescriptor = $convert.base64Decode(
    'ChBQdWJsaWNLZXlSZXF1ZXN0EiUKDnBhcnRpY2lwYW50X2lkGAEgASgJUg1wYXJ0aWNpcGFudE'
    'lk');

@$core.Deprecated('Use publicKeyResponseDescriptor instead')
const PublicKeyResponse$json = {
  '1': 'PublicKeyResponse',
  '2': [
    {'1': 'participant_id', '3': 1, '4': 1, '5': 9, '10': 'participantId'},
    {'1': 'public_key', '3': 2, '4': 1, '5': 9, '10': 'publicKey'},
  ],
};

/// Descriptor for `PublicKeyResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List publicKeyResponseDescriptor = $convert.base64Decode(
    'ChFQdWJsaWNLZXlSZXNwb25zZRIlCg5wYXJ0aWNpcGFudF9pZBgBIAEoCVINcGFydGljaXBhbn'
    'RJZBIdCgpwdWJsaWNfa2V5GAIgASgJUglwdWJsaWNLZXk=');

@$core.Deprecated('Use sendMessageRequestDescriptor instead')
const SendMessageRequest$json = {
  '1': 'SendMessageRequest',
  '2': [
    {'1': 'conversation_id', '3': 1, '4': 1, '5': 9, '10': 'conversationId'},
    {'1': 'sender_id', '3': 2, '4': 1, '5': 9, '10': 'senderId'},
    {'1': 'content', '3': 3, '4': 1, '5': 9, '10': 'content'},
    {'1': 'username', '3': 4, '4': 1, '5': 9, '10': 'username'},
  ],
};

/// Descriptor for `SendMessageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendMessageRequestDescriptor = $convert.base64Decode(
    'ChJTZW5kTWVzc2FnZVJlcXVlc3QSJwoPY29udmVyc2F0aW9uX2lkGAEgASgJUg5jb252ZXJzYX'
    'Rpb25JZBIbCglzZW5kZXJfaWQYAiABKAlSCHNlbmRlcklkEhgKB2NvbnRlbnQYAyABKAlSB2Nv'
    'bnRlbnQSGgoIdXNlcm5hbWUYBCABKAlSCHVzZXJuYW1l');

@$core.Deprecated('Use sendMessageResponseDescriptor instead')
const SendMessageResponse$json = {
  '1': 'SendMessageResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 11, '6': '.chatter_message.Message', '10': 'message'},
  ],
};

/// Descriptor for `SendMessageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendMessageResponseDescriptor = $convert.base64Decode(
    'ChNTZW5kTWVzc2FnZVJlc3BvbnNlEjIKB21lc3NhZ2UYASABKAsyGC5jaGF0dGVyX21lc3NhZ2'
    'UuTWVzc2FnZVIHbWVzc2FnZQ==');

@$core.Deprecated('Use getConversationsRequestDescriptor instead')
const GetConversationsRequest$json = {
  '1': 'GetConversationsRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetConversationsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getConversationsRequestDescriptor = $convert.base64Decode(
    'ChdHZXRDb252ZXJzYXRpb25zUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQ=');

@$core.Deprecated('Use getConversationsResponseDescriptor instead')
const GetConversationsResponse$json = {
  '1': 'GetConversationsResponse',
  '2': [
    {'1': 'conversations', '3': 1, '4': 3, '5': 11, '6': '.chatter_message.Conversation', '10': 'conversations'},
  ],
};

/// Descriptor for `GetConversationsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getConversationsResponseDescriptor = $convert.base64Decode(
    'ChhHZXRDb252ZXJzYXRpb25zUmVzcG9uc2USQwoNY29udmVyc2F0aW9ucxgBIAMoCzIdLmNoYX'
    'R0ZXJfbWVzc2FnZS5Db252ZXJzYXRpb25SDWNvbnZlcnNhdGlvbnM=');

@$core.Deprecated('Use getMessagesRequestDescriptor instead')
const GetMessagesRequest$json = {
  '1': 'GetMessagesRequest',
  '2': [
    {'1': 'conversation_id', '3': 1, '4': 1, '5': 9, '10': 'conversationId'},
    {'1': 'limit', '3': 2, '4': 1, '5': 3, '10': 'limit'},
    {'1': 'offset', '3': 3, '4': 1, '5': 3, '10': 'offset'},
  ],
};

/// Descriptor for `GetMessagesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMessagesRequestDescriptor = $convert.base64Decode(
    'ChJHZXRNZXNzYWdlc1JlcXVlc3QSJwoPY29udmVyc2F0aW9uX2lkGAEgASgJUg5jb252ZXJzYX'
    'Rpb25JZBIUCgVsaW1pdBgCIAEoA1IFbGltaXQSFgoGb2Zmc2V0GAMgASgDUgZvZmZzZXQ=');

@$core.Deprecated('Use getMessagesResponseDescriptor instead')
const GetMessagesResponse$json = {
  '1': 'GetMessagesResponse',
  '2': [
    {'1': 'messages', '3': 1, '4': 3, '5': 11, '6': '.chatter_message.Message', '10': 'messages'},
  ],
};

/// Descriptor for `GetMessagesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMessagesResponseDescriptor = $convert.base64Decode(
    'ChNHZXRNZXNzYWdlc1Jlc3BvbnNlEjQKCG1lc3NhZ2VzGAEgAygLMhguY2hhdHRlcl9tZXNzYW'
    'dlLk1lc3NhZ2VSCG1lc3NhZ2Vz');

@$core.Deprecated('Use createConversationRequestDescriptor instead')
const CreateConversationRequest$json = {
  '1': 'CreateConversationRequest',
  '2': [
    {'1': 'participant_ids', '3': 1, '4': 3, '5': 9, '10': 'participantIds'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `CreateConversationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createConversationRequestDescriptor = $convert.base64Decode(
    'ChlDcmVhdGVDb252ZXJzYXRpb25SZXF1ZXN0EicKD3BhcnRpY2lwYW50X2lkcxgBIAMoCVIOcG'
    'FydGljaXBhbnRJZHMSEgoEbmFtZRgCIAEoCVIEbmFtZQ==');

@$core.Deprecated('Use createConversationResponseDescriptor instead')
const CreateConversationResponse$json = {
  '1': 'CreateConversationResponse',
  '2': [
    {'1': 'conversation', '3': 1, '4': 1, '5': 11, '6': '.chatter_message.Conversation', '10': 'conversation'},
  ],
};

/// Descriptor for `CreateConversationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createConversationResponseDescriptor = $convert.base64Decode(
    'ChpDcmVhdGVDb252ZXJzYXRpb25SZXNwb25zZRJBCgxjb252ZXJzYXRpb24YASABKAsyHS5jaG'
    'F0dGVyX21lc3NhZ2UuQ29udmVyc2F0aW9uUgxjb252ZXJzYXRpb24=');

@$core.Deprecated('Use getAvailableUsersRequestDescriptor instead')
const GetAvailableUsersRequest$json = {
  '1': 'GetAvailableUsersRequest',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.chatter_message.User', '10': 'user'},
  ],
};

/// Descriptor for `GetAvailableUsersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAvailableUsersRequestDescriptor = $convert.base64Decode(
    'ChhHZXRBdmFpbGFibGVVc2Vyc1JlcXVlc3QSKQoEdXNlchgBIAEoCzIVLmNoYXR0ZXJfbWVzc2'
    'FnZS5Vc2VyUgR1c2Vy');

@$core.Deprecated('Use getAvailableUsersResponseDescriptor instead')
const GetAvailableUsersResponse$json = {
  '1': 'GetAvailableUsersResponse',
  '2': [
    {'1': 'users', '3': 1, '4': 3, '5': 11, '6': '.chatter_message.User', '10': 'users'},
  ],
};

/// Descriptor for `GetAvailableUsersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAvailableUsersResponseDescriptor = $convert.base64Decode(
    'ChlHZXRBdmFpbGFibGVVc2Vyc1Jlc3BvbnNlEisKBXVzZXJzGAEgAygLMhUuY2hhdHRlcl9tZX'
    'NzYWdlLlVzZXJSBXVzZXJz');

@$core.Deprecated('Use addUserRequestDescriptor instead')
const AddUserRequest$json = {
  '1': 'AddUserRequest',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.chatter_message.User', '10': 'user'},
  ],
};

/// Descriptor for `AddUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addUserRequestDescriptor = $convert.base64Decode(
    'Cg5BZGRVc2VyUmVxdWVzdBIpCgR1c2VyGAEgASgLMhUuY2hhdHRlcl9tZXNzYWdlLlVzZXJSBH'
    'VzZXI=');

@$core.Deprecated('Use addUserResponseDescriptor instead')
const AddUserResponse$json = {
  '1': 'AddUserResponse',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.chatter_message.User', '10': 'user'},
  ],
};

/// Descriptor for `AddUserResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addUserResponseDescriptor = $convert.base64Decode(
    'Cg9BZGRVc2VyUmVzcG9uc2USKQoEdXNlchgBIAEoCzIVLmNoYXR0ZXJfbWVzc2FnZS5Vc2VyUg'
    'R1c2Vy');

