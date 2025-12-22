import 'package:flutter/material.dart';
import 'package:search_frontend/core/utils/size_config.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BottomInfo extends StatelessWidget {
  const BottomInfo({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                child: InkWell(
                  onTap: () async {
                    await launchUrlString(
                      "https://mingas.by/",
                      mode: LaunchMode.platformDefault,
                    );
                  },
                  child: Text(
                    "Сайт УП “Мингаз”",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ),
              SizedBox(width: SizeConfig.blockSizeHorizontal * 2),
              Text(
                "Сообщить об ошибке",
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 2),
          Text(
            "© ${DateTime.now().year}-${DateTime.now().year + 1} Унитарное предприятие  “Мингаз”",
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
