import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Base64Fun{

   tempDirectory(path,user)  {
    DateTime s = DateTime.now();
    File file = new File(path+'$s');
    var decodedBytes = base64Decode(user.image64);
    file.writeAsBytesSync(decodedBytes);
    return file;

  }
   tempDirectory2(path,image64)  {
     DateTime s = DateTime.now();
     File file = new File(path+'$s');
     var decodedBytes = base64Decode(image64);
     file.writeAsBytesSync(decodedBytes);
     return file;

   }
}