//
//  BoardColor.swift
//  Routine
//
//  Created by t2023-m0072 on 12/2/24.
//

import UIKit

///보드 컬러 열거형
///
///uiColor() 메서드를 통해 UIColor를 반환

enum BoardColor: Int, Codable, CaseIterable {

    case white
    case pastelYellow
    case pastelPink
    case pastelPeach
    case ivory
    case creamyBeige
    case softIvory
    case mintGreen
    case pastelGreen
    case lightAqua
    case softAqua
    case lilac

    func uiColor() -> UIColor {
        switch self {
        case .white:
            return UIColor(red: cgFloat(255),
                           green: cgFloat(255),
                           blue: cgFloat(255),
                           alpha: 1)

        case .pastelYellow:
            return UIColor(red: cgFloat(244),
                           green: cgFloat(244),
                           blue: cgFloat(245),
                           alpha: 1)

        case .pastelPink:
            return UIColor(red: cgFloat(254),
                           green: cgFloat(243),
                           blue: cgFloat(245),
                           alpha: 1)

        case .pastelPeach:
            return UIColor(red: cgFloat(253),
                           green: cgFloat(247),
                           blue: cgFloat(243),
                           alpha: 1)

        case .ivory:
            return UIColor(red: cgFloat(251),
                           green: cgFloat(251),
                           blue: cgFloat(241),
                           alpha: 1)

        case .creamyBeige:
            return UIColor(red: cgFloat(251),
                           green: cgFloat(247),
                           blue: cgFloat(236),
                           alpha: 1)

        case .softIvory:
            return UIColor(red: cgFloat(251),
                           green: cgFloat(252),
                           blue: cgFloat(241),
                           alpha: 1)

        case .mintGreen:
            return UIColor(red: cgFloat(244),
                           green: cgFloat(250),
                           blue: cgFloat(236),
                           alpha: 1)

        case .pastelGreen:
            return UIColor(red: cgFloat(241),
                           green: cgFloat(251),
                           blue: cgFloat(247),
                           alpha: 1)

        case .lightAqua:
            return UIColor(red: cgFloat(241),
                           green: cgFloat(252),
                           blue: cgFloat(251),
                           alpha: 1)

        case .softAqua:
            return UIColor(red: cgFloat(240),
                           green: cgFloat(252),
                           blue: cgFloat(251),
                           alpha: 1)

        case .lilac:
            return UIColor(red: cgFloat(244),
                           green: cgFloat(243),
                           blue: cgFloat(255),
                           alpha: 1)
        }
    }
    
    private func cgFloat(_ value: Int) -> CGFloat {
        guard value < 256 else { return 1 }
        return CGFloat(value) / 255
    }
    
}
