
import SwiftUI


final public class NavStackViewModel: ObservableObject {
    @Published fileprivate var current : Screen?
    
    private var screenStack = ScreenStack() {
        didSet {
            current = screenStack.top()
        }
    }
    
    func push <S: View> (_ screen: S) {
        withAnimation(.easeInOut) {
            let screen = Screen(id: UUID().uuidString, nextScreen: AnyView(screen))
            screenStack.push(screen)
        }
    }
    
    func pop(to: PopDestination = .previous) {
        withAnimation(.easeInOut) {
            switch to {
                case .previous:
                    screenStack.popToPreview()
                case .root:
                    screenStack.popToRoot()
            }
        }
    }
}

public struct NavStack <Content>: View where Content: View {
    
    @StateObject private var viewModel: NavStackViewModel = .init()
    
    private let content: Content
    
    public init(@ViewBuilder content: @escaping () -> Content ) {
        self.content = content()
    }
    
    public var body: some View {
        let isRoot = viewModel.current == nil
        ZStack {
            if isRoot {
                content
                    .transition(.inTrailingOutScale)
                    .environmentObject(viewModel)
            } else {
                viewModel.current?.nextScreen
                    .transition(.inTrailingOutScale)
                    .environmentObject(viewModel)
            }
        }
    }
    
}

public struct NavLink <Content, Destination>: View where Content: View, Destination: View {
    @EnvironmentObject private var viewModel : NavStackViewModel
    
    private let destination: Destination
    private let content: Content
    
    public init(destination: Destination, @ViewBuilder content: @escaping () -> Content) {
        self.destination = destination
        self.content = content()
        
    }
    
    public var body: some View {
        content
            .onTapGesture {
                push()
            }
    }
    
    private func push() {
        viewModel.push( NavView(content: destination, tabbarColor: .blue) )
    }
    
}

public struct NavPopLink <Content>: View where Content: View {
    @EnvironmentObject private var viewModel : NavStackViewModel
    
    private let destination: PopDestination
    private let content: Content
    
    public init(destination: PopDestination, @ViewBuilder content: @escaping () -> Content) {
        self.destination = destination
        self.content = content()
    }
    
    public var body: some View {
        content.onTapGesture {
            pop()
        }
    }
    
    private func pop() {
        viewModel.pop(to: destination)
    }
    
}

    // MARK: - ENUMS

public enum PopDestination {
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
    
    func getScreensCount() -> Int {
        screens.count
    }
    
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

extension AnyTransition {
    
}
