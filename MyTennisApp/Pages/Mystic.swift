import SwiftUI

struct Mystic: View {

	 @State var textValue: String = ""

	 var body: some View {
			NavigationView {
				 Form {
						Section {
							 Text("Hello, world!")
									.padding()
						} header: {
							 Text("Description")
						}
						Section {
							 TextField("Enter Amount", text: $textValue)  
						} header: {
							 Text("Step 1. Enter Amount")
						}

				 }
			}
	 }
}

#Preview {
	 Mystic()
}
