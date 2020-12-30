//
//  NSAttributedStringExtensions.swift
//  Wenyishou
//
//  Created by 永芯 on 2020/5/27.
//  Copyright © 2020 永芯. All rights reserved.
//

import Foundation
import UIKit

struct AttrString {
  let attributedString: NSAttributedString
}

extension AttrString: ExpressibleByStringLiteral {
  init(stringLiteral: String) {
    self.attributedString = NSAttributedString(string: stringLiteral)
  }
}

extension AttrString: CustomStringConvertible {
  var description: String {
    return String(describing: self.attributedString)
  }
}

extension AttrString: ExpressibleByStringInterpolation {
  init(stringInterpolation: StringInterpolation) {
    self.attributedString = NSAttributedString(attributedString: stringInterpolation.attributedString)
  }

  struct StringInterpolation: StringInterpolationProtocol {
    var attributedString: NSMutableAttributedString

    init(literalCapacity: Int, interpolationCount: Int) {
      self.attributedString = NSMutableAttributedString()
    }

    func appendLiteral(_ literal: String) {
      let astr = NSAttributedString(string: literal)
      self.attributedString.append(astr)
    }

    func appendInterpolation(_ string: String, attributes: [NSAttributedString.Key: Any]) {
      let astr = NSAttributedString(string: string, attributes: attributes)
      self.attributedString.append(astr)
    }
  }
}

extension AttrString {
  struct Style {
    let attributes: [NSAttributedString.Key: Any]
    static func font(_ font: UIFont) -> Style {
      return Style(attributes: [.font: font])
    }
    static func color(_ color: UIColor) -> Style {
      return Style(attributes: [.foregroundColor: color])
    }
    static func bgColor(_ color: UIColor) -> Style {
      return Style(attributes: [.backgroundColor: color])
    }
    static func link(_ link: String) -> Style {
      return .link(URL(string: link)!)
    }
    static func link(_ link: URL) -> Style {
      return Style(attributes: [.link: link])
    }
    static let oblique = Style(attributes: [.obliqueness: 0.1])
    static func underline(_ color: UIColor, _ style: NSUnderlineStyle) -> Style {
      return Style(attributes: [
        .underlineColor: color,
        .underlineStyle: style.rawValue
      ])
    }
    static func alignment(_ alignment: NSTextAlignment) -> Style {
      let ps = NSMutableParagraphStyle()
      ps.alignment = alignment
      return Style(attributes: [.paragraphStyle: ps])
    }
  }
}
