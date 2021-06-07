import 'dart:async';
import 'dart:math';

import 'package:chatcrm/src/grpc/chatcrm.pbgrpc.dart';
import 'package:grpc/grpc.dart';

Future<void> main() async {
  final channel = ClientChannel(
    '127.0.0.1',
    port: 4444,
    options: const ChannelOptions(
      credentials: ChannelCredentials.insecure(),
    ),
  );

  final stub = ChatClient(channel);

  final user = Random().nextInt(9999).toString();

  final joinMessage = Message(
    user: user,
    text: 'Say hello',
  );

  final messages = stub.join(joinMessage);

  messages.listen((value) {
    print('Received');
    print(value);
  });

  while (true) {
    await Future.delayed(
      Duration(seconds: Random().nextInt(10)),
    );

    print('Sending...');
    await stub.send(
      Message(user: user, text: Random().nextInt(1000000).toString()),
    );
  }
}
