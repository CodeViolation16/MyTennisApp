import SwiftUI

struct ContentView1: View {
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

	 var body: some View {
			List {
				 ForEach(Array(dateTimeArr.enumerated()), id: \.0) { sectionIndex, item in
						VStack(alignment: .leading) {
							 Text(item.0)

							 ForEach(Array(item.1.enumerated()), id: \.0) { detailIndex, detail in
									HStack {
										 Button(action: {
												dateTimeArr[sectionIndex].1.remove(at: detailIndex)
										 }) {
												Image(systemName: "trash")
													 .foregroundColor(.red)
										 }
										 VStack(alignment: .leading) {
												Text("Time: \(detail.0)")
												Text("Name: \(detail.1)")
												Text("Location: \(detail.2)")
										 }
									}
									Divider()
							 }
						}
				 }
			}
	 }
}

#Preview {
	 ContentView1()
}
