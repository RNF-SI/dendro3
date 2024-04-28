// Choose the appropriate file based on the condition.
export 'config_dev.dart' if (dart.library.prod) 'config_prod.dart';
