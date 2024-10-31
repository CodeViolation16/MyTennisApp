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
	 @State var dateTimeArray: [(String, [(String, String, String, String)])] = [
			("October 30, 2024", [
				 ("10:00 AM - 10:00 AM ", "Margot Feazel", "Court 1", "Do more Forehand"),
				 ("2:00 PM - 10:00 AM", "Jane Smith", "Court 2", "Do more Backhand"),
				 ("5:00 PM - 10:00 AM", "Alice Johnson", "Court 3", "Do more Serve")
			]),
			("November 1, 2024", [
				 ("11:30 AM - 10:00 AM", "Khanh Nguyen", "Court 1", "Do more Forehand"),
				 ("3:15 PM - 10:00 AM", "Charlie White", "Court 2", "Do more Forehand")
			])
	 ]


	 var body: some View {
			NavigationStack {

				 ScrollView {
						Divider()
						VStack(alignment: .leading, spacing: 4) {
							 ForEach(dateTimeArray, id: \.0) { dateEntry in
									Section(header: Text(dateEntry.0)
										 .font(.system(size: 22, weight: .bold))
										 .padding(.leading, 20)
										 .padding(.top, 5) ) {
										 ScrollView(.horizontal, showsIndicators: false) {
												HStack(spacing: 10) {
													 ForEach(dateEntry.1, id: \.0) { lesson in
															Lesson_List(
																 name: lesson.1,
																 time: lesson.0,
																 location: lesson.2,
																 lessonNotes: lesson.3
															)
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
									Modal_Input(modalToggle: $modalToggle) { date, time, name, location, lessonNote in

										 if let dateIndex = dateTimeArray.firstIndex(where: { $0.0 == date }) {
												dateTimeArray[dateIndex].1.append((time, name, location, lessonNote))

													 // Sort times within the same date
												dateTimeArray[dateIndex].1.sort {
													 let timeFormatter = DateFormatter()
													 timeFormatter.dateFormat = "h:mm a"
													 let time1 = timeFormatter.date(from: $0.0) ?? Date.distantPast
													 let time2 = timeFormatter.date(from: $1.0) ?? Date.distantPast
													 return time1 < time2
												}
										 } else {
												dateTimeArray.append((date, [(time, name, location, lessonNote)]))
										 }

												// Sort dates in dateTimeArray
										 dateTimeArray.sort {
												let dateFormatter = DateFormatter()
												dateFormatter.dateStyle = .medium
												let date1 = dateFormatter.date(from: $0.0) ?? Date.distantPast
												let date2 = dateFormatter.date(from: $1.0) ?? Date.distantPast
												return date1 < date2
										 }
									}
									.presentationDetents([.fraction(0.89)])
									.presentationDragIndicator(.visible)
									.transition(.opacity)

							 }
							 

						}
				 }
			}
	 }


}



struct Lesson_List: View {
	 var name: String
	 var time: String
	 var location: String
	 var lessonNotes: String
	 var body: some View {
			VStack(alignment: .leading, spacing: 15) {
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
			.frame(width: 360)
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
			Spacer()
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
	 var onAddLesson: (String, String, String, String, String) -> Void


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
									let dateFormatter = DateFormatter()
									dateFormatter.dateStyle = .medium
									let dateString = dateFormatter.string(from: dateValue)

									let timeFormatter = DateFormatter()
									timeFormatter.dateFormat = "h:mm a"
									let startTime = timeFormatter.string(from: startTimeValue)
									let endTime = timeFormatter.string(from: endTimeValue)
									let timeString = "\(startTime) - \(endTime)"

									
					
									onAddLesson(dateString, timeString, nameText, locationText, lessonText)
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
