	 //
	 //  MyTennisApp.swift
	 //  MyTennisApp
	 //
	 //  Created by Khanh Nguyen on 10/21/24.
	 //

import SwiftUI
import Foundation

enum OptionModels: Int, CaseIterable, Identifiable {
	 case dashboard
	 case performance
	 case profile
	 case MyLessons
	 case MysticMac

	 var id: Int  { return self.rawValue }

	 var title: String {
			switch self {
				 case .dashboard: return "Dashboard"
				 case .performance: return "Performance"
				 case .profile: return "Profile"
				 case .MyLessons: return "My Lessons"
				 case .MysticMac: return "Mystic Mac"
			}
	 }

	 var systemImageName: String {
			switch self {
				 case .dashboard: return "filemenu.and.cursorarrow"
				 case .performance: return "chart.bar"
				 case .profile: return "person"
				 case .MyLessons: return "magnifyingglass"
				 case .MysticMac: return "person.fill"
			}
	 }
}

struct SideMenuItems: View {
	 var body: some View {
			HStack {
				 Image(systemName: "person.circle.fill")
						.imageScale(.large)
						.foregroundColor(.white)
						.frame(width: 48, height: 48)
						.background(.blue)
						.clipShape(RoundedRectangle(cornerRadius: 10))
						.padding(.vertical)

				 VStack(alignment: .leading, spacing: 6) {
						Text("Khanh Nguyen")
							 .font(.subheadline)
						Text("ngiakhanh18@gmail.com")
							 .font(.footnote)
							 .tint(.gray)
				 }
			}
	 }
}

struct SideMenuRow: View {
	 var option: OptionModels
	 @Binding var selectedOption: OptionModels?
	 private var isSelected: Bool {
			return selectedOption == option
	 }

	 var body: some View {
			HStack {
				 Image(systemName: option.systemImageName)
						.imageScale(.small)
				 Text(option.title)
						.font(.subheadline)
				 Spacer()
			}
			.padding(.leading)
			.foregroundColor(isSelected ? .blue : .primary)
			.frame(width: 216, height: 44)
			.background(isSelected ? .blue.opacity(0.15) : .clear)
			.clipShape(RoundedRectangle(cornerRadius: 10))
	 }
}

struct SideMenuView: View {
	 @Binding var isShowing: Bool
	 @Binding var selectedTab: Int
	 @State private var selectedOption: OptionModels?

	 var body: some View {
			ZStack{
				 if isShowing {
						Rectangle()
							 .ignoresSafeArea()
							 .opacity(0.3)
							 .onTapGesture { isShowing.toggle() }

						HStack{
							 VStack(alignment: .leading, spacing: 32){
									SideMenuItems()
									VStack {
										 ForEach(OptionModels.allCases){ option in
												Button(action: {
													 onOptionTapped(option)
												}) {
													 SideMenuRow(option: option, selectedOption: $selectedOption)
												}

										 }
									}
									Spacer()
							 }
							 .padding()
							 .frame(width: 270, alignment: .leading)
							 .background(.white)
							 Spacer()
						}
						.transition(.move(edge: .leading))
				 }
			}

			.animation(.easeInOut, value: isShowing)
	 }

				 private func onOptionTapped(_ option: OptionModels){
						selectedOption = option
						selectedTab = option.rawValue
						isShowing = false
				 }

	 private func destinationView(for option: OptionModels) -> some View {

			switch option {
				 case .MyLessons:
						return AnyView(Lessons())
				 case .MysticMac:
						return AnyView(Mystic())
				 case .dashboard:
						return AnyView(Dashboard())
				 case .performance:
						return AnyView(Performance())
				 case .profile:
						return AnyView(Profile())
			}
	 }
}




#Preview {
	 SideMenuView(isShowing: .constant(true), selectedTab: .constant(0))
}
