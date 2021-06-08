import 'dart:async';
import 'dart:math';

import 'package:chatcrm/src/grpc/chatcrm.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'package:pedantic/pedantic.dart';

Future<void> listener(Stream<Message> messages) async {
  try {
    await for (var message in messages) {
      print('Received');
      print(message);
    }
  } on GrpcError catch (e) {
    print('Error');
    print('Code: ${e.code}');
    print('Message: ${e.message}');
  }
}

Future<void> main() async {
  final channel = ClientChannel(
    '192.168.43.70',
    port: 4444,
    options: const ChannelOptions(
      credentials: ChannelCredentials.insecure(),
    ),
  );

  final stub = ChatClient(channel);

  // final user = Random().nextInt(9999).toString();

  final joinMessage = Message(
    user: 'yukabit',
  );

  final messages = stub.join(joinMessage);

  unawaited(listener(messages));

  // messages.listen((value) {
  //   print('Received');
  //   print(value);
  // }, onError: (err) {
  //   final error = err as GrpcError;
  //   print('Error Code: ${error.code}');
  //   print('Error Message: ${error.message}');
  // });

  while (true) {
    await Future.delayed(
      Duration(seconds: Random().nextInt(10)),
    );

    print('Sending...');
    await stub.send(
      Message(
          user: 'yukabit',
          text: Random().nextInt(1000000).toString(),
          to: 'holo'),
    );
  }
}
