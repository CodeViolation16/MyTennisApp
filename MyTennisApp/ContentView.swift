import SwiftUI

struct ContentView: View {
	 @State private var showMenu: Bool = false
	 @State private var selectedTab = 0
	 @State private var value = ""
	 var body: some View {
			NavigationStack{
				 ZStack {
						TabView(selection: $selectedTab) {
							 Text("Dashboard").tag(0)
							 Text("Performance").tag(1)
							 Text("Profile").tag(2)
							 Text("My Lessons").tag(3)
							 Text("Mystic Mac").tag(4)

						}
						
						SideMenuView(isShowing: $showMenu, selectedTab: $selectedTab)
						
				 }
				 .toolbar(showMenu ? .hidden : .visible, for: .navigationBar)
				 .navigationTitle("Home")
				 .navigationBarTitleDisplayMode(.inline)
				 .toolbar {
						ToolbarItem (placement: .topBarLeading){
							 Button(action: {
									showMenu.toggle()
							 }, label: {
									Image(systemName: "line.3.horizontal")
										 .font(.system(size: 23))
										 .scaleEffect(x: 0.8, y: 1)
							 })
						}
				 }

			}

	 }

}


#Preview {
	 ContentView()
}
