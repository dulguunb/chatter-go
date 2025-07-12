import 'package:grpc/grpc.dart';
import 'package:meow/e2e/key_manager.dart';
import 'package:meow/generated/chat.pbgrpc.dart';
import 'package:uuid/uuid.dart';
import 'package:get_it/get_it.dart';
import 'package:pointycastle/export.dart';

class ChatService {
  late ChatServiceClient serviceClient;
  late User me;
  late List<Conversation> conversations = <Conversation>[];
  late Map<String,ResponseStream<GetMessagesResponse>> messageStreams = {};
  RSAKeyManager keyManager = RSAKeyManager();
  Map<String,(User,RSAPublicKey)> participantsPublicKeys = {};

  ChatService({required String ipAddress,required int port}){
    final channel = ClientChannel(
      ipAddress,
      port: port,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    serviceClient = ChatServiceClient(channel);
  }

  Future<AddUserResponse> addUser(String username) async {
    var user = User(
      username: username,
      displayName: username,
      avatarUrl: "",
      available: true,
    );
    AddUserRequest req = AddUserRequest(user: user );
    final res = await serviceClient.addUser(req);
    if (res.user.id != ""){
      me = res.user;
    } else {
      throw ("add user did not return id");
    }
    return res;
  }

  ResponseStream<GetAvailableUsersResponse> getUsersStream() {
    final req = GetAvailableUsersRequest(user: me);
    return serviceClient.streamUsersUpdate(req);
  }

  Future<Conversation> createConversation(User participant) async {
    GetConversationsRequest getConversationsRequest = GetConversationsRequest(userId: me.id);
    final getConvResponse = await serviceClient.getConversations(getConversationsRequest);
    for (var conv in getConvResponse.conversations){
        if (conv.participantIds.contains(participant.id)){
          await putPublicKeyParticipant(conv.id,participant);
          return conv;
        }
    }
    Uuid uuid = Uuid();
    final convUuid = uuid.v4();
    List<String> participantIds = [me.id,participant.id];
    CreateConversationRequest createConversationRequest = CreateConversationRequest(participantIds: participantIds,name: convUuid);
    final resp = await serviceClient.createConversation(createConversationRequest);
    await putPublicKeyParticipant(resp.conversation.id,participant);
    return resp.conversation;
  }

  sendMessage(String content,String convId) async {
    final (user,publicKey) = participantsPublicKeys[convId]!;
    final encryptedMessage = keyManager.encrypt(publicKey,content);
    SendMessageRequest req = SendMessageRequest(conversationId: convId,content: encryptedMessage,senderId: me.id, username:me.username);
    final resp = await serviceClient.sendMessage(req);
  }

  ResponseStream<GetMessagesResponse> getMessagesStream(String conversationId) {
     GetMessagesRequest req = GetMessagesRequest(
        conversationId:conversationId,
      );
      final messageStream = serviceClient.getMessagesStream(req);
      return messageStream;
  }

  String decrypt(String encrypted){
    return keyManager.decrypt(encrypted);
  }

  Future<GetMessagesResponse> getMessages(String conversationId) async {
    GetMessagesRequest req = GetMessagesRequest(
      conversationId:conversationId,
    );
    final getMessagesResponse = await serviceClient.getMessages(req);
    for (var i=0;i<getMessagesResponse.messages.length;i++){
      getMessagesResponse.messages[i].content = decrypt(getMessagesResponse.messages[i].content);
    }
    return getMessagesResponse;
  }

  bool isMe(String userId){
    return me.id == userId;
  }

  sendPublicKey() async {
    final publicKeyPem = keyManager.encodeRSAPublicKeyToPem();
    PublicKeySendRequest request = PublicKeySendRequest(participantId: me.id,publicKey: publicKeyPem);
    final response = await serviceClient.sendPublicKey(request);
  }

  putPublicKeyParticipant(String conversationId,User user) async {
    PublicKeyRequest request = PublicKeyRequest(participantId: user.id);
    final response = await serviceClient.getPublicKeyOfPartner(request);
    participantsPublicKeys[conversationId] = (user,keyManager.parseRsaPublicKeyFromPem(response.publicKey));
  }

}

final chatService = GetIt.I<ChatService>();

