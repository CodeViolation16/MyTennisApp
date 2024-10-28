//import SwiftUI
//
//	 // Define a structure for a Task
//struct Task: Identifiable {
//	 let id = UUID()
//	 var name: String
//}
//
//struct Test: View {
//	 @State private var tasks: [Task] = []
//	 @State private var newTaskName: String = ""
//	 @State private var isEditing: Bool = false
//	 @State private var selectedTask: Task?
//
//	 var body: some View {
//			NavigationView {
//				 VStack {
//							 // Input for new task
//						HStack {
//							 TextField("Enter a new task", text: $newTaskName)
//									.textFieldStyle(RoundedBorderTextFieldStyle())
//									.padding(.horizontal)
//
//									// Add task button
//							 Button(action: {
//									addTask()
//							 }) {
//									Image(systemName: "plus.circle.fill")
//										 .font(.title)
//							 }
//							 .disabled(newTaskName.isEmpty)
//						}
//						.padding()
//
//
//						List {
//							 ForEach(tasks) { task in
//									Text(task.name)
//										 .onTapGesture {
//												editTask(task)
//										 }
//							 }
//							 .onDelete(perform: deleteTask)
//						}
//				 }
//				 .navigationTitle("To-Do List")
//				 .toolbar {
//						EditButton() // Enables swipe to delete
//				 }
//				 .sheet(item: $selectedTask) { task in
//						TaskEditView(task: $tasks[tasks.firstIndex(where: { $0.id == task.id })!])
//				 }
//			}
//	 }
//
//			// Adds a new task
//	 private func addTask() {
//			tasks.append(Task(name: newTaskName))
//			newTaskName = ""
//	 }
//
//			// Deletes a task
//	 private func deleteTask(at offsets: IndexSet) {
//			tasks.remove(atOffsets: offsets)
//	 }
//
//			// Sets the selected task for editing
//	 private func editTask(_ task: Task) {
//			selectedTask = task
//	 }
//}
//
//	 // Separate view for editing a task
//struct TaskEditView: View {
//	 @Binding var task: Task
//	 @Environment(\.dismiss) private var dismiss
//
//	 var body: some View {
//			VStack {
//				 TextField("Edit Task", text: $task.name)
//						.textFieldStyle(RoundedBorderTextFieldStyle())
//						.padding()
//
//				 Button("Save") {
//						dismiss()
//				 }
//				 .padding()
//			}
//			.padding()
//	 }
//}
//
//#Preview {
//	 Test()
//}
