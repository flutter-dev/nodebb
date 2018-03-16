import 'package:logging/logging.dart';
import 'package:nodebb/services/io_service.dart';
import 'package:nodebb/services/remote_service.dart';
import 'package:nodebb/socket_io/sio_client.dart';



class Application {

  static setup() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((LogRecord rec) {
      print('${rec.level.name}: ${rec.message}');
    });

    RemoteService.getInstance().setup(Application.host);
    SocketIOClient client = new SocketIOClient(
        uri: 'ws://${Application.host}/socket.io/?EIO=3&transport=websocket',
        jar: RemoteService.getInstance().jar
    );
    IOService.getInstance().setup(client);
  }

//  static final store = new Store<AppState, AppStateBuilder, AppActions>(
//      reducerBuilder.build(),
//      new AppState(),
//      new AppActions(),
//      middleware: [
//        createAppStoreMiddleware()
//      ]
//  );

  static final Logger logger = new Logger('Application');

  static final host = '172.18.4.19:4567';
}