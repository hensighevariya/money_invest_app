import 'package:money_invest_app/src/utils/log.dart';
import 'package:socket_io_client/socket_io_client.dart';

typedef VoidCallback = void Function();
typedef SocketListenerCallback<T> = void Function(T data);
typedef SocketDataTransformer<T> = T Function(dynamic data);

class SocketListener {
  const SocketListener({
    this.onConnected,
    this.onReconnect,
    this.onDisconnect,
    this.onReconnectFailed,
    this.onConnectError,
    this.onError,
  });

  final VoidCallback? onConnected;
  final VoidCallback? onReconnect;
  final VoidCallback? onDisconnect;
  final VoidCallback? onReconnectFailed;
  final VoidCallback? onConnectError;
  final VoidCallback? onError;
}

class SocketClientService {
  SocketClientService({required this.url});

  final String url;

  final List<SocketListener> _listeners = [];
  Socket? _socket;

  bool get connected => _socket?.connected ?? false;

  void _onConnected(dynamic data) {
    Log.debug('SocketClientService.onConnected: $data');
    for (final listener in _listeners) {
      listener.onConnected?.call();
    }
  }

  void _onReconnect(dynamic data) {
    Log.debug('SocketClientService.onReconnect: $data');
    for (final listener in _listeners) {
      listener.onReconnect?.call();
    }
  }

  void _onDisconnect(dynamic data) {
    Log.debug('SocketClientService.onDisconnect: $data');
    for (final listener in _listeners) {
      listener.onDisconnect?.call();
    }
  }

  void _onReconnectFailed(dynamic data) {
    Log.debug('SocketClientService.onReconnectFailed: $data');
    for (final listener in _listeners) {
      listener.onReconnectFailed?.call();
    }
  }

  void _onConnectError(dynamic data) {
    Log.debug('SocketClientService.onConnectError: $data');
    for (final listener in _listeners) {
      listener.onConnectError?.call();
    }
  }

  void _onError(dynamic data) {
    Log.debug('WebSocket.onError: $data');
    for (final listener in _listeners) {
      listener.onError?.call();
    }
  }

  void dispose() {
    _listeners.clear();
    disconnect();
  }

  void addListener(SocketListener listener) {
    _listeners.add(listener);
  }

  void removeListener(SocketListener listener) {
    _listeners.remove(listener);
  }

  Future<void> connect({String? namespace, String? authToken}) async {
    if (connected) return;
    try {
      final optionsBuilder = OptionBuilder()
        ..setTransports(['websocket'])
        ..setExtraHeaders({'Connection': 'upgrade', 'Upgrade': 'websocket'})
        ..enableAutoConnect()
        ..setReconnectionAttempts(5)
        ..setReconnectionDelay(500)
        ..enableForceNew()
        ..enableForceNewConnection()
        ..setTimeout(60000);

      if (authToken != null) {
        optionsBuilder.setAuth({'token': authToken});
      }
      String url = this.url;
      if (namespace != null) url = url + namespace;

      _socket = io(url, optionsBuilder.build())
        ..onConnect(_onConnected)
        ..onReconnect(_onReconnect)
        ..onDisconnect(_onDisconnect)
        ..onError(_onError)
        ..onReconnectFailed(_onReconnectFailed)
        ..onConnectError(_onConnectError);

      _socket?.connect();
      Log.debug('SocketClientService Connecting... $url');
    } catch (error) {
      Log.error('SocketClientService.connect -> $error');
    }
  }

  void disconnect() {
    if (connected) _socket?.disconnect();
    _socket = null;
  }

  void send(String event, [dynamic data]) {
    _socket?.emit(event, data);
    Log.debug('SocketClientService Send: $event -> $data');
  }

  void sendWithCallback<T>(
    String event, {
    required SocketListenerCallback<T> callback,
    dynamic data,
    SocketDataTransformer<T>? transformData,
  }) {
    _socket?.emitWithAck(event, data, ack: callback);
    Log.debug('SocketClientService Send: $event -> $data');
  }

  void listen<T>(
    String event,
    SocketListenerCallback<T> onData, {
    SocketDataTransformer<T>? transformData,
  }) {
    Log.debug('SocketClientService.listen: $event');
    _socket?.on(event, (data) {
      Log.debug('SocketClientService.onData: $event -> $data');
      if (transformData != null) {
        final transformedData = transformData.call(data);
        onData(transformedData);
      } else {
        onData(data as T);
      }
    });
  }

  void off(String event) {
    Log.debug('SocketClientService.off: $event');
    _socket?.off(event);
  }
}
