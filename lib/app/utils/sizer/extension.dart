part of responsive_sizer;

extension DeviceExt on num {
  /// The respective value in centimeters
  double get cm => this * 37.8;

  /// The respective value millimeters
  double get mm => this * 3.78;

  /// The respective value in quarter-millimeters
  double get Q => this * 0.945;

  /// The respective value in inches
  double get inches => this * 96;

  /// The respective value in picas (1/6th of 1 inch)
  double get pc => this * 16;

  /// The respective value in points (1/72th of 1 inch)
  double get pt => this * inches / 72;

  /// The respective value in pixels (default)
  double get px => this.toDouble();

  /// Respective percentage of the viewport's smaller dimension.
  double get vmin => this * min(Device.height, Device.width) / 100;

  /// Respective percentage of the viewport's larger dimension.
  double get vmax => this * max(Device.height, Device.width) / 100;

  /// Calculates the height depending on the device's screen size
  ///
  /// Eg: 20.h -> will take 20% of the screen's height
  double get h => this * Device.height / 100;

  /// Calculates the width depending on the device's screen size
  ///
  /// Eg: 20.h -> will take 20% of the screen's width
  double get w => this * Device.width / 100;

  /// Calculates the sp (Scalable Pixel) depending on the device's pixel
  /// density and aspect ratio
  double get sp => this * (Device.width / 3) / 100;

  /// Calculates the material dp (Pixel Density)
  /// (https://material.io/design/layout/pixel-density.html#pixel-density-on-android))
  double get dp => this * (w * 160) / Device.pixelRatio;
}
