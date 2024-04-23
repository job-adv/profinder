import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:profinder/models/usage_condition/usage_condition.dart';
import 'package:profinder/services/usage_conditions/usage_conditions.dart';

import '../../utils/theme_data.dart';
import '../../widgets/appbar/overlay_top_bar.dart';

class ConditionsOverlay extends StatefulWidget {
  const ConditionsOverlay({Key? key}) : super(key: key);

  @override
  State<ConditionsOverlay> createState() => _ConditionsOverlayState();
}

class _ConditionsOverlayState extends State<ConditionsOverlay> {
  late Future<List<UsageCondition>> _conditions;

  final UsagConditionsService _conditionsService = UsagConditionsService();

  Future<void> _loadConditions() async {
    _conditions = _conditionsService.fetch();
  }

  @override
  void initState() {
    super.initState();
    _loadConditions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: OverlayTopBar(
        title: "Conditions d'utilisation",
        dismissIcon: FluentIcons.chevron_left_12_filled,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<UsageCondition>>(
          future: _conditions,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final conditions = snapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "Bienvenue sur E-Artisan.",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Les conditions d'utilisation suivantes régissent l'utilisation de cette application. En accédant à cette application, nous supposons que vous acceptez ces conditions d'utilisation dans leur intégralité. Ne continuez pas à utiliser l'application si vous n'acceptez pas tous les termes et conditions énoncés sur cette page.",
                    ),
                    SizedBox(height: 20),
                    Text(
                      "La terminologie suivante s'applique à ces conditions d'utilisation, à la déclaration de confidentialité et à l'avis de non-responsabilité, à tous les accords: «Client», «Vous» et «Votre» se réfèrent à vous, à la personne accédant à cette application et acceptant les conditions de la Société. " +
                          "«La Société», «Nous-mêmes», «Nous», «Notre» et «Nous» font référence à notre société. «Partie», «Parties» ou «Nous» désigne à la fois le Client et nous-mêmes. Tous les termes se rapportent à l'offre, à l'acceptation et à la considération du paiement nécessaire pour entreprendre le processus de notre assistance au Client de la manière la plus appropriée, qu'il s'agisse de réunions formelles de durée fixe ou autrement, dans le but exprès de répondre aux besoins du Client concernant la fourniture des services / produits déclarés de la Société, conformément et sous réserve de la loi en vigueur de France. ",
                    ),
                    SizedBox(height: 20),
                    Text(
                      "L'utilisation de cette application est soumise aux lois et réglementations françaises.",
                    ),
                    SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: conditions.length,
                      itemBuilder: (context, index) {
                        final condition = conditions[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              condition.content,
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}
