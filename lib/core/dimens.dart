enum DeviceType { mobile, tablet, desktop }

class Dimens {
  static DeviceType deviceType = DeviceType.mobile;

  static void setDeviceType(DeviceType device) => deviceType = device;

  static double _adjust(double base) {
    double scale;
    switch (deviceType) {
      case DeviceType.desktop:
        scale = 2.0;
        break;
      case DeviceType.tablet:
        scale = 1.3;
        break;
      case DeviceType.mobile:
        scale = 1.0;
        break;
    }
    return base * scale;
  }

  //common space
  static double get spaceMin => _adjust(1);

  static double get space4xSmall => _adjust(4);

  static double get space3xSmall => _adjust(6);

  static double get space2xSmall => _adjust(8);

  static double get spaceXSmall => _adjust(10);

  static double get spaceSmall => _adjust(12);

  static double get spaceMedium => _adjust(14);

  static double get spaceXMedium => _adjust(16);

  static double get space2xMedium => _adjust(18);

  static double get space3xMedium => _adjust(20);

  static double get space4xMedium => _adjust(22);

  static double get spaceLarge => _adjust(24);

  static double get spaceXLarge => _adjust(26);

  static double get space2xLarge => _adjust(28);

  static double get space3xLarge => _adjust(30);

  static double get space4xLarge => _adjust(32);

  static double get space5xLarge => _adjust(36);

  static double get space6xLarge => _adjust(40);

  //common font sizes
  static double get fontSizeEight => _adjust(8);

  static double get fontSizeTen => _adjust(10);

  static double get fontSizeTwelve => _adjust(12);

  static double get fontSizeFourteen => _adjust(14);

  static double get fontSizeSixteen => _adjust(16);

  static double get fontSizeEighteen => _adjust(18);

  static double get fontSizeTwenty => _adjust(20);

  //Padding
  static double get padding5xSmall => _adjust(2);

  static double get padding4xSmall => _adjust(4);

  static double get padding3xSmall => _adjust(6);

  static double get padding2xSmall => _adjust(8);

  static double get paddingXSmall => _adjust(10);

  static double get paddingSmall => _adjust(12);

  static double get paddingMedium => _adjust(14);

  static double get paddingXMedium => _adjust(16);

  static double get padding2xMedium => _adjust(18);

  static double get padding3xMedium => _adjust(20);

  static double get padding4xMedium => _adjust(22);

  static double get paddingLarge => _adjust(24);

  static double get paddingXLarge => _adjust(26);

  static double get padding2xLarge => _adjust(28);

  static double get padding3xLarge => _adjust(30);

  static double get padding4xLarge => _adjust(32);

  //common radius sizes
  static double get radius4xSmall => _adjust(4);

  static double get radius3xSmall => _adjust(6);

  static double get radius2xSmall => _adjust(8);

  static double get radiusXSmall => _adjust(10);

  static double get radiusSmall => _adjust(12);

  static double get radiusMedium => _adjust(14);

  static double get radiusXMedium => _adjust(16);

  static double get radius2xMedium => _adjust(18);

  static double get radius3xMedium => _adjust(20);

  static double get radius4xMedium => _adjust(22);

  static double get radiusLarge => _adjust(24);

  static double get radiusXLarge => _adjust(26);

  static double get radius2xLarge => _adjust(28);

  static double get radius3xLarge => _adjust(30);

  static double get radius4xLarge => _adjust(32);

  //sizeBox sizes
  static double get sizeBox4xSmall => _adjust(4);

  static double get sizeBox3xSmall => _adjust(6);

  static double get sizeBox2xSmall => _adjust(8);

  static double get sizeBoxXSmall => _adjust(10);

  static double get sizeBoxSmall => _adjust(12);

  static double get sizeBoxMedium => _adjust(14);

  static double get sizeBoxXMedium => _adjust(16);

  static double get sizeBox2xMedium => _adjust(18);

  static double get sizeBox3xMedium => _adjust(20);

  static double get sizeBox4xMedium => _adjust(22);

  static double get sizeBoxLarge => _adjust(24);

  static double get sizeBoxXLarge => _adjust(26);

  static double get sizeBox2xLarge => _adjust(28);

