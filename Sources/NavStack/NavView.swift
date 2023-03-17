    //
    //  NavView.swift
    //
    //
    //  Created by Александр Никитин on 14.03.2023.
    //

import SwiftUI


struct NavView <Content: View> : View {
    
    @EnvironmentObject var navVM: CustomNavStackViewModel
    
    private var content: Content
    var tabbarColor: Color
    
    init(content: Content, tabbarColor: Color) {
        self.content = content
        self.tabbarColor = tabbarColor
    }
    
    var body: some View {
        ZStack {
            VStack{
                ZStack(alignment: .bottom){
                    tabbarColor
                        .opacity(0.3)
                    HStack {
                        NavPopButton(destination: .previous) {
                            HStack{
                                Image(systemName: "chevron.left")
                                Text("Back")
                            }
                        }
                        .padding()
                        Spacer()
                        NavPopButton(destination: .root) {
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
