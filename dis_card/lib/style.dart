import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DamStyle {
  // Colors
  static const Color primaryColor = Color(0xffffffff);
  static const Color secondaryColor = Color(0xFFEE8B60);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color orangeColor = Color(0xFFE62F16);
  static const Color blackColor = Color(0x00000000);
  static const Color fondoColor = Color(0xECECECFF);

  // Margins, Paddings, Card properties
  static const double bodyPadding = 8.0;

  // Font sizes, TextStyles
  static const double textSizeSmall = 14.0;
  static const double textSizeMedium = 18.0;
  static const double textSizeBig = 30.0;
  static const double textSizeTitle = 40.0;

  static TextStyle get textTitle => GoogleFonts.getFont(
        'Nunito',
        color: DamStyle.orangeColor,
        fontWeight: FontWeight.w600,
        fontSize: 40,
      );

  static TextStyle textTitleCustom(Color c, double fSize) =>
      GoogleFonts.getFont(
        'Nunito',
        color: c,
        fontWeight: FontWeight.w700,
        fontSize: fSize,
      );

  Card myCard() {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        margin: const EdgeInsets.all(15),
        elevation: 10,

        // Dentro de esta propiedad usamos ClipRRect
        child: ClipRRect(
          // Los bordes del contenido del card se cortan usando BorderRadius
          borderRadius: BorderRadius.circular(30),

          // EL widget hijo que será recortado segun la propiedad anterior
          child: Column(
            children: <Widget>[
              // Usamos el widget Image para mostrar una imagen
              Image(
                // Como queremos traer una imagen desde un url usamos NetworkImage
                image: NetworkImage(
                    'https://www.yourtrainingedge.com/wp-content/uploads/2019/05/background-calm-clouds-747964.jpg'),
              ),

              // Usamos Container para el contenedor de la descripción
              Container(
                padding: EdgeInsets.all(10),
                child: Text('Montañas'),
              ),
            ],
          ),
        ));
  }
}
