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

/// A representation on reacord key-value pair which can be associated with user's Yat.
public struct YatRecordInput {
    
    /// Record key used by Yat service to store data accociated with user's Yat.
    public enum Tag: String {
        /// Aave wallet address key.
        case AAVEAddress = "0x1026"
        /// Cardano wallet address key.
        case ADAAddress = "0x1012"
        /// Algorand wallet address key.
        case ALGOAddress = "0x1038"
        /// Ankr wallet address key.
        case ANKRAddress = "0x106E"
        /// Aragon wallet address key.
        case ARAddress = "0x106F"
        /// Cosmos wallet address key.
        case ATOMAddress = "0x1032"
        /// Avalanche wallet address key.
        case AVAXAddress = "0x1035"
        /// BakerySwap wallet address key.
        case BAKEAddress = "0x1070"
        /// Basic Attention Token wallet address key.
        case BATAddress = "0x1055"
        /// Bitcoin Cash wallet address key.
        case BCHAddress = "0x1017"
        /// Binance Coin wallet address key.
        case BNBAddress = "0x1010"
        /// Bancor wallet address key.
        case BNTAddress = "0x1061"
        /// Bitcoin SV wallet address key.
        case BSVAddress = "0x102C"
        /// Binance Bitcoin wallet address key.
        case BTCBAddress = "0x1041"
        /// Bitcoin wallet address key.
        case BTCAddress = "0x1003"
        /// Bitcoin Gold wallet address key.
        case BTGAddress = "0x1059"
        /// BitTorrent wallet address key.
        case BTTAddress = "0x103B"
        /// Binance USD wallet address key.
        case BUSDAddress = "0x1025"
        /// PancakeSwap wallet address key.
        case CAKEAddress = "0x102E"
        /// Celo wallet address key.
        case CELOAddress = "0x106D"
        /// Celsius wallet address key.
        case CELAddress = "0x1057"
        /// SwissBorg wallet address key.
        case CHSBAddress = "0x1069"
        /// Chiliz wallet address key.
        case CHZAddress = "0x1046"
        /// Compound wallet address key.
        case COMPAddress = "0x103A"
        /// Crypto.com Coin wallet address key.
        case CROAddress = "0x1039"
        /// CVR wallet address key.
        case CRVAddress = "0x106B"
        /// Dai wallet address key.
        case DAIAddress = "0x1033"
        /// Dash wallet address key.
        case DASHAddress = "0x103C"
        /// Decred wallet address key.
        case DCRAddress = "0x1043"
        /// DigiByte wallet address key.
        case DGBAddress = "0x105C"
        /// Dogecoin wallet address key.
        case DOGEAddress = "0x1013"
        /// Polkadot wallet address key.
        case DOTAddress = "0x1015"
        /// Elrond wallet address key.
        case EGLDAddress = "0x1040"
        /// Enjin Coin wallet address key.
        case ENJAddress = "0x1058"
        /// EOS wallet address key.
        case EOSAddress = "0x1020"
        /// Ethereum Classic wallet address key.
        case ETCAddress = "0x101F"
        /// Ethereum wallet address key.
        case ETHAddress = "0x1004"
        /// Filecoin wallet address key.
        case FILAddress = "0x1024"
        /// Fantom wallet address key.
        case FTMAddress = "0x105D"
        /// FTX Token wallet address key.
        case FTTAddress = "0x102D"
        /// The Graph wallet address key.
        case GRTAddress = "0x105B"
        /// Hedera Hashgraph wallet address key.
        case HBARAddress = "0x1048"
        /// Helium wallet address key.
        case HNTAddress = "0x1064"
        /// Holo wallet address key.
        case HOTAddress = "0x1053"
        /// Huobi Token wallet address key.
        case HTAddress = "0x102A"
        /// Internet Computer wallet address key.
        case ICPAddress = "0x1016"
        /// ICON wallet address key.
        case ICXAddress = "0x1065"
        /// Klaytn wallet address key.
        case KLAYAddress = "0x1031"
        /// Kusama wallet address key.
        case KSMAddress = "0x1036"
        /// LEO Token wallet address key.
        case LEOAddress = "0x103E"
        /// Chainlink wallet address key.
        case LINKAddress = "0x101A"
        /// Litecoin wallet address key.
        case LTCAddress = "0x1019"
        /// Terra wallet address key.
        case LUNAAddress = "0x102B"
        /// Decentraland wallet address key.
        case MANAAddress = "0x104F"
        /// Polygon wallet address key.
        case MATICAddress = "0x1029"
        /// IOTA wallet address key.
        case MIOTAAddress = "0x102F"
        /// Maker wallet address key.
        case MKRAddress = "0x1034"
        /// Nano wallet address key.
        case NANOAddress = "0x104D"
        /// Near Protocol wallet address key.
        case NEARAddress = "0x1052"
        /// NEO wallet address key.
        case NEOAddress = "0x1027"
        /// Nexo wallet address key.
        case NEXOAddress = "0x104E"
        /// OKB wallet address key.
        case OKBAddress = "0x104A"
        /// OMG Network wallet address key.
        case OMGAddress = "0x1063"
        /// Harmony wallet address key.
        case ONEAddress = "0x106C"
        /// Ontology wallet address key.
        case ONTAddress = "0x1056"
        /// PAX wallet address key.
        case PAXAddress = "0x1066"
        /// Qtum wallet address key.
        case QTUMAddress = "0x1050"
        /// Revain wallet address key.
        case REVAddress = "0x1045"
        /// THORChain wallet address key.
        case RUNEAddress = "0x1037"
        /// Ravencoin wallet address key.
        case RVNAddress = "0x1067"
        /// Siacoin wallet address key.
        case SCAddress = "0x1060"
        /// Shiba Inu wallet address key.
        case SHIBAddress = "0x1028"
        /// Synthetix Network Token wallet address key.
        case SNXAddress = "0x1047"
        /// Solana wallet address key.
        case SOLAddress = "0x101D"
        /// Stacks wallet address key.
        case STXAddress = "0x1054"
        /// Sushi wallet address key.
        case SUSHIAddress = "0x1051"
        /// Telcoin wallet address key.
        case TELAddress = "0x104C"
        /// Theta Fuel wallet address key.
        case TFUELAddress = "0x105A"
        /// THETA wallet address key.
        case THETAAddress = "0x1021"
        /// TRON wallet address key.
        case TRXAddress = "0x1023"
        /// TrueUSD wallet address key.
        case TUSDAddress = "0x1068"
        /// UMA wallet address key.
        case UMAAddress = "0x105F"
        /// Uniswap wallet address key.
        case UNIAddress = "0x1018"
        /// USD Coin wallet address key.
        case USDCAddress = "0x101B"
        /// Tether wallet address key.
        case USDTAddress = "0x1011"
        /// TerraUSD wallet address key.
        case USTAddress = "0x1049"
        /// VeChain wallet address key.
        case VETAddress = "0x101E"
        /// Waves wallet address key.
        case WAVESAddress = "0x103F"
        /// Wrapped Bitcoin wallet address key.
        case WBTCAddress = "0x1022"
        /// NEM wallet address key.
        case XEMAddress = "0x1042"
        /// Stellar wallet address key.
        case XLMAddress = "0x101C"
        /// Monero Standard wallet address key.
        case XMRStandardAddress = "0x1001"
        /// Monero Sub wallet address key.
        case XMRSubAddress = "0x1002"
        /// XRP wallet address key.
        case XRPAddress = "0x1014"
        /// Tari wallet address key.
        case XTRAddress = "0x0101"
        /// Tezos wallet address key.
        case XTZAddress = "0x1030"
        /// Venus wallet address key.
        case XVSAddress = "0x106A"
        /// yearn.finance wallet address key.
        case YFIAddress = "0x1044"
        /// Zcash wallet address key.
        case ZECAddress = "0x103D"
        /// Horizen wallet address key.
        case ZENAddress = "0x105E"
        /// Zilliqa wallet address key.
        case ZILAddress = "0x104B"
        /// 0x wallet address key.
        case ZRXAddress = "0x1062"
    }
    
    /// Record key used to define the type of stored data.
    public let tag: Tag
    /// Data stored under the key.
    public let value: String
    
    /// A representation on reacord key-value pair which can be associated with user's Yat.
    /// - Parameters:
    ///   - tag: Record key used to define the type of stored data.
    ///   - value: Data stored under the key.
    public init(tag: Tag, value: String) {
        self.tag = tag
        self.value = value
    }
}
