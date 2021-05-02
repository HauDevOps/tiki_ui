import 'package:tiki_challenge/model/banner_model.dart';
import 'package:tiki_challenge/model/deal_hot_model.dart';
import 'package:tiki_challenge/model/quick_link_model.dart';
import 'package:tiki_challenge/remote/api/tiki_api.dart';

class Repository{
  Future<BannerEntity> getBanner() async {
    return await TikiApi().getBanner();
  }

  // Get Quick link
  Future<QuickLink> getQuickLink() async {
    return await TikiApi().getQuickLink();
  }

  Future<DealHotEntity> getDealHot() async {
    return await TikiApi().getDealHot();
  }
}