import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppConstant.customAppbar(
          context,
          Text(
            "terms".tr(context),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          [],
          true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      "تعد هذه البنود و الأحكام بمثابة اتفاقية بينك وبين صاحب التطبيق فيما يتعلق باستخدام التطبيق",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const Divider(),
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      "قبول الشروط",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              AppConstant.customSizedBox(0, 10),
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      "باستخدام التطبيق، فإنك توافق على الالتزام بهذه الشروط. إذا كنت لا توافق على هذه الشروط، فلا يجوز لك استخدام التطبيق.",
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              const Divider(),
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      "حقوق الملكية الفكرية ",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              AppConstant.customSizedBox(0, 10),
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      "جميع حقوق الملكية الفكرية في التطبيق، بما في ذلك حقوق النشر والعلامات التجارية وحقوق التصميم، مملوكة لشركة Sheek Bazar . لا يُسمح لك بنسخ أو توزيع أو تعديل أو إنشاء أعمال مشتقة من التطبيق أو أي جزء منه.",
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              const Divider(),
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      "استخدام التطبيق",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              AppConstant.customSizedBox(0, 10),
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      "يُسمح لك باستخدام التطبيق للأغراض الشخصية فقط. لا يجوز لك استخدام التطبيق لأغراض تجارية أو لأي غرض آخر غير مصرح به.",
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              const Divider(),
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      "المحتوى المقدم من المستخدم",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              AppConstant.customSizedBox(0, 10),
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      "قد تتضمن بعض الميزات في التطبيق إمكانية تقديم محتوى من قبل المستخدمين، مثل المنشورات أو الصور أو مقاطع الفيديو. أنت مسؤول عن أي محتوى تقدمه إلى التطبيق. لا يجوز لك تقديم محتوى ينتهك حقوق الملكية الفكرية لأي شخص آخر أو يتضمن معلومات كاذبة أو مضللة أو مسيئة.",
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              const Divider(),
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      "الخصوصية",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              AppConstant.customSizedBox(0, 10),
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      "تلتزم الشركة بحماية خصوصيتك. يمكنك الاطلاع على سياسة الخصوصية عن طريق واجهة الخصوصية.",
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              const Divider(),
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      "المسؤولية",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              AppConstant.customSizedBox(0, 10),
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      "لا تتحمل الشركة أي مسؤولية عن أي أضرار أو خسائر قد تنشأ عن استخدامك للتطبيق.",
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              const Divider(),
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      "التغييرات في الشروط",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              AppConstant.customSizedBox(0, 10),
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      "تحتفظ الشركة بالحق في تغيير هذه الشروط في أي وقت. سيتم إشعارك بأي تغييرات في الشروط من خلال إشعار يتم نشره على التطبيق أو من خلال أي وسيلة أخرى مناسبة.",
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              const Divider(),
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      "الاتفاق الكامل",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              AppConstant.customSizedBox(0, 10),
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      "تشكل هذه الشروط الاتفاق الكامل بينك وبين الشركة فيما يتعلق باستخدامك للتطبيق. تحل هذه الشروط محل أي اتفاقيات سابقة بينك وبين الشركة فيما يتعلق باستخدامك للتطبيق.",
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              const Divider(),
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      "النزاعات",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              AppConstant.customSizedBox(0, 10),
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      "في حالة نشوب أي نزاع بينك وبين الشركة فيما يتعلق باستخدامك للتطبيق، فإنك توافق على محاولة حل النزاع أولاً من خلال التفاوض. إذا لم يتمكن الطرفان من حل النزاع من خلال التفاوض، فإنك توافق على الخضوع للاختصاص القضائي الحصري لمحاكم دولة العراق .",
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              const Divider(),
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      "الاتصال بنا",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              AppConstant.customSizedBox(0, 10),
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      "إذا كان لديك أي أسئلة أو مخاوف بشأن هذه الشروط أو استخدامك للتطبيق، فيرجى الاتصال بنا .",
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              AppConstant.customSizedBox(0, 10),
              Center(
                child: Image.asset(
                  "assets/images/icon.png",
                  height: 350.h,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
