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

struct Theme {
    
    static var isMidScreen: Bool {
        let height = UIScreen.main.nativeBounds.height
        return height > 1136 && height <= 1334
        
    }
    
    static var isSmallScreen: Bool {
        return UIScreen.main.nativeBounds.height <= 1136
    }
    
    private static func imageNamed(_ name: String) -> UIImage {
        return UIImage(
            named: name,
            in: Bundle(for: YatIntroPageViewController.self),
            compatibleWith: nil
        )!
    }
    
    static var viewElevationShadowColor: UIColor {
        switch YatLib.colorMode {
        case .dark: return Color.clear
        case .light: return Color.black
        }
    }
    
    static var statusBarStyle: UIStatusBarStyle {
        switch YatLib.colorMode {
        case .dark: return .lightContent
        case .light: return .darkContent
        }
    }
    
    static var yatLogoImage: UIImage {
        let fileName: String
        switch YatLib.colorMode {
        case .dark: fileName = "YatLogoWhite"
        case .light: fileName = "YatLogoBlack"
        }
        return UIImage(
            named: fileName,
            in: Bundle(for: YatLib.self),
            compatibleWith: nil
        )!
    }
    
    static var yatLogoTopMargin: CGFloat {
        if isSmallScreen {
            return 20
        } else {
            return 40
        }
    }
    
    static var backgroundColor: UIColor {
        switch YatLib.colorMode {
        case .dark: return Color.black
        case .light: return Color.white
        }
    }
    
    static var containerBackgroundColor: UIColor {
        switch YatLib.colorMode {
        case .dark: return Color.darkBlueBackground
        case .light: return Color.white
        }
    }
    
    static var page1TxInfoContainerTopMargin: CGFloat {
        if isSmallScreen {
            return 90
        } else if isMidScreen {
            return 110
        } else {
            return 176
        }
    }
    
    static var infoTitleBottomMargin: CGFloat {
        if isSmallScreen {
            return -10
        } else if isMidScreen {
            return -15
        } else {
            return -20
        }
    }
    
    static var infoTitleColor: UIColor {
        switch YatLib.colorMode {
        case .dark: return Color.white
        case .light: return Color.black
        }
    }
    
    static var infoTitleFont: UIFont {
        switch YatLib.colorMode {
        case .dark:
            if isSmallScreen {
                return UIFont.CircularSpotifyTxT.book.withSize(21)
            } else {
                return UIFont.CircularSpotifyTxT.book.withSize(24)
            }
        case .light:
            if isSmallScreen {
                return UIFont.Avenir.black.withSize(21)
            } else {
                return UIFont.Avenir.black.withSize(24)
            }
        }
    }
    
    static var infoDescriptionFont: UIFont {
        switch YatLib.colorMode {
        case .dark:
            if isSmallScreen {
                return UIFont.CircularSpotifyTxT.book.withSize(14)
            } else {
                return UIFont.CircularSpotifyTxT.book.withSize(16)
            }
        case .light:
            if isSmallScreen {
                return UIFont.Avenir.medium.withSize(14)
            } else {
                return UIFont.Avenir.medium.withSize(16)
            }
        }
    }
    
    static var infoDescriptionBottomMargin: CGFloat {
        if isSmallScreen {
            return -20
        } else if isMidScreen {
            return -30
        } else {
            return -40
        }
    }
    
    static var primaryButtonColor: UIColor {
        switch YatLib.colorMode {
        case .dark: return Color.blue
        case .light: return Color.purple
        }
    }
    
    static var secondaryButtonColor: UIColor {
        switch YatLib.colorMode {
        case .dark: return Color.secondaryButtonDark
        case .light: return Color.secondaryButtonLight
        }
    }
    
    static var secondaryButtonTextColor: UIColor {
        switch YatLib.colorMode {
        case .dark: return Color.xLightGray
        case .light: return Color.black
        }
    }
    
    static var buttonHeight: CGFloat {
        return 48
    }
    
