// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/Locale/cubit/locale_cubit.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';

class PrivactScreen extends StatelessWidget {
  const PrivactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppConstant.customAppbar(
          context,
          Text(
            "privacy".tr(context),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          [],
          true),
      body: SingleChildScrollView(
        child: BlocBuilder<LocaleCubit, ChangeLocaleState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(20.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: state.locale.languageCode == "en"
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  const Text(
                    " ندرك في تطبيقنا أهمية خصوصية بياناتك ، ونحن ملتزمون بحماية معلوماتك الشخصية ",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "توضح سياسة الخصوصية هذه كيفية جمعنا واستخدامنا ومشاركة معلوماتك الشخصية عندما تستخدم تطبيقنا",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  const Text(
                    "نقوم بجمع المعلومات الشخصية منك عندما تقوم بإنشاء حساب على تطبيقنا. قد تتضمن هذه المعلومات ما يلي",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    " اسمك  \n رقم هاتفك  \n قد نتطلب عنوانك في بعض الميزات ",
                    textAlign: TextAlign.right,
                  ),
                  const Divider(),
                  const Text(
                    "نقوم أيضاً بجمع معلومات حول كيفية استخدامك لتطبيقنا. قد تتضمن هذه المعلومات ما يلي",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    " المنتجات المفضلة لديك - \n الطلبات التي تطلبها للملابس أو الغسيل  - \n عناوينك المدخلة لمساعدتنا في عملية الطلب-",
                    textAlign: TextAlign.right,
                  ),
                  const Divider(),
                  const Text(
                    "نستخدم المعلومات الشخصية التي نجمعها منك لأغراض مختلفة، بما في ذلك",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    " تقديم خدماتنا لك  \n التواصل معك  \n تحسين تجربة المستخدم ",
                    textAlign: TextAlign.right,
                  ),
                  const Divider(),
                  const Text(
                    "حماية المعلومات",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "نستخدم إجراءات أمنية لحماية معلوماتك الشخصية من الوصول غير المصرح به أو الاستخدام أو الإفشاء أو التلف",
                    textAlign: TextAlign.right,
                  ),
                  const Divider(),
                  const Text(
                    "لديك حقوق معينة فيما يتعلق بمعلوماتك الشخصية. يمكنك",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    " الوصول إلى معلوماتك الشخصية- \n تصحيح معلوماتك الشخصية غير الدقيقة - \n حذف معلوماتك الشخصية - \n الاعتراض على استخدام معلوماتك الشخصية-",
                    textAlign: TextAlign.right,
                  ),
                  const Divider(),
                  const Text(
                    "تغييرات سياسة الخصوصية",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "قد نقوم بتحديث سياسة الخصوصية هذه من وقت لآخر. سنقوم بإعلامك بأي تغييرات مهمة من خلال نشر إشعار على تطبيقنا",
                    textAlign: TextAlign.right,
                  ),
                  const Divider(),
                  const Text(
                    "الموافقة",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "باستخدام موقعنا الإلكتروني أو تطبيقنا، فإنك توافق على سياسة الخصوصية هذه",
                    textAlign: TextAlign.right,
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
            );
          },
        ),
      ),
    );
  }
}
