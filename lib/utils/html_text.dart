
import 'package:moyen_express/resources/exports/index.dart';


class HtmlText extends StatelessWidget {
  final String jsonData;
    final bool showReadMore;
  const HtmlText({Key? key, required this.jsonData,this.showReadMore = true,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return SingleChildScrollView(
      child: Column(
        children: [
        Html(
                style: {
                  "h1": Style(
                    maxLines:  2,
                    textOverflow: TextOverflow.ellipsis,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                  "h2": Style(
                    maxLines:  2,
                    textOverflow: TextOverflow.ellipsis,
                    color: Colors.black,
                  ),
                  "p": Style(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: FontSize(12.0),
                  ),
                },
                data: jsonData,
              ),
          if (showReadMore)...[
            const CustomButton.solid(
              backgroundColor: AppColors.primaryColor, // Change color as needed
              textColor: Colors.white,
              text:  'Read More',
              // onTap: () => productDetailsController.toggleExpansion(),
              radius: 6,
            ).constrainedBox(maxWidth: 150, maxHeight: 50),
        ],
     ] ),
    );
  }
}