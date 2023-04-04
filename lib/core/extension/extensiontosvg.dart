import 'package:dropboxclone/core/constants/svg_path.dart';

extension ExtensionToSvg on String{
  String svgPath(){
    if(this==".pdf"){
      return pdfSvg;
    }
    if(this==".docx"|| this==".doc"){
      return wordSvg;
    }

    if(this==".xls"||this==".xlsx"){
      return excelSvg;
    }

    if(this==".mp4"){
      return mp4Svg;
    }

    if(this==".png"){
      return pngSvg;
    }

    if(this==".jpg"||this==".jpeg"){
      return jpgSvg;
    }

    if(this==".txt"){
      return txtSvg;
    }
    return notKnownSvg;
  }
}