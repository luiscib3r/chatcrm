///
//  Generated code. Do not modify.
//  source: grpc/chatcrm.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'chatcrm.pb.dart' as $0;
export 'chatcrm.pb.dart';

class ChatClient extends $grpc.Client {
  static final _$join = $grpc.ClientMethod<$0.Message, $0.Message>(
      '/chatcrm.Chat/join',
      ($0.Message value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Message.fromBuffer(value));
  static final _$send = $grpc.ClientMethod<$0.Message, $0.Message>(
      '/chatcrm.Chat/send',
      ($0.Message value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Message.fromBuffer(value));

  ChatClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseStream<$0.Message> join($0.Message request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$join, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.Message> send($0.Message request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$send, request, options: options);
  }
}

abstract class ChatServiceBase extends $grpc.Service {
  $core.String get $name => 'chatcrm.Chat';

  ChatServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Message, $0.Message>(
        'join',
        join_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.Message.fromBuffer(value),
        ($0.Message value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Message, $0.Message>(
        'send',
        send_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Message.fromBuffer(value),
        ($0.Message value) => value.writeToBuffer()));
  }

  $async.Stream<$0.Message> join_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Message> request) async* {
    yield* join(call, await request);
  }

  $async.Future<$0.Message> send_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Message> request) async {
    return send(call, await request);
  }

  $async.Stream<$0.Message> join($grpc.ServiceCall call, $0.Message request);
  $async.Future<$0.Message> send($grpc.ServiceCall call, $0.Message request);
}
