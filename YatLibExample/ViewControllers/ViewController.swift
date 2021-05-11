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

class ViewController: UIViewController {
    
    /**
     * These values are provided to the app developer by the Yat development team.
     * REPLACE THESE VALUES WITH THE PROVIDED ONES - OR THE APP WON'T WORK.
     */
    private let yatAppConfig = YatAppConfig(
        name: "Super Cool Wallet",
        sourceName: "SCW",
        pathKey: "scw",
        pubKey: "{64 character hex public key}",
        code: "66b6a5aa-11b4-12a9-1c1e-84765ef174ab",
        authToken: "AppToken84765783"
    )
    /**
     * Sample data that will be attached to the Yat.
     */
    private let yatRecords = [
        YatRecord(
            type: .BTCAddress,
            value: "1NDyJtNTjmwk5xPNhjgAMu4HDHigtobu1s"
        ),
        YatRecord(
            type: .ETHAddress,
            value: "108dEFa0272dC118EF03a7993e4fC7A8AcF3a3d1"
        ),
        YatRecord(
            type: .XTRAddress,
            value: "D2E4DB6DAC593A9AF36987A35676838EDE4F69684BA433BAEED68BCE048E111B"
        ),
        YatRecord(
            type: .XMRStandardAddress,
            value: "4AdUndXHHZ6cfufTMvppY6JwXNouMBzSkbLYfpAV5Usx3skxNgYeYTRj5UzqtReoS44qo9mtmXCqY45DJ852K5Jv2684Rge"
        )
    ]
    
    @IBOutlet weak var congratulationsLabel: UILabel!
    @IBOutlet weak var emojiIdLabel: UILabel!
    @IBOutlet weak var isNowYoursLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        congratulationsLabel.isHidden = true
        emojiIdLabel.isHidden = true
        emojiIdLabel.layer.cornerRadius = emojiIdLabel.frame.height / 2
        emojiIdLabel.layer.masksToBounds = true
        isNowYoursLabel.isHidden = true
        startButton.layer.cornerRadius = 4
        startButton.layer.masksToBounds = true
        
        YatLib.initialize(
            appConfig: yatAppConfig,
            // random user id
            userId: UUID().uuidString,
            // random password
            userPassword: UUID().uuidString,
            colorMode: .dark,
            delegate: self,
            records: yatRecords
        )
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func onStartButtonTap() {
        YatLib.start(hostViewController: self)
    }


}

extension ViewController: YatLibDelegate {
    
    func onYatIntegrationComplete(yat: String) {
        congratulationsLabel.isHidden = false
        emojiIdLabel.isHidden = false
        emojiIdLabel.text = yat
        isNowYoursLabel.isHidden = false
        startButton.isHidden = true
        YatLib.lookupYat(yat: yat) {
            (lookupResponse) in
            print("Yat lookup success. Yat has \(lookupResponse.records.count) records.")
            for (index, yatRecord) in lookupResponse.records.enumerated() {
                print("Record #\(index + 1): \(yatRecord.type) :: \(yatRecord.value)")
            }
        } onError: {
            (error) in
            print("Yat lookup error: \(error.localizedDescription)")
        }
    }
    
}
