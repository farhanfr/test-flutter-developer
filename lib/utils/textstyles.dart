import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_flutter_developer_enterkomputer/utils/colors.dart';



/* LATO */

TextStyle latoTwenty = GoogleFonts.lato(
  fontSize: 20.0,
  fontWeight: FontWeight.w700,
);

TextStyle latoBold = GoogleFonts.lato(
  fontSize: 16.0,
  fontWeight: FontWeight.w700,
);

TextStyle latoSixteen = GoogleFonts.lato(
  fontSize: 16.0,
  fontWeight: FontWeight.w400,
);

TextStyle latoRegular = GoogleFonts.lato(
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
);
TextStyle latoRegularSemiBold = GoogleFonts.lato(
  fontSize: 14.0,
  fontWeight: FontWeight.w600,
);

TextStyle latoSmall = GoogleFonts.lato(
  fontSize: 12.0,
  fontWeight: FontWeight.w400,
);
TextStyle latoSmallSemiBold = GoogleFonts.lato(
  fontSize: 12.0,
  fontWeight: FontWeight.w600,
);

TextStyle body2 = GoogleFonts.lato(
  fontSize: 16.0,
  fontWeight: FontWeight.w400,
  color: textPrimary,
);

TextStyle body1Lato = GoogleFonts.lato(
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
  color: textPrimary,
);

TextStyle body2Lato = GoogleFonts.lato(
  fontSize: 12.0,
  fontWeight: FontWeight.w400,
  color: textPrimary,
);

TextStyle subtitle1 = GoogleFonts.lato(
  fontSize: 16.0,
  fontWeight: FontWeight.w400,
  color: textPrimary,
);

TextStyle caption = GoogleFonts.lato(
  fontSize: 14.0,
  fontWeight: FontWeight.normal,
  color: textPrimary,
);

TextStyle overline = GoogleFonts.lato(
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
  color: textPrimary,
);

TextStyle disableText = GoogleFonts.lato(
  fontSize: 14.0,
  fontWeight: FontWeight.normal,
  color: inactiveSwitch,
);

TextStyle boldCaption = GoogleFonts.lato(
  fontSize: 14.0,
  fontWeight: FontWeight.bold,
  color: textPrimary,
);

TextStyle captionGold = GoogleFonts.lato(
  fontSize: 14.0,
  fontWeight: FontWeight.normal,
  color: primary,
);

TextStyle subtitle1v2 = GoogleFonts.lato(
  fontSize: 20.0,
  fontWeight: FontWeight.normal,
  color: textPrimary,
);

TextStyle subtitle2v2 = GoogleFonts.lato(
  fontSize: 18.0,
  fontWeight: FontWeight.w500,
  color: textPrimary,
);

TextStyle body1 = GoogleFonts.lato(
  fontSize: 18.0,
  fontWeight: FontWeight.w400,
  color: textPrimary,
);

TextStyle h3 = GoogleFonts.lato(
  fontSize: 20.0,
  fontWeight: FontWeight.w500,
  color: textPrimary,
);

TextStyle body1v2 = GoogleFonts.lato(
  fontSize: 16.0,
  fontWeight: FontWeight.w400,
  color: textPrimary,
);

TextStyle h2 = GoogleFonts.lato(
  fontSize: 26.0,
  fontWeight: FontWeight.w700,
  color: textPrimary,
);

TextStyle LatoBold = GoogleFonts.lato(
  fontSize: 16.0,
  fontWeight: FontWeight.w700,
  color: textPrimary,
);

TextStyle h1 = GoogleFonts.montserrat(
  fontSize: 34.0,
  fontWeight: FontWeight.w700,
  color: textPrimary,
);

/* NUNITO */

TextStyle nunitoBold = GoogleFonts.nunito(
  fontSize: 36.0,
  fontWeight: FontWeight.w700,
);

TextStyle nunitoSemiBold = GoogleFonts.nunito(
  fontSize: 26.0,
  fontWeight: FontWeight.w600,
);

TextStyle nunitoRegular = GoogleFonts.nunito(
  fontSize: 20.0,
  fontWeight: FontWeight.w500,
);

TextStyle nunitoSmall = GoogleFonts.nunito(
  fontSize: 16.0,
  fontWeight: FontWeight.w500,
);

/* INTER */

