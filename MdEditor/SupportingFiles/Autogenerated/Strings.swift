// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable all

internal enum L10n {

  internal enum MenuButton {
    /// About
    internal static let about = L10n.tr("Localizable", "MenuButton.about")
    /// New document
    internal static let newDocument = L10n.tr("Localizable", "MenuButton.newDocument")
    /// Open document
    internal static let openDocument = L10n.tr("Localizable", "MenuButton.openDocument")
  }
}

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
// swiftlint:enable all