import SwiftUI

struct WeatherElderlyRow: View {
    var logo: String
    var name: String
    var value: String
    
    var body: some View {
        HStack {
            Image(systemName: logo)
                .font(.title)
                .frame(width: 10, height: 20)
                .padding()
                .background(Color(.white))
                .cornerRadius(50)
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.system(size: 20)).bold()
                
                Text(value)
                    .bold()
                    .font(.system(size: 35))
            }
        }
    }
}

struct WeatherElderlyRow_Previews: PreviewProvider {
    static var previews: some View {
        WeatherElderlyRow(logo: "thermometer", name: "Feels like", value: "8°")
    }
}
