import SwiftUI

struct ContentView12: View {
	 @State var dateTimeArr: [(String, [(String, String, String)])] = [
			("October 30, 2024", [
				 ("10:00 AM", "John Doe", "Court 1"),
				 ("2:00 PM", "Jane Smith", "Court 2"),
				 ("5:00 PM", "Alice Johnson", "Court 3")
			]),
			("November 1, 2024", [
				 ("11:30 AM", "Bob Brown", "Court 1"),
				 ("3:15 PM", "Charlie White", "Court 2")
			])
	 ]
	 private func deleteBooking(dateIndex: Int, bookingIndex: Int) {
			dateTimeArr[dateIndex].1.remove(at: bookingIndex)
			if dateTimeArr[dateIndex].1.isEmpty {
				 dateTimeArr.remove(at: dateIndex)
			}
	 }



	 @State private var dateInput: Date = Date()
	 @State private var timeInput: Date = Date()
	 @State private var nameInput: String = ""
	 @State private var courtInput: String = ""

	 var body: some View {
			List {
				 ForEach(dateTimeArr.indices, id: \.self) { dateIndex in
						Section(header: Text(dateTimeArr[dateIndex].0)) {
							 ForEach(dateTimeArr[dateIndex].1.indices, id: \.self) { bookingIndex in
									let booking = dateTimeArr[dateIndex].1[bookingIndex]

									Button(action: {
										 print("Clicked on: dateTimeArr[\(dateIndex)][1][\(bookingIndex)]")

										 deleteBooking(dateIndex: dateIndex, bookingIndex: bookingIndex)
									}) {
										 HStack {
												Text(booking.0)
												Spacer()
												Text(booking.1)
												Spacer()
												Text(booking.2)
										 }
									}
							 }
						}
				 }
			}
			.listStyle(InsetGroupedListStyle())

			Button("Push") {
				 let dateFormatter = DateFormatter()
				 dateFormatter.dateStyle = .medium
				 let dateString = dateFormatter.string(from: dateInput)

				 let timeFormatter = DateFormatter()
				 timeFormatter.dateFormat = "h:mm a"
				 let timeString = timeFormatter.string(from: timeInput)

				 if let index = dateTimeArr.firstIndex(where: { $0.0 == dateString }) {

						dateTimeArr[index].1.append((timeString, nameInput,courtInput))

						dateTimeArr[index].1.sort {
							 let time1 = timeFormatter.date(from: $0.0) ?? Date.distantPast
							 let time2 = timeFormatter.date(from: $1.0) ?? Date.distantPast
							 return time1 < time2
						}
				 } else {
						dateTimeArr.append((dateString, [(timeString, nameInput,courtInput)]))
				 }

				 dateTimeArr.sort {
						let date1 = dateFormatter.date(from: $0.0) ?? Date.distantPast
						let date2 = dateFormatter.date(from: $1.0) ?? Date.distantPast
						return date1 < date2
				 }

			}
			DatePicker("Select Date", selection: $dateInput, displayedComponents: .date)
			DatePicker("Select Time", selection: $timeInput, displayedComponents: .hourAndMinute)
			TextField("name", text: $nameInput)
			TextField("court", text: $courtInput)
			Spacer()
	 }

}

#Preview {
	 ContentView12()
}
