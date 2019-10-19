
class DateFormatter{

  static String getToday(){
    return '${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}';
  }
}