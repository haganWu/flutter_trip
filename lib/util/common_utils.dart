class CommonUtils {


  static String getCatchUrl(String url) {
    String resultUrl = url;
    if (url.contains('ctrip.com')) {
      //fix 携程H5 http://无法打开问题
      resultUrl = url.replaceAll("http://", 'https://');
    }
    return resultUrl;
  }
}
