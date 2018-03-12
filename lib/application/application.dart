import 'package:logging/logging.dart';



class Application {

  static setup() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((LogRecord rec) {
      print('${rec.level.name}: ${rec.message}');
    });
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