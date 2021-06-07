import 'package:chatcrm/src/services/chat.service.dart';
import 'package:grpc/grpc.dart';

Future<void> main(List<String> args) async {
  final server = Server([
    ChatService(),
  ]);

  await server.serve(port: 4444);

  print('Server listening...');
}
