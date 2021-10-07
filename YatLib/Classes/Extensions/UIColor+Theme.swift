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

import UIKit

extension UIColor {
    
    // MARK: - Light Style
    
    static var closeButtonGrey: Self { named("CloseButtonBackgroundColor") }
    static var buttonTextBlack: Self { named("ButtonTextBlack") }
    static var pagerBlue: Self { named("PagerBlue") }
    static var pagerGrey: Self { named("PagerGrey") }
    static var primaryBlue: Self { named("PrimaryBlue") }
    static var secondaryGrey: Self { named("SecondaryGrey") }
    static var textGrey: Self { named("TextGrey") }
    static var capsuleShadow: Self { named("CapsuleShadow") }
    
    // MARK: - Dark Style
    
    static var backgroundDark: Self { named("BackgroundDark") }
    static var textLightGrey: Self { named("TextLightGrey") }
    static var primaryLightBlue: Self { named("PrimaryLightBlue") }
    static var secondaryDark: Self { named("SecondaryDark") }
    static var pagerSolidGrey: Self { named("PagerSolidGrey") }
    
    // MARK: - Helpers
    
    private static func named(_ name: String) -> Self! { Self(named: name, in: .local, compatibleWith: nil) }
}
