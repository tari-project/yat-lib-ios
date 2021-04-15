/*
    Copyright 2021 The Tari Project

    Redistribution and use in source and binary forms, with or
    without modification, are permitted provided that the
    following conditions are met:

    1. Redistributions of source code must retain the above copyright notice,
    this list of conditions and the following disclaimer.

    2. Redistributions in binary form must reproduce the above
    copyright notice, this list of conditions and the following disclaimer in the
    documentation and/or other materials provided with the distribution.

    3. Neither the name of the copyright holder nor the names of
    its contributors may be used to endorse or promote products
    derived from this software without specific prior written permission.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
    CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
    INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
    OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
    DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
    CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
    SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
    NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
    LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
    HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
    CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
    OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
    SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import Foundation
import UIKit

extension UIColor {
    
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
    
    
    
}


struct Color {
    
    private static func named(_ name: String) -> UIColor? {
        return UIColor(
            named: name,
            in: Bundle(for: YatIntroPageViewController.self),
            compatibleWith: nil
        )
    }
    
    static var darkBlueBackground: UIColor  { return named("DarkBlueBackground")! }
    static var blue: UIColor { return named("Blue")! }
    static var darkGray: UIColor { return named("DarkGray")! }
    static var xDarkGray: UIColor { return named("XDarkGray")! }
    static var lightGray: UIColor { return named("LightGray")! }
    static var xLightGray: UIColor { return named("XLightGray")! }
    static var xxLightGray: UIColor { return named("XXLightGray")! }
    static var termsGray: UIColor { return named("TermsGray")! }
    static var secondaryButtonLight: UIColor { return named("SecondaryButtonLight")! }
    static var secondaryButtonDark: UIColor { return named("SecondaryButtonDark")! }
    static var white: UIColor { return UIColor(red: 1, green: 1, blue: 1, alpha: 1) }
    static var clear: UIColor { return UIColor(red: 1, green: 1, blue: 1, alpha: 0) }
    static var black: UIColor { return UIColor(red: 0, green: 0, blue: 0, alpha: 1) }
    static var purple: UIColor { return named("Purple")! }
    static var orangeGradientStart: UIColor { return named("OrangeGradientStart")! }
    static var orangeGradientEnd: UIColor { return named("OrangeGradientEnd")! }
    
}
