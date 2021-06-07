import 'dart:async';

import 'package:chatcrm/src/grpc/chatcrm.pbgrpc.dart';
import 'package:grpc/src/server/call.dart';

class ChatService extends ChatServiceBase {
  final channels = <String, StreamController<Message>>{};

  @override
  Stream<Message> join(ServiceCall call, Message request) async* {
    print('Join ${request.user}');

    if (channels[request.user] == null) {
      channels[request.user] = StreamController<Message>();
    }

    for (var channel in channels.values) {
      channel.add(request);
    }

    yield* channels[request.user]!.stream;
  }

  @override
  Future<Message> send(ServiceCall call, Message request) async {
    print('Sending: ${request.text}');

    for (var channel in channels.values) {
      channel.add(request);
    }

    return request;
  }
}
