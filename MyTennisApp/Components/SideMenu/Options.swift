//	 //
//	 //  Options.swift
//	 //  MyTennisApp
//	 //
//	 //  Created by Khanh Nguyen on 10/21/24.
//	 //
//
//import Foundation
//
//
//enum OptionModels: Int, CaseIterable {
//	 case dashboard
//	 case performance
//	 case profile
//	 case MyLessons
//	 case MysticMac
//
//	 var title: String {
//			switch self {
//				 case .dashboard:
//						return "Dashboard"
//				 case .performance:
//						return "Performance"
//				 case .profile:
//						return "Profile"
//				 case .MyLessons:
//						return "My Lessons"
//				 case .MysticMac:
//						return "Mystic Mac"
//			}
//	 }
//	 
//	 var systemImageName: String {
//			switch self {
//				 case .dashboard:
//						return "filemenu.and.cursorarrow"
//				 case .performance:
//						return "chart.bar"
//				 case .profile:
//						return "person"
//				 case .MyLessons:
//						return "magnifyingglass"
//				 case .MysticMac:
//						return "person.fill"
//			}
//	 }
//}
//
//extension OptionModels: Identifiable {
//	 var id: Int  {return self.rawValue}
//}
