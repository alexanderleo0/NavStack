//
//  AnyTransition.swift
//  
//
//  Created by Exey Panteleev on 09.03.2023.
//

import SwiftUI

public extension AnyTransition {
    
    static var movePush: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing).combined(with: .opacity)
        let removal = AnyTransition.move(edge: .leading).combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
    
    static var movePop: AnyTransition {
        let insertion = AnyTransition.move(edge: .leading).combined(with: .opacity)
        let removal = AnyTransition.move(edge: .trailing).combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
    
    static var inTrailingOutScale: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing).combined(with: .opacity)
        let removal = AnyTransition.move(edge: .bottom).combined(with: .opacity).combined(with: .scale(scale: 0.001, anchor: .bottom))
        return .asymmetric(insertion: insertion, removal: removal)
    }
    
}
