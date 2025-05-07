import 'package:flutter/material.dart';

// How to use:
// import 'package:emptor/utils/colors.dart';
// AppColors.primaryColor

class AppColors {
  // Ana renkler
  static const Color primaryColor =
      Color(0xFF00B0FF); // Parlak mavi - Ana tema rengi
  static const Color secondaryColor =
      Color(0xFF00C853); // Parlak yeşil - İkincil tema rengi
  static const Color tertiaryColor =
      Color(0xFFFF6D00); // Canlı turuncu - Üçüncü tema rengi
  static const Color quaternaryColor =
      Color(0xFFFF4081); // Canlı pembe - Dördüncü tema rengi
  static const Color quinaryColor =
      Color(0xFFAA00FF); // Canlı mor - Beşinci tema rengi

  // Arka plan ve metin renkleri
  static const Color backgroundColor = Colors.white;
  static const Color textColor =
      Color(0xFF212121); // Koyu gri - Okunabilir metin

  // Durum renkleri
  static const Color successColor = Color(0xFF00C853); // Parlak yeşil - Başarı
  static const Color errorColor = Color(0xFFFF1744); // Canlı kırmızı - Hata
  static const Color warningColor = Color(0xFFFFD600); // Parlak sarı - Uyarı
  static const Color disabledColor = Color(0xFFBDBDBD); // Gri - Devre dışı
}
