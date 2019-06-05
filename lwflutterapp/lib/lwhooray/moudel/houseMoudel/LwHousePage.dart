import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lwflutterapp/lwhooray/moudel/baseMoudel/lwBaseModel.dart';
import 'package:lwflutterapp/lwhooray/moudel/homeMoudel/model/LwHomeModel.dart';
import 'package:lwflutterapp/lwhooray/moudel/houseMoudel/lwHouseDeatilPage.dart';
import 'package:lwflutterapp/lwhooray/moudel/houseMoudel/model/LwHouseModel.dart';
import 'package:lwflutterapp/lwhooray/moudel/houseMoudel/widgets/LwHouseWidgets.dart';
import 'package:lwflutterapp/lwhooray/tool/networkUtils.dart';
import 'package:lwflutterapp/lwhooray/other/api.dart';

class LwHousePage extends StatefulWidget {
  // 首页过来的数据
  List<ItemListModel> homePageDataModels = [];
  @override
  _LwHousePageState createState() => _LwHousePageState();
  LwHousePage(this.homePageDataModels);
}

class _LwHousePageState extends State<LwHousePage>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;
  /// 排序
  String _sortType = 'asc';
  /// 区域id
  String _quyuId = '';
  String _cityid = 'd94bba14-dec1-11e5-bcc3-00163e1c066c';
  String _preStayTime = '';
  List<dynamic> _houseListModelList = [];
  
  @override
  void initState() {
    super.initState();
    if (widget.homePageDataModels != null &&
        widget.homePageDataModels.length != 0) {
      setState(() {
        _houseListModelList.addAll(widget.homePageDataModels);
      });
    } else {
      _getHouseListData();
    }
  }

  void _getHouseListData() async {
    Map<String, dynamic> para = {
      'preStayTime': _preStayTime,
      'sortFields': 'zujin_',
      'sortType': _sortType,
      'quyuId': _quyuId,
      'cityId': _cityid
    };
    // print('\n----para:${para.toString()}');
    LwNetworkUtils.requestDataWithPost(LWAPI.HOUSE_PROJECT_LIST_DATA_URL, para,
        (Response response) {
      LwResponse lwrespose = LwResponse.fromJson(jsonDecode(response.data));
      setState(() {
        _houseListModelList.clear();
        _houseListModelList.addAll(lwrespose.result.list);
      });
    }, (ErrorModel error) {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: lwAppBar('房源'),
      body: Container(
        color: Color(0xfff5f5f5),
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: RefreshIndicator(
          child: ListView.separated(
            itemCount: _houseListModelList.length,
            itemBuilder: (context, index) {
              String pic;
              String itemName;
              String address;
              String price;
              String customid;
              if (_houseListModelList.first.runtimeType == ItemListModel) {
                ItemListModel model = _houseListModelList[index];
                pic = model.itemPic.big;
                itemName = model.itemName;
                address = model.itemAddress;
                price = model.iosItemLowestprice;
                customid = model.itemId;
              } else {
                HouseListModel model = _houseListModelList[index];
                pic = model.picObj.big;
                itemName = model.itemName;
                address = model.houseItemAddress;
                price = model.iosDedicated;
                customid = model.customid;
              }

              return GestureDetector(
                child: houseColumsItemWidget(
                    context, pic, itemName, address, price),
                onTap: () {
                  print('------------customid:$customid');
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => lwHouseDeatilPage(customid),
                  ));
                },
              );
            },
            separatorBuilder: (context, index) {
              return Container(
                height: 10.0,
                color: Color(0xfff5f5f5),
              );
            },
          ),
          onRefresh: _refresh,
        ),
      ),
    );
  }

  Future<Null> _refresh() async {
    final Completer<void> completer = Completer();
    Timer(Duration(seconds: 3), () {
      completer.complete();
    });
    return completer.future.then((_) {
       if (widget.homePageDataModels == null ||
        widget.homePageDataModels.length == 0) {
      _getHouseListData();
    }
    });
  }
}
