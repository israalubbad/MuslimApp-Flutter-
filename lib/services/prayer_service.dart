
import 'package:adhan/adhan.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

class PrayerInfoService {
  final Coordinates coordinates;
  final CalculationMethod method;
  final Madhab madhab;

  PrayerInfoService({
    required this.coordinates,
    this.method = CalculationMethod.umm_al_qura,
    this.madhab = Madhab.shafi,
  });

  Map<String, dynamic> getPrayerData() {
    final params = method.getParameters();
    params.madhab = madhab;

    final date = DateComponents.from(DateTime.now());
    final prayerTimes = PrayerTimes(coordinates, date, params);

    final dateFormat = DateFormat('hh:mm a', 'ar');
    final times = {
      'fajr': dateFormat.format(prayerTimes.fajr),
      'sunrise': dateFormat.format(prayerTimes.sunrise),
      'dhuhr': dateFormat.format(prayerTimes.dhuhr),
      'asr': dateFormat.format(prayerTimes.asr),
      'maghrib': dateFormat.format(prayerTimes.maghrib),
      'isha': dateFormat.format(prayerTimes.isha),
    };


    final hijri = HijriCalendar.now();
    final gregorian = DateFormat('dd MMMM yyyy', 'ar').format(DateTime.now());

    final currentPrayer = prayerTimes.currentPrayer();
    final nextPrayer = prayerTimes.nextPrayer() ?? Prayer.fajr; // fallback للفجر

    DateTime? nextPrayerTime = prayerTimes.timeForPrayer(nextPrayer);
    Duration? remaining = nextPrayerTime?.difference(DateTime.now());

    String prayerNameArabic(Prayer? p) {
      switch (p) {
        case Prayer.fajr:
          return 'الفجر';
        case Prayer.sunrise:
          return 'الشروق';
        case Prayer.dhuhr:
          return 'الظهر';
        case Prayer.asr:
          return 'العصر';
        case Prayer.maghrib:
          return 'المغرب';
        case Prayer.isha:
          return 'العشاء';
        default:
          return 'الفجر';
      }
    }

    String prayerKey(Prayer? p) {
      switch (p) {
        case Prayer.fajr:
          return 'fajr';
        case Prayer.sunrise:
          return 'sunrise';
        case Prayer.dhuhr:
          return 'dhuhr';
        case Prayer.asr:
          return 'asr';
        case Prayer.maghrib:
          return 'maghrib';
        case Prayer.isha:
          return 'isha';
        default:
          return 'fajr';
      }
    }

    final nextKey = prayerKey(nextPrayer);
    final nextName = prayerNameArabic(nextPrayer);
    final nextTime = times[nextKey];

    return {
      'times': times,
      'date_gregorian': gregorian,
      'date_hijri': hijri.toFormat("dd MMMM yyyy"),
      'prayer_current_key': prayerKey(currentPrayer),
      'prayer_next_key': nextKey,
      'prayer_current_name': prayerNameArabic(currentPrayer),
      'prayer_next_name': nextName,
      'prayer_next_time': nextTime,
      'time_remaining': remaining != null
          ? '${remaining.inHours}h ${remaining.inMinutes.remainder(60)}m'
          : '—',
    };
  }



}
