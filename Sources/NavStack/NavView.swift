    //
    //  NavView.swift
    //
    //
    //  Created by Александр Никитин on 14.03.2023.
    //

import SwiftUI


public struct NavView <Content: View> : View {
    
    @EnvironmentObject var navVM: NavStackViewModel
    
    private var content: Content
    var tabbarColor: Color = .white
    
    public init(content: Content, tabbarColor: Color) {
        self.content = content
        self.tabbarColor = tabbarColor
    }
    
    public var body: some View {
        ZStack {
            VStack{
                ZStack(alignment: .bottom){
                    tabbarColor
                        .opacity(0.3)
                    HStack {
                        NavPopLink(destination: .previous) {
                            HStack{
                                Image(systemName: "chevron.left")
                                Text("Back")
                            }
                        }
                        .padding()
                        Spacer()
                        NavPopLink(destination: .root) {
                            HStack {
                                Image(systemName: "chevron.up")
                                Text("Root")
                            }
                        }
                        .padding()

                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 90)
                Spacer()
            }
            VStack{
                content
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }.ignoresSafeArea()
    }
}


struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        NavView(content: EmptyView(), tabbarColor: Color.blue)
    }
}

//extension AnyTransition {
//    static var iris: AnyTransition {
////        .modifier(active: <#T##ViewModifier#>, identity: <#T##ViewModifier#>)
////        .modifier(
////            active: ClipShapeModifier(shape: ScaledCircle(animatableData: 0)),
////            identity: ClipShapeModifier(shape: ScaledCircle(animatableData: 1))
////        )
//    }
//}

//struct ScaledCircle: Shape
