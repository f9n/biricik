import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: Center(
        child: Text(
          "IOT teknolojisinin gelişmesiyle birlikte cihazlar arası haberleşmek kolay bir hal almış ve işimizi kolaylaştırmaya başlamıştır. Mobil teknolojilerin de gelişmesiyle artık uzaktaki bir cihazı bir mobil uygulama aracılıyla yönetmek çok kolay bir hale gelmiştir. Biz de bu durumu düşünerek gündelik hayatta uğraşabileceğimiz bir alanda bir mobil uygulama tasarlamak istedik. Adı Biricik. Biricik mobil uygulaması robot olarak Raspberry Pi 3 kullanan bir robotun işlevlerini görüntüleyen ve wifi üzerinden veri alınıp göndermesini sağlayan bir uygulamadır. Uygulama sayesinde L298N Motor sürücüyü kullanarak robotun 2 eksende haretini sağlayabilecek, HC-SR04 soner mesafe ölçüm sensörü, QTR-8A kızılötesi renk algılama sensörü ile veri aktarımı sağlanacak ve Raspberry Pi 3 üzerinde bulunan kamera portu üzerinden VGA kameradaki kamera verileri uygulamaya canlı olarak aktarılacaktır. Mobil uygulama ve robot arasında veri aktarımı gerçekleşebilmesi için aynı internet ağı üzerinde olmaları gerekmektedir. Uygulama üzerinde robot kontrolünün ve verilerin analizinin esnek olması için dinamik bir dashboard tasarlanmıştır.",
          style: TextStyle(),
        ),
      ),
    );
  }
}
