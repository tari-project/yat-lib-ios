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

public struct YatRecordInput {
    
    public enum Tag: String {
        case AAVEAddress = "0x1026"
        case ADAAddress = "0x1012"
        case ALGOAddress = "0x1038"
        case ANKRAddress = "0x106E"
        case ARAddress = "0x106F"
        case ATOMAddress = "0x1032"
        case AVAXAddress = "0x1035"
        case BAKEAddress = "0x1070"
        case BATAddress = "0x1055"
        case BCHAddress = "0x1017"
        case BNBAddress = "0x1010"
        case BNTAddress = "0x1061"
        case BSVAddress = "0x102C"
        case BTCBAddress = "0x1041"
        case BTCAddress = "0x1003"
        case BTGAddress = "0x1059"
        case BTTAddress = "0x103B"
        case BUSDAddress = "0x1025"
        case CAKEAddress = "0x102E"
        case CELOAddress = "0x106D"
        case CELAddress = "0x1057"
        case CHSBAddress = "0x1069"
        case CHZAddress = "0x1046"
        case COMPAddress = "0x103A"
        case CROAddress = "0x1039"
        case CRVAddress = "0x106B"
        case DAIAddress = "0x1033"
        case DASHAddress = "0x103C"
        case DCRAddress = "0x1043"
        case DGBAddress = "0x105C"
        case DOGEAddress = "0x1013"
        case DOTAddress = "0x1015"
        case EGLDAddress = "0x1040"
        case ENJAddress = "0x1058"
        case EOSAddress = "0x1020"
        case ETCAddress = "0x101F"
        case ETHAddress = "0x1004"
        case FILAddress = "0x1024"
        case FTMAddress = "0x105D"
        case FTTAddress = "0x102D"
        case GRTAddress = "0x105B"
        case HBARAddress = "0x1048"
        case HNTAddress = "0x1064"
        case HOTAddress = "0x1053"
        case HTAddress = "0x102A"
        case ICPAddress = "0x1016"
        case ICXAddress = "0x1065"
        case KLAYAddress = "0x1031"
        case KSMAddress = "0x1036"
        case LEOAddress = "0x103E"
        case LINKAddress = "0x101A"
        case LTCAddress = "0x1019"
        case LUNAAddress = "0x102B"
        case MANAAddress = "0x104F"
        case MATICAddress = "0x1029"
        case MIOTAAddress = "0x102F"
        case MKRAddress = "0x1034"
        case NANOAddress = "0x104D"
        case NEARAddress = "0x1052"
        case NEOAddress = "0x1027"
        case NEXOAddress = "0x104E"
        case OKBAddress = "0x104A"
        case OMGAddress = "0x1063"
        case ONEAddress = "0x106C"
        case ONTAddress = "0x1056"
        case PAXAddress = "0x1066"
        case QTUMAddress = "0x1050"
        case REVAddress = "0x1045"
        case RUNEAddress = "0x1037"
        case RVNAddress = "0x1067"
        case SCAddress = "0x1060"
        case SHIBAddress = "0x1028"
        case SNXAddress = "0x1047"
        case SOLAddress = "0x101D"
        case STXAddress = "0x1054"
        case SUSHIAddress = "0x1051"
        case TELAddress = "0x104C"
        case TFUELAddress = "0x105A"
        case THETAAddress = "0x1021"
        case TRXAddress = "0x1023"
        case TUSDAddress = "0x1068"
        case UMAAddress = "0x105F"
        case UNIAddress = "0x1018"
        case USDCAddress = "0x101B"
        case USDTAddress = "0x1011"
        case USTAddress = "0x1049"
        case VETAddress = "0x101E"
        case WAVESAddress = "0x103F"
        case WBTCAddress = "0x1022"
        case XEMAddress = "0x1042"
        case XLMAddress = "0x101C"
        case XMRStandardAddress = "0x1001"
        case XMRSubAddress = "0x1002"
        case XRPAddress = "0x1014"
        case XTRAddress = "0x0101"
        case XTZAddress = "0x1030"
        case XVSAddress = "0x106A"
        case YFIAddress = "0x1044"
        case ZECAddress = "0x103D"
        case ZENAddress = "0x105E"
        case ZILAddress = "0x104B"
        case ZRXAddress = "0x1062"
    }
    
    public let tag: Tag
    public let value: String
    
    public init(tag: Tag, value: String) {
        self.tag = tag
        self.value = value
    }
}
