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
import YatLib

final class ViewController: UIViewController {
    
    /**
     * Cryptocurrency address data that will be attached to the Yat.
     */
    private let yatRecords = [
        YatRecordInput(
            tag: .ADAAddress,
            value: "DdzFFzCqrhsgwQmeWNBTsG8VjYunBLK9GNR93GSLTGj1FeMm8kFoby2cTHxEHBEraHQXmgTtFGz7fThjDRNNvwzcaw6fQdkYySBneRas"
        ),
        YatRecordInput(
            tag: .DOTAddress,
            value: "GC8fuEZG4E5epGf5KGXtcDfvrc6HXE7GJ5YnbiqSpqdQYLg"
        ),
        YatRecordInput(
            tag: .BTCAddress,
            value: "1NDyJtNTjmwk5xPNhjgAMu4HDHigtobu1s"
        ),
        YatRecordInput(
            tag: .ETHAddress,
            value: "108dEFa0272dC118EF03a7993e4fC7A8AcF3a3d1"
        ),
        YatRecordInput(
            tag: .XTRAddress,
            value: "D2E4DB6DAC593A9AF36987A35676838EDE4F69684BA433BAEED68BCE048E111B"
        ),
        YatRecordInput(
            tag: .XMRStandardAddress,
            value: "4AdUndXHHZ6cfufTMvppY6JwXNouMBzSkbLYfpAV5Usx3skxNgYeYTRj5UzqtReoS44qo9mtmXCqY45DJ852K5Jv2684Rge"
        )
    ]
    
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton.layer.cornerRadius = 4
        startButton.layer.masksToBounds = true
        
        Yat.configuration = YatConfiguration(appReturnLink: "scw://y.at", organizationName: "Super Cool Wallet", organizationKey: "SCW")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    @IBAction func onStartButtonTap() {
        Yat.integration.showOnboarding(onViewController: self, records: yatRecords)
    }
}
