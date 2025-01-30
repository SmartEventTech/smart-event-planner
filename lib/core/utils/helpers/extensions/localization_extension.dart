import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';

extension Localization on BuildContext {
  S get tr => S.of(this);
}

S get tr => S.current;