  static double get sizeBox3xLarge => _adjust(30);

  static double get sizeBox4xLarge => _adjust(32);

  //Icons sizes
  static double get icon4xSmall => _adjust(8);

  static double get icon2xSmall => _adjust(12);

  static double get iconXSmall => _adjust(16);

  static double get iconSmall => _adjust(20);

  static double get iconMedium => _adjust(24);

  static double get iconXMedium => _adjust(28);

  static double get icon2xMedium => _adjust(32);

  static double get iconLarge => _adjust(36);

  static double get iconXLarge => _adjust(40);

  static double get icon2xLarge => _adjust(44);

  static double get icon3xLarge => _adjust(48);

  //Buttons
  static double get button2xSmall => _adjust(12);

  static double get buttonXSmall => _adjust(16);

  static double get buttonSmall => _adjust(20);

  static double get buttonMedium => _adjust(24);

  static double get buttonXMedium => _adjust(28);

  static double get button2xMedium => _adjust(32);

  static double get buttonLarge => _adjust(36);

  static double get buttonXLarge => _adjust(40);

  static double get button2xLarge => _adjust(44);

  //common border widths
  static double get borderWidthXSmall => _adjust(0.5);

  static double get borderWidthSmall => _adjust(1);

  static double get borderWidthMedium => _adjust(1.5);

  static double get borderWidthXMedium => _adjust(2);

  static double get borderWidthLarge => _adjust(2.5);

  static double get borderWidthXLarge => _adjust(3);

  //Navigation Bar
  static double get navigationBarHeight => _adjust(80);

  static double get navigationBarPaddingSmall => _adjust(36);

  static double get navigationBarPaddingMedium => _adjust(40);

  static double get navigationBarPaddingLarge => _adjust(44);

  //Text Fields
  static double get textFieldHeightSmall => _adjust(45);

  static double get textFieldHeightMedium => _adjust(55);

  static double get textFieldHeightLarge => _adjust(65);

  //Tab Bar
  static double get tabBarHeight => _adjust(70);

  static double get checkBoxScale => 0.9; // scale might stay constant

  //Toolbar
  static double get keyboardToolbarHeight => _adjust(44);

  //Loader
  static double get loaderSizeSmall => _adjust(24);

  static double get loaderSizeMedium => _adjust(32);

  static double get loaderSizeLarge => _adjust(40);

  //Elevation
  static double get elevationSmall => _adjust(2);

  static double get elevationMedium => _adjust(4);

  static double get elevationLarge => _adjust(6);

  static double get elevationXLarge => _adjust(8);

  //Thickness
  static double get dividerThicknessXSmall => _adjust(0.5);

  static double get dividerThicknessSmall => _adjust(1);

  static double get dividerThicknessMedium => _adjust(2);

  static double get dividerThicknessLarge => _adjust(3);

  //Container Height
  static double get container3xSmall => _adjust(65);

  static double get container2xSmall => _adjust(100);

  static double get containerXSmall => _adjust(150);

  static double get containerSmall => _adjust(200);

  static double get containerMedium => _adjust(250);

  static double get containerXMedium => _adjust(300);

  static double get container2xMedium => _adjust(350);

  static double get containerLarge => _adjust(400);

  static double get containerXLarge => _adjust(450);

  static double get container2xLarge => _adjust(500);

  //Visual density
  static double get visualDensitySmall => -4;

  static double get visualDensityMedium => -2;

  //Toggle button
  static double get toggleButtonHeight => _adjust(30);

  static double get toggleButtonWidth => _adjust(50);

  //Bottom sheet height
  static double get bottomSheetXSmall => 0.3;

  static double get bottomSheetSmall => 0.4;

  static double get bottomSheetMedium => 0.5;

  static double get bottomSheetXMedium => 0.6;

  static double get bottomSheetLarge => 0.7;

  static double get bottomSheetXLarge => 0.8;

  static double get bottomSheet2xLarge => 0.9;

  //DropDown
  static double get dropDownMenuHeightSmall => _adjust(180);

  static double get dropDownMenuHeightMedium => _adjust(360);

  static double get dropDownMenuHeightLarge => _adjust(480);

  static double get dropDownHeightSmall => _adjust(40);
}
