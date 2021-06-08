import 'dart:async';

import 'package:chatcrm/src/grpc/chatcrm.pbgrpc.dart';
import 'package:grpc/src/server/call.dart';

class ChatService extends ChatServiceBase {
  final channelStreams = <String, StreamController<Message>>{};

  @override
  Stream<Message> join(ServiceCall call, Message request) async* {
    if (channelStreams[request.user] != null) {
      await channelStreams[request.user]!.close();
      // print('\nℹ️  Closed ${request.user} old stream\n');
    }

    channelStreams[request.user] = StreamController<Message>()
      ..add(
        Message(
          user: 'server',
          to: request.user,
          text: 'Welcome ${request.user}',
        ),
      );

    // print('\nℹ️  User ${request.user} is joined\n');

    yield* channelStreams[request.user]!.stream;
  }

  @override
  Future<Message> send(ServiceCall call, Message request) async {
    if (channelStreams[request.to] != null) {
      // print(
      //   '\nℹ️  Sending:\n\n    ${request.text}\n\n    from: ${request.user}\n    to: ${request.to}',
      // );
      channelStreams[request.to]!.add(request);
      channelStreams[request.user]!.add(request);
      return request;
    } else {
      throw Exception('User ${request.to} not found');
    }
  }

  @override
  Future<Channels> channels(ServiceCall call, NoParam request) async {
    return Channels(channels: channelStreams.keys);
  }

  @override
  Future<Message> logout(ServiceCall call, Message request) async {
    // print('\nℹ️  User ${request.user} is logout\n');
    await channelStreams[request.user]?.close();

    channelStreams.remove(request.user);

    return request;
  }
}