TextStyle interBold = GoogleFonts.inter(
  fontSize: 34.0,
  fontWeight: FontWeight.w700,
);

TextStyle interSemiBold = GoogleFonts.inter(
  fontSize: 26.0,
  fontWeight: FontWeight.w600,
);

TextStyle interRegular = GoogleFonts.inter(
  fontSize: 20.0,
  fontWeight: FontWeight.w500,
);

TextStyle interSmallSemiBold = GoogleFonts.inter(
  fontSize: 16.0,
  fontWeight: FontWeight.w600,
);
TextStyle interSmall = GoogleFonts.inter(
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
);
TextStyle interVerySmall = GoogleFonts.inter(
  fontSize: 12.0,
  fontWeight: FontWeight.w500,
);

/* POPPINS */

TextStyle poppinsTitle = GoogleFonts.poppins(
  fontSize: 16.0,
  fontWeight: FontWeight.w700,
);
TextStyle poppinsSemiBold = GoogleFonts.poppins(
  fontSize: 16.0,
  fontWeight: FontWeight.w600,
);
TextStyle poppinsSubtitle = GoogleFonts.poppins(
  fontSize: 13.0,
  fontWeight: FontWeight.w500,
);
TextStyle categories = GoogleFonts.poppins(
  fontSize: 12.0,
  fontWeight: FontWeight.w500,
);
TextStyle membership = GoogleFonts.poppins(
  fontSize: 10.0,
  fontWeight: FontWeight.w500,
);

/* MONTSERRAT */

TextStyle subtitle2 = GoogleFonts.montserrat(
  fontSize: 16.0,
  fontWeight: FontWeight.w500,
  color: textPrimary,
);

TextStyle button = GoogleFonts.montserrat(
  fontSize: 16.0,
  fontWeight: FontWeight.w700,
  letterSpacing: 1.25,
);

TextStyle tab = GoogleFonts.montserrat(
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
  color: textPrimary,
);

/* EDIT */

TextStyle h1Inv = h1.copyWith(color: textPrimaryInverted);
TextStyle h1Accent = h1.copyWith(color: textSecondary);

TextStyle h2Inv = h2.copyWith(color: textPrimaryInverted);
TextStyle h2Accent = h2.copyWith(color: textSecondary);

TextStyle h3Inv = h3.copyWith(color: textPrimaryInverted);
TextStyle h3Accent = h3.copyWith(color: textSecondary);

TextStyle subtitle1Inv = subtitle1.copyWith(color: textPrimaryInverted);
TextStyle subtitle1Accent = subtitle1.copyWith(color: textSecondary);

TextStyle subtitle2Inv = subtitle2.copyWith(color: textPrimaryInverted);
TextStyle subtitle2Accent = subtitle2.copyWith(color: textSecondary3);

TextStyle body1Inv = body1.copyWith(color: textPrimaryInverted);
TextStyle body1Accent = body1.copyWith(color: textSecondary);

TextStyle body2Inv = body2.copyWith(color: textPrimaryInverted);
TextStyle body2Accent = body2.copyWith(color: textSecondary);

TextStyle buttonInv = button.copyWith(color: textPrimaryInverted);
TextStyle buttonAccent = button.copyWith(color: textSecondary);

TextStyle captionInv = caption.copyWith(color: textPrimaryInverted);
TextStyle captionAccent = caption.copyWith(color: textSecondary);

TextStyle overlineInv = overline.copyWith(color: textPrimaryInverted);
TextStyle overlineAccent = overline.copyWith(color: inactiveTrackSwitch);

TextStyle tabInv = tab.copyWith(color: textPrimaryInverted);
TextStyle tabAccent = tab.copyWith(color: textSecondary);

// v2
TextStyle subtitle1v2Inv = subtitle1v2.copyWith(color: textPrimaryInverted);
TextStyle subtitle1v2Accent = subtitle1v2.copyWith(color: textSecondary);

TextStyle subtitle2v2Inv = subtitle2v2.copyWith(color: textPrimaryInverted);
TextStyle subtitle2v2Accent = subtitle2v2.copyWith(color: textSecondary);

TextStyle body1v2Inv = body1v2.copyWith(color: textPrimaryInverted);
TextStyle body1v2Accent = body1v2.copyWith(color: textSecondary);
