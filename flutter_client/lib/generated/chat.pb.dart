// This is a generated file - do not edit.
//
// Generated from chat.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class User extends $pb.GeneratedMessage {
  factory User({
    $core.String? id,
    $core.String? username,
    $core.String? displayName,
    $core.String? avatarUrl,
    $core.bool? available,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (username != null) result.username = username;
    if (displayName != null) result.displayName = displayName;
    if (avatarUrl != null) result.avatarUrl = avatarUrl;
    if (available != null) result.available = available;
    return result;
  }

  User._();

  factory User.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory User.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'User', package: const $pb.PackageName(_omitMessageNames ? '' : 'chatter_message'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'username')
    ..aOS(3, _omitFieldNames ? '' : 'displayName')
    ..aOS(4, _omitFieldNames ? '' : 'avatarUrl')
    ..aOB(5, _omitFieldNames ? '' : 'available')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  User clone() => User()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  User copyWith(void Function(User) updates) => super.copyWith((message) => updates(message as User)) as User;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static User create() => User._();
  @$core.override
  User createEmptyInstance() => create();
  static $pb.PbList<User> createRepeated() => $pb.PbList<User>();
  @$core.pragma('dart2js:noInline')
  static User getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<User>(create);
  static User? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get username => $_getSZ(1);
  @$pb.TagNumber(2)
  set username($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUsername() => $_has(1);
  @$pb.TagNumber(2)
  void clearUsername() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get displayName => $_getSZ(2);
  @$pb.TagNumber(3)
  set displayName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDisplayName() => $_has(2);
  @$pb.TagNumber(3)
  void clearDisplayName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get avatarUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set avatarUrl($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAvatarUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearAvatarUrl() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get available => $_getBF(4);
  @$pb.TagNumber(5)
  set available($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAvailable() => $_has(4);
  @$pb.TagNumber(5)
  void clearAvailable() => $_clearField(5);
}

class Message extends $pb.GeneratedMessage {
  factory Message({
    $core.String? id,
    $core.String? conversationId,
    $core.String? senderId,
    $core.String? content,
    $fixnum.Int64? timestamp,
    $core.String? username,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (conversationId != null) result.conversationId = conversationId;
    if (senderId != null) result.senderId = senderId;
    if (content != null) result.content = content;
    if (timestamp != null) result.timestamp = timestamp;
    if (username != null) result.username = username;
    return result;
  }

  Message._();

  factory Message.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory Message.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Message', package: const $pb.PackageName(_omitMessageNames ? '' : 'chatter_message'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'conversationId')
    ..aOS(3, _omitFieldNames ? '' : 'senderId')
    ..aOS(4, _omitFieldNames ? '' : 'content')
    ..aInt64(5, _omitFieldNames ? '' : 'timestamp')
    ..aOS(6, _omitFieldNames ? '' : 'username')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Message clone() => Message()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Message copyWith(void Function(Message) updates) => super.copyWith((message) => updates(message as Message)) as Message;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Message create() => Message._();
  @$core.override
  Message createEmptyInstance() => create();
  static $pb.PbList<Message> createRepeated() => $pb.PbList<Message>();
  @$core.pragma('dart2js:noInline')
  static Message getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Message>(create);
  static Message? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get conversationId => $_getSZ(1);
  @$pb.TagNumber(2)
  set conversationId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasConversationId() => $_has(1);
  @$pb.TagNumber(2)
  void clearConversationId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get senderId => $_getSZ(2);
  @$pb.TagNumber(3)
  set senderId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSenderId() => $_has(2);
  @$pb.TagNumber(3)
  void clearSenderId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get content => $_getSZ(3);
  @$pb.TagNumber(4)
  set content($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasContent() => $_has(3);
  @$pb.TagNumber(4)
  void clearContent() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get timestamp => $_getI64(4);
  @$pb.TagNumber(5)
  set timestamp($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTimestamp() => $_has(4);
  @$pb.TagNumber(5)
  void clearTimestamp() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get username => $_getSZ(5);
  @$pb.TagNumber(6)
  set username($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasUsername() => $_has(5);
  @$pb.TagNumber(6)
  void clearUsername() => $_clearField(6);
}

class Conversation extends $pb.GeneratedMessage {
  factory Conversation({
    $core.String? id,
    $core.Iterable<$core.String>? participantIds,
    $core.String? name,
    $core.String? lastMessageId,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (participantIds != null) result.participantIds.addAll(participantIds);
    if (name != null) result.name = name;
    if (lastMessageId != null) result.lastMessageId = lastMessageId;
    return result;
  }

  Conversation._();

  factory Conversation.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory Conversation.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Conversation', package: const $pb.PackageName(_omitMessageNames ? '' : 'chatter_message'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..pPS(2, _omitFieldNames ? '' : 'participantIds')
    ..aOS(4, _omitFieldNames ? '' : 'name')
    ..aOS(5, _omitFieldNames ? '' : 'lastMessageId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Conversation clone() => Conversation()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Conversation copyWith(void Function(Conversation) updates) => super.copyWith((message) => updates(message as Conversation)) as Conversation;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Conversation create() => Conversation._();
  @$core.override
  Conversation createEmptyInstance() => create();
  static $pb.PbList<Conversation> createRepeated() => $pb.PbList<Conversation>();
  @$core.pragma('dart2js:noInline')
  static Conversation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Conversation>(create);
  static Conversation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get participantIds => $_getList(1);

  @$pb.TagNumber(4)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(4)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(4)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(4)
  void clearName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get lastMessageId => $_getSZ(3);
  @$pb.TagNumber(5)
  set lastMessageId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(5)
  $core.bool hasLastMessageId() => $_has(3);
  @$pb.TagNumber(5)
  void clearLastMessageId() => $_clearField(5);
}

class PublicKey extends $pb.GeneratedMessage {
  factory PublicKey({
    $core.String? participantId,
    $core.String? publicKey,
  }) {
    final result = create();
    if (participantId != null) result.participantId = participantId;
    if (publicKey != null) result.publicKey = publicKey;
    return result;
  }

  PublicKey._();

  factory PublicKey.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory PublicKey.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PublicKey', package: const $pb.PackageName(_omitMessageNames ? '' : 'chatter_message'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'participantId')
    ..aOS(2, _omitFieldNames ? '' : 'publicKey')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PublicKey clone() => PublicKey()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PublicKey copyWith(void Function(PublicKey) updates) => super.copyWith((message) => updates(message as PublicKey)) as PublicKey;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PublicKey create() => PublicKey._();
  @$core.override
  PublicKey createEmptyInstance() => create();
  static $pb.PbList<PublicKey> createRepeated() => $pb.PbList<PublicKey>();
  @$core.pragma('dart2js:noInline')
  static PublicKey getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PublicKey>(create);
  static PublicKey? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get participantId => $_getSZ(0);
  @$pb.TagNumber(1)
  set participantId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasParticipantId() => $_has(0);
  @$pb.TagNumber(1)
  void clearParticipantId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get publicKey => $_getSZ(1);
  @$pb.TagNumber(2)
  set publicKey($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPublicKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearPublicKey() => $_clearField(2);
}

/// === Requests / Responses ===
class PublicKeySendRequest extends $pb.GeneratedMessage {
  factory PublicKeySendRequest({
    $core.String? participantId,
    $core.String? publicKey,
  }) {
    final result = create();
    if (participantId != null) result.participantId = participantId;
    if (publicKey != null) result.publicKey = publicKey;
    return result;
  }

  PublicKeySendRequest._();

  factory PublicKeySendRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory PublicKeySendRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PublicKeySendRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'chatter_message'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'participantId')
    ..aOS(2, _omitFieldNames ? '' : 'publicKey')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PublicKeySendRequest clone() => PublicKeySendRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PublicKeySendRequest copyWith(void Function(PublicKeySendRequest) updates) => super.copyWith((message) => updates(message as PublicKeySendRequest)) as PublicKeySendRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PublicKeySendRequest create() => PublicKeySendRequest._();
  @$core.override
  PublicKeySendRequest createEmptyInstance() => create();
  static $pb.PbList<PublicKeySendRequest> createRepeated() => $pb.PbList<PublicKeySendRequest>();
  @$core.pragma('dart2js:noInline')
  static PublicKeySendRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PublicKeySendRequest>(create);
  static PublicKeySendRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get participantId => $_getSZ(0);
  @$pb.TagNumber(1)
  set participantId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasParticipantId() => $_has(0);
  @$pb.TagNumber(1)
  void clearParticipantId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get publicKey => $_getSZ(1);
  @$pb.TagNumber(2)
  set publicKey($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPublicKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearPublicKey() => $_clearField(2);
}

class PublicKeySendResponse extends $pb.GeneratedMessage {
  factory PublicKeySendResponse({
    $core.String? participantId,
    $core.int? success,
  }) {
    final result = create();
    if (participantId != null) result.participantId = participantId;
    if (success != null) result.success = success;
    return result;
  }

  PublicKeySendResponse._();

  factory PublicKeySendResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory PublicKeySendResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PublicKeySendResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'chatter_message'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'participantId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'success', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PublicKeySendResponse clone() => PublicKeySendResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PublicKeySendResponse copyWith(void Function(PublicKeySendResponse) updates) => super.copyWith((message) => updates(message as PublicKeySendResponse)) as PublicKeySendResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PublicKeySendResponse create() => PublicKeySendResponse._();
  @$core.override
  PublicKeySendResponse createEmptyInstance() => create();
  static $pb.PbList<PublicKeySendResponse> createRepeated() => $pb.PbList<PublicKeySendResponse>();
  @$core.pragma('dart2js:noInline')
  static PublicKeySendResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PublicKeySendResponse>(create);
  static PublicKeySendResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get participantId => $_getSZ(0);
  @$pb.TagNumber(1)
  set participantId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasParticipantId() => $_has(0);
  @$pb.TagNumber(1)
  void clearParticipantId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get success => $_getIZ(1);
  @$pb.TagNumber(2)
  set success($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);
}

class PublicKeyRequest extends $pb.GeneratedMessage {
  factory PublicKeyRequest({
    $core.String? participantId,
  }) {
    final result = create();
    if (participantId != null) result.participantId = participantId;
    return result;
  }

  PublicKeyRequest._();

  factory PublicKeyRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory PublicKeyRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PublicKeyRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'chatter_message'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'participantId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PublicKeyRequest clone() => PublicKeyRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PublicKeyRequest copyWith(void Function(PublicKeyRequest) updates) => super.copyWith((message) => updates(message as PublicKeyRequest)) as PublicKeyRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PublicKeyRequest create() => PublicKeyRequest._();
  @$core.override
  PublicKeyRequest createEmptyInstance() => create();
  static $pb.PbList<PublicKeyRequest> createRepeated() => $pb.PbList<PublicKeyRequest>();
  @$core.pragma('dart2js:noInline')
  static PublicKeyRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PublicKeyRequest>(create);
  static PublicKeyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get participantId => $_getSZ(0);
  @$pb.TagNumber(1)
  set participantId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasParticipantId() => $_has(0);
  @$pb.TagNumber(1)
  void clearParticipantId() => $_clearField(1);
}

class PublicKeyResponse extends $pb.GeneratedMessage {
  factory PublicKeyResponse({
    $core.String? participantId,
    $core.String? publicKey,
  }) {
    final result = create();
    if (participantId != null) result.participantId = participantId;
    if (publicKey != null) result.publicKey = publicKey;
    return result;
  }

  PublicKeyResponse._();

  factory PublicKeyResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory PublicKeyResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PublicKeyResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'chatter_message'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'participantId')
    ..aOS(2, _omitFieldNames ? '' : 'publicKey')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PublicKeyResponse clone() => PublicKeyResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PublicKeyResponse copyWith(void Function(PublicKeyResponse) updates) => super.copyWith((message) => updates(message as PublicKeyResponse)) as PublicKeyResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PublicKeyResponse create() => PublicKeyResponse._();
  @$core.override
  PublicKeyResponse createEmptyInstance() => create();
  static $pb.PbList<PublicKeyResponse> createRepeated() => $pb.PbList<PublicKeyResponse>();
  @$core.pragma('dart2js:noInline')
  static PublicKeyResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PublicKeyResponse>(create);
  static PublicKeyResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get participantId => $_getSZ(0);
  @$pb.TagNumber(1)
  set participantId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasParticipantId() => $_has(0);
  @$pb.TagNumber(1)
  void clearParticipantId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get publicKey => $_getSZ(1);
  @$pb.TagNumber(2)
  set publicKey($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPublicKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearPublicKey() => $_clearField(2);
}

class SendMessageRequest extends $pb.GeneratedMessage {
  factory SendMessageRequest({
    $core.String? conversationId,
    $core.String? senderId,
    $core.String? content,
    $core.String? username,
  }) {
    final result = create();
    if (conversationId != null) result.conversationId = conversationId;
    if (senderId != null) result.senderId = senderId;
    if (content != null) result.content = content;
    if (username != null) result.username = username;
    return result;
  }

  SendMessageRequest._();

  factory SendMessageRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory SendMessageRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SendMessageRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'chatter_message'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'conversationId')
    ..aOS(2, _omitFieldNames ? '' : 'senderId')
    ..aOS(3, _omitFieldNames ? '' : 'content')
    ..aOS(4, _omitFieldNames ? '' : 'username')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendMessageRequest clone() => SendMessageRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendMessageRequest copyWith(void Function(SendMessageRequest) updates) => super.copyWith((message) => updates(message as SendMessageRequest)) as SendMessageRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendMessageRequest create() => SendMessageRequest._();
  @$core.override
  SendMessageRequest createEmptyInstance() => create();
  static $pb.PbList<SendMessageRequest> createRepeated() => $pb.PbList<SendMessageRequest>();
  @$core.pragma('dart2js:noInline')
  static SendMessageRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendMessageRequest>(create);
  static SendMessageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get conversationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set conversationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConversationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearConversationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get senderId => $_getSZ(1);
  @$pb.TagNumber(2)
  set senderId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSenderId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSenderId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get content => $_getSZ(2);
  @$pb.TagNumber(3)
  set content($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasContent() => $_has(2);
  @$pb.TagNumber(3)
  void clearContent() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get username => $_getSZ(3);
  @$pb.TagNumber(4)
  set username($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUsername() => $_has(3);
  @$pb.TagNumber(4)
  void clearUsername() => $_clearField(4);
}

class SendMessageResponse extends $pb.GeneratedMessage {
  factory SendMessageResponse({
    Message? message,
  }) {
    final result = create();
    if (message != null) result.message = message;
    return result;
  }

  SendMessageResponse._();

  factory SendMessageResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory SendMessageResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SendMessageResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'chatter_message'), createEmptyInstance: create)
    ..aOM<Message>(1, _omitFieldNames ? '' : 'message', subBuilder: Message.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendMessageResponse clone() => SendMessageResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendMessageResponse copyWith(void Function(SendMessageResponse) updates) => super.copyWith((message) => updates(message as SendMessageResponse)) as SendMessageResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendMessageResponse create() => SendMessageResponse._();
  @$core.override
  SendMessageResponse createEmptyInstance() => create();
  static $pb.PbList<SendMessageResponse> createRepeated() => $pb.PbList<SendMessageResponse>();
  @$core.pragma('dart2js:noInline')
  static SendMessageResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendMessageResponse>(create);
  static SendMessageResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Message get message => $_getN(0);
  @$pb.TagNumber(1)
  set message(Message value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => $_clearField(1);
  @$pb.TagNumber(1)
  Message ensureMessage() => $_ensure(0);
}

class GetConversationsRequest extends $pb.GeneratedMessage {
  factory GetConversationsRequest({
    $core.String? userId,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    return result;
  }

  GetConversationsRequest._();

  factory GetConversationsRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetConversationsRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetConversationsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'chatter_message'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetConversationsRequest clone() => GetConversationsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetConversationsRequest copyWith(void Function(GetConversationsRequest) updates) => super.copyWith((message) => updates(message as GetConversationsRequest)) as GetConversationsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetConversationsRequest create() => GetConversationsRequest._();
  @$core.override
  GetConversationsRequest createEmptyInstance() => create();
  static $pb.PbList<GetConversationsRequest> createRepeated() => $pb.PbList<GetConversationsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetConversationsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetConversationsRequest>(create);
  static GetConversationsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

class GetConversationsResponse extends $pb.GeneratedMessage {
  factory GetConversationsResponse({
    $core.Iterable<Conversation>? conversations,
  }) {
    final result = create();
    if (conversations != null) result.conversations.addAll(conversations);
    return result;
  }

  GetConversationsResponse._();

  factory GetConversationsResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetConversationsResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetConversationsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'chatter_message'), createEmptyInstance: create)
    ..pc<Conversation>(1, _omitFieldNames ? '' : 'conversations', $pb.PbFieldType.PM, subBuilder: Conversation.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetConversationsResponse clone() => GetConversationsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetConversationsResponse copyWith(void Function(GetConversationsResponse) updates) => super.copyWith((message) => updates(message as GetConversationsResponse)) as GetConversationsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetConversationsResponse create() => GetConversationsResponse._();
  @$core.override
  GetConversationsResponse createEmptyInstance() => create();
  static $pb.PbList<GetConversationsResponse> createRepeated() => $pb.PbList<GetConversationsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetConversationsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetConversationsResponse>(create);
  static GetConversationsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Conversation> get conversations => $_getList(0);
}

class GetMessagesRequest extends $pb.GeneratedMessage {
  factory GetMessagesRequest({
    $core.String? conversationId,
    $fixnum.Int64? limit,
    $fixnum.Int64? offset,
  }) {
    final result = create();
    if (conversationId != null) result.conversationId = conversationId;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetMessagesRequest._();

  factory GetMessagesRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetMessagesRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMessagesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'chatter_message'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'conversationId')
    ..aInt64(2, _omitFieldNames ? '' : 'limit')
    ..aInt64(3, _omitFieldNames ? '' : 'offset')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMessagesRequest clone() => GetMessagesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMessagesRequest copyWith(void Function(GetMessagesRequest) updates) => super.copyWith((message) => updates(message as GetMessagesRequest)) as GetMessagesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMessagesRequest create() => GetMessagesRequest._();
  @$core.override
  GetMessagesRequest createEmptyInstance() => create();
  static $pb.PbList<GetMessagesRequest> createRepeated() => $pb.PbList<GetMessagesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMessagesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMessagesRequest>(create);
  static GetMessagesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get conversationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set conversationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConversationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearConversationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get limit => $_getI64(1);
  @$pb.TagNumber(2)
  set limit($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get offset => $_getI64(2);
  @$pb.TagNumber(3)
  set offset($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOffset() => $_has(2);
  @$pb.TagNumber(3)
  void clearOffset() => $_clearField(3);
}

class GetMessagesResponse extends $pb.GeneratedMessage {
  factory GetMessagesResponse({
    $core.Iterable<Message>? messages,
  }) {
    final result = create();
    if (messages != null) result.messages.addAll(messages);
    return result;
  }

  GetMessagesResponse._();

  factory GetMessagesResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetMessagesResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMessagesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'chatter_message'), createEmptyInstance: create)
    ..pc<Message>(1, _omitFieldNames ? '' : 'messages', $pb.PbFieldType.PM, subBuilder: Message.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMessagesResponse clone() => GetMessagesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMessagesResponse copyWith(void Function(GetMessagesResponse) updates) => super.copyWith((message) => updates(message as GetMessagesResponse)) as GetMessagesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMessagesResponse create() => GetMessagesResponse._();
  @$core.override
  GetMessagesResponse createEmptyInstance() => create();
  static $pb.PbList<GetMessagesResponse> createRepeated() => $pb.PbList<GetMessagesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMessagesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMessagesResponse>(create);
  static GetMessagesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Message> get messages => $_getList(0);
}

class CreateConversationRequest extends $pb.GeneratedMessage {
  factory CreateConversationRequest({
    $core.Iterable<$core.String>? participantIds,
    $core.String? name,
  }) {
    final result = create();
    if (participantIds != null) result.participantIds.addAll(participantIds);
    if (name != null) result.name = name;
    return result;
  }

  CreateConversationRequest._();

  factory CreateConversationRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory CreateConversationRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateConversationRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'chatter_message'), createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'participantIds')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateConversationRequest clone() => CreateConversationRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateConversationRequest copyWith(void Function(CreateConversationRequest) updates) => super.copyWith((message) => updates(message as CreateConversationRequest)) as CreateConversationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateConversationRequest create() => CreateConversationRequest._();
  @$core.override
  CreateConversationRequest createEmptyInstance() => create();
  static $pb.PbList<CreateConversationRequest> createRepeated() => $pb.PbList<CreateConversationRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateConversationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateConversationRequest>(create);
  static CreateConversationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get participantIds => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);
}

class CreateConversationResponse extends $pb.GeneratedMessage {
  factory CreateConversationResponse({
    Conversation? conversation,
  }) {
    final result = create();
    if (conversation != null) result.conversation = conversation;
    return result;
  }

  CreateConversationResponse._();

  factory CreateConversationResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory CreateConversationResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateConversationResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'chatter_message'), createEmptyInstance: create)
    ..aOM<Conversation>(1, _omitFieldNames ? '' : 'conversation', subBuilder: Conversation.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateConversationResponse clone() => CreateConversationResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateConversationResponse copyWith(void Function(CreateConversationResponse) updates) => super.copyWith((message) => updates(message as CreateConversationResponse)) as CreateConversationResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateConversationResponse create() => CreateConversationResponse._();
  @$core.override
  CreateConversationResponse createEmptyInstance() => create();
  static $pb.PbList<CreateConversationResponse> createRepeated() => $pb.PbList<CreateConversationResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateConversationResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateConversationResponse>(create);
  static CreateConversationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Conversation get conversation => $_getN(0);
  @$pb.TagNumber(1)
  set conversation(Conversation value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasConversation() => $_has(0);
  @$pb.TagNumber(1)
  void clearConversation() => $_clearField(1);
  @$pb.TagNumber(1)
  Conversation ensureConversation() => $_ensure(0);
}

/// === Chat Service ===
class GetAvailableUsersRequest extends $pb.GeneratedMessage {
  factory GetAvailableUsersRequest({
    User? user,
  }) {
    final result = create();
    if (user != null) result.user = user;
    return result;
  }

  GetAvailableUsersRequest._();

  factory GetAvailableUsersRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetAvailableUsersRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAvailableUsersRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'chatter_message'), createEmptyInstance: create)
    ..aOM<User>(1, _omitFieldNames ? '' : 'user', subBuilder: User.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAvailableUsersRequest clone() => GetAvailableUsersRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAvailableUsersRequest copyWith(void Function(GetAvailableUsersRequest) updates) => super.copyWith((message) => updates(message as GetAvailableUsersRequest)) as GetAvailableUsersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAvailableUsersRequest create() => GetAvailableUsersRequest._();
  @$core.override
  GetAvailableUsersRequest createEmptyInstance() => create();
  static $pb.PbList<GetAvailableUsersRequest> createRepeated() => $pb.PbList<GetAvailableUsersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAvailableUsersRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAvailableUsersRequest>(create);
  static GetAvailableUsersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(User value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => $_clearField(1);
  @$pb.TagNumber(1)
  User ensureUser() => $_ensure(0);
}

class GetAvailableUsersResponse extends $pb.GeneratedMessage {
  factory GetAvailableUsersResponse({
    $core.Iterable<User>? users,
  }) {
    final result = create();
    if (users != null) result.users.addAll(users);
    return result;
  }

  GetAvailableUsersResponse._();

  factory GetAvailableUsersResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetAvailableUsersResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAvailableUsersResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'chatter_message'), createEmptyInstance: create)
    ..pc<User>(1, _omitFieldNames ? '' : 'users', $pb.PbFieldType.PM, subBuilder: User.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAvailableUsersResponse clone() => GetAvailableUsersResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAvailableUsersResponse copyWith(void Function(GetAvailableUsersResponse) updates) => super.copyWith((message) => updates(message as GetAvailableUsersResponse)) as GetAvailableUsersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAvailableUsersResponse create() => GetAvailableUsersResponse._();
  @$core.override
  GetAvailableUsersResponse createEmptyInstance() => create();
  static $pb.PbList<GetAvailableUsersResponse> createRepeated() => $pb.PbList<GetAvailableUsersResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAvailableUsersResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAvailableUsersResponse>(create);
  static GetAvailableUsersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<User> get users => $_getList(0);
}

class AddUserRequest extends $pb.GeneratedMessage {
  factory AddUserRequest({
    User? user,
  }) {
    final result = create();
    if (user != null) result.user = user;
    return result;
  }

  AddUserRequest._();

  factory AddUserRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory AddUserRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddUserRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'chatter_message'), createEmptyInstance: create)
    ..aOM<User>(1, _omitFieldNames ? '' : 'user', subBuilder: User.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddUserRequest clone() => AddUserRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddUserRequest copyWith(void Function(AddUserRequest) updates) => super.copyWith((message) => updates(message as AddUserRequest)) as AddUserRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddUserRequest create() => AddUserRequest._();
  @$core.override
  AddUserRequest createEmptyInstance() => create();
  static $pb.PbList<AddUserRequest> createRepeated() => $pb.PbList<AddUserRequest>();
  @$core.pragma('dart2js:noInline')
  static AddUserRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddUserRequest>(create);
  static AddUserRequest? _defaultInstance;

  @$pb.TagNumber(1)
  User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(User value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => $_clearField(1);
  @$pb.TagNumber(1)
  User ensureUser() => $_ensure(0);
}

class AddUserResponse extends $pb.GeneratedMessage {
  factory AddUserResponse({
    User? user,
  }) {
    final result = create();
    if (user != null) result.user = user;
    return result;
  }

  AddUserResponse._();

  factory AddUserResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory AddUserResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddUserResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'chatter_message'), createEmptyInstance: create)
    ..aOM<User>(1, _omitFieldNames ? '' : 'user', subBuilder: User.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddUserResponse clone() => AddUserResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddUserResponse copyWith(void Function(AddUserResponse) updates) => super.copyWith((message) => updates(message as AddUserResponse)) as AddUserResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddUserResponse create() => AddUserResponse._();
  @$core.override
  AddUserResponse createEmptyInstance() => create();
  static $pb.PbList<AddUserResponse> createRepeated() => $pb.PbList<AddUserResponse>();
  @$core.pragma('dart2js:noInline')
  static AddUserResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddUserResponse>(create);
  static AddUserResponse? _defaultInstance;

  @$pb.TagNumber(1)
  User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(User value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => $_clearField(1);
  @$pb.TagNumber(1)
  User ensureUser() => $_ensure(0);
}


const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
