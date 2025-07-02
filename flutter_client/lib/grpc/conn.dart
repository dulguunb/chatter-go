import 'package:grpc/grpc.dart';
import 'package:meow/generated/chat.pbgrpc.dart';
import 'package:uuid/uuid.dart';
import 'package:get_it/get_it.dart';

class ChatService {
  late ChatServiceClient serviceClient;
  late User me;
  late List<Conversation> conversations = <Conversation>[];
  late Map<String,ResponseStream<GetMessagesResponse>> messageStreams = {};
  ChatService({required String ipAddress,required int port}){
    final channel = ClientChannel(
      ipAddress,
      port: port,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    serviceClient = ChatServiceClient(channel);
  }

  Future<AddUserResponse> addUser(String username) async {
    final uuid = Uuid();
    me = User(
      id: uuid.v4(),
      username: username,
      displayName: username,
      avatarUrl: "",
      available: true,
    );
    AddUserRequest req = AddUserRequest(user: me );
    final res = await serviceClient.addUser(req);
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
          return conv;
        }
    }
    Uuid uuid = Uuid();
    final convUuid = uuid.v4();
    List<String> participantIds = [me.id,participant.id];
    CreateConversationRequest createConversationRequest = CreateConversationRequest(participantIds: participantIds,name: convUuid);
    final conv = await serviceClient.createConversation(createConversationRequest);
    return conv.conversation;
  }

  sendMessage(String content,String convId) async {
    SendMessageRequest req = SendMessageRequest(conversationId: convId,content: content,senderId: me.id, username:me.username);
    final resp = await serviceClient.sendMessage(req);
  }

  ResponseStream<GetMessagesResponse> getMessagesStream(String conversationId) {
     GetMessagesRequest req = GetMessagesRequest(
        conversationId:conversationId,
      );
      final messageStream = serviceClient.getMessagesStream(req);
      return messageStream;
  }

  Future<GetMessagesResponse> getMessages(String conversationId) {
     GetMessagesRequest req = GetMessagesRequest(
        conversationId:conversationId,
      );
      final getMessagesResponse = serviceClient.getMessages(req);
      return getMessagesResponse;
  }

  bool isMe(String userId){
    return me.id == userId;
  }

}

final chatService = GetIt.I<ChatService>();

