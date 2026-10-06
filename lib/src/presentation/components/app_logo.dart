import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum _SecuritySaasLogoVariant {
  logo('logo.svg'),
  fullLogo('full-logo.svg');

  final String fileName;

  const _SecuritySaasLogoVariant(this.fileName);
}

class SecuritySaasLogo extends StatelessWidget {
  const SecuritySaasLogo({super.key, this.height, this.width})
    : _variant = _SecuritySaasLogoVariant.logo;

  const SecuritySaasLogo.full({super.key, this.height, this.width})
    : _variant = _SecuritySaasLogoVariant.fullLogo;

  final double? height;
  final double? width;
  final _SecuritySaasLogoVariant _variant;

  static const _assetPath = 'assets/logo/';

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      _assetPath + _variant.fileName,
      width: width,
      height: height,
      fit: BoxFit.contain,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('height', height));
    properties.add(DoubleProperty('width', width));
    properties.add(
      EnumProperty<_SecuritySaasLogoVariant>('_variant', _variant),
    );
  }
}
