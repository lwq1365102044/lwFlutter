class LWAPI{
  /**
   * http://47.94.200.244:81/ 培训
   * https://pms.hntpsjwy.com/ 正式
   * http://192.168.1.221 开发
   */
  
  /// 正式环境
  static final String LW_API_PRODUCT_BASE_URL = 'https://pms.hntpsjwy.com/';
  /// 测试环境
  static final String LW_API_CESHI_BASE_URL = 'http://192.168.1.222/';


  /// API的base url
  static final String LW_API_BASE_URL = LW_API_PRODUCT_BASE_URL;
  /// 首页 banner (equipment:2) 设备（1.微信，2.APP）
  static final String HOME_BANNER_URL = 'v2/clientAPP/app/banner_promotion';
  /// 首页 推荐（房源、户型）（cityId：d94bba14-dec1-11e5-bcc3-00163e1c066c）
  static final String HOME_TUIJIAN_URL = 'v2/clientAPP/app/business_recommendation';
  /// 城市列表
  static final String HOME_CITY_DATA_LIST_URL = 'v2/clientAPP/app/get_city_list';
  
  /// 根据城市id获取区域列 (房源 筛选的 区域列表 cityId:'')
  static final String HOUSE_FANGYUAN_DATA_LIST_URL = 'v2/clientAPP/app/get_townList_by_cityId';
  /// 项目列表（房源列表）
  static final String HOUSE_PROJECT_LIST_DATA_URL = 'v2/clientAPP/app/get_item_list';
  /// 项目详情
  static final String HOUSE_PROJECT_LIST_DEATIL_DATA_URL = 'v2/clientAPP/app/get_item_details';
  /// 户型列表
  static final String HOUSE_HUXING_LIST_DATA_URL = 'v2/clientAPP/app/get_room_type_list';
  /// 户型详情
  static final String HOUSE_HUXING_LIST_DEATIL_DATA_URL = 'v2/clientAPP/app/get_roomType_details';


}
