// This is a generated file - do not edit.
//
// Generated from chat.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'chat.pb.dart' as $0;

export 'chat.pb.dart';

@$pb.GrpcServiceName('chatter_message.ChatService')
class ChatServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  ChatServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.PublicKeySendResponse> sendPublicKey($0.PublicKeySendRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$sendPublicKey, request, options: options);
  }

  $grpc.ResponseFuture<$0.PublicKeyResponse> getPublicKeyOfPartner($0.PublicKeyRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getPublicKeyOfPartner, request, options: options);
  }

  $grpc.ResponseFuture<$0.AddUserResponse> addUser($0.AddUserRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$addUser, request, options: options);
  }

  $grpc.ResponseStream<$0.GetAvailableUsersResponse> streamUsersUpdate($0.GetAvailableUsersRequest request, {$grpc.CallOptions? options,}) {
    return $createStreamingCall(_$streamUsersUpdate, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$0.SendMessageResponse> sendMessage($0.SendMessageRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$sendMessage, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetConversationsResponse> getConversations($0.GetConversationsRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getConversations, request, options: options);
  }

  $grpc.ResponseStream<$0.GetMessagesResponse> getMessagesStream($0.GetMessagesRequest request, {$grpc.CallOptions? options,}) {
    return $createStreamingCall(_$getMessagesStream, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$0.GetMessagesResponse> getMessages($0.GetMessagesRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getMessages, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateConversationResponse> createConversation($0.CreateConversationRequest request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$createConversation, request, options: options);
  }

    // method descriptors

  static final _$sendPublicKey = $grpc.ClientMethod<$0.PublicKeySendRequest, $0.PublicKeySendResponse>(
      '/chatter_message.ChatService/SendPublicKey',
      ($0.PublicKeySendRequest value) => value.writeToBuffer(),
      $0.PublicKeySendResponse.fromBuffer);
  static final _$getPublicKeyOfPartner = $grpc.ClientMethod<$0.PublicKeyRequest, $0.PublicKeyResponse>(
      '/chatter_message.ChatService/GetPublicKeyOfPartner',
      ($0.PublicKeyRequest value) => value.writeToBuffer(),
      $0.PublicKeyResponse.fromBuffer);
  static final _$addUser = $grpc.ClientMethod<$0.AddUserRequest, $0.AddUserResponse>(
      '/chatter_message.ChatService/AddUser',
      ($0.AddUserRequest value) => value.writeToBuffer(),
      $0.AddUserResponse.fromBuffer);
  static final _$streamUsersUpdate = $grpc.ClientMethod<$0.GetAvailableUsersRequest, $0.GetAvailableUsersResponse>(
      '/chatter_message.ChatService/StreamUsersUpdate',
      ($0.GetAvailableUsersRequest value) => value.writeToBuffer(),
      $0.GetAvailableUsersResponse.fromBuffer);
  static final _$sendMessage = $grpc.ClientMethod<$0.SendMessageRequest, $0.SendMessageResponse>(
      '/chatter_message.ChatService/SendMessage',
      ($0.SendMessageRequest value) => value.writeToBuffer(),
      $0.SendMessageResponse.fromBuffer);
  static final _$getConversations = $grpc.ClientMethod<$0.GetConversationsRequest, $0.GetConversationsResponse>(
      '/chatter_message.ChatService/GetConversations',
      ($0.GetConversationsRequest value) => value.writeToBuffer(),
      $0.GetConversationsResponse.fromBuffer);
  static final _$getMessagesStream = $grpc.ClientMethod<$0.GetMessagesRequest, $0.GetMessagesResponse>(
      '/chatter_message.ChatService/GetMessagesStream',
      ($0.GetMessagesRequest value) => value.writeToBuffer(),
      $0.GetMessagesResponse.fromBuffer);
  static final _$getMessages = $grpc.ClientMethod<$0.GetMessagesRequest, $0.GetMessagesResponse>(
      '/chatter_message.ChatService/GetMessages',
      ($0.GetMessagesRequest value) => value.writeToBuffer(),
      $0.GetMessagesResponse.fromBuffer);
  static final _$createConversation = $grpc.ClientMethod<$0.CreateConversationRequest, $0.CreateConversationResponse>(
      '/chatter_message.ChatService/CreateConversation',
      ($0.CreateConversationRequest value) => value.writeToBuffer(),
      $0.CreateConversationResponse.fromBuffer);
}

@$pb.GrpcServiceName('chatter_message.ChatService')
abstract class ChatServiceBase extends $grpc.Service {
  $core.String get $name => 'chatter_message.ChatService';

  ChatServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.PublicKeySendRequest, $0.PublicKeySendResponse>(
        'SendPublicKey',
        sendPublicKey_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PublicKeySendRequest.fromBuffer(value),
        ($0.PublicKeySendResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PublicKeyRequest, $0.PublicKeyResponse>(
        'GetPublicKeyOfPartner',
        getPublicKeyOfPartner_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PublicKeyRequest.fromBuffer(value),
        ($0.PublicKeyResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AddUserRequest, $0.AddUserResponse>(
        'AddUser',
        addUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AddUserRequest.fromBuffer(value),
        ($0.AddUserResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAvailableUsersRequest, $0.GetAvailableUsersResponse>(
        'StreamUsersUpdate',
        streamUsersUpdate_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.GetAvailableUsersRequest.fromBuffer(value),
        ($0.GetAvailableUsersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SendMessageRequest, $0.SendMessageResponse>(
        'SendMessage',
        sendMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SendMessageRequest.fromBuffer(value),
        ($0.SendMessageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetConversationsRequest, $0.GetConversationsResponse>(
        'GetConversations',
        getConversations_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetConversationsRequest.fromBuffer(value),
        ($0.GetConversationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMessagesRequest, $0.GetMessagesResponse>(
        'GetMessagesStream',
        getMessagesStream_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.GetMessagesRequest.fromBuffer(value),
        ($0.GetMessagesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMessagesRequest, $0.GetMessagesResponse>(
        'GetMessages',
        getMessages_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetMessagesRequest.fromBuffer(value),
        ($0.GetMessagesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateConversationRequest, $0.CreateConversationResponse>(
        'CreateConversation',
        createConversation_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateConversationRequest.fromBuffer(value),
        ($0.CreateConversationResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.PublicKeySendResponse> sendPublicKey_Pre($grpc.ServiceCall $call, $async.Future<$0.PublicKeySendRequest> $request) async {
    return sendPublicKey($call, await $request);
  }

  $async.Future<$0.PublicKeySendResponse> sendPublicKey($grpc.ServiceCall call, $0.PublicKeySendRequest request);

  $async.Future<$0.PublicKeyResponse> getPublicKeyOfPartner_Pre($grpc.ServiceCall $call, $async.Future<$0.PublicKeyRequest> $request) async {
    return getPublicKeyOfPartner($call, await $request);
  }

  $async.Future<$0.PublicKeyResponse> getPublicKeyOfPartner($grpc.ServiceCall call, $0.PublicKeyRequest request);

  $async.Future<$0.AddUserResponse> addUser_Pre($grpc.ServiceCall $call, $async.Future<$0.AddUserRequest> $request) async {
    return addUser($call, await $request);
  }

  $async.Future<$0.AddUserResponse> addUser($grpc.ServiceCall call, $0.AddUserRequest request);

  $async.Stream<$0.GetAvailableUsersResponse> streamUsersUpdate_Pre($grpc.ServiceCall $call, $async.Future<$0.GetAvailableUsersRequest> $request) async* {
    yield* streamUsersUpdate($call, await $request);
  }

  $async.Stream<$0.GetAvailableUsersResponse> streamUsersUpdate($grpc.ServiceCall call, $0.GetAvailableUsersRequest request);

  $async.Future<$0.SendMessageResponse> sendMessage_Pre($grpc.ServiceCall $call, $async.Future<$0.SendMessageRequest> $request) async {
    return sendMessage($call, await $request);
  }

  $async.Future<$0.SendMessageResponse> sendMessage($grpc.ServiceCall call, $0.SendMessageRequest request);

  $async.Future<$0.GetConversationsResponse> getConversations_Pre($grpc.ServiceCall $call, $async.Future<$0.GetConversationsRequest> $request) async {
    return getConversations($call, await $request);
  }

  $async.Future<$0.GetConversationsResponse> getConversations($grpc.ServiceCall call, $0.GetConversationsRequest request);

  $async.Stream<$0.GetMessagesResponse> getMessagesStream_Pre($grpc.ServiceCall $call, $async.Future<$0.GetMessagesRequest> $request) async* {
    yield* getMessagesStream($call, await $request);
  }

  $async.Stream<$0.GetMessagesResponse> getMessagesStream($grpc.ServiceCall call, $0.GetMessagesRequest request);

  $async.Future<$0.GetMessagesResponse> getMessages_Pre($grpc.ServiceCall $call, $async.Future<$0.GetMessagesRequest> $request) async {
    return getMessages($call, await $request);
  }

  $async.Future<$0.GetMessagesResponse> getMessages($grpc.ServiceCall call, $0.GetMessagesRequest request);

  $async.Future<$0.CreateConversationResponse> createConversation_Pre($grpc.ServiceCall $call, $async.Future<$0.CreateConversationRequest> $request) async {
    return createConversation($call, await $request);
  }

  $async.Future<$0.CreateConversationResponse> createConversation($grpc.ServiceCall call, $0.CreateConversationRequest request);

}
