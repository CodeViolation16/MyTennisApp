	 //
	 //  official.swift
	 //  MyTennisApp
	 //
	 //  Created by Khanh Nguyen on 10/30/24.
	 //

import SwiftUI

struct Official: View {


	 private func deleteBooking(dateIndex: Int, bookingIndex: Int) {
			dateTimeArr[dateIndex].1.remove(at: bookingIndex)
			if dateTimeArr[dateIndex].1.isEmpty {
				 dateTimeArr.remove(at: dateIndex)
			}
	 }
	 @State var dateTimeArr: [(String, [(String, String, String)])] = []
	 @State private var dateInput: String = ""
	 @State private var timeInput: String = ""
	 @State private var nameInput: String = ""
	 @State private var courtInput: String = ""
	 @State var modalToggle: Bool = false

	 @State var dateTime_Arr: [(String, [(String, String, String, String)])] = [
			("October 30, 2024", [
				 ("10:00 AM - 10:00 AM ", "John Doe", "Court 1", "Do more Forehand"),
				 ("2:00 PM - 10:00 AM", "Jane Smith", "Court 2", "Do more Backhand"),
				 ("5:00 PM - 10:00 AM", "Alice Johnson", "Court 3", "Do more Serve")
			]),
			("November 1, 2024", [
				 ("11:30 AM - 10:00 AM", "Bob Brown", "Court 1", "Do more Forehand"),
				 ("3:15 PM - 10:00 AM", "Charlie White", "Court 2", "Do more Forehand")
			])
	 ]


	 var body: some View {
			NavigationStack {
				 ScrollView {
						Divider()
//						Text(date, style: .date)
//							 .font(.title2)
//							 .fontWeight(.semibold)
//							 .padding([.top, .leading, .trailing])

					
						VStack(alignment: .leading, spacing: 10) {
							 ForEach(dateTime_Arr, id: \.0) { dateEntry in
									Section(header: Text(dateEntry.0).font(.headline)) {
										 ForEach(dateEntry.1, id: \.0) { lesson in
												ScrollView(.horizontal, showsIndicators: false) {
													 HStack {
															Lesson_List(name: lesson.1, time: lesson.0, location: lesson.2, lessonNotes: lesson.3)
													 }
												}
										 }
									}
							 }
						}

				 }
				 .frame(maxWidth: .infinity, maxHeight: .infinity)
				 .navigationTitle("My Lessons")
				 .toolbar {
						ToolbarItem(placement: .navigationBarTrailing) {
							 Button(action: {
									withAnimation {
										 modalToggle.toggle()
									}
									print("Plus button tapped")
							 }) {
									Image(systemName: "plus.app.fill")
										 .font(.system(size: 24))
							 }
							 .sheet(isPresented: $modalToggle) {
									Modal_Input(modalToggle: $modalToggle)
										 .transition(.opacity)
										 .presentationDetents([.fraction(0.85)])
										 .presentationDragIndicator(.visible)
							 }

						}
				 }
			}
	 }
}

//struct Lesson_Model: Identifiable {
//	 let id = UUID()
//	 var name: String
//	 var location: String
//	 var notes: String
//	 var startDate: String
//	 var endDate: String
//	 var date: Date
//}

struct Lesson_List: View {
//	 var date: String
	 var name: String
	 var time: String
	 var location: String
	 var lessonNotes: String
	 var body: some View {
			VStack(alignment: .leading, spacing: 15) {
//				 Text(date)
//						.font(.title2)
//						.fontWeight(.semibold)
//						.padding([.top, .leading, .trailing])
				 HStack {
						Text(name)
							 .font(.title3)
							 .fontWeight(.bold)
							 .lineLimit(1)
							 .layoutPriority(1)

						Spacer()

						Text(time)
							 .font(.callout)
							 .foregroundColor(.white)
							 .padding(.vertical, 5)
							 .padding(.horizontal, 10)
							 .background(
									LinearGradient(
										 gradient: Gradient(colors: [Color.blue, Color.teal]),
										 startPoint: .leading,
										 endPoint: .trailing
									)
							 )
							 .cornerRadius(8)
							 .lineLimit(1)
				 }
				 .frame(maxWidth: .infinity)

				 Divider()

				 HStack {
						Image(systemName: "mappin.and.ellipse")
							 .foregroundColor(.gray)
						Text(location)
							 .font(.subheadline)
							 .foregroundColor(.blue)
							 .fontWeight(.medium)
				 }

				 HStack {
						Image(systemName: "note.text")
							 .foregroundColor(.gray)
						Text("Lesson Plan: \(lessonNotes)")
							 .font(.subheadline)
							 .foregroundColor(.secondary)
				 }
			}
			.padding()
			.frame(maxWidth: 600)
			.background(
				 RoundedRectangle(cornerRadius: 15)
						.fill(Color(.systemGray5))
			)
			.overlay(
				 RoundedRectangle(cornerRadius: 15)
						.stroke(Color.gray.opacity(0.4), lineWidth: 1)
			)
			.shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
			.padding()
	 }
}


struct Modal_Input: View {
	 @State private var dateValue: Date = Date()
	 @State private var startTimeValue: Date = Date()
	 @State private var endTimeValue: Date = Date()
	 @State private var nameText: String = ""
	 @State private var locationText: String = ""
	 @State private var lessonText: String = ""
	 @Binding var modalToggle: Bool

	 var body: some View {
			NavigationStack {
				 VStack(spacing: 10) {
						HStack {
							 DatePicker("", selection: $dateValue, in: Date()..., displayedComponents: .date)
									.labelsHidden()
							 DatePicker("", selection: $startTimeValue, displayedComponents: .hourAndMinute)
									.labelsHidden()
							 DatePicker("", selection: $endTimeValue, displayedComponents: .hourAndMinute)
									.labelsHidden()
						}
						.padding()

						VStack(alignment: .leading) {
							 Text("Lesson Name")
									.font(.headline)
							 TextField("Enter lesson name", text: $nameText)
									.textFieldStyle(RoundedBorderTextFieldStyle())
									.padding(.bottom, 10)
							 Text("Location")
									.font(.headline)
							 TextField("Enter location", text: $locationText)
									.textFieldStyle(RoundedBorderTextFieldStyle())
									.padding(.bottom, 10)
							 Text("Lesson Note")
									.font(.headline)
							 TextEditor(text: $lessonText)
									.padding(.horizontal, 5)
									.frame(height: 100)
									.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5)))
						}
						.padding(.horizontal)

						Button(action: {
							 withAnimation {
									modalToggle.toggle()
							 }
						}) {
							 Text("Create Lesson")
									.padding()
									.frame(width: 350, height: 50)
									.background(Color.black)
									.foregroundColor(.white)
									.cornerRadius(12)
									.offset(y: 15)
						}
				 }
				 .frame(maxHeight: .infinity, alignment: .top)
				 .toolbar {
						ToolbarItem(placement: .navigationBarLeading) {
							 Button(action: {
									withAnimation(.easeInOut(duration: 2.5)){
										 modalToggle.toggle()
									}
							 }) {
									Image(systemName: "arrow.left")
										 .font(.system(size: 16))
										 .foregroundColor(.black)
									Text("Add new lessons")
										 .font(.headline)
										 .foregroundColor(.primary)
							 }
							 .padding(.top, 30)
							 .padding(.leading, 10)
						}
				 }
			}
	 }
}

#Preview {
			Official()
}
