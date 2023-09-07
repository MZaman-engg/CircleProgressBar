

import SwiftUI

struct CircleProgressView: View {

  // MARK: - Bindings
  @Binding var progress: Float

  // MARK: - Body
  var body: some View {
    ZStack {
      // grey background circle
      Circle()
        .stroke(lineWidth: 5)
        .opacity(0.3)
        .foregroundColor(Color(UIColor.systemGray3))

      // green base circle to receive shadow
      Circle()
        .trim(from: 0.0, to: CGFloat(min(self.progress, 0.5)))
        .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
        .foregroundColor(Color.blue)
        .rotationEffect(Angle(degrees: 270.0))

      // point with shadow, clipped
      Circle()
        .trim(from: CGFloat(abs((min(progress, 1.0)) - 0.001)),
              to: CGFloat(abs((min(progress, 1.0))-0.0005)))
        .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
        .foregroundColor(Color(UIColor.blue))
        .shadow(color: .black, radius: 10, x: 0, y: 0)
        .rotationEffect(Angle(degrees: 270.0))
        .clipShape(
          Circle().stroke(lineWidth: 30)
        )

      // green overlay circle to hide shadow on one side
      Circle()
        .trim(from: progress > 0.5 ? 0.25 : 0, to: CGFloat(min(self.progress, 1.0)))
        .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
        .foregroundColor(Color.blue)
        .rotationEffect(Angle(degrees: 270.0))

      Text("\(Int(progress * 100))")
        .font(.caption)
        .fontWeight(.semibold)
        .foregroundColor(.blue)
    }
    .padding()
  }
}

struct ContentView: View {
  @State private var progress: Float = 0.5

  var body: some View {
    VStack {
      CircleProgressView(progress: $progress)
        .frame(width: 70)
        .padding()

      Slider(value: $progress, in: 0...1, step: 0.01)
        .padding(.horizontal)
    }
  }
}

struct CircleProgressView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
