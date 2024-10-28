////
////  SideMenuRow.swift
////  MyTennisApp
////
////  Created by Khanh Nguyen on 10/20/24.
////
//
//import SwiftUI
//
//struct SideMenuRow: View {
//	 var option: OptionModels
//	 @Binding var selectedOption: OptionModels?
//	 private var isSelected: Bool {
//			return selectedOption == option
//	 }
//	 
//    var body: some View {
//			 HStack {
//					Image(systemName: option.systemImageName)
//						 .imageScale(.small)
//					Text(option.title)
//						 .font(.subheadline)
//					Spacer()
//			 }
//			 .padding(.leading)
//			 .foregroundColor(isSelected ? .blue : .primary)
//			 .frame(width: 216, height: 44)
//			 .background(isSelected ? .blue.opacity(0.15) : .clear)
//			 .clipShape(RoundedRectangle(cornerRadius: 10))
//
//    }
//}
//
//#Preview {
//	 SideMenuRow(option: .dashboard, selectedOption: .constant(.dashboard))
//}
