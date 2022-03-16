// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum CommentsView {
    internal enum Button {
      ///  Push to comment
      internal static let title = L10n.tr("Localizable", "commentsView.button.title")
    }
    internal enum TextView {
      /// Write down your thoughts...
      internal static let placeholder = L10n.tr("Localizable", "commentsView.textView.placeholder")
    }
  }

  internal enum DetailViewController {
    internal enum AppearanceView {
      /// Eye color:
      internal static let eyeColor = L10n.tr("Localizable", "detailViewController.appearanceView.eyeColor")
      /// Gender:
      internal static let gender = L10n.tr("Localizable", "detailViewController.appearanceView.gender")
      /// Hair color:
      internal static let hairColor = L10n.tr("Localizable", "detailViewController.appearanceView.hairColor")
      /// Height:
      internal static let height = L10n.tr("Localizable", "detailViewController.appearanceView.height")
      /// Race:
      internal static let race = L10n.tr("Localizable", "detailViewController.appearanceView.race")
      /// Weight:
      internal static let weight = L10n.tr("Localizable", "detailViewController.appearanceView.weight")
    }
    internal enum BiographyView {
      /// Aliases:
      internal static let aliases = L10n.tr("Localizable", "detailViewController.biographyView.aliases")
      /// Alignment:
      internal static let alignment = L10n.tr("Localizable", "detailViewController.biographyView.alignment")
      /// Alter egos:
      internal static let alterEgos = L10n.tr("Localizable", "detailViewController.biographyView.alterEgos")
      /// First appearance:
      internal static let firstAppearance = L10n.tr("Localizable", "detailViewController.biographyView.firstAppearance")
      /// Full name:
      internal static let fullName = L10n.tr("Localizable", "detailViewController.biographyView.fullName")
      /// Place of birth:
      internal static let placeOfBirth = L10n.tr("Localizable", "detailViewController.biographyView.placeOfBirth")
      /// Publisher:
      internal static let publisher = L10n.tr("Localizable", "detailViewController.biographyView.publisher")
      internal enum SectionTitle {
        /// Appearance
        internal static let appearance = L10n.tr("Localizable", "detailViewController.biographyView.sectionTitle.appearance")
        /// Biography
        internal static let biography = L10n.tr("Localizable", "detailViewController.biographyView.sectionTitle.biography")
        /// Connections
        internal static let connections = L10n.tr("Localizable", "detailViewController.biographyView.sectionTitle.connections")
        /// Work
        internal static let work = L10n.tr("Localizable", "detailViewController.biographyView.sectionTitle.work")
      }
    }
    internal enum Characteristics {
      internal enum Button {
        /// Characteristics
        internal static let title = L10n.tr("Localizable", "detailViewController.characteristics.button.title")
      }
    }
    internal enum Comments {
      internal enum Button {
        /// Comments
        internal static let title = L10n.tr("Localizable", "detailViewController.comments.button.title")
      }
    }
    internal enum ConnectionsView {
      /// Group affiliation:
      internal static let groupAffiliation = L10n.tr("Localizable", "detailViewController.connectionsView.groupAffiliation")
      /// Relatives:
      internal static let relatives = L10n.tr("Localizable", "detailViewController.connectionsView.relatives")
    }
    internal enum Powerstats {
      /// Combat
      internal static let combat = L10n.tr("Localizable", "detailViewController.powerstats.Combat")
      /// Durability
      internal static let duranility = L10n.tr("Localizable", "detailViewController.powerstats.Duranility")
      /// Intelligence
      internal static let intelligence = L10n.tr("Localizable", "detailViewController.powerstats.intelligence")
      /// Power
      internal static let power = L10n.tr("Localizable", "detailViewController.powerstats.Power")
      /// Speed
      internal static let speed = L10n.tr("Localizable", "detailViewController.powerstats.Speed")
      /// Strength
      internal static let strength = L10n.tr("Localizable", "detailViewController.powerstats.strength")
      internal enum Button {
        /// Powerstats
        internal static let title = L10n.tr("Localizable", "detailViewController.powerstats.button.title")
      }
    }
    internal enum WorkView {
      /// Base:
      internal static let base = L10n.tr("Localizable", "detailViewController.workView.base")
      /// Occupation:
      internal static let occupation = L10n.tr("Localizable", "detailViewController.workView.occupation")
    }
  }

  internal enum FavoritesViewController {
    internal enum EmptyStateView {
      /// You don't have any favorites.
      internal static let label = L10n.tr("Localizable", "favoritesViewController.emptyStateView.label")
    }
  }

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
    internal enum Fight {
      internal enum TabBarItem {
        /// Fight
        internal static let title = L10n.tr("Localizable", "tabBarViewController.fight.tabBarItem.title")
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
