class ChatModel {
  String chatId;
  String chatMessage;
  bool isCurrentUser;
  Map<dynamic, dynamic> properties;

  ChatModel(this.chatId, this.chatMessage, this.isCurrentUser, this.properties);
  
  dynamic get getChatMessage {
    return chatMessage;
  }

  bool get checkMessageOfCurrentUser {
    return isCurrentUser;
  }

  dynamic get getProperties {
    return properties;
  }
}