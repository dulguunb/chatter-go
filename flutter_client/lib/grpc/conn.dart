import 'package:grpc/grpc.dart';
import 'package:meow/generated/chat.pbgrpc.dart';
import 'package:uuid/uuid.dart';
import 'package:get_it/get_it.dart';

class ChatService {
  late ChatServiceClient serviceClient;
  late User me;
  late List<Conversation> conversations = <Conversation>[];
  
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
    try {
      final res = await serviceClient.addUser(req);
      return res;
    } catch(e) {
      throw 'could not add user: $username';
    }
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
    // TODO:  Error handle 
  }

  ResponseStream<GetMessagesResponse> getMessageStream(String conversationId) {
    GetMessagesRequest req = GetMessagesRequest(
      conversationId:conversationId,
    );
    final messageStream = serviceClient.getMessages(req);
    return messageStream;
  }

  bool isMe(String userId){
    return me.id == userId;
  }

}

final chatService = GetIt.I<ChatService>();