    static var buttonFont: UIFont {
        switch YatLib.colorMode {
        case .dark:
            return UIFont.CircularSpotifyTxT.book.withSize(16)
        case .light:
            return UIFont.Avenir.heavy.withSize(16)
        }
    }
    
    static var page2BackgroundTopMargin: CGFloat {
        if isSmallScreen {
            return -30
        } else if isMidScreen {
            return 30
        } else {
            return 80
        }
    }
    
    static var sendingBTCToLabelTopMargin: CGFloat {
        if isSmallScreen {
            return 140
        } else {
            return 112
        }
    }
    
    static var infoPage2BackgroundGraphicImage: UIImage {
        switch YatLib.colorMode {
        case .dark:
            return imageNamed("IntroPage2BackgroundGraphicDark")
        case .light:
            return imageNamed("IntroPage2BackgroundGraphicLight")
        }
    }
    
    static var rocketImage: UIImage {
        return imageNamed("Rocket")
    }
    
    static var fullMoonImage: UIImage {
        return imageNamed("FullMoon")
    }
    
    static var webLinkIconImage: UIImage {
        switch YatLib.colorMode {
        case .dark:
            return imageNamed("WebLinkIconDark")
        case .light:
            return imageNamed("WebLinkIconLight")
        }
    }
    
    static var webLinkIconWhiteImage: UIImage {
        return imageNamed("WebLinkIconWhite")
    }
    
    static var infoPage3BackgroundGraphicImage: UIImage {
        switch YatLib.colorMode {
        case .dark:
            return UIImage(
                named: "IntroPage3BackgroundGraphicDark",
                in: Bundle(for: YatIntroPageViewController.self),
                compatibleWith: nil
            )!
        case .light:
            return UIImage(
                named: "IntroPage3BackgroundGraphicLight",
                in: Bundle(for: YatIntroPageViewController.self),
                compatibleWith: nil
            )!
        }
    }
    
    static var page3BackgroundTopMargin: CGFloat {
        if isSmallScreen {
            return -10
        } else if isMidScreen {
            return 30
        } else {
            return 100
        }
    }
    
    static var fireImage: UIImage {
        return imageNamed("Fire")
    }
    
    static var hornSignImage: UIImage {
        return imageNamed("HornSign")
    }
    
    static var sunglassesImage: UIImage {
        return imageNamed("Sunglasses")
    }
    
    static var displayYatTitleTopMargin: CGFloat {
        if isSmallScreen {
            return 40
        } else if isMidScreen {
            return 50
        } else {
            return 61
        }
    }
    
    static var displayYatDescriptionTopMargin: CGFloat {
        if isSmallScreen {
            return 16
        } else if isMidScreen {
            return 18
        } else {
            return 20
        }
    }
    
    static var displayYatEmojiIdLabelTopMargin: CGFloat {
        if isSmallScreen {
            return 25
        } else if isMidScreen {
            return 30
        } else {
            return 40
        }
    }
    
    static var termsFont: UIFont {
        switch YatLib.colorMode {
        case .dark:
            return UIFont.CircularSpotifyTxT.book.withSize(14)
        case .light:
            return UIFont.Avenir.medium.withSize(14)
        }
    }
    
    static var termsButtonBottomMargin: CGFloat {
        if isSmallScreen {
            return -20
        } else if isMidScreen {
            return -30
        } else {
            return -40
        }
    }
    
    static var upgradeToCustomYatButtonBottomMargin: CGFloat {
        if isSmallScreen {
            return -20
        } else if isMidScreen {
            return -30
        } else {
            return -38
        }
    }
    
    static var backButtonImage: UIImage {
        switch YatLib.colorMode {
        case .dark:
            return imageNamed("BackButtonDark")
        case .light:
            return imageNamed("BackButtonLight")
        }
    }
    
    static var closeButtonImage: UIImage {
        switch YatLib.colorMode {
        case .dark:
            return imageNamed("CloseButtonDark")
        case .light:
            return imageNamed("CloseButtonLight")
        }
    }
    
}
