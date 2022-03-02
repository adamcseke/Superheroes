// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum SearchViewController {
    internal enum EmptyStateView {
      /// The World is in danger and no superhero to save it...
      internal static let label = L10n.tr("Localizable", "searchViewController.emptyStateView.label")
    }
    internal enum SearchBar {
      /// Type here to search...
      internal static let placeholder = L10n.tr("Localizable", "searchViewController.searchBar.placeholder")
    }
  }

  internal enum TabBarViewController {
    internal enum Favorites {
      internal enum TabBarItem {
        /// Favorites
        internal static let title = L10n.tr("Localizable", "tabBarViewController.favorites.tabBarItem.title")
      }
    }
    internal enum Profile {
      internal enum TabBarItem {
        /// Profile
        internal static let title = L10n.tr("Localizable", "tabBarViewController.profile.tabBarItem.title")
      }
    }
    internal enum Search {
      internal enum TabBarItem {
        /// Heroes
        internal static let title = L10n.tr("Localizable", "tabBarViewController.search.tabBarItem.title")
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
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
