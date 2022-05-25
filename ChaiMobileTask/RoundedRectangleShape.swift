//
//  RoundedRectangleShape.swift
//  ChaiMobileTask
//
//  Created by Seongwuk Park on 25/05/22.
//

import Foundation
import SwiftUI

struct RoundedRectangleShape: Shape {
    let corners: UIRectCorner
    let radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
