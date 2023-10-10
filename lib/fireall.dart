import 'package:flutter/material.dart';

class FireAll extends StatefulWidget {
  const FireAll({super.key});

  @override
  State<FireAll> createState() => _nameState();
}

class _nameState extends State<FireAll> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: EmergencyGuide()),
          ],
        ),
      ),
    );
  }

  RichText myTextTemplate({required String header, required String text}) {
    return RichText(
        textAlign: TextAlign.justify,
        text: TextSpan(text: header, style: headerStyle(), children: [
          TextSpan(text: text, style: boldNormalStyle()), // Make text bold
        ]));
  }

  TextStyle boldNormalStyle() {
    return TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15); // Set fontWeight to bold
  }

  TextStyle headerStyle() =>
      TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16);
}

class EmergencyGuide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            'Before the Fire',
            [
              '1. Check Fire Equipment:\n',
              '   - Review fire extinguishers and read the instructions for use. For example, make sure that the fire extinguisher is not expired and that the pressure gauge is in the green zone.\n',
              '2. Create a Fire Escape Plan and Organize Fire Drills:\n',
              '   - You can simulate a smoky environment and practice how to keep everyone safe. Hang an escape map in every room and designate a meeting point for each family member.\n',
              '3. Review Your Insurance Policy:\n',
              '   - By reviewing your insurance policy, for example, you can check your fire insurance coverage and create an inventory to list valuables in your home.',
            ],
          ),
          _buildSection(
            'In the Moment of Fire',
            [
              '1. Notify Immediately:\n',
              '   - The first thing you should do in the event of a fire is to immediately call an emergency number such as 112 to notify the fire brigade.\n',
              '2. Do Not Inhale the Smoke:\n',
              '   - Smoke is one of the biggest dangers of fire. For example, using the clothes you wear to cover your face and mouth to avoid inhaling smoke will significantly affect your protection from smoke. Try to stay away from the direction the smoke is coming from.\n',
              '3. Use Emergency Fire Brigade Equipment:\n',
              '   - In case of a fire, use emergency firefighting equipment such as fire extinguishers or fire ladders.\n',
              '4. Get Out of the Building:\n',
              '   - During a fire, leave the building and make sure you are safe. For example, go to a gathering point to meet other people and wait for the fire brigade to arrive.',
            ],
          ),
          _buildSection(
            'After the Fire',
            [
              '1. Check Your Health Condition:\n',
              '   - If you have inhaled smoke or are injured, seek medical attention immediately. Also check the health status of your family or relatives.\n',
              '2. Contact Aid Organizations:\n',
              '   - Contact local aid organizations for the help and support you need. If you are homeless as a result of the fire or have urgent needs, these organizations can help you.',
            ],
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items
              .map((item) {
                final index = items.indexOf(item) + 1;
                if (item.startsWith('$index. ')) {
                  // Sayı ile başlayan maddelerin altını çizili ve kalın yap
                  final content = item.replaceFirst('$index. ', '');
                  return Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      '$index. $content',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // Make text bold
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      item,
                      style: TextStyle(fontWeight: FontWeight.bold), // Make text bold
                    ),
                  );
                }
              })
              .toList(),
        ),
        SizedBox(height: 20.0),
      ],
    );
  }
}
