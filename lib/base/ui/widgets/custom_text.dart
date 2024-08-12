import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manga_reader/utils/responsive.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.isUnderline = false,
    this.textAlign,
    this.letterSpacing,
    this.maxLines,
    this.textOverflow,
    this.height = 1,
  });

  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool isUnderline;
  final TextAlign? textAlign;
  final double? letterSpacing;
  final int? maxLines;
  final double? height;
  final TextOverflow? textOverflow;

  @override
  Widget build(BuildContext context) {
    final Responsive r = Responsive.of(context);
    return Text(
      text,
      overflow: textOverflow,
      textAlign: textAlign,
      maxLines: maxLines,
      style: GoogleFonts.poppins(
        letterSpacing: letterSpacing,
        color: color,
        fontSize: fontSize ?? r.diagonalResponsive(2),
        fontWeight: fontWeight,
        decoration: isUnderline ? TextDecoration.underline : null,
        height: height,
      ),
    );
  }
}
