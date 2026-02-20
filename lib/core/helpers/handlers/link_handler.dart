import 'package:feedback_to_vfd/core/helpers/handlers/social_media_type_enum.dart';
import 'package:url_launcher/url_launcher_string.dart';

Future<void> openSocialMediaLink(SocialMediaType socialMedia) async {
  switch (socialMedia) {
    case SocialMediaType.twitter:
      await handleLink(
        'https://x.com/yfdtweets',
      );
    case SocialMediaType.telegram:
      await handleLink(
        'https://t.me/yfd_official',
      );
    case SocialMediaType.facebook:
      await handleLink(
        'https://www.facebook.com/ephraim.umunnakwe.7',
      );
    case SocialMediaType.youtube:
      await handleLink(
        'https://www.youtube.com/@theKingRaym',
      );
    case SocialMediaType.linkedin:
      await handleLink(
        'https://t.me/yfd_official',
      );
    case SocialMediaType.instagram:
      await handleLink(
        'https://www.instagram.com/yfd?igsh=ZGNzZDkxNW15Zmsx',
      );
    case SocialMediaType.tiktok:
      await handleLink(
        'https://www.tiktok.com/@yfd_official?_t=ZM-8ugtGrVvxTz&_r=1',
      );
    case SocialMediaType.none:
      break;
  }
}

Future<void> handleLink(String link) async {
  if (link.isNotEmpty) {
    await launchUrlString(link);
  }
}
