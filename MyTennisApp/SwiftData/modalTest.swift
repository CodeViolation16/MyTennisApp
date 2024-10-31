	 //
	 //  modalTest.swift
	 //  MyTennisApp
	 //
	 //  Created by Khanh Nguyen on 10/30/24.
	 //

import SwiftUI

struct modalTest: View {
	 @State private var dateValue: Date = Date()
	 @State private var startTimeValue: Date = Date()
	 @State private var endTimeValue: Date = Date()
	 @State private var nameText: String = ""
	 @State private var locationText: String = ""
	 @State private var lessonText: String = ""

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

						VStack(alignment: .leading){
//							 inputField(title: "Lesson Name", text: $lessonsName)
//							 inputField(title: "Location", text: $location)
//							 LessonNotesField(title: "Lesson Notes", text: $lessonNotes)
							 Text("Lesson Name")
									.font(.headline)
							 TextField("Enter lesson Name", text: $nameText)
									.textFieldStyle(RoundedBorderTextFieldStyle())
									.padding(.bottom, 10)
							 Text("Location")
									.font(.headline)
							 TextField("Enter lesson", text: $locationText)
									.textFieldStyle(RoundedBorderTextFieldStyle())
									.padding(.bottom, 10)
							 Text("Lesson Note")
									.font(.headline)
							 TextEditor(text: $lessonText)
									.padding(.horizontal, 5)
									.frame(height: 100)
									.overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray.opacity(2.5)))
						}
						.padding(.horizontal)

						Button(action: {
							print("hello")
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
	 modalTest()
}
