import 'package:uchat/features/coin/data/models/payloads/coin_update_payload.dart';

class CoinUpdateEvent {
  CoinUpdateResponse coinUpdateResponse;
  CoinUpdateEvent({required this.coinUpdateResponse});
}
