import Foundation
import SwiftData


@Model
class Time {
	 var date: String
	 var time: String
	 init(date: String, time: String) {
			self.date = date
			self.time = time
	 }
}
