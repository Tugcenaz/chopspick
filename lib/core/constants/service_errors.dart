class Errors {
  static String show(String errCode) {
    switch (errCode) {
      case 'emaıl-already-ın-use':
        return "Bu mail adresi zaten kullanımda. Lütfen farklı bir mail kullanınız";
      case 'wrong-password':
        return "Girilen şifre yanlış!";
      case 'ınvalıd-emaıl':
        return 'Geçersiz mail adresi';
      case 'user-not-found':
        return 'Bu bilgilere ait kullanıcı bulunamadı!';
      case 'network-request-failed':
        return 'İnternet bağlantınızı kontrol edin!';
      default:
        return "Bilinmeyen bir hata oluştu.";
    }
  }
}
