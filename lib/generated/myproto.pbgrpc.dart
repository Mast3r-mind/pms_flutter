//
//  Generated code. Do not modify.
//  source: myproto.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'myproto.pb.dart' as $0;

export 'myproto.pb.dart';

@$pb.GrpcServiceName('myproto.MyService')
class MyServiceClient extends $grpc.Client {
  static final _$streamData = $grpc.ClientMethod<$0.MyRequest, $0.MyResponse>(
      '/myproto.MyService/StreamData',
      ($0.MyRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.MyResponse.fromBuffer(value));

  MyServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseStream<$0.MyResponse> streamData($0.MyRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$streamData, $async.Stream.fromIterable([request]), options: options);
  }
}

@$pb.GrpcServiceName('myproto.MyService')
abstract class MyServiceBase extends $grpc.Service {
  $core.String get $name => 'myproto.MyService';

  MyServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.MyRequest, $0.MyResponse>(
        'StreamData',
        streamData_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.MyRequest.fromBuffer(value),
        ($0.MyResponse value) => value.writeToBuffer()));
  }

  $async.Stream<$0.MyResponse> streamData_Pre($grpc.ServiceCall call, $async.Future<$0.MyRequest> request) async* {
    yield* streamData(call, await request);
  }

  $async.Stream<$0.MyResponse> streamData($grpc.ServiceCall call, $0.MyRequest request);
}
