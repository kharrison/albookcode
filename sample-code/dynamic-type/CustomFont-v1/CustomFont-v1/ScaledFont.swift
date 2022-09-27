//  Copyright (c) 2017-2021 Keith Harrison. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright
//  notice, this list of conditions and the following disclaimer in the
//  documentation and/or other materials provided with the distribution.
//
//  3. Neither the name of the copyright holder nor the names of its
//  contributors may be used to endorse or promote products derived from
//  this software without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//  POSSIBILITY OF SUCH DAMAGE.

import UIKit

/// A utility type to help you use custom fonts with
/// dynamic type.
///
/// To use this type you must supply the name of a style
/// dictionary for the font when creating the `ScaledFont`.
/// The style dictionary should be stored as a property list
/// file in the main bundle.
///
/// The style dictionary contains an entry for each text
/// style. The available text styles are:
///
/// - `largeTitle`, `title`, `title2`, `title3`
/// -  `headline`, `subheadline`, `body`, `callout`
/// -  `footnote`, `caption`, `caption2`
///
/// The value of each entry is a dictionary with two keys:
///
/// + `fontName`: A `String` which is the font name.
/// + `fontSize`: A number which is the point size to use
///             at the `.large` (base) content size.
///
/// For example to use a 17 pt Noteworthy-Bold font
/// for the `.headline` style at the `.large` content size:
///
///     <dict>
///         <key>headline</key>
///         <dict>
///             <key>fontName</key>
///             <string>Noteworthy-Bold</string>
///             <key>fontSize</key>
///             <integer>17</integer>
///         </dict>
///     </dict>
///
/// You do not need to include an entry for every text style
/// but if you try to use a text style that is not included
/// in the dictionary it will fallback to the system preferred
/// font.
///
/// ## Using With UIKit
///
/// For `UIKit`, apply the scaled font to text labels, text fields or text
/// views:
///
/// ```swift
/// let scaledFont = ScaledFont(fontName: "Noteworthy")
/// label.font = scaledFont.font(forTextStyle: .headline)
/// label.adjustsFontForContentSizeCategory = true
/// ```
///
/// Remember to set the `adjustsFontFotContentSizeCategory` property
/// to have the font size adjust automatically when the user changes
/// their preferred content size.
///

@available(iOS 11.0, tvOS 11.0, watchOS 4.0, *)
public struct ScaledFont {
    internal enum StyleKey: String, Decodable {
        case largeTitle, title, title2, title3
        case headline, subheadline, body, callout
        case footnote, caption, caption2
    }

    internal struct FontDescription: Decodable {
        let fontSize: CGFloat
        let fontName: String
    }

    internal typealias StyleDictionary = [StyleKey.RawValue: FontDescription]
    internal var styleDictionary: StyleDictionary?

    /// Create a `ScaledFont`
    ///
    /// - Parameter fontName: Name of a plist file (without the extension)
    ///   that contains the style dictionary used to scale fonts for each
    ///   text style.
    /// - Parameter bundle: The `Bundle` that contains the style dictionary.
    ///   Default is the main bundle.

    public init(fontName: String, bundle: Bundle = .main) {
        if let url = bundle.url(forResource: fontName, withExtension: "plist"),
           let data = try? Data(contentsOf: url)
        {
            let decoder = PropertyListDecoder()
            styleDictionary = try? decoder.decode(StyleDictionary.self, from: data)
        }
    }

    /// Get the scaled font for the given text style using the
    /// style dictionary supplied at initialization.
    ///
    /// - Parameter textStyle: The `UIFont.TextStyle` for the
    ///   font.
    /// - Returns: A `UIFont` of the custom font that has been
    ///   scaled for the users currently selected preferred
    ///   text size.
    ///
    /// - Note: If the style dictionary does not have
    ///   a font for this text style the default preferred
    ///   font is returned.

    public func font(forTextStyle textStyle: UIFont.TextStyle) -> UIFont {
        guard let styleKey = StyleKey(textStyle),
              let fontDescription = styleDictionary?[styleKey.rawValue],
              let font = UIFont(name: fontDescription.fontName, size: fontDescription.fontSize)
        else {
            return UIFont.preferredFont(forTextStyle: textStyle)
        }

        let fontMetrics = UIFontMetrics(forTextStyle: textStyle)
        return fontMetrics.scaledFont(for: font)
    }
}

@available(iOS 11.0, tvOS 11.0, watchOS 4.0, *)
extension ScaledFont.StyleKey {
    init?(_ textStyle: UIFont.TextStyle) {
        #if !os(tvOS)
        if #available(watchOS 5.0, *) {
            if textStyle == .largeTitle {
                self = .largeTitle
                return
            }
        }
        #endif
        switch textStyle {
            case .title1: self = .title
            case .title2: self = .title2
            case .title3: self = .title3
            case .headline: self = .headline
            case .subheadline: self = .subheadline
            case .body: self = .body
            case .callout: self = .callout
            case .footnote: self = .footnote
            case .caption1: self = .caption
            case .caption2: self = .caption2
            default: return nil
        }
    }
}
