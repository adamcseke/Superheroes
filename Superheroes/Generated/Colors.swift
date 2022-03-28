// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Colors {
  internal static let fighterStatOrange = ColorAsset(name: "FighterStatOrange")
  internal static let fighterStatPurple = ColorAsset(name: "FighterStatPurple")
  internal static let gray = ColorAsset(name: "Gray")
  internal static let grayHeroName = ColorAsset(name: "GrayHeroName")
  internal static let orange = ColorAsset(name: "Orange")
  internal static let progressCircleBlue = ColorAsset(name: "ProgressCircleBlue")
  internal static let progressCircleBrown = ColorAsset(name: "ProgressCircleBrown")
  internal static let progressCircleGreen = ColorAsset(name: "ProgressCircleGreen")
  internal static let progressCircleOrange = ColorAsset(name: "ProgressCircleOrange")
  internal static let progressCirclePink = ColorAsset(name: "ProgressCirclePink")
  internal static let progressCircleRed = ColorAsset(name: "ProgressCircleRed")
  internal static let statButtonBorderLightMode = ColorAsset(name: "StatButtonBorderLightMode")
  internal static let statButtonLabelLightMode = ColorAsset(name: "StatButtonLabelLightMode")
  internal static let tabBar = ColorAsset(name: "TabBar")
  internal static let white = ColorAsset(name: "White")
  internal static let infoLabel = ColorAsset(name: "infoLabel")
  internal static let saveButtonBackground = ColorAsset(name: "saveButtonBackground")
  internal static let sectionTitleLightMode = ColorAsset(name: "sectionTitleLightMode")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  internal func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
