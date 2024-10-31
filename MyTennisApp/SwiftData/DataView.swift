import SwiftUI
import SwiftData

struct Time_Test: View {
	 @State var name_Text: String = ""
	 @State var location_Text: String = ""
	 @State var date_Text: Date = Date()
	 @State var time_Text: Date = Date()
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

	 func onDelete(item: (String, [(String, String, String)]), detail: (String, String, String)) {
				 // Find the index of `item` in `dateTimeArr`
			if let itemIndex = dateTimeArr.firstIndex(where: { $0.0 == item.0 }) {
						// Find the index of `detail` in the inner array
				 if let detailIndex = dateTimeArr[itemIndex].1.firstIndex(where: { $0 == detail }) {
							 // Remove the specific detail
						dateTimeArr[itemIndex].1.remove(at: detailIndex)
				 }
			}
	 }


	 var body: some View {
			VStack {
				 Text("Tennis is Great")
						.font(.title)
						.padding()

				 List {
						ForEach(dateTimeArr, id: \.0) { item in
							 VStack(alignment: .leading) {
									Text(item.0)
									ForEach(item.1, id: \.0) { detail in
										 Button(action: {
												onDelete(item: item, detail: detail)
												dateTimeArr[0].1.remove(at: 0)

										 }) {
												Image(systemName: "trash")
													 .foregroundColor(.red)
										 }
										 Text("Time: \(detail.0)")
										 Text("Name: \(detail.1)")
										 Text("Location: \(detail.2)")
										 Divider()
									}
							 }
						}
				 }
				 Button("delete") {
						dateTimeArr[0].1.remove(at: 0)
				 }

				 DatePicker("Select Date", selection: $date_Text, displayedComponents: .date)
				 DatePicker("Select Time", selection: $time_Text, displayedComponents: .hourAndMinute)
				 TextField("Name", text: $name_Text)
				 TextField("Location", text: $location_Text)

				 Button("Submit Information") {
						let dateFormatter = DateFormatter()
						dateFormatter.dateStyle = .medium
						let dateString = dateFormatter.string(from: date_Text)

						let timeFormatter = DateFormatter()
						timeFormatter.dateFormat = "h:mm a"
						let timeString = timeFormatter.string(from: time_Text)

						if let index = dateTimeArr.firstIndex(where: { $0.0 == dateString }) {

							 dateTimeArr[index].1.append((timeString, name_Text,location_Text))

							 dateTimeArr[index].1.sort {
									let time1 = timeFormatter.date(from: $0.0) ?? Date.distantPast
									let time2 = timeFormatter.date(from: $1.0) ?? Date.distantPast
									return time1 < time2
							 }
						} else {

							 dateTimeArr.append((dateString, [(timeString, name_Text, location_Text)]))
						}


						dateTimeArr.sort {
							 let date1 = dateFormatter.date(from: $0.0) ?? Date.distantPast
							 let date2 = dateFormatter.date(from: $1.0) ?? Date.distantPast
							 return date1 < date2
						}
				 }
			}
			.padding() // Optional: Add padding to the VStack
	 }
}

#Preview {
	 Time_Test()
}

	 //										 ForEach(Array(dateTimeArr[dateIndex].1.enumerated()), id: \.0) { itemIndex, item in
	 //												VStack(alignment: .leading) {
	 //													 Text("Time: \(item.0)")
	 //													 Text("Name: \(item.1)")
	 //													 Text("Location: \(item.2)")
	 //													 Button(action: {
	 //															deleteItem(dateIndex: dateIndex, itemIndex: itemIndex)
	 //													 }) {
	 //															Image(systemName: "trash")
	 //																 .foregroundColor(.red)
	 //													 }
	 //												}
	 //										 }


