// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable all

public enum L10n {
  public enum LaunchScreen {
  }
  public enum Localizable {

    public enum App {
      /// About
      public static let about = L10n.tr("Localizable", "App.about")
    }

    public enum Document {

      public enum Action {
        /// New document
        public static let newDocument = L10n.tr("Localizable", "Document.Action.newDocument")
        /// Open document
        public static let openDocument = L10n.tr("Localizable", "Document.Action.openDocument")
      }
    }

    public enum Files {
      /// yyyy.MM.dd HH:m:ss
      public static let dateFormat = L10n.tr("Localizable", "Files.dateFormat")
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