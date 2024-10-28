////
////  SideMenuView.swift
////  MyTennisApp
////
////  Created by Khanh Nguyen on 10/19/24.
////
//
//import SwiftUI
//
//struct SideMenuView: View {
//	 @Binding var isShowing: Bool
//	 @Binding var selectedTab: Int
//	 @State private var selectedOption: OptionModels?
//	 
//    var body: some View {
//			 ZStack{
//					if isShowing {
//						 Rectangle()
//								.ignoresSafeArea()
//								.opacity(0.3)
//								.onTapGesture { isShowing.toggle() }
//
//						 HStack{
//								VStack(alignment: .leading, spacing: 32){
//									 SideMenuItems()
//									 VStack {
//											ForEach(OptionModels.allCases){ option in
//												 Button(action: {
//													onOptionTapped(option)
//												 }, label: {
//														SideMenuRow(option: option, selectedOption: $selectedOption)
//												 })
//											}
//									 }
//									 Spacer()
//								}
//								.padding()
//								.frame(width: 270, alignment: .leading)
//								.background(.white)
//								Spacer()
//						 }
//					}
//			 }
//			 .transition(.move(edge: .leading))
//			 .animation(.easeInOut, value: isShowing)
//    }
//	 private func onOptionTapped(_ option: OptionModels){
//			selectedOption = option
//			selectedTab = option.rawValue
//			isShowing = false
//	 }
//}
//
//#Preview {
//	 SideMenuView(isShowing: .constant(true), selectedTab: .constant(0))
//}
