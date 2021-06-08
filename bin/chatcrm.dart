import 'package:chatcrm/src/services/chat.service.dart';
import 'package:grpc/grpc.dart';

void main(List<String> arguments) async {
  final server = Server([
    ChatService(),
  ]);

  await server.serve(port: 4444);

  print('Server listening...');
}
