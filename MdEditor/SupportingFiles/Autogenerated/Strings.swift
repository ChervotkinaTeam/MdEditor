// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable all

internal enum L10n {

  internal enum App {
    /// About
    internal static let about = L10n.tr("Localizable", "App.about")
  }

  internal enum Document {

    internal enum Action {
      /// New document
      internal static let newDocument = L10n.tr("Localizable", "Document.Action.newDocument")
      /// Open document
      internal static let openDocument = L10n.tr("Localizable", "Document.Action.openDocument")
    }
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