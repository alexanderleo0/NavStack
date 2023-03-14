
import SwiftUI

final public class CustomNavStackViewModel: ObservableObject {
    
    var navigationType: NavType = .push
    
    @Published fileprivate var current : Screen?
    
    private var screenStack = ScreenStack() {
        didSet {
            current = screenStack.top()
        }
    }
    
    
    // MARK: - API
    
    func push <S: View> (_ screen: S) {
        navigationType = .push
        let screen = Screen(id: UUID().uuidString, nextScreen: AnyView(screen))
        screenStack.push(screen)
    }
    
    func pop(to: PopDestination = .previous) {
        navigationType = .pop
        switch to {
            case .previous:
                screenStack.popToPreview()
            case .root:
                screenStack.popToRoot()
        }
    }
}

public struct NavStack <Content>: View where Content: View {
     
    @StateObject private var viewModel: CustomNavStackViewModel = .init()
    private let content: Content
    
    init(@ViewBuilder content: @escaping () -> Content ) {
        
        self.content = content()
    }
      
    
    public var body: some View {
        let isRoot = viewModel.current == nil
        return ZStack {
            if isRoot {
                content
                    .environmentObject(viewModel)
            } else {
                viewModel.current!.nextScreen
                    .environmentObject(viewModel)
            }
        }
    }
    
}

// MARK: - ENUMS

enum NavTransition {
    case none
    case custom(AnyTransition)
}

enum NavType {
    case push
    case pop
    case byId
}

enum PopDestination {
    case previous
    case root
}


// MARK: - BASE LOGIC

private struct Screen: Identifiable, Equatable {
    
    let id: String
    let nextScreen: AnyView
    
    static func == (lhs: Screen, rhs: Screen) -> Bool {
        lhs.id == rhs.id
    }
    
}

private struct ScreenStack{
    
    private var screens: [Screen] = .init()
     
    func top() -> Screen? {
        screens.last
    }
    
    mutating func pushToId(id: String) {
        debugPrint("push to id \(id)")
    }
    
    mutating func push(_ s: Screen) {
        screens.append(s)
    }
    
    mutating func popToPreview() {
        _ = screens.popLast()
    }
    
    mutating func popToRoot() {
        screens.removeAll()
    }
}
