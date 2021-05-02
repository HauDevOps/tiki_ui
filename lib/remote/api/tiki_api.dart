import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tiki_challenge/model/banner_model.dart';
import 'package:tiki_challenge/model/deal_hot_model.dart';
import 'package:tiki_challenge/model/quick_link_model.dart';

class TikiApi{

  Future<BannerEntity> getBanner() async{
    var response = await Dio().get('https://api.tiki.vn/v2/home/banners/v2');
    if (response.statusCode != HttpStatus.ok) {
      return new Future.error(response.statusMessage);
    }
    return BannerEntity.fromJson(response.data);
  }

  Future<DealHotEntity> getDealHot() async {
    var response = await Dio().get('https://api.tiki.vn/v2/widget/deals/hot');
    if (response.statusCode != HttpStatus.ok) {
      return new Future.error(response.statusMessage);
    }
    return DealHotEntity.fromJson(response.data);
  }

  Future<QuickLink> getQuickLink() async{
    var response = await Dio().get('https://api.tiki.vn/shopping/v2/widgets/quick_link');
    if (response.statusCode != HttpStatus.ok) {
      return new Future.error(response.statusMessage);
    }
    return QuickLink.fromJson(response.data);
  }

}