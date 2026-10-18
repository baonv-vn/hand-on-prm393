import '../models/weather.dart';

const _rainChanceThreshold = 50;
const _hotThreshold = 35.0;
const _coldThreshold = 15.0;

class Advice {
  final String title;
  final String detail;
  const Advice(this.title, this.detail);
}

Advice umbrellaAdvice(Weather w) {
  final rainy = (w.rainChance ?? 0) >= _rainChanceThreshold || w.precipitation > 0;
  return rainy
      ? Advice('Nên mang ô', 'Khả năng mưa ${w.rainChance ?? '?'}%')
      : const Advice('Không cần mang ô', 'Trời khá khô ráo');
}

Advice outdoorAdvice(Weather w) {
  if (w.feelsLike >= _hotThreshold) {
    return const Advice('Quá nóng để tập ngoài trời', 'Nên ở trong nhà hoặc tập buổi tối');
  }
  if (w.feelsLike <= _coldThreshold) {
    return const Advice('Khá lạnh', 'Mặc thêm áo ấm khi ra ngoài');
  }
  return const Advice('Thời tiết dễ chịu', 'Thích hợp đi dạo hoặc chạy bộ');
}

String describeWeatherCode(int code) {
  if (code == 0) return 'Trời quang';
  if (code <= 3) return 'Có mây';
  if (code == 45 || code == 48) return 'Sương mù';
  if (code >= 51 && code <= 57) return 'Mưa phùn';
  if (code >= 61 && code <= 67) return 'Mưa';
  if (code >= 71 && code <= 77) return 'Tuyết';
  if (code >= 80 && code <= 82) return 'Mưa rào';
  if (code >= 95) return 'Dông';
  return 'Không xác định';
}