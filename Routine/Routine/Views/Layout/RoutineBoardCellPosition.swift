//
//  RoutineBoardCellShape.swift
//  Routine
//
//  Created by t2023-m0072 on 11/13/24.
//

import UIKit

// MARK: - RoutineBoardCollectionViewCell.Position

extension RoutineCollectionViewCell {

    //셀 보드의 위치
    struct Position {

        private let role: Role

        private let line: Line

        init(index: Int, countOfData: Int) {
            self.role = Role(index: index, countOfData: countOfData)
            self.line = Line(index)
        }

        //마스크 코너 반환
        func maskedCorner() -> CACornerMask {
            switch role {
            case .first:
                return [.layerMinXMinYCorner, .layerMinXMaxYCorner]

            case .normal:
                switch line {
                case .even(.first):
                    return [.layerMaxXMaxYCorner]

                case .even(.third):
                    return [.layerMinXMinYCorner]

                case .odd(.first):
                    return [.layerMinXMaxYCorner]

                case .odd(.third):
                    return [.layerMaxXMinYCorner]

                default:
                    return []
                }

            case .last:
                switch line {
                case .even(.first), .odd(.first):
                    return []

                case .odd(.second), .odd(.third):
                    return [.layerMaxXMinYCorner]

                default:
                    return [.layerMinXMinYCorner]
                }
            }
        }

        //첫번째, 마지막, 그외
        enum Role {
            case first
            case normal
            case last

            init(index: Int, countOfData: Int) {
                if index == 0 && countOfData > 1 {
                    self = .first
                } else if index == countOfData - 1 {
                    self = .last
                } else {
                    self = .normal
                }
            }
        }

        //홀수 짝수 줄
        enum Line {
            case odd(Row)
            case even(Row)

            init(_ index: Int) {
                let row = Row(index)
                let line = index / 3 % 2
                self = (line == 0) ? .odd(row) : .even(row)
            }
        }

        //라인의 첫번째, 두번째, 세번째
        enum Row {
            case first
            case second
            case third

            init(_ index: Int) {
                let index = index % 3
                switch index {
                case 0: self = .first
                case 1: self = .second
                default: self = .third
                }
            }
        }
    }

}
