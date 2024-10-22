// ignore_for_file: deprecated_member_use, file_names, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/config/themes/cubit/themes_cubit.dart';
import 'package:sheek_bazar/core/utils/app_colors.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    Future<void> openWhatsApp(String whatsappNumber) async {
      String url;
      if (Platform.isAndroid) {
        // add the [https]
        url = Uri.encodeFull('https://wa.me/$whatsappNumber');

        // return "https://wa.me/$phone/?text=${Uri.parse(message)}"; // new line
      } else {
        // add the [https]
        url = Uri.encodeFull(
            'https://api.whatsapp.com/send?phone=$whatsappNumber');

        // return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}"; // new line
      }
      // Check if WhatsApp is installed
      await canLaunch(url) ? launch(url) : print('WhatsApp not installed');
    }

    Future<void> callNumber(String phoneNumber) async {
      print("asd");
      const String url = 'tel:';
      if (await canLaunch(url + phoneNumber)) {
        await launch(url + phoneNumber);
      } else {
        print('Failed to launch ');
      }
    }

    Future<void> launchEmail(String emailAddress) async {
      const String url = 'mailto:';
      if (await canLaunch(url + emailAddress)) {
        await launch(url + emailAddress);
      } else {
        print('Failed to launch email for address $emailAddress');
      }
    }

    Future<void> launchMessage(String emailAddress) async {
      const String url = 'sms:';
      if (await canLaunch(url + emailAddress)) {
        await launch(url + emailAddress);
      } else {
        print('Failed to launch email for address $emailAddress');
      }
    }

    Future<void> launchSocialMedia(String insta_link) async {
      if (await canLaunch(insta_link)) {
        await launch(
          insta_link,
          universalLinksOnly: true,
        );
      } else {
        throw 'There was a problem to open the url: $insta_link';
      }
    }

    return Scaffold(
      appBar: AppConstant.customAppbar(
          context,
          Text(
            "contact_us".tr(context),
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: AppColors.primaryColor),
          ),
          [],
          true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Center(
            child: Image.asset(
              "assets/images/contact_us.png",
              height: 750.h,
            ),
          ),
          const Divider(),
          AppConstant.customSizedBox(0, 50),
          Text(
            "social_media".tr(context),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          AppConstant.customSizedBox(0, 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () async {
                    await launchSocialMedia(
                        "https://www.facebook.com/sheek.bazar");
                  },
                  child: Image.asset(
                    "assets/images/facebook_icon.png",
                    height: 125.h,
                  )),
              InkWell(
                  onTap: () async {
                    await launchSocialMedia(
                        "https://www.tiktok.com/@sheek.bazar");
                  },
                  child: Image.asset(
                    "assets/images/tiktok_icon.png",
                    height: 125.h,
                  )),
              InkWell(
                  onTap: () async {
                    await launchSocialMedia(
                        "https://www.instagram.com/sheek.bazar/");
                  },
                  child: Image.asset(
                    "assets/images/insta_icon.png",
                    height: 150.h,
                    width: 150.w,
                  )),
            ],
          ),
          AppConstant.customSizedBox(0, 50),
          const Divider(),
          AppConstant.customSizedBox(0, 50),
          Text(
            "call_us".tr(context),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          AppConstant.customSizedBox(0, 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocBuilder<ThemesCubit, ThemesState>(
                builder: (context, theme) {
                  return InkWell(
                      onTap: () async {
                        await openWhatsApp("+9647502907090");
                      },
                      child: Image.asset(
                        "assets/images/whatsapp_logo.png",
                        height: 125.h,
                      ));
                },
              ),
              InkWell(
                  onTap: () async {
                    await callNumber("+964750 290 7090");
                  },
                  child: const CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    child: Icon(Icons.call, color: AppColors.whiteColor),
                  )),
              // AppConstant.customSizedBox(50, 0),
              InkWell(
                  onTap: () async {
                    await launchMessage("+964750 290 7090");
                  },
                  child: const CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    child: Icon(Icons.mail, color: AppColors.whiteColor),
                  )),
            ],
          ),
          AppConstant.customSizedBox(0, 50),
          const Divider(),
          AppConstant.customSizedBox(0, 50),
          Text(
            "email".tr(context),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          AppConstant.customSizedBox(0, 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () async {
                    await launchEmail("Info@sheek-bazar.com");
                  },
                  child: const Text(
                    "Info@sheek-bazar.com",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
            ],
          )
        ]),
      ),
    );
  }
}
