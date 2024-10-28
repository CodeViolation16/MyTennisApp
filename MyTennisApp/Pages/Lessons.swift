import SwiftUI

struct Lessons: View {
	 @State private var modalToggle: Bool = false
	 @State private var lessons: [LessonModel] = []
	 @State private var date_date = Date()
	 @State private var list_date: [Date] = []

	 var body: some View {
			NavigationStack {
				 ScrollView{
						Divider()

						VStack(alignment: .leading, spacing: 10) {
							 ForEach(list_date.sorted(), id: \.self) { date in
									Text(date, style: .date)
										 .font(.title2)
										 .fontWeight(.semibold)
										 .padding([.top, .leading, .trailing])

									ScrollView(.horizontal, showsIndicators: false) {
										 HStack {
												ForEach(lessons.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }) { lesson in
													 LazyHStack(spacing: 0) {
															LessonList(name: lesson.name, time: "\(lesson.startDate) - \(lesson.endDate)", location: lesson.location, lessonNotes: lesson.notes)
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
									modalToggle.toggle()
									print("Plus button tapped")
							 }) {
									Image(systemName: "plus.app.fill")
										 .font(.system(size: 24))
							 }
							 .sheet(isPresented: $modalToggle, content: {
									ModalView(
										 modalToggle: $modalToggle,
										 lessons: $lessons,
										 list_date: $list_date,
										 date_date: $date_date
									)
									.presentationDetents([ .fraction(0.85)])
							 })
						}

						ToolbarItem(placement: .bottomBar) {
							 Button(action: {
									print("Bottom bar button tapped")
							 }) {
									Text("More Options")
							 }
						}
				 }
			}
	 }
}

struct ModalView: View {
	 @State var lessonsName: String = ""
	 @State var timeline: String = ""
	 @State var location: String = ""
	 @State var lessonNotes: String = ""
	 @State private var timeStarted = Date()
	 @State private var timeEnded = Date()
	 @Binding var modalToggle: Bool
	 @Binding var lessons: [LessonModel]
	 @Binding var list_date: [Date]
	 @Binding var date_date: Date

	 let timeFormatter: DateFormatter = {
			let formatter = DateFormatter()
			formatter.dateFormat = "h:mm a"
			return formatter
	 }()

	 var body: some View {
			NavigationView {
				 ZStack {
						VStack(spacing: 10) {
							 HStack {
									DatePicker("", selection: $date_date, in: Date()..., displayedComponents: .date)
										 .labelsHidden()
									DatePicker("", selection: $timeStarted, displayedComponents: .hourAndMinute)
										 .labelsHidden()
									DatePicker("", selection: $timeEnded, displayedComponents: .hourAndMinute)
										 .labelsHidden()
							 }
							 .padding()

							 VStack {
									inputField(title: "Lesson Name", text: $lessonsName)
									inputField(title: "Location", text: $location)
									LessonNotesField(title: "Lesson Notes", text: $lessonNotes)
							 }
							 .padding(.horizontal)

							 Button(action: {
									let newLesson = LessonModel(
										 name: lessonsName,
										 location: location,
										 notes: lessonNotes,
										 startDate: timeFormatter.string(from: timeStarted),
										 endDate: timeFormatter.string(from: timeEnded),
										 date: date_date
									)

									lessons.append(newLesson)

										 // Add date to list_date only if it's not already present
									if !list_date.contains(where: { Calendar.current.isDate($0, inSameDayAs: date_date) }) {
										 list_date.append(date_date)
									}

									modalToggle.toggle()
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
						.padding()
				 }
				 .frame(maxHeight: .infinity, alignment: .top)
				 .toolbar {
						ToolbarItem(placement: .navigationBarLeading) {
							 Button(action: {
									withAnimation {
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

struct LessonModel: Identifiable {
	 let id = UUID()
	 var name: String
	 var location: String
	 var notes: String
	 var startDate: String
	 var endDate: String
	 var date: Date
}

struct LessonList: View {
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

struct inputField: View {
	 var title: String
	 @Binding var text: String

	 var body: some View {
			VStack(alignment: .leading) {
				 Text(title)
						.font(.headline)
				 TextField("Enter \(title.lowercased())", text: $text)
						.textFieldStyle(RoundedBorderTextFieldStyle())
						.padding(.bottom, 10)
			}
	 }
}

struct LessonNotesField: View {
	 let title: String
	 @Binding var text: String

	 var body: some View {
			VStack(alignment: .leading) {
				 Text(title)
						.font(.headline)
				 TextEditor(text: $text)
						.padding(.horizontal, 5)
						.frame(height: 100)
						.overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray.opacity(2.5)))
			}
	 }
}

#Preview {
	 Lessons()
}
