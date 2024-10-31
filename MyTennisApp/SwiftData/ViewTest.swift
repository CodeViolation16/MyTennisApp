import SwiftUI

struct TimeEntry {
	 let time: String
	 let name: String
	 let location: String
}

struct DateTimeEntry {
	 let date: String
	 var entries: [TimeEntry]
}

struct TimeTest: View {
	 @State private var nameText: String = ""
	 @State private var locationText: String = ""
	 @State private var selectedDate: Date = Date()
	 @State private var dateTimeArr: [DateTimeEntry] = []

	 private var dateFormatter: DateFormatter {
			let formatter = DateFormatter()
			formatter.dateStyle = .medium
			return formatter
	 }

	 private var timeFormatter: DateFormatter {
			let formatter = DateFormatter()
			formatter.dateFormat = "h:mm a"
			return formatter
	 }

	 private func addEntry() {
			let dateString = dateFormatter.string(from: selectedDate)
			let timeString = timeFormatter.string(from: selectedDate)

			if let index = dateTimeArr.firstIndex(where: { $0.date == dateString }) {
						// If it exists, append the new time and name
				 dateTimeArr[index].entries.append(TimeEntry(time: timeString, name: nameText, location: locationText))
				 dateTimeArr[index].entries.sort(by: { timeFormatter.date(from: $0.time)! < timeFormatter.date(from: $1.time)! })
			} else {
						// If it doesn't exist, create a new entry
				 dateTimeArr.append(DateTimeEntry(date: dateString, entries: [TimeEntry(time: timeString, name: nameText, location: locationText)]))
			}

				 // Sort by date
			dateTimeArr.sort(by: { dateFormatter.date(from: $0.date)! < dateFormatter.date(from: $1.date)! })
	 }

	 private func deleteEntry(dateTime: DateTimeEntry, entry: TimeEntry) {
			if let dateIndex = dateTimeArr.firstIndex(where: { $0.date == dateTime.date }),
				 let entryIndex = dateTimeArr[dateIndex].entries.firstIndex(where: { $0.time == entry.time && $0.name == entry.name && $0.location == entry.location }) {
				 dateTimeArr[dateIndex].entries.remove(at: entryIndex)
				 if dateTimeArr[dateIndex].entries.isEmpty {
						dateTimeArr.remove(at: dateIndex)
				 }
			}
	 }

	 var body: some View {
			VStack {
				 Text("Tennis is Great")
						.font(.title)
						.padding()

				 List {
						Section(header: Text("Selected Date and Time")) {
							 ForEach(dateTimeArr, id: \.date) { dateTime in
									VStack(alignment: .leading) {
										 Text(dateTime.date)  // Display date

										 ForEach(dateTime.entries, id: \.time) { entry in
												VStack(alignment: .leading) {
													 Text("Time: \(entry.time)")
													 Text("Name: \(entry.name)")
													 Text("Location: \(entry.location)")
													 Button(action: {
															deleteEntry(dateTime: dateTime, entry: entry)
													 }) {
															Image(systemName: "trash")
																 .foregroundColor(.red)
													 }
												}
										 }
									}
									.padding(.vertical, 4)
							 }
						}
				 }

				 DatePicker("Select Date & Time", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
				 TextField("Name", text: $nameText)
				 TextField("Location", text: $locationText)

				 Button("Submit Information") {
						addEntry()
				 }
				 .disabled(nameText.isEmpty || locationText.isEmpty)
			}
			.padding() // Optional: Add padding to the VStack
	 }
}

#Preview {
	 TimeTest()
}
